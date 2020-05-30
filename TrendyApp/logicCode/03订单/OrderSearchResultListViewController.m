//
//  OrderSearchResultListViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/4/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderSearchResultListViewController.h"
#import "MYRHTableView.h"
#import "OrderHomeCellView.h"
#import "OrderDetailViewController.h"
#import "NoDataView.h"
@interface OrderSearchResultListViewController   ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  OrderSearchResultListViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
    _mtableView.noDataView=[NoDataView NoDataViewWithImageStr:@"emptyi" withTitleStr:kS(@"main_order", @"empty_notice_primary") ContentStr:kS(@"main_order", @"empty_notice")];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        OrderHomeCellView*viewcell=[OrderHomeCellView viewWithFrame:CGRectMake(0, 10, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell upDataMeWithData:Datadic];
        [viewcell addBaseViewTarget:weakSelf select:@selector(cellBtnClick:)];
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        [weakSelf pushController:[OrderDetailViewController class] withInfo:[Datadic ojsk:@"orderid"] withTitle:kST(@"order_detail")];
    }];
    
}
#pragma mark  request data from the server use tableview

-(void)cellBtnClick:(OrderHomeCellView*)viewcell{
    __weak __typeof(self) weakSelf = self;
    [kOrderService orderActionWithOrderData:viewcell.data WithActionType:[[viewcell.eventView data] ojsk:@"action"] withBlock:^(id data, int status, NSString *msg) {
        [weakSelf request];
    }];
}
#pragma mark  request data from the server use tableview
-(void)request{
    [_mtableView showRefresh:YES LoadMore:YES];
    krequestParam
    //    if (_tfSearch&&_tfSearch.hidden==NO) {
    [dictparam setObject:self.userInfo forKey:@"key"];
    //    }
    
    [dictparam setObject:@"1" forKey:@"status"];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [pageOrPageSizeData addEntriesFromDictionary:dictparam];
        //        [kCarCenterService carcenter_carlist:pageOrPageSizeData withBlock:dataCallBack];
        [kOrderService order_index:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
