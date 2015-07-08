//
//  CooladingManager.m
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "CooladingManager.h"
#import "DEFINE.h"
#import "AFNetworking.h"
#import "CCLog.h"
#import "Cookie.h"

NSString* CooladingManagerSearchFailedError =  @"CooladingManagerSearchFailedError";

static CooladingManager* cooladingManager;

@implementation CooladingManager

+ (CooladingManager*)sharedCooladingManager {
  if (!cooladingManager) {
    cooladingManager = [[CooladingManager alloc] init];

  }

  return cooladingManager;
}

- (id)init {
  if (self == [super init]) {
  }
  return self;
}

- (NSError*)tellDelegateAboutQuestionSearchError:(NSError*)error {
  NSDictionary* errorInfo = nil;
  if (error) {
    errorInfo =
        [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
  }

  NSError* reportableError =
      [NSError errorWithDomain:CooladingManagerSearchFailedError
                          code:CooladingManagerErrorCommuntitySearchCode
                      userInfo:errorInfo];

  return reportableError;
}



#pragma mark - 


- (void)setUserProcessStatus:(UserProcessStatus)userProcessStatus {
    
    if (_userProcessStatus != userProcessStatus) {
        _userProcessStatus = userProcessStatus;
        
        [Cookie setCookie:@"userProcessStatus" value:[NSNumber numberWithInteger:userProcessStatus]];
        
    }
}

- (void)setConstructionStatus:(ConstructionStatus)constructionStatus {
    
    if (_constructionStatus != constructionStatus) {
        _constructionStatus = constructionStatus;
        
        [Cookie setCookie:@"constructionStatus" value:[NSNumber numberWithInteger:constructionStatus]];
    }
}

@end
