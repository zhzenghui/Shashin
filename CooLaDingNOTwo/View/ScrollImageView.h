//
//  ScrollImageView.h
//  CooLaDingNOTwo
//
//  Created by hui zeng on 6/11/15.
//  Copyright (c) 2015 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollImageView : UIScrollView<UIScrollViewDelegate>

-(instancetype)initWithArray:(NSArray *)array andInt:(int)count;


@end
