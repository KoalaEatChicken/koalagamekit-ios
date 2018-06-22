//
//  ViewController.m
//  KoalaDemo
//
//  Created by kaola  on 2018/6/5.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "ViewController.h"

#import <KoalaGameKIt/KoalaGameKit.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - koala demo methods
- (void)demo_init {
    
    // 调试时，可以开启打印，发布时，一定要关闭打印～
#ifdef DEBUG
    [Koala kgk_openLog: YES];
#endif
    
    // 初始化
    [KKConfig sharedConfig].appid = @"100000"; // app id
    [KKConfig sharedConfig].channel = @"appstore100000";
    [KKConfig sharedConfig].appkey = @"123456";  // 签名的key
    __weak typeof(self) weakSelf = self;
    [Koala kgk_initGameKitWithCompletionHandler:^(KKResult *result) {
        
        if (result.result.boolValue) {
            
            NSLog(@"初始化成功：%@", result.msg);
            [weakSelf demo_autologin];
        }
        else {
            
            // 如果初始化失败，cp需要在这里重新初始化，直到初始化为止。
            NSLog(@"初始化失败：%@", result.msg);
            NSLog(@"如果初始化失败，是不能进行登录等后续操作的~ 所以如果初始化失败，要在这里处理初始化失败事件哦~");
            NSLog(@"注意：请确保初始化成功的前提下，再进行后续的操作！");
        }
    }];
    
}

- (void)demo_autologin {
    
    [Koala kgk_loginWithViewController:NULL isAllowUserAutologin:YES floatBallInitStyle:FloatBallStyleDefault isRememberFloatBallLocation:YES completeHandler:^(KKResult * _Nonnull result) {
        
        if (result.isSucc) {
            // 登录成功，data是一个user模型：KKUser
            KKUser *user = result.data;
            NSLog(@"登录成功：%@", user);
        }
        else {
            
            // 登录失败: 并不会有登录失败的回调，如网络错误，密码错误等，sdk已自行处理。
            NSLog(@"登录失败:%@", result.msg);
        }
    }];
}

- (void)demo_login {
    
    [Koala kgk_loginWithViewController:NULL isAllowUserAutologin:NO floatBallInitStyle:FloatBallStyleDefault isRememberFloatBallLocation:YES completeHandler:^(KKResult * _Nonnull result) {
        
        if (result.isSucc) {
            // 登录成功，data是一个user模型：KKUser
            KKUser *user = result.data;
            NSLog(@"登录成功：%@", user);
        }
        else {
            
            // 登录失败: 并不会有登录失败的回调，如网络错误，密码错误等，sdk已自行处理。
            NSLog(@"登录失败:%@", result.msg);
        }
    }];
}

-(void)demo_postRoleInfo {
    
    KKRole *role = [KKRole new];
    role.serverid = @"100";
    role.servername = @"区服二号";
    role.roleid = @"1001";
    role.rolename = @"凌凌8";
    role.rolelevel = @"100";
    [Koala kgk_postRoleInfoWithModel:role completionHandler:^(KKResult * _Nonnull result) {
        
        NSLog(@"角色上报结果：%@", result);
        if (result.isSucc) {
            
            NSLog(@"角色上报完成");
        }
        else {
            
            NSLog(@"角色上报失败：%@", result.msg);
        }
    }];
}

- (void)demo_switchAccount {
    
    /** 切换账号 */
    [Koala kgk_switchAccounts];
}

- (void)demo_pay {
    
    KKOrder *order = [KKOrder new];
    order.subject = @"test";
    order.amount = @"6.00";
    order.iapId = @"com.gold.coin100";
    order.billno = @"111";
    order.extrainfo = @"test";
    order.serverid = @"100";
    order.rolename = @"test";
    order.rolelevel = @"200";
    
    [Koala kgk_settleBillWithOrder:order completionHandler:^(KKResult * _Nonnull result) {
        
        NSLog(@"支付结果：%@", result);
        if (result.result.integerValue == KKSettleBillStatusIapSuccess) {
            
            // 苹果支付成功：移动端已支付成功，制服是否成功，要以服务器的回调为准
            NSLog(@"苹果支付成功");
        }
        else if (result.result.integerValue == KKSettleBillStatusUserCancel) {
            
            // 用户取消支付：用户点击了左上角的取消按钮，确定不支付
            // 这个状态过期，不再起作用，支付结果以服务器之间的回调为准
            NSLog(@"第三方支付，用户点击了左上角的取消按钮");
        }
        else if (result.result.integerValue == KKSettleBillStatusNotConfirm) {
            
            // 第三方支付（web）已经出结果了，但是成功失败并不确定，支付结果以服务器之间的回调为准
            NSLog(@"第三方支付出结果了，支付结果以服务器之间的回调为准");
        }
        else {
            
            // 其他error
            NSLog(@"支付失败：%@", result.msg);
        }
    }];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 注册登出当前账号的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccessNoti:) name:KKNotiLogoutSuccessNoti object:NULL];
}

- (void)logoutSuccessNoti:(NSNotification *)noti {
    
    NSLog(@"CP： 登出成功了，cp在这里处理登出游戏账号等操作~");
}

- (void)dealloc {
    
    // remove self from 登出当前账号的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KKNotiLogoutSuccessNoti object:NULL];
}

#pragma mark - table Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self demo_init];
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            [self demo_login];
        }
        else if (indexPath.row == 1) {
            
            [self demo_postRoleInfo];
        }
        else if (indexPath.row == 2) {
            
            [self demo_switchAccount];
        }
    }
    else if (indexPath.section == 2) {
        
        [self demo_pay];
    }
}



@end
