//
//  StatusBarView.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/7/10.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "StatusBarView.h"
#import "DEFINE.h"


@implementation StatusBarView

static StatusBarView *sharedView;


+ (StatusBarView *)sharedView {
    
    if ( !sharedView) {
        
        static dispatch_once_t once;
        dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:CGRectMake(0, 0, KDeviceWidth, 20)]; });
        sharedView.alpha = 0;
        sharedView.backgroundColor = [UIColor yellowColor];
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:sharedView];
                break;
            }
        }
    }

    
    return sharedView;
}

- (BOOL)isShow; {
    
    if ( sharedView.alpha == 1 ) {
        return YES;
    }
    else {
        return NO;
    }
    
}



- (void)show; {
    

    sharedView.alpha = 1;


}


- (void)dismiss; {
    sharedView.alpha = 0;

}

@end
