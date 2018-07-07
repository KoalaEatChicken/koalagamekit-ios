//
//  Koala.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/5.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "KKConfig.h"
#import "KKResult.h"
#import "KKUser.h"
#import "KKOrder.h"
#import "KKRole.h"
#import "KKOpenMacros.h"
@interface Koala : NSObject

// 获取单例
+ (nonnull instancetype)getInstance;
+ (nonnull instancetype)sharedKoala;


/**
 打开/关闭 内部的log

 @param log 是否开启打印，默认不开启打印
 */
+ (void)kgk_openLog:(BOOL)log;

/**
 初始化

 @param completionHandler 初始化的回调
 */
+ (void)kgk_initGameKitWithCompletionHandler:(nullable KKCompletionHandler)completionHandler;


/**
 登录
 
 @param viewController 登录框需要显示在这个vc的上面；可为空，默认为key window的root view controlloer
 @param isAllowUserAutologin 是否允许用户自动登录
 @param floatBallInitStyle 悬浮球第一次展示时的位置样式
 @param isRememberFloatBallLocation 是否记住悬浮球的位置（用户最后一次拖动到的位置）
 @param completeHandler 登录的回调
 */
+ (void)kgk_loginWithViewController:(nullable UIViewController *)viewController
              isAllowUserAutologin:(BOOL)isAllowUserAutologin
                floatBallInitStyle:(FloatBallStyle)floatBallInitStyle
       isRememberFloatBallLocation:(BOOL)isRememberFloatBallLocation
                   completeHandler:(nullable KKCompletionHandler)completeHandler;

/**
 角色上报统计
 @param role 角色模型
 @param completionHandler 角色上报回调
 **/
+ (void)kgk_postRoleInfoWithModel:(nonnull KKRole *)role completionHandler:(nullable KKCompletionHandler)completionHandler;


/**
 切换账号
 这个接口为非必要接口（🐨内部也有提供登出的入口）；
 如果游戏另有注销/切换之类的入口，可以接入这个接口；
 会发出一个登出成功的通知：KKNotiLogoutSuccessNoti；
 登出失败是没有回调的，🐨自己处理登出失败.
 */
+ (void)kgk_switchAccounts;


/**
 制服

 @param order 订单模型
 @param completionHandler 制服回调
 */
+ (void)kgk_settleBillWithOrder:(nonnull KKOrder *)order completionHandler:(nullable KKCompletionHandler)completionHandler;


@end
