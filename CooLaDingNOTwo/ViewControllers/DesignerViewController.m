//
//  DesignerViewController.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/29.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "DesignerViewController.h"

#import "UIImageView+WebCache.h"

#import "ShowCaseViewController.h"

@interface DesignerViewController()
{
    UILabel *nameLabel;
    UIImageView *headerImageView;
    UILabel *price;
    
    UILabel *description;
    
    UILabel *title;
    UILabel *caseLabel;
    UILabel *serverLabel;
    
    UIScrollView *caseScrollView;
    
    UIButton *backButton;
    
    
    
}



@end

@implementation DesignerViewController

-(void)back :(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadUData {
    NSString *urlStr = self.dict[@"minHeadImageUrl"]; ;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    
    nameLabel.text =  self.dict[@"realName"]; //@"test";
    price.text = self.dict[@"dgPrice"]; //@"$111~200";
    description.text = self.dict[@"dgMaxim"]; //@"我们年轻，我们认真，我们在路上一起成长 副本";




//    caseLabel.backgroundColor = TEST_COLOR;
//    serverLabel.backgroundColor = TEST_COLOR;
//    
    if (self.listType == ListTypeDesigner) {
    

        title.text = @"元洲资深设计主任";
//        caseLabel.text = [NSString stringWithFormat:@"%@%@",  self.dict[@"authResult"],@"套设计方案"];
//        serverLabel.text = [NSString stringWithFormat:@"%@%@",  self.dict[@"serveCount"],@"人服务过"];
        price.text = self.dict[@"dgPrice"]; //@"$111~200";
        
        
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@完成工地",  self.dict[@"authResult"]]];
        [string addAttribute:NSForegroundColorAttributeName value:KYello range:NSMakeRange(0,1)];
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:30] range:NSMakeRange(0,1)];
        
        caseLabel.attributedText = string;
        
        
        NSMutableAttributedString * zaiShiGongdiShuString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@在施工地",  self.dict[@"serveCount"]]];
        [zaiShiGongdiShuString addAttribute:NSForegroundColorAttributeName value:KYello range:NSMakeRange(0,1)];
        [zaiShiGongdiShuString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:30] range:NSMakeRange(0,1)];
        serverLabel.attributedText = zaiShiGongdiShuString;
        
        

    }
    else  {
        
        //        //            ucount fcount authResult
        title.text = @"元洲资深工长";
        caseLabel.text = [NSString stringWithFormat:@"%@%@",  self.dict[@"ucount"],@"个完成工地"];
        serverLabel.text = [NSString stringWithFormat:@"%@%@",  self.dict[@"fcount"],@"个在施工地"];
        price.text = self.dict[@"provinceName"]; //@"$111~200";
        
        
        
        
        //            attributedText
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@个完成工地",  self.dict[@"ucount"]]];
        [string addAttribute:NSForegroundColorAttributeName value:KYello range:NSMakeRange(0,1)];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0,1)];
        
        caseLabel.attributedText = string;
        
        
        NSMutableAttributedString * zaiShiGongdiShuString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@个在施工地",  self.dict[@"fcount"]]];
        [zaiShiGongdiShuString addAttribute:NSForegroundColorAttributeName value:KYello range:NSMakeRange(0,1)];
        [zaiShiGongdiShuString addAttribute:NSFontAttributeName value:[UIFont  boldSystemFontOfSize:30] range:NSMakeRange(0,1)];
        serverLabel.attributedText = zaiShiGongdiShuString;
        
        
        
        

    }
}


- (void)openCase:(UITapGestureRecognizer *)recognizer {
    UIView *v = [recognizer view];

    
    NSArray *list = self.dict[@"workList"][v.tag - 1][@"workDetailList"];

    ShowCaseViewController *scvc = [[ShowCaseViewController alloc] init];
    
    scvc.list = list;
    
    [self.navigationController pushViewController:scvc animated:YES];
    
    
}


- (void)loadDataForView  {
    
    
    
    NSArray *list = self.dict[@"workList"];

    
    
    float width = 260;
    
    for ( int i  = 0; i < list.count; i++) {
        
        NSDictionary *designerDict = list[i];
        
        
        
        
        UIView *designerView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, 260, 367)];
        designerView.tag = i + 1;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCase:)];
        [designerView addGestureRecognizer:tap];
        [caseScrollView addSubview:designerView];
        
        
        
        
        
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 214, 213)];
        [designerView addSubview:avatar];
        avatar.backgroundColor = [UIColor whiteColor];
        avatar.layer.masksToBounds = YES;
        avatar.layer.cornerRadius = 6;
        avatar.layer.borderWidth = .5;
        avatar.layer.borderColor = [[UIColor grayColor] CGColor];
        [avatar sd_setImageWithURL:[NSURL URLWithString:designerDict[@"coverImageUrl"]]];
        
        
        
        //    名字
        UILabel *caseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 273, 214, 20)];
        caseNameLabel.font = [UIFont systemFontOfSize:20];
        [designerView addSubview:caseNameLabel];
        caseNameLabel.textAlignment = NSTextAlignmentCenter;
        caseNameLabel.text = designerDict[@"workName"];
        
        
    }
    
    
    [caseScrollView setContentSize:CGSizeMake(width * list.count, 367)];
    
    
    
}

#pragma <#arguments#>


- (void)loadView {
    [super loadView];
    
    
    
    
    UIImageView *navbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 88)];
    navbar.image = [UIImage imageNamed:@"navbar_backround"];
    [self.view addSubview:navbar];

    headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32, 172, 184, 184)];
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.cornerRadius = 6;
    headerImageView.layer.borderWidth = .5;
    headerImageView.layer.borderColor = [KYello CGColor];
    
    [self.view addSubview:headerImageView];
    
    
//    名字
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(253, 241, 100, 30)];
    nameLabel.font = [UIFont boldSystemFontOfSize:25];
    [self.view addSubview:nameLabel];
    
    
//      价格
    price =  [[UILabel alloc] initWithFrame:CGRectMake(253, 284, 120, 30)];
    price.font = [UIFont systemFontOfSize:18];
    price.backgroundColor = KYello;
    price.layer.masksToBounds = YES;
    price.layer.cornerRadius = 10;
    price.textAlignment = NSTextAlignmentCenter;
    price.textColor = [UIColor whiteColor];
    [self.view addSubview:price];
    
//      介绍
    description = [[UILabel alloc] initWithFrame:CGRectMake(253, 342, 500, 18)];
    description.font = [UIFont boldSystemFontOfSize:20];
    description.textColor = [UIColor grayColor];
    
    [self.view addSubview:description];
    
//    方案
    caseLabel = [[UILabel alloc] initWithFrame:CGRectMake(700, 284, 300, 30)];
    caseLabel.font = [UIFont boldSystemFontOfSize:25];
    caseLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:caseLabel];
    
//    服务过
    serverLabel = [[UILabel alloc] initWithFrame:CGRectMake(700, 332, 300, 30)];
    serverLabel.font = [UIFont boldSystemFontOfSize:25];
    serverLabel.textAlignment = NSTextAlignmentRight;

    [self.view addSubview:serverLabel];
    
//    头衔
    
    title =  [[UILabel alloc] initWithFrame:CGRectMake(850, 162, 153, 30)];
    title.font = [UIFont systemFontOfSize:18];
    title.backgroundColor = KYello;
    title.layer.masksToBounds = YES;
    title.layer.cornerRadius = 10;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    
//    案例卷
    caseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400, 1024, 367)];
    [self.view addSubview:caseScrollView];
    
    
//    
 
    
//    toolbar
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, 716, 1024, 52)];
    toolbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolbar];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 2)];
    line.backgroundColor = KYello;
    [toolbar addSubview:line];
    
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(30, 10, 44, 44);
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [toolbar addSubview:backButton];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarView.hidden = YES;
    
    [self loadUData];
    
    [self loadDataForView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}


@end
