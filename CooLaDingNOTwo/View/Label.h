//
//  Laber.h
//  态度
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 com.i-bejoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Label : UILabel
+ (id)share;
- (UILabel*)bgcolor:(UIColor*)bgcolor
           textfont:(UIFont*)textfont
          textcolor:(UIColor*)textcolor
               rect:(CGRect)frame
              align:(NSTextAlignment)align;

@end
