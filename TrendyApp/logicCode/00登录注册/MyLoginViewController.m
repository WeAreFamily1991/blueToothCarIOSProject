//
//  MyLoginViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//
#import "MyLoginViewController.h"
#import "MYRHTableView.h"
#import "MyForgetPassWordViewController.h"
#import "MyRegistViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
@interface MyLoginViewController  ()
{
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UITextField*textfieldEmail;
@property(nonatomic,strong)UITextField*textfieldPassword;
@end

@implementation  MyLoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateStatusBarStyleLightContent];
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
 WSSizeButton*btnClose=[RHMethods buttonWithframe:CGRectMake(0, kTopHeight-44, 20+30, 44) backgroundColor:nil text:@"" font:0 textColor:nil radius:0 superview:self.view];
    [btnClose setImageStr:@"closeix" SelectImageStr:nil];
    [btnClose addViewClickBlock:^(UIView *view) {
//        kUtility_Login.logSucBlock = nil;
        [kUtility_Login hiddenLoginAlertWithBlock:NO];
        
    }];
}
#pragma mark -   write UI
-(void)addView{
    self.navView.hidden=YES;
    
      __weak __typeof(self) weakSelf = self;
    UIView*viewBottomHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 210) backgroundcolor:rgb(0, 0, 0) superView:self.view];
    UIImageView*imgVBG=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 210) defaultimage:@"proimg2" supView:viewBottomHeader];
    imgVBG.alpha=0.8;
    UIImageView*imgVLogo=[RHMethods imageviewWithFrame:CGRectMake(0, 71, 163, 50) defaultimage:@"logoi" supView:imgVBG];
    [imgVLogo beCX];
    
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-0) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    _mtableView.backgroundColor=[UIColor clearColor];
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(20, 165, kScreenWidth-40, 280) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        viewContent.layer.cornerRadius=5;
        
        NSArray*arraytitle=@[kS(@"login", @"login_hint_user"),kS(@"login", @"login_hint_password"),];
        
        NSArray*arrayImage=@[@"emaili",@"logini",];
        for (int i=0; i<arraytitle.count; i++) {
            UIView*viewContentCell=[UIView viewWithFrame:CGRectMake(0, 15+i*60, viewContent.frameWidth, 60) backgroundcolor:nil superView:viewContent];
            UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(28, 32, 16, 16) defaultimage:arrayImage[i] supView:viewContentCell];
            UITextField*tfInput=[RHMethods textFieldlWithFrame:CGRectMake(imgVIcon.frameXW+10, 0, viewContentCell.frameWidth-imgVIcon.frameXW-10-28, 14+2*13) font:Font(14) color:rgb(51, 51, 51) placeholder:arraytitle[i] text:@""  supView:viewContentCell];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(28, 0, viewContentCell.frameWidth-2*28, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContentCell];
            viewLine.frameBY=0;
            tfInput.frameBY=0;
            if (i== 0) {
                self.textfieldEmail=tfInput;
            }else{
                self.textfieldPassword=tfInput;
                self.textfieldPassword.secureTextEntry=YES;
            }
        }
        WSSizeButton*btnLogin=[RHMethods buttonWithframe:CGRectMake(28, 0, viewContent.frameWidth-28*2, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"login", @"login_button_login") font:16 textColor:rgbwhiteColor radius:5 superview:viewContent];
        btnLogin.frameBY=70;
        
        [btnLogin addViewTarget:self select:@selector(loginBtnClick:)];
        UILabel*lbforget=[RHMethods lableX:btnLogin.frameX Y:btnLogin.frameYH+15 W:btnLogin.frameWidth*0.5-20 Height:13 font:13 superview:viewContent withColor:rgb(102, 102, 102) text:kS(@"login", @"login_text_forget_password")];
        [lbforget addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[MyForgetPassWordViewController class] withInfo:nil withTitle:kST(@"forgetPassword")];
        }];
        
        UILabel*lbNewUserRegist=[RHMethods RlableRX:28 Y:lbforget.frameY W:lbforget.frameWidth Height:lbforget.frameHeight font:lbforget.frameHeight superview:viewContent withColor:rgb(13, 107, 154) text:kS(@"login", @"login_text_register")];
        [lbNewUserRegist addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[MyRegistViewController class] withInfo:nil withTitle:kST(@"register")];
        }];
    }
    
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]) {
       
        UILabel*lbMe=[RHMethods ClableY:0 W:kScreenWidth Height:14 font:14 superview:self.view withColor:rgb(187, 187, 187) text:kS(@"login", @"login_text_third_login")];
        lbMe.frameBY=76;
        UIImageView*imgVWChat=[RHMethods imageviewWithFrame:CGRectMake(0, lbMe.frameYH+16, 40, 40) defaultimage:@"webchati" supView:self.view];
        [imgVWChat beCX];

        [imgVWChat addViewClickBlock:^(UIView *view) {
            [weakSelf otherTypeLogin:SSDKPlatformTypeWechat];
        }];
    }
    
}
#pragma mark  request data from the server use tableview
-(void)loginBtnClick:(UIButton*)btn{
    [kUtility_Login loginWithAccount:self.textfieldEmail.text pwd:self.textfieldPassword.text];
}

#pragma mark - event listener function


#pragma mark - delegate function

#pragma mark - 第三方登录
-(void)otherTypeLogin:(SSDKPlatformType)type{
    //清除第三方平台授权
//    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
//    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat result:nil];
    NSMutableDictionary *dicT=[NSMutableDictionary new];
    if (type==SSDKPlatformTypeQQ) {
        [dicT setValue:@"qq" forKey:@"type"];
    }else if(type==SSDKPlatformTypeWechat){
        [dicT setValue:@"wx" forKey:@"type"];
    }else if(type==SSDKPlatformTypeSinaWeibo){
        [dicT setValue:@"sina" forKey:@"type"];
    }
   
    [ShareSDK getUserInfo:type
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             [dicT setValue:user.uid forKey:@"usid"];
             [dicT setValue:user.nickname forKey:@"name"];
             [dicT setValue:user.icon forKey:@"icon"];
             [dicT setValue:user.gender==SSDKGenderFemale?@"2":@"1" forKey:@"sex"];
             [self loginThirdPartyShareSDK:dicT];
         }else if (state==SSDKResponseStateFail){
             DLog(@"error:%@",error);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:[NSString stringWithFormat:@"%@",error]
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
             [alert show];
         }else
         {
             NSLog(@"%@",error);
         }

     }];
}

-(void)loginThirdPartyShareSDK:(NSMutableDictionary *)dic{
    //    [SVProgressHUD showImage:nil status:@"没得接口"];
    [dic setValue:@"wechat" forKey:@"type"];//wechat：微信
    krequestParam
    [dic addEntriesFromDictionary:dictparam];
    DLog(@"_________dic:%@",dic);
    [NetEngine createPostAction:@"login/thirdlogin" withParams:dic onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *userDict = [resData objectForJSONKey:@"data"];
            if (![[userDict valueForJSONStrKey:@"email"] notEmptyOrNull]){//是否已绑定账号
//            if ([[userDict valueForJSONStrKey:@"mobile"] notEmptyOrNull]){//是否已绑定账号
                [self pushController:[MyRegistViewController class] withInfo:@"绑定手机" withTitle:kST(@"bind_mail") withOther:@{@"data":userDict,@"TypeLogin":dic} withAllBlock:^(id data, int status, NSString *msg) {
                    [kUtility_Login clearUserInfoInDefault];
                }];
            }else{
                [kUtility_Login setUserId:[userDict valueForJSONStrKey:@"uid"]];
                [kUtility_Login setUserToken:[userDict valueForJSONStrKey:@"token"]];
                [kUtility_Login setUserData:userDict];
                
                [kUtility_Login saveUserInfoToDefault];
                [kUtility_Login hiddenLoginAlert];
            }
        }else{
            [SVProgressHUD showImage:nil status:[resData valueForJSONStrKey:@"info"]];
        }
    }];
    
}

@end
