//
//  PaySuccessViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "PaySuccessViewController.h"

#import "MYRHTableView.h"
@interface PaySuccessViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  PaySuccessViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];

    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 75, kScreenWidth, 100) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 85, 85) defaultimage:@"complete2" supView:viewContent];
        [imgVIcon beCX];
        UILabel*lbContent=[RHMethods ClableY:imgVIcon.frameYH+54 W:viewContent.frameWidth-30 Height:19 font:19 superview:viewContent withColor:rgb(51, 51, 51) text:@"恭喜您，支付成功~"];
        UILabel*lbWarning=[RHMethods ClableY:lbContent.frameYH+15 W:lbContent.frameWidth Height:13 font:13 superview:viewContent withColor:rgb(244, 58, 58) text:@"您在提車時間2小時前可追加保險人"];
         WSSizeButton*btnViewOrder=[RHMethods buttonWithframe:CGRectMake(0, lbWarning.frameYH+46, 125, 44) backgroundColor:rgb(13, 112, 161) text:@"查看訂單" font:16 textColor:rgb(255, 255, 255) radius:4 superview:viewContent];
         WSSizeButton*btnBackHome=[RHMethods buttonWithframe:CGRectMake(kScreenWidth*0.5+10, btnViewOrder.frameY, btnViewOrder.frameWidth, btnViewOrder.frameHeight) backgroundColor:nil text:@"返回首頁" font:16 textColor:rgb(13, 112, 161) radius:4 superview:viewContent];
        btnBackHome.layer.borderWidth=1;
        btnBackHome.layer.borderColor=rgb(13, 112, 161).CGColor;
        btnViewOrder.frameRX=btnBackHome.frameX;
        
        
        
    }
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
