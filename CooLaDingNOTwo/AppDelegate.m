//
//  AppDelegate.m
//  CooLaDingNOTwo
//
//  Created by savvy on 15/6/3.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllers/ViewController.h"
#import "CCLog.h"
#import "Session.h"
#import "IBJUser.h"
#import "Cookie.h"
#import <RongIMKit/RongIMKit.h>
#import "CooLaDingNOTwo-swift.h"
#import "SDImageCache.h"


@interface AppDelegate ()

@end

@implementation AppDelegate




#pragma mark - user

- (void)getUserInfomation {
    
    NSInteger ups = [[Cookie getCookie:@"userProcessStatus"] integerValue];
    NSInteger cts = [[Cookie getCookie:@"constructionStatus"] integerValue];
    
    NSDictionary *userDict =  [Cookie getCookie:@"userInfo"];;
    IBJUser *user = [[IBJUser alloc] initWithDict:userDict];
    if ( ! [user isKindOfClass:[IBJUser class]] ) {
        user = [[IBJUser alloc] init];
    }

#ifdef  DEBUG
//    user.tokenId = @"Q29vbGFkaW5nLVNFQ1RFVDoxNDMzOTg3MzE2OjI4";
//    user.userPhoto = @"http://img5q.duitang.com/uploads/item/201410/30/20141030131546_JaZjm.jpeg";
//    user.phoneNumber = @"111111111111";
//    [CooladingManager sharedCooladingManager].constructionStatus = ConstructionStatusBefore;
//    user.houseAddress = @"先帝创业未半哦日中道崩殂";
//    user.nickName = @"王大锤";
#endif
    [CooladingManager sharedCooladingManager].user = user;

    
    if (ups == 0) {
        [CooladingManager sharedCooladingManager].userProcessStatus = UserProcessStatusGuest;
    }
    else  {
        [CooladingManager sharedCooladingManager].userProcessStatus = ups;

    }
    
    if (cts == 0) {
        [CooladingManager sharedCooladingManager].constructionStatus = ConstructionStatusBefore;
    }
    else {
        [CooladingManager sharedCooladingManager].constructionStatus = cts;

    }


    
}

#pragma mark - rcim
- (void)loadBaiduMap {
    

    
    
}
- (void)loadRCIM {
    
    
    //初始化融云SDK，
    NSString *deviceToken = [Cookie getCookie:@"deviceToken"];

    //初始化融云SDK，
    [[RCIM sharedRCIM] initWithAppKey:@"0vnjpoadn5u1z" deviceToken:deviceToken];

    
    NSString *token =  [Cookie getCookie:@"rcToken"];
    
    //                    NSString *token = tkInfo[@"token"];
    
    if ( token ) {
        [[RCIM sharedRCIM] disconnect];
        
        
        // 快速集成第二步，连接融云服务器
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            
            DLog(@"启动成功：userId %@", userId);
        } error:^(RCConnectErrorCode status) {
            
            DLog(@"启动失败： %li", (long)status);
            
        } tokenIncorrect:^{
            DLog(@"token错误或者过期。");
        }];
        

        return;
    }
    
//    {"code":200,"userId":"null","token":"WDSQYwtSbDrJpf7Lc8gOJCepx5rZ+lq2NN8lw6QbnNZemKr3cXAESn63UlB32jt0lgvM9RzaM+4XFbRzmObaAg=="}

    
    
//    [[Connetion shared] consultToken:[CooladingManager sharedCooladingManager].user finish:^(NSDictionary *resultData, NSError *error) {
//        
//        if ( ! error) {
//            
//            
//            if ([resultData [Kstatus] intValue]== 1) {
//                
//                if (resultData[Kresult]) {
//                    
//                    // 载入用户的团队信息
//                    NSDictionary *tkInfo = resultData[Kresult];
//                    
//                    NSString *token = tkInfo[@"token"];
//                    
//                    if ( token ) {
//                        [Cookie setCookie:@"rcToken" value:token];
//                    }
//                    
//                    [[RCIM sharedRCIM] disconnect];
//                    
//                    
//                    // 快速集成第二步，连接融云服务器
//                    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
//                        
//                        DLog(@"启动成功：userId %@", userId);
//                    } error:^(RCConnectErrorCode status) {
//                        
//                        DLog(@"启动失败： %li", (long)status);
//                        
//                    } tokenIncorrect:^{
//                        DLog(@"token错误或者过期。");
//                    }];
//                    
//                }
//                else {
//                    
//                    [self loadRCIM];
//                }
//            }
//
//            
//        }
//        
//    }];
    

    
    

//    3、启动会话列表界面

    
}


//添加界面刷新Notifition
- (void)addReloadRCIMNotifition {
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadRCIM) name:KKloadRCIM object:nil];
}


#pragma mark - application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    载入用户信息
    [self getUserInfomation];
    
    
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];

    DLog(@"%@", docPath );

    
    //    载入融云
//    [self loadRCIM];


    // 要使用百度地图，请先启动BaiduMapManager
//    [self loadBaiduMap];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
#endif
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
//    NSString *firstStart=[Cookie getCookie:@"firstStart"];
    
    UIViewController *vc = nil;
    UINavigationController *navc =nil;
//    firstStart=0;//test
//    if ([firstStart isEqualToString:@"1"]) {
        vc = [[ViewController alloc] init];
        navc = [[UINavigationController alloc] initWithRootViewController:vc];
//    }else{
//        vc = [[IndexViewController alloc] init];
//        navc = [[UINavigationController alloc] initWithRootViewController:vc];
//    }
    self.window.rootViewController = navc;
    [self.window makeKeyAndVisible];
    
    
    
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    DLog(@"推送的 deviceToken： %@", token);
//    保存deviceToken 到Cookie
    [Cookie setCookie:@"deviceToken" value:token];

}


-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0); {
    
    DLog(@"%@", userInfo);
}




#ifdef __IPHONE_8_0

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

//
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//}
//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//}
//



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
