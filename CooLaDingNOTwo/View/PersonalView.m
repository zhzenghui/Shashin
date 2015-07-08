//
//  PersonalView.m
//  CooLaDingNOTwo
//
//  Created by hui zeng on 6/8/15.
//  Copyright (c) 2015 coolading. All rights reserved.
//
#import "ScrollImageView.h"
#import "DEFINE.h"
#import "Masonry.h"
#import "PersonalView.h"

static PersonalView* person;

static PersonalView *personalView;

@implementation PersonalView
+ (id)share {
    if (person) {
        return person;
    }
    person = [[PersonalView alloc] init];
    return person;
}

-(PersonalView *)rect:(CGRect)rect imageName:(NSString *)imageName addTarget:(id)target tag:(int)tag addT:(SEL)selecter labelText:(NSString *)text
{
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.left.mas_equalTo((0/375.0)*KDeviceWidth);
         make.top.mas_equalTo(0/667.0*KDeviceHeight);
         make.width.mas_equalTo(70/375.0*KDeviceWidth);
         make.height.mas_equalTo(70/667.0*KDeviceHeight);
     }];
    

    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.left.mas_equalTo((0/375.0)*KDeviceWidth);
         make.top.mas_equalTo(0/667.0*KDeviceHeight);
         make.width.mas_equalTo(70/375.0*KDeviceWidth);
         make.height.mas_equalTo(70/667.0*KDeviceHeight);
     }];

    
    
    
    float x = 14/375.0*KDeviceWidth;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:x];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.left.mas_equalTo((0/375.0)*KDeviceWidth);
         make.top.mas_equalTo(85/667.0*KDeviceHeight);
         make.width.mas_equalTo(70/375.0*KDeviceWidth);
         make.height.mas_equalTo(14/667.0*KDeviceHeight);
     }];
    
    return self;
}
-(PersonalView *)cgRect:(CGRect)rect addTarget:(id)target tag:(int)tag addT:(SEL)selecter
{
    
    
    self.frame = rect;
    
    //朋友
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"微信好友.jpg"] forState:UIControlStateNormal];
    button1.frame = CGRectMake(10, 10, 70, 70);
    button1.tag = tag;
    [button1 addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = 15;
    [self addSubview:button1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 70, 15)];
    [label1 setText:@"好友"];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    
    //朋友圈
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"微信朋友圈.jpg"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(100, 10, 70, 70);
    button2.tag = tag+100;
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 15;
    [button2 addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 90, 70, 15)];
    [label2 setText:@"朋友圈"];
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    
    return self;
}
-(PersonalView *)cgRect:(CGRect)rect addTarget:(id)target tag:(int)tag addT:(SEL)selecter name:(NSString *)name
{
    self.frame = rect;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [button setBackgroundColor:[UIColor redColor]];
    
    button.frame = CGRectMake(KDeviceWidth/3/2-30, 150/2-30, 60 , 60 );
    
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];

    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 125, 30)];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = name;
    [self addSubview:label];
    
    
    self.nImageView = [[UIImageView alloc]initWithFrame:CGRectMake(125-30, 150-30, 30, 30)];
    [self.nImageView setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.nImageView];
    
    
    
    
    
    return self;
}



-(PersonalView *)addArr:(NSArray *)arr num:(int)num addTarget:(id)target tag:(int)tag addT:(SEL)selecter cgRect:(CGRect)rect dataMarr:(NSMutableArray *)dataMarr
{
//    self.namelistArr = nameArr;
//    self.numlistArr = numArr;
    self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 20, KDeviceWidth-120, 44)];
//    self.nameLabel.text = nameArr[0];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    button.frame =rect;
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    
    [self addSubview:button];
    self.frame = CGRectMake(0, 0, KDeviceWidth, KDeviceHeight);
    [self setBackgroundColor:[UIColor whiteColor]];
    self.userInteractionEnabled = YES;

    ScrollImageView * scrollImageView=[[ScrollImageView alloc]initWithArray:arr andInt:0];
    scrollImageView.delegate = self;
    [self addSubview:scrollImageView];
    
    
    
    self.numLabel  = [[UILabel alloc]initWithFrame:CGRectMake(60, KDeviceHeight-60, KDeviceWidth-120, 44)];
//    self.numLabel.text = numArr[0];
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self bringSubviewToFront:self.numLabel];
    [self addSubview:self.numLabel];

    return  self;
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    int currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    NSLog(@"%i", currentPage);
    
    self.nameLabel.text = self.namelistArr[currentPage];
    self.numLabel.text = self.numlistArr[currentPage];
    
    //    upnumberLabel.text = [ NSString stringWithFormat:@"%i", currentPage+1];
    
    
}

@end
