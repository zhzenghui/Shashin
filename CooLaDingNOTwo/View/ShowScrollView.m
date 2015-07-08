//
//  ShowScrollView.m
//  CooLaDingNOTwo
//
//  Created by hui zeng on 6/11/15.
//  Copyright (c) 2015 coolading. All rights reserved.
//
#import "DEFINE.h"
#import "ShowScrollView.h"


@interface ShowScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UIImage * image;
@property (nonatomic,assign)CGSize size;


@end
@implementation ShowScrollView

//将输入的frame等比缩放到宽或
-(CGSize)transfomFrameImage:(UIImage *)image
{
    
    
    CGFloat width=image.size.width/KDeviceWidth;
    CGFloat height=image.size.height/KDeviceHeight;
    CGFloat w;
    CGFloat h;
    if (width>height) {
        w=image.size.width/width;
        h=image.size.height/width;
    }
    else
    {
        w=image.size.width/height;
        h=image.size.height/height;
        
        
    }
    CGSize s=CGSizeMake(w, h);
    
    
    
    return s;
}
- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)image
{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        self.bounces=NO;
        
         UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        
        self.image=img;
        
        _size=[self transfomFrameImage:img];
        self.imageView=[[UIImageView alloc]initWithImage:img];
        self.imageView.frame=CGRectMake(0, 0, _size.width, _size.height);
        self.imageView.userInteractionEnabled=YES;
        [self setupGestureRecognizer];
        [self addSubview:self.imageView];
        
        self.contentSize=frame.size;
        
        self.imageView.center = CGPointMake(self.contentSize.width * 0.5, self.contentSize.height * 0.5);
        
        self.backgroundColor=[UIColor blackColor];
        
        //设置最大伸缩比例
        self.maximumZoomScale=2.0;
        //设置最小伸缩比例
        self.minimumZoomScale=0.5;
        
    }
    return self;
}
- (void)setupGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapGestureRecognizer.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:tapGestureRecognizer];
    
    UITapGestureRecognizer * tapOne=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapone:)];
    tapOne.numberOfTapsRequired=1;
    [_imageView addGestureRecognizer:tapOne];
    [tapOne requireGestureRecognizerToFail:tapGestureRecognizer];
}
- (void)tapHandler:(UITapGestureRecognizer *)recognizer
{
    if (CGRectGetWidth(recognizer.view.frame)!=_size.width) {
        [self setZoomScale:1.0 animated:YES];
    }
    else
    {
        [self setZoomScale:self.maximumZoomScale animated:YES];
    }
    
}
-(void)tapone:(UITapGestureRecognizer *)sender
{
    if (self.zoomScale!=1.0) {
        [self setZoomScale:1.0 animated:YES];
    }
//    else  {
//                UIView * v=[sender view];
//                [v.superview.superview removeFromSuperview];
//                UIWindow * window= [UIApplication sharedApplication].keyWindow;
////                for (UIView * view in window.subviews) {
////                    if ([view isKindOfClass:[UIPageControl class]]) {
////                        [view removeFromSuperview];
////                    }
////                }
//    }
    
    
}



-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //
    NSLog(@"%@",scrollView);
    NSLog(@"%@",NSStringFromCGRect(scrollView.bounds));
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    //self.imageView.center=self.view.center;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
