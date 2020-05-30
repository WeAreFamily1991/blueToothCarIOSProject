//
//  MyForgetPassWordViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyForgetPassWordViewController.h"
#import "MYRHTableView.h"
@interface MyForgetPassWordViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
//@property(nonatomic,strong)UITextField*accountTf;
@property(nonatomic,strong)UITextField*textfieldPhoneNumber;
@property(nonatomic,strong)UITextField*textfieldVerifyCode;
@property(nonatomic,strong)UITextField*textfieldPassword;
@property(nonatomic,strong)UIButton*btnYZM;

@end

@implementation  MyForgetPassWordViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    self.view.backgroundColor=rgb(255, 255, 255);
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    NSArray*arraytitle=@[kS(@"forgetPassword", @"register_hint_pls_input_mail"),kS(@"forgetPassword", @"register_hint_pls_input_verify_code"),kS(@"forgetPassword", @"forget_pwd_hint_pls_input_new_pwd"),];
    for (int i=0; i<arraytitle.count; i++) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(30, 10, kScreenWidth-60, 55-10) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UITextField*tfInput=[RHMethods textFieldlWithFrame:CGRectMake(0, 0, viewContent.frameWidth, viewContent.frameHeight) font:Font(15) color:rgb(51, 51, 51) placeholder:arraytitle[i] text:@""  supView:viewContent];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, viewContent.frameWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        viewLine.frameBY=0;
        if (i==0) {
            viewContent.frameYH=105;
            _textfieldPhoneNumber=tfInput;
        }else if(i==1){
            _textfieldVerifyCode=tfInput;
            WSSizeButton*btnYZM=[RHMethods buttonWithframe:CGRectMake(0, 0, 90, tfInput.frameHeight) backgroundColor:nil text:kS(@"forgetPassword", @"register_button_send_verify_code") font:14 textColor:rgb(13,107,154) radius:0 superview:viewContent];
            btnYZM.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            btnYZM.frameRX=tfInput.frameRX;
            tfInput.frameWidth=tfInput.frameWidth-10-btnYZM.frameWidth;
            [btnYZM addViewTarget:self select:@selector(YZMButtonClicked)];
            _btnYZM=btnYZM;
        }else if(i==2){
            _textfieldPassword=tfInput;
            _textfieldPassword.secureTextEntry=YES;
        }
    }
    {
        WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(30, 30, kScreenWidth-60, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"forgetPassword", @"forget_pwd_button_submit") font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnOK];
        [btnOK addViewTarget:self select:@selector(submintButtonClicked)];
    }
//    {
//        WSSizeButton*btnSwich=[RHMethods buttonWithframe:CGRectMake(30, 25-5, kScreenWidth-60, 13+10) backgroundColor:nil text:kS(@"forgetPassword", @"register_button_register_by_mail") font:13 textColor:rgb(13, 107, 154) radius:0 superview:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:btnSwich];
//        __weak __typeof(self) weakSelf = self;
//        [btnSwich setTitle:kS(@"forgetPassword", @"register_button_register_by_phone_number") forState:UIControlStateSelected];
//        [btnSwich addViewClickBlock:^(UIView *view) {
//            WSSizeButton*btnSwich=(id)view;
//            btnSwich.selected=!btnSwich.selected;
//            weakSelf.textfieldPhoneNumber.placeholder=btnSwich.selected?kS(@"forgetPassword", @"register_hint_pls_input_mail"):kS(@"forgetPassword", @"register_hint_pls_input_phone_number");
//            [weakSelf navbarTitle:btnSwich.selected?kS(@"forgetPassword", @"register_button_register_by_mail"):kS(@"forgetPassword", @"register_button_register_by_phone_number")];
//        }];
//        //        if (self.otherInfo) {
//        [btnSwich viewClickMe];
//        btnSwich.hidden=YES;
//        btnSwich.alpha=0;
//        //        }
//
//    }
    
//    {
//        //        UILabel*lbPrivacyProtocpol=[RHMethods ClableY:0 W:0 Height:13 font:13 superview:self.view withColor:rgb(102, 102, 102) text:kS(@"forgetPassword", @"register_button_agree_policy")];
//        UILabel*lbPrivacyProtocpol=[RHMethods ClableY:0 W:0 Height:13 font:13 superview:self.view withColor:rgb(102, 102, 102) text:kS(@"forgetPassword", @"register_button_agree_policy")];
//        lbPrivacyProtocpol.frameBY=20;
//
//
//        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[kS(@"forgetPassword", @"register_button_agree_policy") dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
//                                                           documentAttributes:nil error:nil];
//        lbPrivacyProtocpol.numberOfLines = 0;
//        [lbPrivacyProtocpol setAttributedText:attrStr];
//        //        [lbPrivacyProtocpol setColor:rgb(13,107,154) contenttext:@"《隱私條款》"];
//    }
}


-(void)submintButtonClicked{
    
    //    [self closeButtonClicked];
    
    NSString *strAc=_textfieldPhoneNumber.text;
    NSString *strPwd=_textfieldPassword.text;
    NSString *strYZM=_textfieldVerifyCode.text;
    //    NSString *strPWD2=_textfieldPassword.text;
    //    if (![strPwd isEqualToString:strPWD2]) {
    //        [SVProgressHUD showImage:nil status:@"两次输入密码不一样！"];
    //        return;
    //    }
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setValue:strAc forKey:@"username"];
    [dict setValue:strPwd forKey:@"password"];
    [dict setValue:@"2" forKey:@"types"];
    [dict setValue:strYZM  forKey:@"codes"];
    NSString *strUrl=@"";
    strUrl=@"login/forgetpwd";
    [NetEngine createHttpAction:strUrl withCache:NO withParams:dict withMask:SVProgressHUDMaskTypeClear onCompletion:^(id resData, BOOL isCache) {
        DLog(@"__resData____%@",resData);
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            //            self.boolBack=NO;
            [SVProgressHUD showImage:nil status:[resData valueForJSONStrKey:@"info"]];
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            
            [kUtility_Login loginWithAccount:strAc pwd:strPwd];
            //            if([self.userInfo isEqualToString:@"绑定手机"]||
            //               [self.userInfo isEqualToString:@"注册"]){
            //                NSDictionary *userDict = [resData objectForJSONKey:@"data"];
            //                [kUtility_Login setUserAccount:strAc];
            //                //                [[Utility Share] setUserPwd:strPwd];
            //
            //                [kUtility_Login setUserId:[userDict valueForJSONStrKey:@"id"]];
            //                [kUtility_Login setUserToken:[userDict valueForJSONStrKey:@"token"]];
            //                //                [[Utility Share] setUsercookievalue:[userDict valueForJSONStrKey:@"cookievalue"]];
            //
            //                [kUtility_Login setUserData:userDict];
            //                [kUtility_Login saveUserInfoToDefault];
            //
            //                [kUtility_Login hiddenLoginAlert];
            //            }else{
            
            
            //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                    [super backButtonClicked:nil];
            //                });
            //            }
        }else{
            [SVProgressHUD showImage:nil status:[resData valueForJSONStrKey:@"info"]];
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showImage:nil status:alertErrorTxt];
    }];
}
#pragma mark  request data from the server use tableview

-(void)YZMButtonClicked{
    [self.view endEditing:YES];
    NSString *strTel=_textfieldPhoneNumber.text;
    if (![strTel notEmptyOrNull]) {
        [SVProgressHUD showImage:nil status:kS(@"forgetPassword", @"register_hint_pls_input_mail")];
        return;
    }
    [self loadSendCode:@""];
}

-(void)loadSendCode:(NSString *)strCid{
    NSString *strTel=_textfieldPhoneNumber.text;
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setValue:strTel forKey:@"username"];
    [dict setValue:kLanguageService.appLanguage forKey:@"language"];
    //    if ([self.userInfo isEqualToString:@"忘记密码"]) {
    [dict setValue:@"2" forKey:@"types"];
    [dict setValue:@"forgetpwd" forKey:@"type"];
    //    }else if([self.userInfo isEqualToString:@"绑定手机"]){
    //        [dict setValue:@"" forKey:@"codeType"];
    //    }else if ([self.userInfo isEqualToString:@"注册"]){
    //        [dict setValue:@"forgetPassword" forKey:@"codeType"];
    //    }
    
    [NetEngine createHttpAction:@"login/getcode" withCache:NO withParams:dict withMask:SVProgressHUDMaskTypeClear onCompletion:^(id resData, BOOL isCache) {
        DLog(@"__resData____%@",resData);
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            //            self.boolBack=YES;
            self.textfieldVerifyCode.text=[[resData objectForJSONKey:@"data"] valueForJSONStrKey:@"code"];
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONStrKey:@"info"]];
            self.btnYZM.userInteractionEnabled=NO;
            [self performSelector:@selector(updateButtonTitle:) withObject:[[resData objectForJSONKey:@"data"] valueForJSONStrKey:@"second"] afterDelay:0];
            //            if ([self.userInfo isEqualToString:@"绑定手机"]) {
            //                if ([[[resData objectForJSONKey:@"data"] valueForJSONStrKey:@"set_passwd"] isEqualToString:@"0"]) {
            //                    self.pwdBG1.hidden=YES;
            //                    self.pwdBG2.hidden=YES;
            //                    self.subBtn.frameY=Y(self.pwdBG1)+30;
            //                }else{
            //                    self.pwdBG1.hidden=NO;
            //                    self.pwdBG2.hidden=NO;
            //                    self.subBtn.frameY=YH(self.pwdBG2)+40;
            //                }
            //                [self.scrollBG setContentSize:CGSizeMake(kScreenWidth, YH(self.subBtn)+20)];
            //            }
            
        }else{
            [SVProgressHUD showImage:nil status:[resData valueForJSONStrKey:@"info"]];
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showImage:nil status:alertErrorTxt];
    }];
    
}
-(void)updateButtonTitle:(NSString *)str{
    int aflote=[str intValue];
    DLog(@"________________()()()()()(");
    [self.btnYZM setTitle:[NSString stringWithFormat:kS(@"forgetPassword", @"register_button_send_verify_code_waiting_time"),aflote] forState:UIControlStateNormal];
    if (aflote<=1) {
        [self performSelector:@selector(yanZM_date) withObject:nil afterDelay:1.0];
    }else{
        aflote--;
        [self performSelector:@selector(updateButtonTitle:) withObject:[NSString stringWithFormat:@"%d",aflote] afterDelay:1.0];
    }
}

-(void)yanZM_date{
    DLog(@"延迟——————禁止验证码按钮");
    [self.btnYZM setTitle:kS(@"forgetPassword", @"register_button_send_verify_code") forState:UIControlStateNormal];
    self.btnYZM.userInteractionEnabled=YES;
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
