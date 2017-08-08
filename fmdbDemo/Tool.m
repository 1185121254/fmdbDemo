//
//  Tool.m
//  fmdbDemo
//
//  Created by chaojie on 2017/7/20.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "Tool.h"
#import <FMDatabase.h>
#import "YYPerson.h"


#define DBNAME    @"person.sqlite"
#define ID        @"iD"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"

static FMDatabase *_db;

@implementation Tool

+(Tool *)shareManager{
    
    static Tool *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Tool alloc] init];
    });
    
    return manager;
}

+(void)initialize{
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"person.sqlite"];
    
    _db = [FMDatabase databaseWithPath:fileName];
    
    if ([_db open]) {
        
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person(id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL);"];
        if (result) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
        [_db close];
    }
    
}
#pragma mark save
+(void)save:(YYPerson *)person{
    
    if ([_db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_person(name,age)VALUES('%@',%d);",person.name,person.age];
        BOOL res = [_db executeUpdate:sql];
        if (res) {
            NSLog(@"插入表成功");
        }else{
            NSLog(@"插入表失败");
        }
        
        [_db close];
    }
    
}
#pragma mark delect
+(void)delect:(YYPerson *)person{
    
    if ([_db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_person WHERE id > '%d'", person.iD];
        BOOL res = [_db executeUpdate:sql];
        if (res) {
            NSLog(@"删除表成功");
        }else{
            NSLog(@"删除表失败");
        }
        
        [_db close];
    }
    
}
#pragma mark change
+(void)change:(YYPerson *)person{
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE t_person set age = '%d' WHERE name = '%@'",person.age,person.name];
    BOOL res = [_db executeUpdate:sql];
    if (res) {
        NSLog(@"更新表成功");
    }else{
        NSLog(@"更新表失败");
    }
    [_db close];
    
}
+(NSArray *)query{
    
    return [self queryWithCondition:@""];
}
+(NSArray *)queryWithCondition:(NSString *)condition{
    
    NSMutableArray *persons = nil;
    
    if ([_db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_person WHERE name like '%%%@%%'ORDER BY age ASC;",condition];
        FMResultSet *rs = [_db executeQuery:sql];
        
        persons = [NSMutableArray array];
        while ([rs next]) {
            
            int Id = [rs intForColumn:ID];
            NSString * name = [rs stringForColumn:NAME];
            int age = [rs intForColumn:AGE];
            NSLog(@"id = %d, name = %@, age = %d", Id, name, age);
            
            
            
            YYPerson *pp = [[YYPerson alloc] init];
            pp.iD = Id;
            pp.name = name;
            pp.age = age;
            
            [persons addObject:pp];
            
            NSLog(@"查询语句没问题");
        }
        
    }else{
        NSLog(@"查询语句有问题");
    }
    
    [_db close];
    
    return persons;
}
@end
