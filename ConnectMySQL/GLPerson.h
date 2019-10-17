//
//  GLPerson.h
//  ConnectMySQL
//
//  Created by admin on 2019/10/15.
//  Copyright © 2019 历山大亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLPerson : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString * userId;

@property (nonatomic, copy) NSString * password;

@property (nonatomic, copy) NSString * userName;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger age;

@end
