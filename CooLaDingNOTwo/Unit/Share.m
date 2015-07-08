//
//  Share.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/16.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "Share.h"

@implementation Share

//WXSceneSession  = 0,        /**< 聊天界面    */
//WXSceneTimeline = 1,        /**< 朋友圈      */
//WXSceneFavorite = 2,        /**< 收藏       */

//
//+ (void)share :(int)scene title:(NSString *)title description:(NSString *)description urlString:(NSString *)urlString{
//    //    [_delegate changeScene:WXSceneSession];
//    
//    WXMediaMessage *message = [WXMediaMessage message];
//    
//    //
//    //    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.sinaimg.cn/dy/slidenews/4_img/2015_12/704_1579347_398766.jpg"]]];
//    //
//    //    [message setThumbImage:[self scaleToSize:img scale:.4]];
//
//    message.title=title;
//    message.description=description;
//    
//    
//    WXWebpageObject *ext = [WXWebpageObject object];
//
//    NSString *URLstring= urlString;
//    ext.webpageUrl =URLstring;
//    message.mediaObject = ext;
//    
//    
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//
//    req.bText = YES;
//    req.message = message;
//    req.scene = scene;
//    
//    [WXApi sendReq:req];
//    
//}
//
//+ (void)shareToSessionTitle:(NSString *)title description:(NSString *)description urlString:(NSString *)urlString {
// 
//    [self share:0 title:title description:description urlString:urlString];
//}
//
//+ (void)shareToTimeLineTitle:(NSString *)title description:(NSString *)description urlString:(NSString *)urlString {
//    
//    [self share:1 title:title description:description urlString:urlString];
//}

@end
