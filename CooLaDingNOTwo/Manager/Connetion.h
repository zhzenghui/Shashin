//
//  Connetion.h
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/5.
//  Copyright (c) 2015年 coolading. All rights reserved.
//
#import "IBJUser.h"
#import <Foundation/Foundation.h>
#import "IBJUser.h"






@interface Connetion : NSObject

//  DEBUG 模式
/// 是否显示url 日志 , 默认打印
@property(nonatomic, assign) BOOL noLog;

//  是否显示网络访问的提示，默认不显示（  YES 显示， NO 不现实）
@property(nonatomic, assign) BOOL isShowHUD;


+ (Connetion *)shared;






/**
 *  工长数据
 *
 *  @param finishBlock
 */
- (void)workTeamData:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock;


/**
 *  设计师数据
 *
 *  @param finishBlock
 */
- (void)designData:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock;

@end
