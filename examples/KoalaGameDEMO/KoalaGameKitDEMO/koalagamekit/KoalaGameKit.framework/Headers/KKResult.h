//
//  KKResult.h
//  KoalaGameKit
//
//  Created by kaola  on 2018/3/5.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKOpenMacros.h"

/** 通知：登出成功 */
extern NSString * _Nonnull const KKNotiLogoutSuccessNoti;

/* 悬浮球的初始位置 */
typedef NS_ENUM(NSInteger, FloatBallStyle) {
    
    FloatBallStyleDefault,
    FloatBallStyleCenterLeft,
    FloatBallStyleCenterRight,
    FloatBallStyleTopLeft,
    FloatBallStyleTopRight,
    FloatBallStyleBottomLeft,
    FloatBallStyleBottomRight,
};

/* 制服结果的状态码 */
typedef NS_ENUM(NSInteger, KKSettleBillStatus) {
    
    /** 失败  */
    KKSettleBillStatusFailure,
    
    /** 移动端内购成功的回调，但是制服是否成功，要以服务器的回调为准  */
    KKSettleBillStatusIapSuccess,
    
    /** 移动端third part制服成功的回调（由于xx原因，这个回调暂时不会调用），制服是否成功，要以服务器的回调为准  */
    KKSettleBillStatusSuccess,
    
    /** 第三方制服，制服完成时回调到；具体成功与否，要以服务器的回调为准  */
    KKSettleBillStatusNotConfirm,
    
    /** 第三方制服，用户取消制服  */
    KKSettleBillStatusUserCancel,
};


@interface KKResult : NSObject

/**
 ture表示成功
 */
@property(copy, nonatomic) NSString * _Nullable result;
@property(copy, nonatomic) NSString *_Nullable msg;
@property(strong, nonatomic) id _Nullable data;

- (BOOL)isSucc;


/**
 获得一个reslut对象

 @param result result
 @param data data
 @param msg msg
 @return result对象
 */
+ (instancetype _Nonnull)resultWithResult:(nullable NSString *)result data:(nullable id)data msg:(nullable NSString *)msg;

@end

typedef void(^KKCompletionHandler)(KKResult * _Nonnull result);
