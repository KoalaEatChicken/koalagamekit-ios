//
//  KKOrder.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/5.
//  Copyright © 2018年 kaola . All rights reserved.
// 订单

#import <Foundation/Foundation.h>
#import "KKOpenMacros.h"

@interface KKOrder : NSObject

/** 商品名称  */
@property(nonatomic, copy) NSString *subject;

/** 金额（单位元）  */
@property(nonatomic, copy) NSString *amount;

/** 订单号  */
@property(nonatomic, copy) NSString *billno;

/** 内购id  */
@property(nonatomic, copy) NSString *iapId;

/** 额外信息  */
@property(nonatomic, copy) NSString *extrainfo;

/** 服务器id */
@property(nonatomic, copy) NSString *serverid;

/** 角色名称 */
@property(nonatomic, copy) NSString *rolename;

/** 角色等级 */
@property(nonatomic, copy) NSString *rolelevel;

@end
