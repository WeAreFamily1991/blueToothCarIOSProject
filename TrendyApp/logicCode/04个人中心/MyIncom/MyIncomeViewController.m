//
//  MyIncomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyIncomeViewController.h"
#import "MYRHTableView.h"
#import "IntegralDetailListViewController.h"
//MyIncome
@interface MyIncomeViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  MyIncomeViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDATA];
    [self rightButton:nil image:@"listicon3" sel:@selector(rightBtnClick:)];
}
-(void)rightBtnClick:(UIButton*)btn{
    [self pushController:[IntegralDetailListViewController class] withInfo:nil withTitle:kS(@"MyPoints", @"IncomeDetails") withOther:@"cash"];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 146, kScreenWidth, 200) backgroundcolor:nil superView:nil];
    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    {
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 70, 70) defaultimage:@"iicon1" supView:viewContent];
        [imgVIcon beCX];
        UILabel*lbIncomeBalance=[RHMethods ClableY:imgVIcon.frameYH+30 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(153, 153, 153) text:kS(@"MyIncome", @"IncomeBalance")];
        UILabel*lbNumberBalance=[RHMethods ClableY:lbIncomeBalance.frameYH+19.5 W:lbIncomeBalance.frameWidth Height:45 font:45 superview:viewContent withColor:rgb(51, 51, 51) text:[self.data ojsk:@"blance"]];
        
    }
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    [mdic setObject:@"cash" forKey:@"type"];
    __weak __typeof(self) weakSelf = self;
    [kUserCenterService ucenter_getaccount:mdic withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf addView];
    }];
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
