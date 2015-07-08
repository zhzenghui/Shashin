//
//  Cookie.m
//  M32
//
//  Created by i-Bejoy on 13-12-6.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "Cookie.h"

@implementation Cookie

#define KNSUserDefaults [NSUserDefaults standardUserDefaults]

+ (id)getCookie:(NSString*)keyName {
  if (![keyName isEqualToString:@""] && keyName != nil) {
    id dict = [KNSUserDefaults objectForKey:keyName];

    if (!dict) {
      return nil;
    }
    return dict;
  }

  return nil;
}

+ (void)setCookie:(NSString*)keyName value:(id)value;
{
  [KNSUserDefaults setObject:value forKey:keyName];

  [KNSUserDefaults synchronize];
}

@end
