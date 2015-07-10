//
//  StatusBarView.h
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/7/10.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusBarView : UIView


+ (StatusBarView *)sharedView;

- (BOOL)isShow;

- (void)show;

- (void)dismiss;

@end
