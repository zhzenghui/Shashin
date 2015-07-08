//
//  ScrollImageView.m
//  CooLaDingNOTwo
//
//  Created by hui zeng on 6/11/15.
//  Copyright (c) 2015 coolading. All rights reserved.
//
#import "DEFINE.h"
#import "ShowScrollView.h"
#import "ScrollImageView.h"
#import "PersonalView.h"

@implementation ScrollImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithArray:(NSArray *)array andInt:(int)count 
{
    self=[super init];
    if (self) {
        
        
        
        [self setBackgroundColor:[UIColor redColor]];
        self.frame=CGRectMake(0, 64, KDeviceWidth, KDeviceHeight);
        // self.backgroundColor=[UIColor blackColor];
        self.contentSize=CGSizeMake(array.count * KDeviceWidth, KDeviceHeight);
        self.pagingEnabled=YES;
        self.contentOffset=CGPointMake(KDeviceWidth*count, 0);
        for (int i=0; i<array.count; i++) {
            ShowScrollView *showView = [[ShowScrollView alloc] initWithFrame:CGRectMake(KDeviceWidth*i, 0, KDeviceWidth, KDeviceHeight) andImage:array[i][@"imageUrl"]];
            
            [self addSubview:showView];
        }
        
        
        
        
    }
    
    
    return self;
}




@end
