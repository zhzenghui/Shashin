//
//  BaseViewController.m
//  Coolading
//
//  Created by bejoy on 14/10/30.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "BaseViewController.h"
#import "CooladingManager.h"
#import "IBJButton.h"






@implementation BaseViewController {
    
    UIImageView *imgMaskView;
    UILabel *lable;

}



- (void)addNavBack {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
//      initWithImage:[UIImage imageNamed:@"返回按钮-"]
//              style:UIBarButtonItemStylePlain
//             target:self
//             action:@selector(back:)];
    
    
    IBJButton *userButton = [IBJButton buttonWithType:UIButtonTypeCustom];
    [userButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(backNav:) forControlEvents:UIControlEventTouchUpInside];
    userButton.frame = CGRectMake(10, 20, 45, 45);
    
    
    [self.navBarView addSubview:userButton];
}

- (void)openShare {

}

- (void)backNav:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavBarTitle:(NSString *)title; {
    lable.text = title;
    lable.textColor = KYello;
}


#pragma mark - view cycle

- (void)loadView {
    [super loadView];
    self.manager = [CooladingManager sharedCooladingManager];
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    
    self.navBarView = [[IBJView alloc] initWithFrame:CGRectMake(0, 0, KDeviceWidth, 64)];
    self.navBarView.backgroundColor = [UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1]; ;
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KDeviceWidth, 44)];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.navBarView addSubview:lable];
    
    [self.view addSubview: self.navBarView];;
    
    self.navBarView.hidden = YES;

}

- (void)viewDidLoad {
  
    [super viewDidLoad];
//
//  self.view.backgroundColor = color(244.0, 244.0, 244.0);
//  [self.view addSubview:mainView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.view bringSubviewToFront:self.navBarView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];


    self.navigationController.navigationBar.translucent = YES;
    // for ios7
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
    }
    // for under ios7
    else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"]
             forBarMetrics:UIBarMetricsDefault];
    }
}

@end

@implementation BaseViewController(GestureRecognizer)

    
@end

