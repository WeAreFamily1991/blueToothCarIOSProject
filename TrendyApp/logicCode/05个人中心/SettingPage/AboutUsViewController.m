//
//  AboutUsViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AboutUsViewController.h"
#import "MYRHTableView.h"
@interface AboutUsViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  AboutUsViewController
#pragma mark  bigen
- (void)viewDidLoad { 
    [super viewDidLoad];
    [self addView];
    [self navbarTitle:kST(@"aboutUs")];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 160) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 163, 50) defaultimage:@"logoi1" supView:viewContent];
        [imgVIcon beCX];
        [imgVIcon beCY];
    }
    
    NSArray*arrayContent=@[
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"aboutUs", @"CurrentVersion"),
                               @"frameY":@"0",
                               @"describe":[NSString stringWithFormat:@"%@:%@",kS(@"aboutUs", @"VersionNumber"),[UTILITY VersionSelectString]],
//                               @"actionType":@"CurrentVersion",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"aboutUs", @"UserServiceProtocol"),
                               @"frameY":@"0",
                               @"describe":@"",
                               @"actionType":@"rule_service",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"aboutUs", @"PrivacyPolicy"),
                               @"frameY":@"",
                               @"describe":@"",
                               @"actionType":@"rule_privacy",
                               },
                        
                           ];
    for (int i=0; i<arrayContent.count; i++) {
        UIView*viewCell=[UIView getViewWithConfigData:arrayContent[i]];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        if ([[arrayContent[i] ojsk:@"actionType"] notEmptyOrNull]) {
            [viewCell addViewTarget:self select:@selector(menuBtnClick:)];
        }
        
    }
    {
        UIView*viewLastView=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 60) backgroundcolor:nil superView:nil];
        [self.view addSubview:viewLastView];
        viewLastView.frameBY=0;
        UILabel*lbContent=[RHMethods ClableY:0 W:viewLastView.frameWidth-40 Height:0 font:12 superview:viewLastView withColor:rgb(102, 102, 102) text:@"Copyright  ©  2018 All rights reserved\nby Trendy二手車營銷服務平臺    沪ICP备18015430号"];
        lbContent.frameY=0;
    }
}
-(void)menuBtnClick:(UIView*)viewCell{
    [kUserCenterService goWelcom_getruleWithTitle:[viewCell.data ojsk:@"name"] withtype:[viewCell.data ojsk:@"actionType"]];

}

#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
