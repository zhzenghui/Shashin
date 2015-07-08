//
//  ListViewController.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/30.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "ListViewController.h"
#import "UIImageView+WebCache.h"

#import "DesignerViewController.h"

@interface ListViewController ()
{
    UIScrollView *caseScrollView;
}
@end

@implementation ListViewController

- (void)openCDUser:(UITapGestureRecognizer *)recognizer {
    
    UIView *v = [recognizer view];
    
    NSDictionary *dict =  self.list[v.tag-1];
    
    

    DesignerViewController *desi = [[DesignerViewController alloc] init];
    desi.dict = dict;
    desi.listType = self.listType;
    [self.navigationController pushViewController:desi animated:YES];
    
    
    
}

- (void)loadDataForView  {
    
    

    
    
    float width = 366;
    
    for ( int i  = 0; i < self.list.count; i++) {
        
        NSDictionary *designerDict = self.list[i];
        
        
        
        
        UIView *designerView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, 344, 587)];
        designerView.tag = i + 1;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCDUser:)];
        [designerView addGestureRecognizer:tap];
        [caseScrollView addSubview:designerView];
        
        
        
        
        
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 344, 395)];
        [designerView addSubview:avatar];
        avatar.backgroundColor = [UIColor whiteColor];
        avatar.layer.masksToBounds = YES;
        avatar.layer.cornerRadius = 6;
        avatar.layer.borderWidth = .5;
        avatar.layer.borderColor = [[UIColor grayColor] CGColor];
        [avatar sd_setImageWithURL:[NSURL URLWithString:designerDict[@"headImageUrl"]]];
        
        
        
        //    名字
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 473, width, 20)];
        nameLabel.font = [UIFont boldSystemFontOfSize:25];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = KYello;
        [designerView addSubview:nameLabel];
        
        
        
        //      价格
        UILabel *price =  [[UILabel alloc] initWithFrame:CGRectMake(132, 423, 121, 33)];
        price.font = [UIFont systemFontOfSize:18];
        price.backgroundColor = KYello;
        price.layer.masksToBounds = YES;
        price.layer.cornerRadius = 10;
        price.textAlignment = NSTextAlignmentCenter;
        price.textColor = [UIColor whiteColor];
        [designerView addSubview:price];
        

        
        
        
        //      介绍
        UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(0 , 511, width , 18)];
        description.font = [UIFont systemFontOfSize:12];
        description.textColor = [UIColor grayColor];
        description.textAlignment = NSTextAlignmentCenter;
        
        [designerView addSubview:description];
        
        
        //      总工地
        UILabel *gongdiShu = [[UILabel alloc] initWithFrame:CGRectMake(0 , 505, width , 18)];
        gongdiShu.font = [UIFont systemFontOfSize:12];
        gongdiShu.textColor = [UIColor grayColor];
        gongdiShu.textAlignment = NSTextAlignmentCenter;
        
        [designerView addSubview:gongdiShu];
        
        
        //      在施工地
        UILabel *zaiShiGongdiShu = [[UILabel alloc] initWithFrame:CGRectMake(0 , 528, width , 18)];
        zaiShiGongdiShu.font = [UIFont systemFontOfSize:12];
        zaiShiGongdiShu.textColor = [UIColor grayColor];
        zaiShiGongdiShu.textAlignment = NSTextAlignmentCenter;
        
        [designerView addSubview:zaiShiGongdiShu];
        
        
        

        if (self.listType == ListTypeDesigner) {
            
            nameLabel.text = designerDict[@"realName"];
            
            price.text = designerDict[@"dgPrice"];
            
            description.text = designerDict[@"dgMaxim"];
     
        }
        else  {
            
//            description
            nameLabel.text = designerDict[@"realName"];
            
            price.text = designerDict[@"provinceName"];
//            ucount fcount authResult
            description.text = designerDict[@"dgMaxim"];
            
            gongdiShu.text = [NSString stringWithFormat:@"%@完成工地",  designerDict[@"ucount"]];
            zaiShiGongdiShu.text = [NSString stringWithFormat:@"%@在施工地",  designerDict[@"fcount"]];
            
            
            
            //            attributedText
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@个完成工地",  designerDict[@"ucount"]]];
            [string addAttribute:NSForegroundColorAttributeName value:KYello range:NSMakeRange(0,1)];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:NSMakeRange(0,1)];

            gongdiShu.attributedText = string;
            
            
            NSMutableAttributedString * zaiShiGongdiShuString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@个在施工地",  designerDict[@"fcount"]]];
            [zaiShiGongdiShuString addAttribute:NSForegroundColorAttributeName value:KYello range:NSMakeRange(0,1)];
            [zaiShiGongdiShuString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:NSMakeRange(0,1)];
            zaiShiGongdiShu.attributedText = zaiShiGongdiShuString;
            
        }


        
        
    }
    
    
    [caseScrollView setContentSize:CGSizeMake(width * self.list.count, 350)];
    
    
    
}

-(void)back :(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)loadView {
    [super loadView];
    
    
    UIImageView *navbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 88)];
    navbar.image = [UIImage imageNamed:@"navbar_backround"];
    [self.view addSubview:navbar];
    
    //    toolbar
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, 716, 1024, 52)];
    toolbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolbar];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 2)];
    line.backgroundColor = KYello;
    [toolbar addSubview:line];
    
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(30, 10, 44, 44);
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [toolbar addSubview:backButton];
    
    
    //    案例卷
    caseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 131, 1024, 585)];
    [self.view addSubview:caseScrollView];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];


    [self loadDataForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
