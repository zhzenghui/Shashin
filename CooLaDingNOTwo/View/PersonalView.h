//
//  PersonalView.h
//  CooLaDingNOTwo
//
//  Created by hui zeng on 6/8/15.
//  Copyright (c) 2015 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong)UIImageView *nImageView;

@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *numLabel;

@property(nonatomic, strong) NSArray *namelistArr;
@property(nonatomic, strong) NSArray *numlistArr;
+ (id)share;
-(PersonalView *)rect:(CGRect)rect imageName:(NSString *)imageName addTarget:(id)target tag:(int)tag addT:(SEL)selecter labelText:(NSString *)text;

-(PersonalView *)cgRect:(CGRect)rect addTarget:(id)target tag:(int)tag addT:(SEL)selecter;


-(PersonalView *)cgRect:(CGRect)rect addTarget:(id)target tag:(int)tag addT:(SEL)selecter name:(NSString *)name;



-(PersonalView *)addArr:(NSArray *)arr num:(int)num addTarget:(id)target tag:(int)tag addT:(SEL)selecter cgRect:(CGRect)rect dataMarr:(NSMutableArray *)dataMarr;
@end
