//
//  Laber.m
//  态度
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 com.i-bejoy. All rights reserved.
//

#import "Label.h"

static Label* label;
@implementation Label

+ (id)share {
  if (label) {
    return label;
  }
  label = [[Label alloc] init];
  return label;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}

- (UILabel*)bgcolor:(UIColor*)bgcolor
           textfont:(UIFont*)textfont
          textcolor:(UIColor*)textcolor
               rect:(CGRect)frame
              align:(NSTextAlignment)align {
  // nav标题颜色
  UILabel* titleLabel = [[UILabel alloc] init];
  titleLabel.frame = frame;
  titleLabel.backgroundColor = bgcolor;  //设置Label背景透明
  titleLabel.font = textfont;            //设置文本字体与大小
  titleLabel.textColor = textcolor;

  //    titleLabel.textColor = [UIColor colorWithRed:(0.0/255.0) green:(255.0 /
  //    255.0) blue:(0.0 / 255.0) alpha:1];  //设置文本颜色
  titleLabel.textAlignment = align;

  // self.navigationItem.titleView = titleLabel;
  return titleLabel;
}

@end
