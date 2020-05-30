//
//  SuccessfulApplicationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SuccessfulApplicationViewController.h"
#import "MYRHTableView.h"
@interface SuccessfulApplicationViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  SuccessfulApplicationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtableView];
    
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 75, kScreenWidth, 100) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 85, 85) defaultimage:@"complete2" supView:viewContent];
        [imgVIcon beCX];
        UILabel*lbContent=[RHMethods ClableY:imgVIcon.frameYH+54 W:viewContent.frameWidth-30 Height:0 font:19 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carApplyBookingSuccess", @"resultTitle")];
        UILabel*lbWarning=[RHMethods ClableY:lbContent.frameYH+15 W:lbContent.frameWidth Height:0 font:13 superview:viewContent withColor:rgb(244,58,58) text:kS(@"carApplyBookingSuccess", @"resultDesc")];
        WSSizeButton*btnViewOrder=[RHMethods buttonWithframe:CGRectMake(0, lbWarning.frameYH+46, 125+30, 44) backgroundColor:rgb(13, 112, 161) text:kS(@"carApplyBookingSuccess", @"lookApply") font:14 textColor:rgb(255, 255, 255) radius:4 superview:viewContent];//@"查看申請信息
        [btnViewOrder addViewTarget:self select:@selector(clikcedOrders)];
        WSSizeButton*btnBackHome=[RHMethods buttonWithframe:CGRectMake(kScreenWidth*0.5+10, btnViewOrder.frameY, btnViewOrder.frameWidth, btnViewOrder.frameHeight) backgroundColor:nil text:kS(@"carApplyBookingSuccess", @"returnHome") font:14 textColor:rgb(13, 112, 161) radius:4 superview:viewContent];//@"返回首頁"
        btnBackHome.layer.borderWidth=1;
        btnBackHome.layer.borderColor=rgb(13, 112, 161).CGColor;
        btnViewOrder.frameRX=btnBackHome.frameX;
        [btnBackHome addViewTarget:self select:@selector(clikcedHome)];
        
        viewContent.frameHeight=YH(btnBackHome);
        
    }
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - event listener function
-(void)clikcedOrders{
    [UTILITY.CustomTabBar_zk selectedTabIndex:@"2"];
}
-(void)clikcedHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - delegate function


@end
