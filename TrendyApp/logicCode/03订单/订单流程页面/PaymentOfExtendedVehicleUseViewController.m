//
//  PaymentOfExtendedVehicleUseViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "PaymentOfExtendedVehicleUseViewController.h"

#import "MYRHTableView.h"
@interface PaymentOfExtendedVehicleUseViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  PaymentOfExtendedVehicleUseViewController
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
    NSArray*titleArray=@[@"車輛租金",@"保險金",@"費用統計：2040元"];
    for (int i=0; i<titleArray.count; i++) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 55) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:0 W:kScreenWidth-30 Height:viewContent.frameHeight font:16 superview:viewContent withColor:rgb(51, 51, 51) text:titleArray[i]];
        
        UILabel*lbDes=[RHMethods RlableRX:15 Y:0 W:lbName.frameWidth Height:viewContent.frameHeight font:14 superview:viewContent withColor:rgb(153, 153, 153) text:@"499元*3天   1500元"];
        [lbDes setColor:rgb(51, 51, 51) contenttext:@"1500元"];
        UIView*viewline= [UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight-1, viewContent.frameWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        if (i==2) {
            lbName.textAlignment=NSTextAlignmentRight;
            [lbName setColor:rgb(244, 58, 58) contenttext:@"2040元"];
            viewline.hidden=YES;
            lbDes.hidden=YES;
        }
    }
    _mtableView.frameHeight=_mtableView.frameHeight-100;
    {
        UIView*content=[UIView viewWithFrame:CGRectMake(0, _mtableView.frameYH, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:self.view];
        [UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:content];
        UILabel*lbRead=[RHMethods lableX:15 Y:0 W:kScreenWidth-30 Height:40 font:13 superview:content withColor:rgb(102, 102, 102) text:@"請閱讀並同意《Trendy租車支付協議》"];
        UIView*viewline=[UIView viewWithFrame:CGRectMake(0, lbRead.frameYH, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:content];
        UILabel*priceLable=[RHMethods labelWithFrame:CGRectMake(15, viewline.frameYH, kScreenWidth-30-100, 60) font:Font(16) color:rgb(244, 58, 58) text:@"實付金額：2040元" supView:content];
        [priceLable setColor:rgb(51, 51, 51) contenttext:@"實付金額："];
    
         WSSizeButton*btnPay=[RHMethods buttonWithframe:CGRectMake(0,viewline.frameYH+ 10, 130, 40) backgroundColor:rgb(13, 112, 161) text:@"立即支付" font:16 textColor:rgb(255, 255, 255) radius:5 superview:content];
        btnPay.frameRX=15;
        
    }
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
