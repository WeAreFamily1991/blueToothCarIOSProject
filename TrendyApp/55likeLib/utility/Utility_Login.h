//
//  UserLoginService.h
//  BankIntegral
//
//  Created by 55like on 2018/6/11.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "MYBaseService.h"
#define kUtility_Login [Utility_Login shareInstence]
@interface Utility_Login : MYBaseService
/**
 登录成功回调
 */
@property(nonatomic,strong)AllcallBlock logSucBlock;

@property(nonatomic,copy)NSString*userId;
@property(nonatomic,copy)NSString*userToken;
@property(nonatomic,copy)NSString *userNickName;
@property(nonatomic,copy)NSString *userLogo;

@property (nonatomic, strong) NSString *userAccount;
@property (nonatomic, strong) NSString *sinStr;

@property (nonatomic, strong) NSString *userPwd;

@property (nonatomic, strong) NSDictionary *userData;

@property(nonatomic,assign)BOOL imIsLogin;
/**
 是否登录
 
 @return 是否登录
 */
-(BOOL)isLogIn;

/**
 登录成功
 
 @param sucBlok 登录成功回调
 */
-(void)mustLogInWithBlock:(AllcallBlock)sucBlok;


-(void)isLogin:(AllcallBlock)aLoginSuc;
-(void)isLogin:(AllcallBlock)aLoginSuc isServer:(BOOL)abool;
/**
 登录
 
 @param account 账号
 @param password 密码
 */
-(void)loginWithAccount:(NSString *)account pwd:(NSString *)password;
- (void)showLoginAlert;
- (void)hiddenLoginAlert;
- (void)hiddenLoginAlertWithBlock:(BOOL)aLoginSuc;
-(void)logoOut;

-(void)saveUserInfoToDefault;
-(void)readUserInfoFromDefault;
-(void)clearUserInfoInDefault;

/**
 更新登录用户的基础资料
 */
-(void)updateLoginUserData;
-(void)chatWithUser:(NSMutableDictionary*)user withCar:(BOOL)abool;
@end
