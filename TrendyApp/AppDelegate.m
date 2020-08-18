//
//  AppDelegate.m
//  TrendyApp
//
//  Created by 55like on 2019/2/19.
//  Copyright © 2019 55like. All rights reserved.
//
#import "Utility.h"
//#import "DMHessian.h"
#import "RHMethods.h"
#import "Foundation.h"
#import <SVProgressHUD.h>
#import "PLTextView.h"
#import "AppDelegate.h"
//#import "GoogleMaps.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#endif
#import "Utility_pushService.h"
#import "Utility_Location.h"
#import "SuccessfulApplicationViewController.h"
#import "NSDictionary+expanded.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>

@property(nonatomic,strong)NSMutableArray*marry;
@property(nonatomic,assign)BOOL isShowing;
@end

@implementation AppDelegate
-(NSMutableArray *)marry{
    if (_marry==nil) {
        _marry=[NSMutableArray new];
    }
    return _marry;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.isShowing=NO;
    // Override point for customization after application launch.
    //谷歌地圖
    BOOL abool2= [GMSPlacesClient provideAPIKey:@"AIzaSyB_wcQ4daTZjqYFU0vOFqR1mZvAZkXuXdg"];
    BOOL abool1= [GMSServices provideAPIKey:@"AIzaSyB_wcQ4daTZjqYFU0vOFqR1mZvAZkXuXdg"];
    DLog(@"abool1:%d,abool2:%d",abool1,abool2);
    [kLanguageService appLanguage];
    [UTILITY setAddValue:self forKey:@"AppDelegate"];
//    NSDictionary *dic =krequestParam;
   
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"0ecd6f6d05d92a15834e7cc9"
                          channel:@"appstore"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [UTILITY.currentViewController pushController:[SuccessfulApplicationViewController class] withInfo:nil withTitle:@"设置"];
//    });
    
//    [self alertWithUserInfo:[launchOptions toBeMutableObj] withType:@"application"];
//    [self alertWithUserInfo:[launchOptions toBeMutableObj] withType:@"application"];
//    [self alertWithUserInfo:[launchOptions toBeMutableObj] withType:@"application"];
//    [self alertWithUserInfo:[launchOptions toBeMutableObj] withType:@"application"];
//    [self alertWithUserInfo:[launchOptions toBeMutableObj] withType:@"application"];
    
    
    [self shareInit];
    return YES;
}

-(void)shareInit{
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //微信
        [platformsRegister setupWeChatWithAppId:@"wx3bc0b1ec90a3a5d0" appSecret:@"1a0ef11e1a64e2a41abe416033f44188" ];
        
      
    }];
}


-(void)clearAndinitAllController{
//    [self.window removeFromSuperview];
//    self.window=nil;
    for (UIView*views in self.window.subviews) {
        [views removeFromSuperview];
    }
    [kUtility_Location removeAddValueForkey:@"homepageLocationUpdata"];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //根据 场景 标示符 ，创建目前视图对象
    CustomTabBar *tabbar=[story instantiateViewControllerWithIdentifier:@"CustomTabBarStoryboard"];
    [[Utility Share] setCustomTabBar_zk:tabbar];
    //把目标视图设置为根视图，切换到下一组 导航视图中
    self.window.rootViewController=tabbar;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        
//        [self alertWithUserInfo:userInfo withType:@"12zhijie"];
        
        [kUtility_pushService receviveNoticeWithDic:userInfo];
    }else{
        //从通知设置界面进入应用
//        [self alertWithUserInfo:userInfo withType:@"12shezhi"];
        
        [kUtility_pushService receviveNoticeWithDic:userInfo];
    }
}

// iOS 10 Support 弹出的时候直接显示的 点击后通知不会消失
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
//        [kUtility_pushService receviveNoticeWithDic:userInfo];
//        [kUtility_pushService receviveNoticeforwordWithDic:userInfo];
        
    }
    
//    [self alertWithUserInfo:userInfo withType:@"JwillPresentNotification"];
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support 从通知栏里面打开的
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [kUtility_pushService receviveNoticeWithDic:userInfo];
    }
    
//    [self alertWithUserInfo:userInfo withType:@"JdidReceiveNotificationResponse"];
    
//    [self alertWithUserInfo:userInfo withType:@"JdidReceiveNotificationResponse"];
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
//    [self alertWithUserInfo:userInfo withType:@"didReceiveRemoteNotification7+"];
//    [kUtility_pushService receviveNoticeWithDic:userInfo];
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [self alertWithUserInfo:userInfo withType:@"didReceiveRemoteNotification6"];
    
    [kUtility_pushService receviveNoticeWithDic:userInfo];
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}

-(void)alertWithUserInfo:(NSDictionary*)uiserInfo withType:(NSString*)typeStr{
//    NSMutableDictionary*mdic=[NSMutableDictionary new];
    
    
    
////    mdic setObject: forKey:<#(nonnull id<NSCopying>)#>
//    if (uiserInfo) {
//        [mdic setObject:uiserInfo forKey:@"data"];
//    }
//    [mdic setObject:typeStr forKey:@"typeStr"];
//    [self.marry addObject:mdic];
//    if ( self.isShowing==NO) {
//        [self showDic];
//    }
////    [self.marry addObject:[[NSDictionary dictionaryWithDictionary:mdic] toBeMutableObj]];
//
   
}


//-(void)showDic{
//    if (self.marry.count==0) {
//        self.isShowing=NO;
//        return;
//
//    }
//      __weak __typeof(self) weakSelf = self;
//    self.isShowing=YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSMutableDictionary*mdic=weakSelf.marry[0];
//        [weakSelf.marry removeObjectAtIndex:0];
//
//
//        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:[mdic ojk:@"typeStr"] message:[mdic jsonStrSYS] preferredStyle:UIAlertControllerStyleAlert];
//        //    [alertcv addAction:[UIAlertAction actionWithTitle:@"<# #>" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //    }]];
//        [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [weakSelf showDic];
//        }]];
//        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
//
//        }];
//    });
//
//
//}
@end
