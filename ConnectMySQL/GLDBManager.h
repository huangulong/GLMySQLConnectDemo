//
//  GLDBManager.h
//  ConnectMySQL
//
//  Created by admin on 2019/10/15.
//  Copyright © 2019 历山大亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLPerson.h"

@interface GLDBManager : NSObject

+ (instancetype)share;

///查询
- (NSArray *)getAllPerson;
///更新
- (void)updatePerson:(GLPerson *)person;
///插入
- (void)insertPerson:(GLPerson *)person;
///删除
- (void)deletePerson:(GLPerson *)person;
@end

