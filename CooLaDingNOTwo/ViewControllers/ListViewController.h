//
//  ListViewController.h
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/30.
//  Copyright (c) 2015年 coolading. All rights reserved.
//



#import "BaseViewController.h"



typedef NS_ENUM(NSInteger, ListType) {
    ListTypeDesigner,
    ListTypeConstruction
};






@interface ListViewController : BaseViewController


@property(nonatomic, strong) NSMutableArray *list;

@property(nonatomic, assign) ListType listType;

@end
