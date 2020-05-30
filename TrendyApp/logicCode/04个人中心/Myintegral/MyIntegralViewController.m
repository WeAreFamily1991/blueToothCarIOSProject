//
//  MyIntegralViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "MYRHTableView.h"
#import "IntegralDetailListViewController.h"
@interface MyIntegralViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  MyIntegralViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addView];
    [self loadDATA];
    [self rightButton:nil image:@"listicon3" sel:@selector(rightBtnClick:)];
}
-(void)rightBtnClick:(UIButton*)btn{
    [self pushController:[IntegralDetailListViewController class] withInfo:nil withTitle:kS(@"MyPoints", @"IntegralDetails") withOther:@"point"];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 146, kScreenWidth, 600) backgroundcolor:nil superView:nil];
    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    {
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 70, 70) defaultimage:@"iicon" supView:viewContent];
        [imgVIcon beCX];
        UILabel*lbIncomeBalance=[RHMethods ClableY:imgVIcon.frameYH+30 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(153, 153, 153) text:kS(@"MyPoints", @"CurrentIntegral")];
        UILabel*lbNumberBalance=[RHMethods ClableY:lbIncomeBalance.frameYH+19.5 W:lbIncomeBalance.frameWidth Height:45 font:45 superview:viewContent withColor:rgb(51, 51, 51) text:[self.data ojsk:@"blance"]];
        UIView*viewCenterLine=[UIView viewWithFrame:CGRectMake(0, lbNumberBalance.frameYH+40, 37.5, 2) backgroundcolor:rgb(221, 221, 221) superView:viewContent];
        [viewCenterLine beCX];
        
        
        UILabel*lbIncomeBalance2=[RHMethods ClableY:viewCenterLine.frameYH+40 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(153, 153, 153) text:kS(@"MyPoints", @"AccumulatedIntegrals")];
        UILabel*lbNumberBalance2=[RHMethods ClableY:lbIncomeBalance2.frameYH+19.5 W:lbIncomeBalance2.frameWidth Height:45 font:45 superview:viewContent withColor:rgb(153,153,153) text:[self.data  ojsk:@"total"]];
        viewContent.frameHeight=lbNumberBalance2.frameYH+10;
        
    }
    if (viewContent.frameYH>kScreenHeight-viewContent.frameY-60) {
        viewContent.frameY=70;
    }
    
    {
        UIView*viewBottum=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 32.5+14+32.5) backgroundcolor:nil superView:self.view];
        viewBottum.frameBY=0;
        
        UILabel*lbHowGet=[RHMethods lableX:0 Y:0 W:kScreenWidth*0.5-20.5 Height:viewBottum.frameHeight font:14 superview:viewBottum withColor:rgb(13, 107, 154) text:kS(@"MyPoints", @"HowToGet")];
        lbHowGet.textAlignment=NSTextAlignmentRight;
  
        
         UILabel*lbUseRule=[RHMethods RlableRX:0 Y:0 W:kScreenWidth*0.5-20.5 Height:viewBottum.frameHeight font:14 superview:viewBottum withColor:rgb(13, 107, 154) text:kS(@"MyPoints", @"UsageRule")];
        lbUseRule.textAlignment=NSTextAlignmentLeft;
       
        [lbHowGet addViewClickBlock:^(UIView *view) {
            UILabel*lbHowGet=(id)view;
            [kUserCenterService goWelcom_getruleWithTitle:lbHowGet.text withtype:@"rule_pointget"];
        }];
        [lbUseRule addViewClickBlock:^(UIView *view) {
            UILabel*lbUseRule=(id)view;
            [kUserCenterService goWelcom_getruleWithTitle:lbUseRule.text withtype:@"rule_pointuse"];
        }];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 0.5, 18) backgroundcolor:rgb(153, 153, 153) superView:viewBottum];
        [viewLine beCX];
        [viewLine beCY];
    }
}
#pragma mark  request data from the server use tableview
-(void)request{
//    krequestParam
//
//    [dictparam setObject:@"%@" forKey:@"page"];
//    [dictparam setObject:@"12" forKey:@"limit"];
//    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
//    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server
-(void)loadDATA{
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    [mdic setObject:@"point" forKey:@"type"];
      __weak __typeof(self) weakSelf = self;
    [kUserCenterService ucenter_getaccount:mdic withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf addView];
    }];
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
