//
//  CooladingManager.h
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Session.h"
#import "IBJUser.h"


extern NSString* CooladingManagerError;

enum {
  CooladingManagerErrorCommuntitySearchCode,
};




/**
 *  当前客户所处于的流程
 */
typedef NS_ENUM(NSInteger, UserProcessStatus){
    /**
     *  游客没有预约
     */
    UserProcessStatusGuest,
    /**
     *  用户注册，但是没有预约
     */
    UserProcessStatusRegistered,
    /**
     *  已经预约
     */
    UserProcessStatusSubScribe,
    /**
     *  预约进行中
     */
    UserProcessStatusSubScribeQueuing,
    /**
     *  预约成功,即将联系
     */
    UserProcessStatusSubScribeSuccess,
    /**
     *  管家匹配成功Tip
     */
    UserProcessStatusHousekeeperSuccessTip,
    /**
     *  管家匹配成功
     */
    UserProcessStatusHousekeeperSuccess,
    /**
     *  监理匹配成功
     */
    UserProcessStatusSupervise,
    /**
     *  设计师匹配成功
     */
    UserProcessStatusDesignerSuccess,
    /**
     *  装修队匹配成功
     */
    UserProcessStatusConstructionSuccess,

};


/**
 *  施工状态
 */
typedef NS_ENUM(NSInteger, ConstructionStatus){
    /**
     *  施工前
     */
    ConstructionStatusBefore = 1 ,
    /**
     *  施工中
     */
    ConstructionStatusProcess = 2,
    
    /**
     *  施工完成
     */
    ConstructionStatusSuccess = 3
};




@class IBJUser;


/**
 *  全局的托管中心 包括网络  user session  等信息
 */
@interface CooladingManager : NSObject {

}

@property(nonatomic, strong) IBJUser *user;
/**
 *  当前用户所处于流程
 */
@property(nonatomic, assign) UserProcessStatus userProcessStatus;
/**
 *  用户装修流程状态
 */
@property(nonatomic, assign) ConstructionStatus constructionStatus;




+ (CooladingManager*)sharedCooladingManager;



@end
