//
//  KKRole.h
//  KoalaGameKit
//
//  Created by 李一贤 on 2018/4/27.
//  Copyright © 2018年 kaola . All rights reserved.
//
//角色统计模型
#import <Foundation/Foundation.h>
#import "KKOpenMacros.h"

@interface KKRole : NSObject

/** 区服id */
@property(nonatomic, copy) NSString *serverid;

/** 区服名称 */
@property(nonatomic, copy) NSString *servername;

/** 角色ID */
@property(nonatomic, copy) NSString *roleid;

/** 角色名称 */
@property(nonatomic, copy) NSString *rolename;

/** 角色等级 */
@property(nonatomic, copy) NSString *rolelevel;
@end
