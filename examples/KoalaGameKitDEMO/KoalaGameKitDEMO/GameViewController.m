//
//  GameViewController.m
//  KoalaGameKitDEMO
//
//  Created by kaola  on 2018/5/11.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

#import <KoalaGameKit/KoalaGameKit.h>

@interface GameViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *demoSource;

@end


static NSString *DemoLabel = @"demo_label";
static NSString *DemoSEL = @"demo_sel";

@implementation GameViewController


#pragma mark - demo methods
- (void)demo_init {
    
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

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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


- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.demoSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *rows = self.demoSource[section];
    
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *demoDic = self.demoSource[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KoalaCell"];
    cell.textLabel.text = demoDic[DemoLabel];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *demoDic = self.demoSource[indexPath.section][indexPath.row];
    SEL sel = NSSelectorFromString(demoDic[DemoSEL]);
    if ([self canPerformAction:sel withSender:NULL]) {
        [self performSelector:sel];
    }
}

#pragma mark - Getter & Setter
- (NSArray<NSArray<NSDictionary *> *> *)demoSource {
    
    if (_demoSource) {
        return _demoSource;
    }
    
    _demoSource = @[
                    
                    @[@{
                          DemoLabel : @"初始化",
                          DemoSEL   : @"demo_init",
                          }],
                    @[@{
                          DemoLabel : @"登录",
                          DemoSEL   : @"demo_login",
                          },
                      @{
                          DemoLabel : @"扩展信息",
                          DemoSEL   : @"demo_postRoleInfo",
                          },
                      @{
                          DemoLabel : @"切换账号",
                          DemoSEL   : @"demo_switchAccount",
                          },
                      ],
                    @[@{
                          DemoLabel : @"充值",
                          DemoSEL   : @"demo_pay",
                          }],
                    
                    ];
    
    
    return _demoSource;
}




@end
