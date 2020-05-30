//
//  MyLoginViewController.m
//  BankIntegral
//
//  Created by 55like on 2018/6/4.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "LoginViewController.h"
#import "MYRHTableView.h"
//#import "FindPWDViewController.h"
@interface LoginViewController ()
{
    
    UITextField *txtAccount;
    UITextField *txtPwd;
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  LoginViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self navbarTitle:@"登录"];
}
#pragma mark -   write UI
-(void)addView{
//    __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.backgroundColor=rgbwhiteColor;
    
    [self.view addSubview:_mtableView];
    {
        UIView*viewTop=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 40+40+66) backgroundcolor:rgbwhiteColor superView:nil];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 40, 66, 66) defaultimage:@"loginlogo" supView:viewTop];
        [imgVIcon beCX];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewTop];
        
    }
    
    NSArray*arraytitle=@[@"请输入手机号",@"请输入密码",];
    NSArray*arrayImage=@[@"loginicon01",@"loginicon02",];
    for (int i=0; i<arraytitle.count; i++) {
        NSString*titleStr=arraytitle[i];
        UIView*viewCell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 53) backgroundcolor:nil superView:nil];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(34, 17, 18, 18) defaultimage:arrayImage[i] supView:viewCell];
        UITextField*tftext=[RHMethods textFieldlWithFrame:CGRectMake(imgVIcon.frameXW+11, 0, kScreenWidth-(imgVIcon.frameXW+11)-34, viewCell.frameHeight) font:Font(16) color:rgb(51, 51, 51) placeholder:titleStr text:nil  supView:viewCell];
        /*UIView*viewLine=*/[UIView viewWithFrame:CGRectMake(20, viewCell.frameHeight-1, kScreenWidth-40, 1) backgroundcolor:rgb(229,229,229) superView:viewCell];
        if (i==0) {
            txtAccount=tftext;
            tftext.text=kUtility_Login.userAccount;
        }else{
            txtPwd=tftext;
            tftext.secureTextEntry=YES;
            tftext.text=kUtility_Login.userPwd;
        }
        
        
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
    }
    
    
    WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(10, 40, kScreenWidth-20, 44) backgroundColor:rgb(18,142,73) text:@"登录" font:16 textColor:rgbwhiteColor radius:3 superview:nil];
    
    [_mtableView.defaultSection.noReUseViewArray addObject:btnOK];
    [btnOK addViewTarget:self select:@selector(submintButtonClicked:)];
    
    {
        UIView*viewLastCell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 53) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewLastCell];
        WSSizeButton*btnWangji=[RHMethods buttonWithframe:CGRectMake(0, 10, 80, 13+20) backgroundColor:nil text:@"忘记密码？" font:14 textColor:rgb(102,102,102) radius:0 superview:viewLastCell];
        btnWangji.frameRX=10;
        [btnWangji setBtnLableFrame:btnWangji.bounds];
        btnWangji.titleLabel.textAlignment=NSTextAlignmentRight;
        [btnWangji addViewClickBlock:^(UIView *view) {
            
//            [weakSelf pushController:[FindPWDViewController class] withInfo:nil withTitle:@"忘记密码"];
        }];
    }
    
    
    
}
-(void)submintButtonClicked:(UIButton*)btn{
    
    NSString *strAc=txtAccount.text;
    NSString *strPwd=txtPwd.text;
    
    [kUtility_Login loginWithAccount:strAc pwd:strPwd];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    
    [dictparam setObject:@"%@" forKey:@"p"];
    [dictparam setObject:@"12" forKey:@"pagesize"];
    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server
-(void)loadDATA{
    
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
