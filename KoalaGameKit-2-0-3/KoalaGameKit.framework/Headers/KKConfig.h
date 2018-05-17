//
//  KKConfig.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/6.
//  Copyright © 2018年 kaola . All rights reserved.
// 初始化 模型

#import <UIKit/UIKit.h>

//#define kgk_initGameKitWithCompletionHandler erwgasdsgfdsfd201
//#define kgk_loginWithViewController gaewrewaffefase201
//#define kgk_settleBillWithOrder safdwfefgasgagaew201
//#define kgk_switchAccounts fadslasdfljsdfjosadfljfdsjlfds201

@interface KKConfig : NSObject

+ (nonnull instancetype)sharedConfig;

/** 应用ID  */
@property(copy, nonatomic) NSString *_Nonnull appid;

/** 渠道名称  */
@property(copy, nonatomic) NSString *_Nonnull channel;

/**
 这个是游戏的一个标示，如果没有特殊要求，这里可赋空值（nil），或者不给它赋值
 
 游戏的版本号字符串（去掉小数点）
 1、相同ver情况下，保证唯一性的一个字符串；
 2、建议生成规则：游戏版本号去掉小数点（出包时修改后的版本号，去掉小数点）；
 */
@property(copy, nonatomic) NSString *_Nullable pkver;

/** 签名的key  */
@property(copy, nonatomic) NSString *_Nonnull appkey;

@end
