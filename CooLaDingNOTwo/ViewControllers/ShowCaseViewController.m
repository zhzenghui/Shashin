//
//  ShowCaseViewController.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/7/1.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "ShowCaseViewController.h"
#import "MyPhotoBrowser.h"



@interface ShowCaseViewController () <MyPhotoBrowserDelegate>
{
    NSMutableArray *images;

    
}
@end

@implementation ShowCaseViewController



- (void)loadd {
    
    
    if ( ! images) {
        images = [[NSMutableArray alloc] init];
    }

    int i = 0;
    for (NSDictionary *dict in self.list) {
        
        MWPhoto *mWPhoto = [MWPhoto photoWithURL:[NSURL URLWithString:dict[@"imageUrl"]]];
        mWPhoto.imageId = [NSString stringWithFormat:@"%i", i];
        [images addObject:mWPhoto];
        
        i++;
    }
    
    
}

- (void)loadView {
    [super loadView];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadd];

    
    
    MyPhotoBrowser *browser = [[MyPhotoBrowser alloc] initWithDelegate:self];
    browser.desplayType=3;
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = YES; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.title = @"标题";
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.enableSwipeToDismiss = NO;
    
    [browser setCurrentPhotoIndex: 0];//设置当前显示的图片m
    
    [self.view addSubview:browser.view];
    [self addChildViewController:browser];

//    [self.navigationController pushViewController:browser animated:YES];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"案例详情";

    
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MWPhotoBrowserDelegate

//警告，此句必须复写！！！！
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MyPhotoBrowser *)photoBrowser {
    return images.count;
}

- (void)getCurrentMWPhoto:(MWPhoto *)mwPhoto photoAtIndex:(NSUInteger)index{
    //    MWPhoto *mp = [biurls objectAtIndex:index];
    DLog(@"索引%lu！！！！！！", (unsigned long)index);
    
//    MWPhoto *mp = [images objectAtIndex:index][@"imageUrl"];
    //    DLog(@"索引%lu！！！！！！", (unsigned long)mp.imageIndex);
//    NSLog(@"图片网址为%@!!!!!!!!!!!!!",mp.photoURL);
    
    
    
    
}


//警告，此句必须复写！！！！
- (id <MWPhoto>)photoBrowser:(MyPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    MWPhoto *mp = [images objectAtIndex:index];
    return mp;
    
    
}



@end
