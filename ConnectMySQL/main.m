//
//  main.m
//  ConnectMySQL
//
//  Created by admin on 2019/10/15.
//  Copyright © 2019 历山大亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDBManager.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        GLPerson * person = [[GLPerson alloc] init];
        person.userId = @"10002";
        person.userName = @"黄古筝";
        person.age = 25;
        person.sex = 0;
        NSArray * array = [[GLDBManager share] getAllPerson];
//        [[GLDBManager share] insertPerson:person];
        person.userId = @"10003";
//        person.userName = @"古革";
//        [[GLDBManager share] insertPerson:person];
    }
    return 0;
}
