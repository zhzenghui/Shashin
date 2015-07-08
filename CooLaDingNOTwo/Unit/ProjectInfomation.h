//
//  ProjectInfomation.h
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/16.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectInfomation : NSObject


/**
 *  获取工程的版本号BundleVersion（可配置数字之间的连接符，使用默认传入nil）
 *
 *  @param osType         app类型
 */
+ (NSString *)getBundleVersionComponentsJoinedBy:(NSString *)joinStr;




@end
