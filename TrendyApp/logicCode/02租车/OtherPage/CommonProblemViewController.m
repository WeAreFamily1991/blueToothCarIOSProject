//
//  CommonProblemViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CommonProblemViewController.h"
#import "MYRHTableView.h"
#import "CustomerServiceCenterCellView.h"
@interface CommonProblemViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  CommonProblemViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    [_mtableView showRefresh:YES LoadMore:YES];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        CustomerServiceCenterCellView *viewcell=[CustomerServiceCenterCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"20" forKey:@"pagesize"];
    [dictparam setObject:@"1" forKey:@"type"];
    _mtableView.urlString=[NSString stringWithFormat:@"help%@",dictparam.wgetParamStr];
    [_mtableView refresh];
   
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
