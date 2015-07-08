//
//  Button.h
//  态度
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 com.i-bejoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button : UIButton
- (UIButton *)addTarget:(id)target
                   addT:(SEL)selecter
              imagePath:(NSString *)imagePath
                   rect:(CGRect)frame;

+ (id)share;

- (UIButton *)addToView:(UIView *)view
               addTarget:(id)target
                    rect:(CGRect)rect
                     tag:(int)tag
                  action:(SEL)action
               imagePath:(NSString *)imagePath
    highlightedImagePath:(NSString *)highlightedImagePath
       SelectedImagePath:(NSString *)SelectedImagePath;

- (UIButton *)addToView:(UIView *)view
               addTarget:(id)target
                    rect:(CGRect)rect
                     tag:(int)tag
                  action:(SEL)action
               imagePath:(NSString *)imagePath
    highlightedImagePath:(NSString *)highlightedImagePath;

- (UIButton *)addToView:(UIView *)view
              addTarget:(id)target
                   rect:(CGRect)rect
                    tag:(int)tag
                 action:(SEL)action
              imagePath:(NSString *)imagePath;

- (UIButton *)addToView:(UIView *)view
              addTarget:(id)target
                   rect:(CGRect)rect
                    tag:(int)tag
                 action:(SEL)action;

- (UIButton *)addTarget:(id)target
                   addT:(SEL)selecter
              imagePath:(NSString *)imagePath
                   rect:(CGRect)frame
                 toView:(UIView *)view;

@end
