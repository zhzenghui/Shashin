//
//  ViewController.m
//  CooLaDingNOTwo
//
//  Created by savvy on 15/6/3.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "ViewController.h"
#import "CooladingManager.h"


#import "Masonry.h"
#import "CooLaDingNOTwo-swift.h"
#import "IBJView.h"
#import "IBJImageView.h"
#import "DEFINE.h"
#import "IBJButton.h"
#import "IBJView.h"



#import "AppDelegate.h"

#import "Button.h"
#import "UIButton+WebCache.h"
#import <RongIMKit/RongIMKit.h>

#import "SGFocusImageFrame.h"
#import "Connetion.h"
#import "Cookie.h"
#import "Message.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

#import "DesignerViewController.h"
#import "ListViewController.h"

#import "NewViewController.h"


#define KyuKanGongDi 1
#define KCustomerServer 2
#define KQuestion 3
#define KOrder 4
#define KTuZhi 5
#define KLive 6


@interface ViewController () <UIAlertViewDelegate>{
    

    NSMutableArray *designData;
    
    NSMutableArray *workTeamData;
    
    NSMutableArray *images;
    __block NSInteger index;

    NSMutableArray *errorImages;
    
}


@end

@implementation ViewController

// 下载图片数据
- (void)sdLoadImage {
    
    NSInteger count = images.count;
    NSString *urlStr = images[ index  ];
        
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
//        DLog(@"%i/ %i", receivedSize, expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        if (error) {
            DLog(@"%@", error);
            
            if (       !     errorImages  ) {
                
                errorImages = [[NSMutableArray alloc] init];
            }
            
            
            if (error.code == 404) {
                [errorImages addObject:[error userInfo]];
            }

        }
        
        [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:NO imageData:data forKey:url.absoluteString toDisk:YES];



        DLog(@"index: %i / %i ", index, count);
        DLog(@"%@", url.absoluteString);
        
        if (index < count) {
            [self sdLoadImage];
            

        }

        
        

        
        dispatch_async(dispatch_get_main_queue(), ^{

        
        
            NSString *str = [NSString stringWithFormat:@"正在下载第%i张，共%i张", index, count];
            
            [SVProgressHUD showWithStatus:str maskType:SVProgressHUDMaskTypeGradient];
            
            
            if (index > count) {
                [SVProgressHUD showSuccessWithStatus: [NSString stringWithFormat: @"同步完成， 下载图片共：%i， 错误： %i个", count, errorImages.count]];
                
                
                images = nil;
                
                [Cookie setCookie:@"images" value:nil];

                
            }
        });

        
        index++;

        
        
    }];
    

    

    
}


// 清理本地缓存数据， 重新下载
- (void)cleanCache {
    
    
    [[SDImageCache sharedImageCache] cleanDisk];
    
    
    
    
}


//  如果上次没有完成 获取保存的本地数据，继续同步。
- (void)reloadImages {

    index = 0;
    images = [Cookie getCookie:@"images"];
    [self sdLoadImage];
    
    

}

//  检查上次同步过程是否完成
- (void)checkDownloadIsScuess {

    
    images = [Cookie getCookie:@"images"];

    if (images) {
        [Message messageAlert:@"检测到上次同步数据没有完成，即将开始继续下载"];
        [self reloadImages];

    }
    
    
}


//  汇总获取的索引数据 组成 图片数组

- (void)loadImages:(NSArray *)image {
    
    if ( ! images) {
        images = [[NSMutableArray alloc] init];
    }
    [images addObjectsFromArray:image];
    
    
    [SVProgressHUD showWithStatus:@"索引数据下载完成，即将开始下载图片数据 。。。" maskType:SVProgressHUDMaskTypeGradient];
    
    
    NSString *wdown =  [Session getSession:@"wdown"];
    NSString *ddown =  [Session getSession:@"ddown"];
    
    
//    都下载完成时开始下载图片数据
    if ( [wdown isEqualToString:@"1"] && [ddown isEqualToString:@"1"] ) {

    
        DLog(@"图片数量：  %lu", images.count);
        index = 0;
        [self sdLoadImage];
        
        
        [Cookie setCookie:@"images" value:[NSArray arrayWithArray: images]];
    }
    
    
    
    
}

- (void)question {
    [Message messageAlert:@"更新数据需要较长时间，并且所有功能将暂时不可用， 您确定现在更新吗？" delegate:self];
}


//  获取索引数据
- (void)getDCData {

    
    
    [SVProgressHUD showWithStatus:@"正在下载索引数据。。。" maskType:SVProgressHUDMaskTypeGradient];

    
    [[Connetion shared] designData:^(NSDictionary *resultData, NSError *error) {
    
        
        if ( ! error) {
            
            if ([resultData [Kstatus] intValue]== 1) {
                if (resultData[Kresult]) {

                    designData = resultData[Kresult][@"designList"];
                    [Cookie setCookie:@"designData" value:designData];
                    

                    // 设置 设计师数据下载完成
                    [Session setSession:@"ddown" value:@"1"];
                    
                    
                    [self loadImages:resultData[Kresult][@"images"]];

                }
            }
        }
        else {
            
            [SVProgressHUD dismiss];
            [Message messageAlert:@"获取数据发生了错误， 请再次尝试，如果还是错误，请联系管理员。"];
        }

        
    }];
    
    [[Connetion shared] workTeamData:^(NSDictionary *resultData, NSError *error) {
        
        
        if ( ! error) {
            
            if ([resultData [Kstatus] intValue]== 1) {
                if (resultData[Kresult]) {
                    
                    workTeamData = resultData[Kresult][@"designList"];
                    [Cookie setCookie:@"workTeamData" value:workTeamData];
                    
                    // 设置 施工队数据下载完成
                    [Session setSession:@"wdown" value:@"1"];
                    
                    
                    [self loadImages:resultData[Kresult][@"images"]];

                }
            }
        }
        else {
            
            

            [SVProgressHUD dismiss];
            [Message messageAlert:@"获取数据发生了错误， 请再次尝试，如果还是错误，请联系管理员。"];
        }

    }];
    
    
    
}



/**
 *  打开菜单按钮的Viewcontroller
 *
 *  @param button
 */
- (void)openView:(NSInteger)tag {
    
    switch (tag) {
        case 1: // 添加视频
        {
            NewViewController *dvc = [[NewViewController alloc] init];

            [self.navigationController pushViewController:dvc animated:YES];
            break;
        }
        case 2: // 客服
        {
            
            
            if ( ! designData) {
                
                [Message messageAlert:@"您需要重新同步数据， 请点击右下角的刷新按钮重新下载数据"];
                
                return;
            }
            
            ListViewController  *dvc  = [[ListViewController alloc] init];
            dvc.list = workTeamData;
            dvc.listType = ListTypeConstruction;
            [self.navigationController pushViewController:dvc animated:YES];
            
            
            break;
        }
      
        default:
            break;
    }
    
}

- (void)openViewController:(UIButton *)button {
    
    
    [self openView:button.tag];
}


/// 投诉管家
- (void)touShuPersonViewController:(UIButton *)button {
    
    NSString *phoneNumber = [NSString stringWithFormat:@"telprompt:%@", KServerPhone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

#pragma mark - alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            DLog(@"取消");
            
            
            break;
        }
        case 1:
        {

            
            DLog(@"确定");
            
            [self getDCData];

            break;
        }
        default:
            break;
    }
}

#pragma mark - view

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.hidden = YES;

    index = 0;

    [Session setSession:@"ddown" value:@"0"];
    [Session setSession:@"wdown" value:@"0"];
    
    

    
    
    
//    designData = [Cookie getCookie:@"designData"];
//    workTeamData = [Cookie getCookie:@"workTeamData"];
//    
//    
//    
////    设计师按钮
    IBJButton *leftButton = [IBJButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = TEST_COLOR;
    [leftButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, KDeviceWidth/2, KDeviceHeight);
    [leftButton setImage:[UIImage imageNamed:@"首页-左"] forState:UIControlStateNormal];
//
    leftButton.tag = 1;
//
////    工程队按钮
//    IBJButton *rightButton = [IBJButton buttonWithType:UIButtonTypeCustom];
//    rightButton.backgroundColor = TEST_COLOR;
//    [rightButton addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
//    rightButton.frame = CGRectMake(KDeviceWidth/2, 0, KDeviceWidth/2, KDeviceHeight);
//    [rightButton setImage:[UIImage imageNamed:@"首页-右"] forState:UIControlStateNormal];
//    rightButton.tag = 2;
//    
//    
    [self.view addSubview:leftButton];
//    [self.view addSubview:rightButton];
//    
//    
//    
//    IBJButton *button = [IBJButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = TEST_COLOR;
//    [button addTarget:self action:@selector(question) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(KDeviceWidth - 100, KDeviceHeight - 100, 50, 50);
//    [button setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
//    button.tag = 3;
//    
//    
//    [self.view addSubview:button];
//    
//    
//    
//    [self checkDownloadIsScuess];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
