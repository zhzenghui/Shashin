//
//  IBJUser.m
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "IBJUser.h"
#import "CCLog.h"
#import "CooladingManager.h"

@implementation IBJUser

- (id)initWithPhone:(NSString *)phone pwd:(NSString *)pwd {
  if (self = [super init]) {
    _phoneNumber = phone;
    _pwd = pwd;
  }
  return self;
}


//indexType = 3;//0代表首页、1代表预约没处理页、2代表未签约、3代表已签约
//loginTime = 1434079317055;
//nickName = "\U5efa\U8bae\U8f93\U5165\U60a8\U7684\U771f\U662f\U59d3\U540d";
//tokenId = Q29vbGFkaW5nLVNFQ1RFVDoxNDM0MDc5MzE3OjE0;
//userName = 13888888888;
//userPhoto = "http://192.168.1.100:6666/images/head/2015/14_208.jpg";
- (id)initWithDict:(NSDictionary *)userDict; {
   
    if (self = [super init]) {
        

        [self setUserDict:userDict];

    }
    return self;
    
}

- (NSDictionary *)getUser:(IBJUser *)user; {
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
    userDict[@"tokenId"] = _tokenId ;
    userDict[@"nickName"] = _nickName ;
    userDict[@"userPhoto"] = _userPhoto ;
    userDict[@"userName"] = _userName ;
    userDict[@"loginTime"] = _loginTime ;
    userDict[@"indexType"]  = [NSNumber numberWithInteger:  _indexType ];
    
    return [NSDictionary dictionaryWithDictionary:userDict];
}


- (void)setUserDict:(NSDictionary *)userDict; {
    
    _tokenId = userDict[@"tokenId"];
    _nickName = userDict[@"nickName"];
    _userPhoto = userDict[@"userPhoto"];
    _userName = userDict[@"userName"];
    _loginTime = userDict[@"loginTime"];
    _indexType = [userDict[@"indexType"] intValue];
    
    //0代表首页、1代表预约没处理页、2代表未签约、3代表已签约
    UserProcessStatus ups = 0;
    ConstructionStatus cs = ConstructionStatusBefore;
    switch (_indexType) {
        case 0:
            ups = UserProcessStatusRegistered;
            break;
        case 1:
            ups = UserProcessStatusSubScribeQueuing;
            break;
        case 2:
            ups = UserProcessStatusSubScribeSuccess;
            break;
        case 3:
            ups = UserProcessStatusHousekeeperSuccess;
            cs = ConstructionStatusProcess;

            break;
            
        default:
            break;
    }
    
    [CooladingManager sharedCooladingManager].userProcessStatus = ups;
    [CooladingManager sharedCooladingManager].constructionStatus = cs;

    
}


//
//- (id)initWithCoder:(NSCoder *)coder {
//  NSString *username = [coder decodeObjectForKey:@"username"];
//  NSString *phone = [coder decodeObjectForKey:@"phone"];
//  NSString *pwd = @"";  //[coder decodeObjectForKey:@"pwd"];
//  NSString *identity = [coder decodeObjectForKey:@"id"];
//  NSString *residential = [coder decodeObjectForKey:@"residential"];
//  NSString *address = [coder decodeObjectForKey:@"address"];
//  NSString *nickName = [coder decodeObjectForKey:@"nickName"];
//    NSString *customName = [coder decodeObjectForKey:@"customName"];
//
//  NSString *iconPath = [coder decodeObjectForKey:@"iconPath"];
//  NSString *token = [coder decodeObjectForKey:@"token"];
//  NSDate *lastLoginTime = [coder decodeObjectForKey:@"lastLoginTime"];
//  NSString *profileIcon = [coder decodeObjectForKey:@"profileIcon"];
//
//  NSError *error = nil;
//
//  self = [self initWithPhone:phone pwd:pwd];
//
//  self.identity = identity;
//  self.username = username;
//  self.residential = residential;
//  self.phoneNumber = phone;
//  self.houseAddress = address;
//  self.nickName = nickName;
//    self.customName = customName;
//
//  self.iconPath = iconPath;
//  self.tokenId = token;
//  self.lastLoginTime = lastLoginTime;
//  self.profileIcon = profileIcon;
//
//  if (self == nil) DLog(@"*** Could not unarchive %@: %@", self.class, error);
//
//  return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)coder {
//  [coder encodeObject:self.username forKey:@"username"];
//  [coder encodeObject:self.phoneNumber forKey:@"phone"];
//  //    [coder encodeObject:self.pwd forKey:@"pwd"];
//  [coder encodeObject:self.identity forKey:@"id"];
//  [coder encodeObject:self.residential forKey:@"residential"];
//  [coder encodeObject:self.houseAddress forKey:@"address"];
//  [coder encodeObject:self.customName forKey:@"nickName"];
//
//  [coder encodeObject:self.iconPath forKey:@"iconPath"];
//  [coder encodeObject:self.tokenId forKey:@"token"];
//  [coder encodeObject:self.lastLoginTime forKey:@"lastLoginTime"];
//  [coder encodeObject:self.profileIcon forKey:@"profileIcon"];
//}

@end
