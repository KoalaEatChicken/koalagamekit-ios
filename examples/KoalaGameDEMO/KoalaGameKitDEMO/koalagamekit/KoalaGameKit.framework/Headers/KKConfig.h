//
//  KKConfig.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
// 初始化 模型

#import <UIKit/UIKit.h>
#import "KKOpenMacros.h"

@interface KKConfig : NSObject

+ (nonnull instancetype)sharedConfig;

/** 应用ID  */
@property(copy, nonatomic) NSString *_Nonnull appid;

/** 渠道名称  */
@property(copy, nonatomic) NSString *_Nonnull channel;

/** 签名的key  */
@property(copy, nonatomic) NSString *_Nonnull appkey;

/** 相同channel情况下，需要保证唯一性的一个字符串 */
@property(copy, nonatomic, readonly) NSString *_Nullable pkver;

/** 🐨内部测试切支付使用的方法：正式环境中禁止使用  */
- (void)kgk_demo_setPkver:(NSString *)pkver;

@end
