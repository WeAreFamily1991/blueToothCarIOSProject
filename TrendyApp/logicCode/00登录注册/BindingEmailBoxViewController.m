//
//  MyForgetPassWordViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//

#import "BindingEmailBoxViewController.h"
#import "MYRHTableView.h"
@interface BindingEmailBoxViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UITextField*accountTf;
@end

@implementation  BindingEmailBoxViewController
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
    
    NSArray*arraytitle=@[@"請輸入邮箱",];
    for (int i=0; i<arraytitle.count; i++) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(30, 10, kScreenWidth-60, 55-10) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UITextField*tfInput=[RHMethods textFieldlWithFrame:CGRectMake(0, 0, viewContent.frameWidth, viewContent.frameHeight) font:Font(15) color:rgb(51, 51, 51) placeholder:arraytitle[i] text:@""  supView:viewContent];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, viewContent.frameWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        viewLine.frameBY=0;
        if (i==0) {
            viewContent.frameYH=105;
            _accountTf=tfInput;
        }
    }
    
    {
        WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(30, 30, kScreenWidth-60, 44) backgroundColor:rgb(13, 107, 154) text:@"立即綁定" font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnOK];
    }
    //    {
    //         WSSizeButton*btnSwich=[RHMethods buttonWithframe:CGRectMake(30, 25-5, kScreenWidth-60, 13+10) backgroundColor:nil text:@"郵箱註冊" font:13 textColor:rgb(13, 107, 154) radius:0 superview:nil];
    //        [_mtableView.defaultSection.noReUseViewArray addObject:btnSwich];
    //          __weak __typeof(self) weakSelf = self;
    //        [btnSwich setTitle:@"手機註冊" forState:UIControlStateSelected];
    //        [btnSwich addViewClickBlock:^(UIView *view) {
    //            WSSizeButton*btnSwich=(id)view;
    //            btnSwich.selected=!btnSwich.selected;
    //            weakSelf.accountTf.placeholder=btnSwich.selected?@"請輸入郵箱":@"請輸入手機號";
    //            [weakSelf navbarTitle:btnSwich.selected?@"郵箱註冊":@"手機註冊"];
    //        }];
    //        if (self.otherInfo) {
    //            [btnSwich viewClickMe];
    //        }
    //
    //    }
    //    {
    //        UILabel*lbPrivacyProtocpol=[RHMethods ClableY:0 W:0 Height:13 font:13 superview:self.view withColor:rgb(102, 102, 102) text:@"请阅读并同意《隱私條款》"];
    //        [lbPrivacyProtocpol setColor:rgb(13,107,154) contenttext:@"《隱私條款》"];
    //    }
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
