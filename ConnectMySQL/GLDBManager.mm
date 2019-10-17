//
//  GLDBManager.m
//  ConnectMySQL
//
//  Created by admin on 2019/10/15.
//  Copyright © 2019 历山大亚. All rights reserved.
//

#import "GLDBManager.h"
#include "mysql.h"
@interface GLDBManager ()
{
    MYSQL * _myconnect;
}
@property (nonatomic, copy) NSString * local_name;

@property (nonatomic, copy) NSString * user_name;

@property (nonatomic, copy) NSString * pass_word;

@property (nonatomic, copy) NSString * db_name;

@end

@implementation GLDBManager

+ (instancetype)share{
    static id m;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[self alloc] init];
    });
    return m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.local_name = @"localhost";
        self.user_name = @"admin";
        self.pass_word = @"";
        self.db_name = @"adminDB";
        [self connectSQL];
    }
    return self;
}

- (void)connectSQL{
    _myconnect = mysql_init(_myconnect);
    _myconnect = mysql_real_connect(_myconnect, "localhost", "admin", "", "adminDB", MYSQL_PORT, NULL, 0);
    mysql_set_character_set(_myconnect, "utf8");
    if (_myconnect != NULL) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"连接失败");
    }
}

- (NSArray *)getAllPerson{
    if (_myconnect == NULL) {
        return nil;
    }
    int status = mysql_query(_myconnect, "select * from person");
    if (status != 0) {
        NSLog(@"查询失败");
        return nil;
    }
    MYSQL_RES * result = mysql_store_result(_myconnect);
    long long rows = result->row_count;
    NSMutableArray<GLPerson *> * array = [NSMutableArray arrayWithCapacity:rows];
    unsigned int fieldCount = mysql_field_count(_myconnect);
    MYSQL_FIELD * fields = result->fields;
    MYSQL_ROW col;
    for (int row = 0; row < rows; row ++) {
        if ((col = mysql_fetch_row(result))) {
            GLPerson * person = [[GLPerson alloc] init];
            for (int i = 0; i < fieldCount; i ++) {
                MYSQL_FIELD field = fields[i];
                char * m = field.name;
                [person setValue:[NSString stringWithUTF8String:col[i]] forKey:[NSString stringWithUTF8String:m]];
//                if (strcmp(m, "userId") == 0) {
//                    person.userId = [NSString stringWithUTF8String:col[i]];
//                }else if (strcmp(m, "userName") == 0){
//                    person.userName = [NSString stringWithUTF8String:col[i]];
//                }else if (strcmp(m, "id") == 0){
//                    person.id = [NSString stringWithUTF8String:col[i]].integerValue;
//                }else if (strcmp(m, "age") == 0){
//                    person.age = [NSString stringWithUTF8String:col[i]].integerValue;
//                }else if (strcmp(m, "sex") == 0){
//                    person.sex = [NSString stringWithUTF8String:col[i]].integerValue;
//                }
            }
            [array addObject:person];
        }
    }
    return array;
}

- (void)updatePerson:(GLPerson *)person{
    NSString * sql = [NSString stringWithFormat:@"update person set userName='%@',age=%ld,sex=%ld where userId='%@'",person.userName,person.age,person.sex,person.userId];
    int status = mysql_query(_myconnect, [sql UTF8String]);
    if (status != 0) {
        NSLog(@"数据更新失败");
    }else{
        NSLog(@"数据更新成功");
    }
}

- (void)insertPerson:(GLPerson *)person{
    NSString * sql = [NSString stringWithFormat:@"insert into person (userId,userName,age,sex) values('%@','%@',%ld,%ld)",person.userId,person.userName,person.age,person.sex];
    int status = mysql_query(_myconnect, [sql UTF8String]);
    const char * error = mysql_error(_myconnect);
    if (status != 0) {
        NSLog(@"数据插入失败");
        NSLog(@"%s",error);
    }else{
        NSLog(@"数据插入成功");
    }
}

- (void)deletePerson:(GLPerson *)person{
    NSString * sql = [NSString stringWithFormat:@"delete from person where userId='%@'",person.userId];
    int status = mysql_query(_myconnect, [sql UTF8String]);
    if (status != 0) {
        NSLog(@"数据删除失败");
    }else{
        NSLog(@"数据删除成功");
    }
}

@end
