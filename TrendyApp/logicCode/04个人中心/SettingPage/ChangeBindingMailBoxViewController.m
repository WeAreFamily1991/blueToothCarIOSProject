//
//  ModifyPasswordViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ChangeBindingMailBoxViewController.h"
#import "MYRHTableView.h"
@interface ChangeBindingMailBoxViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;

//@property(nonatomic,strong)UITextField*accountTf;
@property(nonatomic,strong)UITextField*textfieldPhoneNumber;
@property(nonatomic,strong)UITextField*textfieldVerifyCode;
//@property(nonatomic,strong)UITextField*textfieldPassword;
@property(nonatomic,strong)UIButton*btnYZM;
@end

@implementation  ChangeBindingMailBoxViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self addView];
    [self navbarTitle:kST(@"changeBindingMailbox")];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    self.view.backgroundColor=rgb(255, 255, 255);
    NSArray*arraytitle=@[kS(@"changeBindingMailbox", @"hint_input_mail"),kS(@"changeBindingMailbox", @"register_hint_pls_input_verify_code")];
    for (int i=0; i<arraytitle.count; i++) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 55.5) backgroundcolor:nil superView:nil];
        UITextField*tfText=[RHMethods textFieldlWithFrame:CGRectMake(30, 0, viewContent.frameWidth-60, viewContent.frameHeight) font:Font(16) color:rgb(51, 51, 51) placeholder:[NSString stringWithFormat:@"%@",arraytitle[i]] text:@""  supView:viewContent];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(tfText.frameX, 0, tfText.frameWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        viewLine.frameBY=0;
        if (i==0) {
            viewContent.frameY=111;
            _textfieldPhoneNumber=tfText;
//            _textfieldPhoneNumber.userInteractionEnabled=NO;
//            _textfieldPhoneNumber.text=kUtility_Login.userAccount;
        }else if(i==2){
//            _textfieldPassword=tfText;
//            _textfieldPassword.secureTextEntry=YES;
        }else if(i==1){
            _textfieldVerifyCode=tfText;
        }
        if ([arraytitle[i] isEqualToString:kS(@"changeBindingMailbox",@"register_hint_pls_input_verify_code")]) {
            tfText.frameWidth=tfText.frameWidth-80;
            WSSizeButton*btnVerificationCode=[RHMethods buttonWithframe:CGRectMake(tfText.frameXW, 0, 80,  15+13+15) backgroundColor:nil text:kS(@"changeBindingMailbox", @"register_button_send_verify_code") font:14 textColor:rgb(13, 107, 154) radius:0 superview:viewContent];
            btnVerificationCode.frameBY=0;
            _btnYZM=btnVerificationCode;
            
            [_btnYZM addViewTarget:self select:@selector(YZMButtonClicked)];
        }
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    }
    
    {
        WSSizeButton*btnConfirm=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"changeBindingMailbox", @"button_submit") font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnConfirm];
        [btnConfirm addViewTarget:self select:@selector(submintButtonClicked)];
    }
    
    
}

-(void)submintButtonClicked{
    
    //    [self closeButtonClicked];
    __weak __typeof(self) weakSelf = self;
    krequestParam
    
        NSString *strAc=_textfieldPhoneNumber.text;
//    NSString *strPwd=_textfieldPassword.text;
    NSString *strYZM=_textfieldVerifyCode.text;
    NSMutableDictionary *dict=dictparam;
        [dict setValue:strAc forKey:@"email"];
//    [dict setValue:strPwd forKey:@"password"];
    //    [dict setValue:@"2" forKey:@"types"];
    [dict setValue:strYZM  forKey:@"codes"];
    NSString *strUrl=@"";
    strUrl=@"ucenter/bindemail";
    [NetEngine createHttpAction:strUrl withCache:NO withParams:dict withMask:SVProgressHUDMaskTypeClear onCompletion:^(id resData, BOOL isCache) {
        DLog(@"__resData____%@",resData);
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            //            self.boolBack=NO;
            [SVProgressHUD showImage:nil status:[resData valueForJSONStrKey:@"info"]];
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [weakSelf.navigationController popViewControllerAnimated:YES];
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
        [SVProgressHUD showImage:nil status:kS(@"modifyPassword", @"register_hint_pls_input_mail")];
        return;
    }
    [self loadSendCode:@""];
}

-(void)loadSendCode:(NSString *)strCid{
    NSString *strTel=_textfieldPhoneNumber.text;
    krequestParam
    NSMutableDictionary *dict=dictparam;
    [dict setValue:strTel forKey:@"username"];
    //    if ([self.userInfo isEqualToString:@"忘记密码"]) {
    [dict setValue:@"2" forKey:@"types"];
    [dict setValue:@"bindemail" forKey:@"type"];
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

@end
