//
//  Tool.h
//  fmdbDemo
//
//  Created by chaojie on 2017/7/20.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYPerson;

@interface Tool : NSObject

+(Tool *)shareManager;

#pragma mark save
+(void)save:(YYPerson *)person;

#pragma mark delect
+(void)delect:(YYPerson *)person;

#pragma mark change
+(void)change:(YYPerson *)person;


+(NSArray *)query;

@end
