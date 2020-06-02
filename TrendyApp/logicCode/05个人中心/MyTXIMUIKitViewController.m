//
//  MyTXIMUIKitViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/4/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyTXIMUIKitViewController.h"
#import "TTabBarController.h"
#import "SettingViewController.h"
#import "ConversationViewController.h"
//#import "TNavigationController.h"
#import "TConversationController.h"
#import "TUIKit.h"
#import "TIMFriendshipManager.h"
@interface MyTXIMUIKitViewController ()

@end

@implementation MyTXIMUIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSInteger sdkAppid = 1400173143; //填入自己app的sdkAppid
//    NSString *accountType = @"36862"; //填入自己app的accountType
//    TUIKitConfig *config = [TUIKitConfig defaultConfig];//默认TUIKit配置，这个您可以根据自己的需求在 TUIKitConfig 里面自行配置
//    [[TUIKit sharedInstance] initKit:sdkAppid accountType:@"" withConfig:[TUIKitConfig defaultConfig]];
    
    [self rightButton:@"聊天" image:nil sel:@selector(btnClick:)];
}
-(void)btnClick:(UIButton*)btn{
    __weak typeof(self) weakSelf=self;
    
//    NSString *identifier = @"6_28"; //填入登录用户名
//    NSString *userSig = @"eJxlj1FPgzAYRd-5FaSvGP0odIDJHoBB3CYJi2QSXhpGu6WaQVPKdDH*dxVdxHhfz7m5uW*GaZqouH*4rpumG1pN9VlyZN6aCNDVL5RSMFpr6ij2D-JXKRSn9V5zNUKbEIIBpo5gvNViL36MGcX*hPbsmY4T33X3s*vMwP2jiMMIs2QTL6Ohs1ZHT2XZ7q55TMpCRz3POtf38yflemsJxU0abjewSEIRQZWfDgtYt3mQltUuXhG5JG2VBl5kDckQWemLAMLi8hzO55NJLY788gfjAGzHndATV73o2lHAYBMbO-AVZLwbHzk1WfM_";        //填入签名userSig
    
    NSString *identifier = @"6_52"; //填入登录用户名
    NSString *userSig = @"eJxlj11PgzAARd-5FQ2vGOnnMk18mJsanDgZw4kvDaMddkZWS0WI8b*ruMQm3tdzbm7uhwcA8Fc36XFRlvu32nLba*mDU*BD-*gPaq0ELywnRvyDstPKSF5srTQDRIwxDKHrKCFrq7bqYIw4ww5txDMfJn7r9LtLRpCOXUVVA4wvsmmUTMl1mb5Olle3UbDU4ZNkfRzDXKzXMs7vkAh3q3mfP7RkcllF1X0RhIuTpuu6Sp0vcmM3aULtrBUhLWdBtkF2l7Bsnrw-RmfOpFUv8vCHMjwmDLmPWmkata8HAUPEECbwJ7736X0ByI5biw__";
    
    [[TUIKit sharedInstance] loginKit:identifier userSig:userSig succ:^{
        
        
        [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_Nick:@"我的昵称"} succ:^{
            NSLog(@"ddd");
        } fail:^(int code, NSString *msg) {
            
        }];
        
        //登录成功
        //初始化 TUIKit 的会话列表UI类
        //1，创建TabBarController
        TTabBarController *tbc = [[TTabBarController alloc] init];
        NSMutableArray *items = [NSMutableArray array];
        
        //    //2，初始化会话列表类
        //    TTabBarItem *msgItem = [[TTabBarItem alloc] init];
        //    msgItem.title = @"消息";
        //    msgItem.controller = [[KKNavigationController alloc] initWithRootViewController:[[ConversationController alloc] init]];
        //    [items addObject:msgItem];
        //
        //    //3，初始化设置类
        TTabBarItem *setItem = [[TTabBarItem alloc] init];
        setItem.title = @"设置";
        setItem.controller = [[KKNavigationController alloc] initWithRootViewController:[[ConversationViewController alloc] init]];
        [items addObject:setItem];
        tbc.tabBarItems = items;
        
        //跳转
        [weakSelf presentViewController:tbc animated:YES completion:nil];
        
        
    } fail:^(int code, NSString *msg) {
        //登录失败
        DLog(@"msg:%@",msg)
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
