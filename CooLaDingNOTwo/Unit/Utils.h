//
//  Utils.h
//  Coolading
//
//  Created by mUser on 15/1/4.
//  Copyright (c) 2015年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString*)getUserTokenID;
+ (NSString*)desgnerTokenID;
+ (NSString*)getGlobalConfig:(NSString*)type;
+ (void)setGlobalConfig:(NSString*)Val Type:(NSString*)type;
+ (BOOL)getGlobalConfigBool:(NSString*)type;
@end
