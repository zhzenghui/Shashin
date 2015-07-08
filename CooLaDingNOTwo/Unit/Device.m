//
//  DeviceUUID.m
//  BaseLib
//
//  Created by bejoy on 14/12/30.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "Cookie.h"
#import "Device.h"



@implementation Device

+ (NSString*)idfa {
  NSString* adId =
      [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

  return adId;
}

+ (NSString*)idfv {
  NSString* idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
  return idfv;
}

+ (NSString*)deviceToken {
    
  NSString* deviceToken = [Cookie  getCookie:@"deviceToken"];
  return deviceToken;
}

+ (NSString *)deviceModel {
    
    
    return [[UIDevice currentDevice] model];
}

@end
