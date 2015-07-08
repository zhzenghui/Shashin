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


@interface NewViewController ()  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation NewViewController

#pragma mark - UIImagePickerControllerDelegate

-(void)writeImageFile:(UIImage *)image {
    NSString *fileName = [NSString stringWithFormat:@"%@/%i.jpg", KCachesDirectory , arc4random()];
    NSString *fileNameString = fileName;
    
    int multiple = 2 * 2;
    
    CGSize size = CGSizeMake(image.size.width, image.size.height);
    image = [image resizedImageToSize:size];
    NSData * binaryImageData =UIImageJPEGRepresentation(image, .8);

    [binaryImageData writeToFile:fileNameString atomically:YES];
    
    
    
    self.imageView.image = image;

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
}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSDictionary *dict = [info valueForKey:UIImagePickerControllerMediaMetadata];
    

    
    [self writeFile:image dict:dict];
    
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.imagePickerController = nil;
    
    
    


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
//    imagePickerController.allowsEditing = YES;
    imagePickerController.videoQuality = UIImagePickerControllerQualityType640x480;
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
