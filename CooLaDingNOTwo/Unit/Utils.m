//
//  Utils.m
//  Coolading
//
//  Created by mUser on 15/1/4.
//  Copyright (c) 2015年 zeng. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString*)getUserTokenID; {
    
    return @"";
}

+ (NSString*)desgnerTokenID; {
    
    return @"";
}


//获取全局配置项
+ (NSString*)getGlobalConfig:(NSString*)type {
  NSString* strReturn = @"";

  NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
  if ([prefs objectForKey:type]) {
    strReturn = [prefs objectForKey:type];
  }
  return strReturn;
}

//修改全局配置项
+ (void)setGlobalConfig:(NSString*)Val Type:(NSString*)type {
  NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
  [prefs setObject:Val forKey:type];
  [prefs synchronize];
}

+ (BOOL)getGlobalConfigBool:(NSString*)type {
  NSString* strReturn = [self getGlobalConfig:type];
  if ([strReturn isEqualToString:@"yes"]) {
    return YES;
  }
  return NO;
}

@end
