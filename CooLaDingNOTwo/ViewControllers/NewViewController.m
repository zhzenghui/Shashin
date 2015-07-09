//
//  NewViewController.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/7/8.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "NewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Resize.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "SDAVAssetExportSession.h"


@interface NewViewController ()  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation NewViewController

#pragma mark - UIImagePickerControllerDelegate

-(void)writeImageFile:(UIImage *)image {
    NSString *fileName = [NSString stringWithFormat:@"%@/%i.jpg", KCachesDirectory , arc4random()];
    NSString *fileNameString = fileName;
    
    

    image = [image resizedImageByWidth:1000];
    NSData * binaryImageData =UIImageJPEGRepresentation(image, .8);

    [binaryImageData writeToFile:fileNameString atomically:YES];
    
    DLog(@"保顿到： %@", fileNameString);
    
    self.imageView.image = image;

}

- (void)writeVideo:(NSString *)fullPathStr {
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%ioutput.mov", KCachesDirectory , arc4random()];
    NSString *fileNameString = fileName;
    NSURL *fullPath = [NSURL fileURLWithPath:fullPathStr];
    NSURL *path = [NSURL fileURLWithPath:fileNameString];
    
    
    NSError *error = nil;
    
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:fullPath fileType:AVFileTypeQuickTimeMovie error:&error];

    NSParameterAssert(videoWriter);
    AVAsset *avAsset = [[AVURLAsset alloc] initWithURL:path options:nil] ;
    
    
    
    NSDictionary *videoCleanApertureSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithInt:480], AVVideoCleanApertureWidthKey,
                                                [NSNumber numberWithInt:640], AVVideoCleanApertureHeightKey,
                                                [NSNumber numberWithInt:10], AVVideoCleanApertureHorizontalOffsetKey,
                                                [NSNumber numberWithInt:10], AVVideoCleanApertureVerticalOffsetKey,
                                                nil];
    
    
    NSDictionary *codecSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:1960000], AVVideoAverageBitRateKey,
                                   [NSNumber numberWithInt:24],AVVideoMaxKeyFrameIntervalKey,
                                   videoCleanApertureSettings, AVVideoCleanApertureKey,
                                   nil];
    
    
    
    NSDictionary *videoCompressionSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                              AVVideoCodecH264, AVVideoCodecKey,
                                              codecSettings,AVVideoCompressionPropertiesKey,
                                              [NSNumber numberWithInt:480], AVVideoWidthKey,
                                              [NSNumber numberWithInt:640], AVVideoHeightKey,
                                              nil];
    
    AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput
                                            assetWriterInputWithMediaType:AVMediaTypeVideo
                                            outputSettings:videoCompressionSettings];
    
    NSParameterAssert(videoWriterInput);
    NSParameterAssert([videoWriter canAddInput:videoWriterInput]);
    videoWriterInput.expectsMediaDataInRealTime = YES;
    [videoWriter addInput:videoWriterInput];
    NSError *aerror = nil;
    AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:avAsset error:&aerror];
    AVAssetTrack *videoTrack = [[avAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0];
    
    videoWriterInput.transform = videoTrack.preferredTransform;
    NSDictionary *videoOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    AVAssetReaderTrackOutput *asset_reader_output = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:videoOptions];
    [reader addOutput:asset_reader_output];
    //audio setup
    
    AVAssetWriterInput* audioWriterInput = [AVAssetWriterInput
                                            assetWriterInputWithMediaType:AVMediaTypeAudio
                                            outputSettings:nil];
    
    
    AVAssetReader *audioReader = [AVAssetReader assetReaderWithAsset:avAsset error:&error];
    AVAssetTrack* audioTrack = [[avAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    AVAssetReaderOutput *readerOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:audioTrack outputSettings:nil];
    
    [audioReader addOutput:readerOutput];
    NSParameterAssert(audioWriterInput);
    NSParameterAssert([videoWriter canAddInput:audioWriterInput]);
    audioWriterInput.expectsMediaDataInRealTime = NO;
    [videoWriter addInput:audioWriterInput];
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    [reader startReading];
    dispatch_queue_t _processingQueue = dispatch_queue_create("assetAudioWriterQueue", NULL);
    [videoWriterInput requestMediaDataWhenReadyOnQueue:_processingQueue usingBlock:
     ^{
         while ([videoWriterInput isReadyForMoreMediaData]) {
             
             CMSampleBufferRef sampleBuffer;
             if ([reader status] == AVAssetReaderStatusReading &&
                 (sampleBuffer = [asset_reader_output copyNextSampleBuffer])) {
                 
                 BOOL result = [videoWriterInput appendSampleBuffer:sampleBuffer];
                 CFRelease(sampleBuffer);
                 
                 
                 if (!result) {
                     // PROBLEM SEEMS TO BE HERE... result is getting false value....
                     [reader cancelReading];
                     NSLog(@"NO RESULT");
                     NSLog(@"videoWriter.error: %@", videoWriter.error);
                     break;
                 }
             } else {
                 [videoWriterInput markAsFinished];
                 
                 switch ([reader status]) {
                     case AVAssetReaderStatusReading:
                         // the reader has more for other tracks, even if this one is done
                         break;
                         
                     case AVAssetReaderStatusCompleted:
                         // your method for when the conversion is done
                         // should call finishWriting on the writer
                         //hook up audio track
                         [audioReader startReading];
                         [videoWriter startSessionAtSourceTime:kCMTimeZero];
                         // dispatch_queue_t mediaInputQueue = dispatch_queue_create("mediaInputQueue", NULL);
                         // [audioWriterInput requestMediaDataWhenReadyOnQueue:mediaInputQueue usingBlock:^
                         //{
                         NSLog(@"Request");
                         NSLog(@"Asset Writer ready :%d",audioWriterInput.readyForMoreMediaData);
                         while (audioWriterInput.readyForMoreMediaData) {
                             CMSampleBufferRef nextBuffer;
                             if ([audioReader status] == AVAssetReaderStatusReading &&
                                 (nextBuffer = [readerOutput copyNextSampleBuffer])) {
                                 NSLog(@"Ready");
                                 if (nextBuffer) {
                                     NSLog(@"NextBuffer");
                                     [audioWriterInput appendSampleBuffer:nextBuffer];
                                 }
                             }else{
                                 [audioWriterInput markAsFinished];
                                 switch ([audioReader status]) {
                                     case AVAssetReaderStatusCompleted:
                                         [videoWriter finishWriting];
                                         NSLog(@"setting  final... the URL");
//                                         self.finalURL=[[NSURL alloc]initFileURLWithPath:fullPathStr];
                                         break;
                                 }
                             }
                             
                             
                         }
                         
                         break;
                         
                     case AVAssetReaderStatusFailed:
                         [videoWriter cancelWriting];
                         break;
                 }
                 
                 break;
             }
         }
     }
     ];
    NSLog(@"Write Ended");
}

- (void)writeFile :(UIImage *)image dict:(NSDictionary *)dict{
    
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Expected to be in StoppingRecording state" userInfo:nil];

//    NSString *fileName = [NSString stringWithFormat:@"%i",   arc4random()];
//    NSString *fileNameString = fileName;
//    NSURL *url=  [NSURL URLWithString:fileNameString];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
//        
//        [[NSFileManager defaultManager] removeItemAtURL:url error:NULL];
//        
//        @synchronized( self ) {
//            
//            
//        }
//    }];

    
    [library writeImageToSavedPhotosAlbum:[image CGImage]  metadata:dict completionBlock:^(NSURL *assetURL, NSError *error) {
        
        DLog(@"%@", assetURL);
    }];
    
    
    
    [self writeImageFile:image];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%ioutput.mov", KCachesDirectory , arc4random()];
    NSString *fileNameString = fileName;

    

}


- (void)writeVideoFileDict:(NSDictionary *)dict{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    NSURL *recordedVideoURL= [dict objectForKey:UIImagePickerControllerMediaURL];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:recordedVideoURL]) {
        [library writeVideoAtPathToSavedPhotosAlbum:recordedVideoURL
                                    completionBlock:^(NSURL *assetURL, NSError *error){}
         ];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%ioutput.mov", KCachesDirectory , arc4random()];
    
//
//    NSData *videoData = [NSData dataWithContentsOfURL:recordedVideoURL];
//    
//    BOOL success = [videoData writeToFile:fileName atomically:NO];
//    
//    
//
//    if (success) {
//        DLog(@"write success");
//        
//    }
    
    


    
}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSDictionary *dict = [info valueForKey:UIImagePickerControllerMediaMetadata];
    

    
    [self write:info];
    return;
//    image
    [self writeFile:image dict:dict];
//    video
    [self writeVideoFileDict:info];
    
    
    
    
    NSURL *recordedVideoURL= [info objectForKey:UIImagePickerControllerMediaURL];

    AVAssetTrack *videoTrack = nil;
    AVURLAsset *asset = [AVAsset assetWithURL: recordedVideoURL ];
    NSArray *videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    
    CMFormatDescriptionRef formatDescription = NULL;
    NSArray *formatDescriptions = [videoTrack formatDescriptions];
    if ([formatDescriptions count] > 0)
        formatDescription = (__bridge CMFormatDescriptionRef)[formatDescriptions objectAtIndex:0];
    
    if ([videoTracks count] > 0)
        videoTrack = [videoTracks objectAtIndex:0];
    
    CGSize trackDimensions = {
        .width = 0.0,
        .height = 0.0,
    };
    trackDimensions = [videoTrack naturalSize];
    
    int width = trackDimensions.width;
    int height = trackDimensions.height;
    NSLog(@"Resolution = %d X %d",width ,height);
    
    float frameRate = [videoTrack nominalFrameRate];
    float bps = [videoTrack estimatedDataRate];
    NSLog(@"Frame rate == %f",frameRate);
    NSLog(@"bps rate == %f",bps);
    
    
    
    
    NSString *quality = AVAssetExportPresetLowQuality;
    NSString *fileName = [NSString stringWithFormat:@"%@/%ioutput.mov", KCachesDirectory , arc4random()];
    NSURL *exportUrl = [NSURL fileURLWithPath:fileName];

    // get a video asset for the original video file

    // see if it's possible to export at the requested quality
    NSArray *compatiblePresets = [AVAssetExportSession  exportPresetsCompatibleWithAsset:asset];
    if ([compatiblePresets containsObject:quality]) {
        // set up the export
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]  initWithAsset:asset presetName:AVAssetExportPreset1280x720];
        exportSession.outputURL = exportUrl;
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        // run the export
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{

                switch ([exportSession status]) {
                    case AVAssetExportSessionStatusFailed:
                        //TODO: warn of failure
                        DLog(@"AVAssetExportSession ：  warn of failure");
                        NSLog(@"Export failed -> Reason: %@, User Info: %@",
                              exportSession.error.localizedDescription,
                              exportSession.error.userInfo.description);
                        break;
                    case AVAssetExportSessionStatusCancelled:
                        //TODO: warn of cancellation
                        DLog(@"AVAssetExportSession ：  warn of cancellation");

                        break;
                    default:
                        //TODO: do whatever is next
                        DLog(@"AVAssetExportSession ：  OK");
                        break;
                }
            });

        }];
    }
    else {
        //TODO: warn that the requested quality is not available
    }
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.imagePickerController = nil;

}

- (void)write :(NSDictionary *)dict{
    NSURL *recordedVideoURL= [dict objectForKey:UIImagePickerControllerMediaURL];

    
    NSString *fileName = [NSString stringWithFormat:@"%@/%ioutput.mov", KCachesDirectory , arc4random()];

    NSURL *outputFileURL = [NSURL fileURLWithPath:fileName];
    
    
    
    AVURLAsset *asset = [AVAsset assetWithURL: recordedVideoURL ];

    
    
    SDAVAssetExportSession *encoder = [[SDAVAssetExportSession alloc] initWithAsset:asset];
    encoder.outputFileType = AVFileTypeMPEG4;
    encoder.outputURL = outputFileURL;
    encoder.videoSettings = @
    {
    AVVideoCodecKey: AVVideoCodecH264,
    AVVideoWidthKey: @1920,
    AVVideoHeightKey: @1080,
    AVVideoCompressionPropertiesKey: @
        {
        AVVideoAverageBitRateKey: @6000000,
        AVVideoProfileLevelKey: AVVideoProfileLevelH264High40,
        },
    };
    encoder.audioSettings = @
    {
    AVFormatIDKey: @(kAudioFormatMPEG4AAC),
    AVNumberOfChannelsKey: @2,
    AVSampleRateKey: @44100,
    AVEncoderBitRateKey: @128000,
    };
    
    [encoder exportAsynchronouslyWithCompletionHandler:^
    {
        if (encoder.status == AVAssetExportSessionStatusCompleted)
        {
            NSLog(@"Video export succeeded");
        }
        else if (encoder.status == AVAssetExportSessionStatusCancelled)
        {
            NSLog(@"Video export cancelled");
        }
        else
        {
            NSLog(@"Video export failed with error: %@ (%d)", encoder.error.localizedDescription, encoder.error.code);
        }
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark -

- (IBAction)showVideoPickerForCamera:(id)sender
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}


- (IBAction)showImagePickerForCamera:(id)sender
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}


- (IBAction)showImagePickerForPhotoPicker:(id)sender
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}


- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
//    imagePickerController.allowsEditing = YES;
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeIFrame960x540;
    imagePickerController.showsCameraControls = YES;

    
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}





- (void)openImagePickerController {

    [self showImagePickerForCamera:nil];

}


#pragma mark - UIImagePickerControllerDelegate

- (void)viewDidLoad {
    [super viewDidLoad];

    [self openImagePickerController];
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
