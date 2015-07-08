//
//  IBJUser.h
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ibj 用户对象模型
 */

@interface IBJUser : NSObject<NSCoding>

/**
 *  工地id
 */
@property(nonatomic, strong) NSString* serveId;


/**
 *  登录设备
 */
@property(nonatomic, strong) NSString* device;

/**
 *
 */
@property(nonatomic, strong) NSString* tokenId;

/**
 *  客户名称
 */
@property(nonatomic, strong) NSString* customName;

/**
 *  昵称
 */
@property(nonatomic, strong) NSString* nickName;


@property(nonatomic, strong) NSString* phoneNumber;


/**
 *   性别 1-男 0-女
 */
@property(nonatomic, strong) NSString* sex;
/**
 *  省
 */
@property(nonatomic, strong) NSString *province;
/**
 *  市
 */
@property(nonatomic, strong) NSString *city;

/**
 *  详细地址
 */
@property(nonatomic, strong) NSString *houseAddress;

/**
 *  面积
 *
 */
@property(nonatomic, strong) NSString* houseArea;
/**
 *  装修情况 0-未装修 1-已装修
 */
@property(nonatomic, strong) NSString* houseType;
/**
 *  预算
 */
@property(nonatomic, strong) NSString*  budget;



@property(nonatomic, strong) NSString* type;
@property(nonatomic, strong) NSString* iconPath;
@property(nonatomic, strong) NSDate  * lastLoginTime;
@property(nonatomic, strong) NSString* profileIcon;
@property(nonatomic, strong) NSString* residential;
@property(nonatomic, strong) NSString* identity;
@property(nonatomic, strong) NSString* userName;
@property(nonatomic, strong) NSString* pwd;
@property(nonatomic, strong) NSString* nPassword;
@property(nonatomic, strong) NSString* oldPassword;

@property(nonatomic, assign) NSInteger indexType;
@property(nonatomic, strong) NSString *loginTime;
//@property(nonatomic, strong) NSString *userPhoto;
@property(nonatomic, strong) NSString *userPhoto;




/**   初始化ibj用户对象名称。

 */
- (id)initWithPhone:(NSString*)phone pwd:(NSString*)pwd;

- (id)initWithDict:(NSDictionary *)userDict;

- (NSDictionary *)getUser:(IBJUser *)user; 
- (void)setUserDict:(NSDictionary *)userDict;

@end
