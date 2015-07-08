//
//  DeviceUUID.h
//  BaseLib
//
//  Created by bejoy on 14/12/30.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

/**
 *  广告标示符 ， 用户不主动改变的话每次时不会变更的。  http://www.cnblogs.com/BigPolarBear/p/3359526.html
 *
 *  @return  
 */
+ (NSString*)idfa;

/**
 *  不要使用这个， 对内的程序使用。 每次重装返回值都不一样
 *
 *  @return
 */
+ (NSString*)idfv;



/**
 *  推送通知的 deviceToken
 *
 *  @return token
 */
+ (NSString*)deviceToken;


/**
 *  设备型号
 *
 *  @return iPhone， iPod touch
 */
+ (NSString *)deviceModel;



@end
