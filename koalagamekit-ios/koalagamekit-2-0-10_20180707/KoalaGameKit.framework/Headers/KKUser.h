//
//  KKUser.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/8.
//  Copyright © 2018年 kaola . All rights reserved.
// 用户模型

#import <Foundation/Foundation.h>
#import "KKOpenMacros.h"

@interface KKUser : NSObject

/** 用户id */
@property(nonatomic, copy) NSString *uid;
/** 用户名 */
@property(nonatomic, copy) NSString *username;
/** 时间戳  */
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *sessid;
@property(nonatomic, copy) NSString *gametoken;
@end
