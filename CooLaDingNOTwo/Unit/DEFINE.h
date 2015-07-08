//
//  DEFINE.h
//  Coolading
//
//  Created by mUser on 15/1/3.
//  Copyright (c) 2015年 zeng. All rights reserved.
//

#import "Utils.h"

#pragma mark - 全局基础配置

#define isLoginXMPP 1  //是否登陆xmpp服务器@"182.92.155.189"//
//#define KXMPPHost @"service.coolading.com"
//#define KXMPPHost @"182.92.155.189"

#pragma mark - 请求域名地址
// xmpp服务地址http://182.92.155.189:9090
//后台账号密码 admin coolading
//#ifdef DEBUG
//@"http://192.168.1.100:8080", 








#define kDomainUrl @"http://192.168.1.100:9999"
#define kDomain @"http://192.168.1.100:8080/rest"
#define kImageDomain @" http://192.168.1.100:6666/image"



//#define kDomainUrl @"http://182.92.155.189:9999"
//#define kDomain @"http://182.92.155.189:9999/rest"
//#define kImageDomain @" http://182.92.155.189:9999/image"




#define KCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KCachesDirectoryFiles [KCachesDirectory stringByAppendingPathComponent:@"/files"]
#define KCachesName(fileName) [NSString stringWithFormat:@"%@/%@", KCachesDirectoryFiles, fileName]

#define KDocumentDirectory  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KDocumentDirectoryPhoto [KDocumentDirectory stringByAppendingPathComponent:@"/photo"]
#define KDocumentName(fileName) [NSString stringWithFormat:@"%@/%@", KDocumentDirectoryPhoto, fileName]




#define kResource @"iPhone"

#define KDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define KDeviceNavHeight 64
#define KDeviceToolBarHeight 170

#define DK @""

#define KServerPhone @"13801031631"

#define KchangeCooladingManagerNotifition @"changeCooladingManagerNotifition"


#define Kstatus @"status"
#define Kmsg @"msg"
#define Kresult @"result"
#define KreadDateMDcitionary @"readDateMDcitionary"

#define KloginSucess @"KloginSucess"

#define KKloadRCIM @"KloadRCIM"
#define KYello   [UIColor colorWithRed:246 / 255.0 \
                  green:171 / 255.0 \
                   blue:0 / 255.0   \
                  alpha:1.00f]
#define KRed  [UIColor colorWithRed:230 / 255.0 green:5 / 255.0 blue:39 / 255.0 alpha:1.0f]

#define KWhitch [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0f]

#define KmainViewHeight mainView.frame.size.height

#define Kbackground [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1]

#define color(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]



#define KiPhone5 (KDeviceWidth==320)
#define KiPhone6 (KDeviceWidth==375)
#define KiPhone6p (KDeviceWidth==414)

#define wProportion 375.0*KDeviceWidth
#define hProportion 667.0*KDeviceHeight


/* *** DEBUG DEFINE *** */
// 测试用色（正常状态下置0，为透明色）
#if DEBUG
#define TEST_COLOR                                 \
  ([UIColor colorWithRed:arc4random() % 10 / 10.0f \
                   green:arc4random() % 10 / 10.0f \
                    blue:arc4random() % 10 / 10.0f \
                   alpha:0.8])
#else
#define TEST_COLOR ([UIColor clearColor])
#endif

#pragma mark - 请求域名地址





#define SERVICE_NAME @"ANY_NAME_FOR_YOU"
#define GROUP_NAME \
@"YOUR_APP_ID.com.apps.shared"  // GROUP NAME should start with application
// identifier.


//根据地区获取位置...
#define kCityLocation(longitude, latitude)                               \
  ([NSString stringWithFormat:@"%@location/pos?long=%f&lat=%f", kDomain, \
                              longitude, latitude])



//计算 文字 宽度高度
#define calculateContentSize(contentText, width, height, font)         \
  [contentText                                                         \
      boundingRectWithSize:CGSizeMake(width, height)                   \
                   options:NSStringDrawingUsesLineFragmentOrigin       \
                attributes:@{                                          \
                  NSFontAttributeName : [UIFont systemFontOfSize:font] \
                } context:nil].size
