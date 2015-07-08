//
//  ProjectInfomation.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/16.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "ProjectInfomation.h"

@implementation ProjectInfomation


/// 获取工程的版本号BundleVersion（可配置数字之间的连接符，使用默认传入nil）
+ (NSString *)getBundleVersionComponentsJoinedBy:(NSString *)joinStr
{
    NSString *curVer = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey];
    
    if ((joinStr != nil) && [joinStr isKindOfClass:[NSString class]]) {
        curVer = [[curVer componentsSeparatedByString:@"."] componentsJoinedByString:joinStr];
    }
    
    if (curVer.length <= 0) {
        curVer = @"";
    }
    
    return curVer;
}


@end
