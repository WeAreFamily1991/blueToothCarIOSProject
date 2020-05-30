//
//  UserLoginService.m
//  BankIntegral
//
//  Created by 55like on 2018/6/11.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "Utility_Login.h"
#import "MyLoginViewController.h"
#import "TIMFriendshipManager.h"
#import "TUIKit.h"
#import "TConversationCell.h"
#import "MessageChatViewController.h"

//#import "UtilityIM.h"
//#import "UserAuthenticationViewController.h"

@interface Utility_Login()
{
    
}
@property(nonatomic,weak)KKNavigationController* navcontroller;
@property(nonatomic,weak)BaseViewController* logincontroller;

@property(nonatomic,assign)BOOL isNOBackHome;
@end
@implementation Utility_Login
- (instancetype)init
{
    self = [super init];
    if (self) {
        _imIsLogin = false;
        [self readUserInfoFromDefault];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loginTMUIKit];
        });
    }
    return self;
}
//-(NSString *)userId{
//    _userId=@"17";
//    return _userId;
//}
//-(NSString*)userToken{
//    _userToken=@"f10b81486cb1841ea76892777f742184";
//    return _userToken;
//}

-(void)loginWithAccount:(NSString *)account pwd:(NSString *)password{
    
    if (![account notEmptyOrNull])
    {
        [SVProgressHUD showImage:nil status:kS(@"login", @"login_hint_user")];
        return;
    }
    if (![password notEmptyOrNull])
    {
        [SVProgressHUD showImage:nil status:kS(@"login", @"login_hint_password")];
        return;
    }
    
    NSDictionary *dic=@{@"username":account,
                        @"password":password,
                        @"types":@"2"
                        };
    [NetEngine createHttpAction:@"login/index" withCache:NO withParams:dic withMask:SVProgressHUDMaskTypeClear onCompletion:^(id resData, BOOL isCache) {
        //        DLog(@"userLogin__resData:%@",resData);
//        uid    字符串    uid
//        mobile    字符串    手机号码
//        email    字符串    邮箱
//        nickname    字符串    昵称
//        gender    字符串    1男 其他女
//        token    字符串    token
        if ([[resData valueForJSONKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *userDict = [resData objectForJSONKey:@"data"];
            [self setUserAccount:account];
            [self setUserPwd:password];
            [self setUserId:[userDict valueForJSONStrKey:@"uid"]];
            [self setUserToken:[userDict valueForJSONStrKey:@"token"]];
            [self setSinStr:[userDict valueForJSONStrKey:@"sign"]];
            [self setUserData:userDict];
            [self saveUserInfoToDefault];
            //"idcard": 0//0-未上传名片，1：已上传名片
//            if ([[userDict valueForJSONStrKey:@"idcard"] isEqualToString:@"0"]) {
//                UINavigationController *curNav =  self.navcontroller;
//                BaseViewController *baseV=(BaseViewController *)[[curNav viewControllers] lastObject];
//                [baseV pushController:[UserAuthenticationViewController class] withInfo:@"diss" withTitle:@" " withOther:nil];
//            }else{
                [self hiddenLoginAlert];
//            }
            
            [self dispatchEventWithActionType:@"loginsuccess" actionData:nil];
            
            [self loginTMUIKit];
            [self dispatchEventWithActionType:@"登录成功" actionData:nil];
            
        }else{
            [SVProgressHUD showImage:nil status:[resData valueForJSONKey:@"info"]];
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showImage:nil status:alertErrorTxt];
    }];
    
}


-(void)mustLogInWithBlock:(AllcallBlock)sucBlok{
    if ([self isLogIn]) {
        sucBlok(nil,200,nil);
    }else{
        self.logSucBlock = sucBlok;
        self.isNOBackHome=YES;
        [self showLoginAlert];
    }
}

-(BOOL)isLogIn{
    if ([_userId notEmptyOrNull] && [_userToken notEmptyOrNull]){
        return YES;
    }else{
        return NO;
    }
}

-(void)isLogin:(AllcallBlock)aLoginSuc
{
    [self isLogin:aLoginSuc isServer:NO];
}
-(void)isLogin:(AllcallBlock)aLoginSuc isServer:(BOOL)abool{
    self.logSucBlock = aLoginSuc;
    if ([self.userId notEmptyOrNull] && [self.userToken notEmptyOrNull]) {
        //登录过-验证token是否过期
        if (abool) {
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:[self userId],@"uid",[self userToken],@"token",nil];
            [NetEngine createHttpAction:@"login/relogin" withCache:NO withParams:dic withMask:SVProgressHUDMaskTypeNil onCompletion:^(id resData, BOOL isCache) {
                if ([[resData valueForJSONKey:@"status"] isEqualToString:@"200"]) {
                    NSDictionary *userDict = [resData objectForJSONKey:@"data"];
                    [self setUserData:userDict];
                    [self saveUserInfoToDefault];
                    
                    [self dispatchEventWithActionType:@"loginsuccess" actionData:nil];
                    [self loginTMUIKit];
//                    //"idcard": 0//0-未上传名片，1：已上传名片
//                    if ([[userDict valueForJSONStrKey:@"idcard"] isEqualToString:@"0"]) {
//                        UINavigationController *curNav = [[[[Utility Share] CustomTabBar_zk] viewControllers] objectAtIndex:[[[Utility Share] CustomTabBar_zk]selectedIndex]];
//                        BaseViewController *baseV=(BaseViewController *)[[curNav viewControllers] lastObject];
//                        [baseV pushController:[UserAuthenticationViewController class] withInfo:@"diss_back" withTitle:@" " withOther:nil];
//                    }else{
                        //没过期
                        self.logSucBlock?self.logSucBlock(nil,200,nil):nil;//只用于验证是否过期-没过期
                        self.logSucBlock = nil;
//                    }
                    
                }else{  //过期
                    self.isNOBackHome=!abool;
                    [self showLoginAlert];
                }
            } onError:^(NSError *error) {
                //请求报错---处理为没过期
                self.logSucBlock?self.logSucBlock(nil,200,nil):nil;
                self.logSucBlock = nil;
            }];
        }else{
            self.logSucBlock?self.logSucBlock(nil,200,nil):nil;
            self.logSucBlock = nil;
        }
    }
    else{
        _isNOBackHome=!abool;
        [self showLoginAlert];
    }
}



- (void)hiddenLoginAlert
{
    [self hiddenLoginAlertWithBlock:YES];
}
- (void)hiddenLoginAlertWithBlock:(BOOL)aLoginSuc{
    __weak __typeof(self) weakSelf = self;
    UINavigationController *curNav = [[[[Utility Share] CustomTabBar_zk] viewControllers] objectAtIndex:[[[Utility Share] CustomTabBar_zk] selectedIndex]];
    [curNav dismissViewControllerAnimated:YES completion:^{
        weakSelf.logincontroller=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"againLoadUserData" object:nil];
        if (aLoginSuc) {
            [weakSelf updateLoginUserData];
            weakSelf.logSucBlock?weakSelf.logSucBlock(nil,200,nil):nil;
            weakSelf.logSucBlock = nil;
        }
    }];
}



- (void)showLoginAlert
{
    
    if (self.logincontroller) {
        self.isNOBackHome=NO;
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"push_showLogin" object:nil userInfo:nil];
    
    //退出im登录
    [self logOUTTMUIKit];
    
    UINavigationController *curNav = [[[[Utility Share] CustomTabBar_zk] viewControllers] objectAtIndex:[[[Utility Share] CustomTabBar_zk]selectedIndex]];
    [curNav dismissViewControllerAnimated:NO completion:nil];
    MyLoginViewController *login=[[MyLoginViewController alloc] init];
    self.logincontroller=login;
    KKNavigationController *loginNav=[[KKNavigationController alloc] initWithRootViewController:login];
    self.navcontroller=loginNav;
    loginNav.modalPresentationStyle=UIModalPresentationFullScreen;
    __weak typeof(self) weakSelf=self;
    [curNav presentViewController:loginNav animated:YES completion:^{
        if (weakSelf.isNOBackHome) {
            DLog(@"不回到首页");
            weakSelf.isNOBackHome=NO;
        }else{
            DLog(@"回到首页");
            [curNav popToRootViewControllerAnimated:NO];
            [[[Utility Share] CustomTabBar_zk] selectedTabIndex:@"0"];
        }
        
    }];
}


-(void)saveUserInfoToDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_userId forKey:@"_userId"];
    [defaults setValue:_userToken forKey:@"_userToken"];
    [defaults setValue:_userAccount forKey:@"_userAccount"];
    [defaults setValue:_sinStr forKey:@"_sinStr"];
    //    [defaults setValue:_userPwd forKey:@"_userPwd"];
    [defaults synchronize];
}


-(void)readUserInfoFromDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _userId=[defaults valueForKey:@"_userId"];
    _userToken=[defaults valueForKey:@"_userToken"];
    _userAccount=[defaults valueForKey:@"_userAccount"];
    _sinStr=[defaults valueForKey:@"_sinStr"];
    //    _userPwd=[defaults valueForKey:@"_userPwd"];
}
-(void)clearUserInfoInDefault
{
    //
    self.userId=@"";
    self.userToken=@"";
    self.userPwd=@"";
    self.userData=nil;
    [self saveUserInfoToDefault];
    
    //消除用户资料
    //    [self removeSqlData];
    
}
-(void)logoOut{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kS(@"setUp", @"dialog_message_logout") message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:kS(@"generalPage", @"OK") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消所有的本地通知
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        [self clearUserInfoInDefault];
        [self showLoginAlert];
        [[[Utility Share] CustomTabBar_zk] selectedTabIndex:@"0"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:kS(@"generalPage", @"cancel") style:UIAlertActionStyleDefault handler:nil]];
    [UTILITY.currentViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 更新登录用户的基础资料
/**
 更新登录用户的基础资料
 */
-(void)updateLoginUserData{
    krequestParam
    [NetEngine createGetAction_LJ_two:[NSString stringWithFormat:@"ucenter/index%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData objectForJSONKey:@"data"];
            self.userData=(id)dic;
            self.userNickName=[dic valueForJSONStrKey:@"realname"];
            self.userLogo=[dic valueForJSONStrKey:@"icon"];
            [self dispatchEventWithActionType:@"用户数据更新" actionData:nil];
            //更新用户IM信息
//            [[UtilityIM Share] updateUserData_IM];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }onError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:alertErrorTxt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateLoginUserData];
        });
    }];
}
-(void)loginTMUIKit{
    
    if (!self.isLogIn) {
        return;
    }
    
    [self updateLoginUserData];
    NSString *identifier = self.userId; //填入登录用户名
    NSString *userSig = self.sinStr;
    
    [self loginWithKit:identifier userSig:userSig];
    
}

-(void)loginWithKit:(NSString*)identifier userSig:(NSString*)userSig {
       __weak __typeof(self) weakSelf = self;
    [[TUIKit sharedInstance] loginKit:identifier userSig:userSig succ:^{
        weakSelf.imIsLogin = true;
        DLog(@"msg:%@",@"IM登录成功");
        DLog(@"\n\n\n\n登录用户：%@\n\n\n\n",[[TIMManager sharedInstance] getLoginUser]);
    } fail:^(int code, NSString *msg) {
        
        weakSelf.imIsLogin = false;
        DLog(@"msg:%@",msg)
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf loginWithKit:identifier userSig:userSig];
//        });
    }];
}


-(void)logOUTTMUIKit{
       __weak __typeof(self) weakSelf = self;
//    if (!self.isLogIn) {
//        return;
//    }
   
    
//    NSString *identifier = self.userId; //填入登录用户名
//    NSString *userSig = self.sinStr;
    
    [[TUIKit sharedInstance] logoutKit:^{
        DLog(@"msg:%@",@"IM退出成功");
        
        weakSelf.imIsLogin = false;
    } fail:^(int code, NSString *msg) {
        DLog(@"msg:%@",msg)
    }];
     
//     loginKit:identifier userSig:userSig succ:^{
//        DLog(@"msg:%@",@"IM登录成功");
//    } fail:^(int code, NSString *msg) {
//        DLog(@"msg:%@",msg)
//    }];
//
}

-(void)chatWithUser:(NSMutableDictionary*)user withCar:(BOOL)abool{
    if (!self.imIsLogin) {
//        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"IM未登录!" preferredStyle:UIAlertControllerStyleAlert];
//        [alertcv addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
////        [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
//
//        }];
        return;
    }
    
    
    //是否是车主
    TConversationCellData*conversation=[TConversationCellData new];
    conversation.convType=TConv_Type_C2C;
    if (abool) {
        conversation.convId=[user ojsk:@"uid"];
        if ([user ojk:@"userinfo"]) {
            
            conversation.title=[[user ojk:@"userinfo"] ojsk:@"nickname"];
            conversation.head=[[user ojk:@"userinfo"] ojsk:@"icon"];
        }else{
            
            conversation.title=[user ojsk:@"nickname"];
            conversation.head=[user ojsk:@"icon"];
        }
        
    }else{
        conversation.convId=[user ojsk:@"caruid"];
        conversation.title=[[user ojk:@"caruserinfo"] ojsk:@"nickname"];
        conversation.head=[[user ojk:@"caruserinfo"] ojsk:@"icon"];
    }
    
    
    [UTILITY.currentViewController pushController:[MessageChatViewController class] withInfo:conversation withTitle:conversation.title];
}
@end
