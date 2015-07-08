//
//  BaseViewController.h
//  Coolading
//
//  Created by bejoy on 14/10/30.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CooladingManager.h"
#import "CCLog.h"
#import "IBJView.h"
#import "Masonry.h"
#import "DEFINE.h"


/**
 *  项目内所有的viewcontroller 的基类
 */
@interface BaseViewController : UIViewController {
    IBJView *contentView;

    
}

// 全局的托管中心 包括网络  user session  等信息
@property(strong) CooladingManager *manager;




//屏幕上方的导航
@property (nonatomic, strong) IBJView *navBarView;



- (void)setNavBarTitle:(NSString *)title;


- (IBAction)back;

/**
 *  添加导航返回按钮
 */
- (void)addNavBack;

@end

@interface BaseViewController(GestureRecognizer)

@end
