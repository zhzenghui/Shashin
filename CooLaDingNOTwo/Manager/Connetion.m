                         //
//  Connetion.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/5.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "Connetion.h"
#import "DEFINE.h"
#import "AFNetworking.h"
#import "CCLog.h"
#import "Device.h"
#import "SVProgressHUD.h"


@implementation Connetion

static Connetion* connetion;

+ (Connetion *)shared {
    if (!connetion) {
        connetion = [[Connetion alloc] init];

    }
    connetion.noLog = NO;
    connetion.isShowHUD = NO;
    return connetion;
}


/**
 *  工长数据
 *
 *  @param finishBlock
 */
- (void)workTeamData:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock; {
    NSString* urlString  = [NSString stringWithFormat:@"%@/ipad/workTeamData", kDomain];
    
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        
        finishBlock(resultData, error);
    }];
}


/**
 *  设计师数据
 *
 *  @param finishBlock
 */
- (void)designData:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock; {
    NSString* urlString  = [NSString stringWithFormat:@"%@/ipad/designData", kDomain];
    
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        
        finishBlock(resultData, error);
    }];
}



#pragma mark - 用户相关的相关网络API

- (NSString*)dictToString:(NSDictionary*)dict {
    NSMutableString* postString = [NSMutableString string];
    
    int i = 0;
    for (NSString* key in dict) {
        [postString appendString:key];
        [postString appendString:@"="];
        [postString appendString:[dict objectForKey:key]];
        
        if (i != dict.count - 1) {
            [postString appendString:@"&"];
        }
        i++;
    }
    return [NSString stringWithString:postString];
}

- (void)GET:(NSString*)URLString finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock; {
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    if ( ! self.noLog) {
        DLog(@"%@", URLString);
    }


    
    connetion.isShowHUD = NO;
    
    if (self.isShowHUD) {
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    }

    
    [manager GET:URLString parameters:nil
         success:^(AFHTTPRequestOperation* operation, id responseObject) {
             
                finishBlock(responseObject, nil);
             
             ;}
         failure:^(AFHTTPRequestOperation* operation, NSError* error) {
             if (self.isShowHUD) {
                 [SVProgressHUD  showErrorWithStatus:@"发生错误" ];
             }
             
             finishBlock(nil, error);
         }];
}

- (void)POST:(NSString*)URLString parameters:(id)parameters finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock; {
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    
    if ( ! self.noLog) {
        DLog(@"%@", URLString);
    }
    if (self.isShowHUD) {
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    }
    
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation* operation, id responseObject) {
        
        finishBlock(responseObject, nil);
    }
          failure:^(AFHTTPRequestOperation* operation, NSError* error) {
              
              if (self.isShowHUD) {
                  [SVProgressHUD  showErrorWithStatus:@"发生错误" ];
              }
              
              finishBlock(nil, error);
          }];
}


@end
