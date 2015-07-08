//
//  Image.h
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/29.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property(nonatomic, assign) int ID;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *url;
@property(nonatomic, assign) int object_type;

@property(nonatomic, assign) int object_id;

@property(nonatomic, assign) int status;
@property(nonatomic, retain) NSString *create_time;

@end
