//
//  OrderHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "PerconalAllOrderListViewController.h"
#import "MYRHTableView.h"
#import "TopAverageToggleView.h"
#import "OrderHomeCellView.h"
#import "OrderDetailViewController.h"

@interface PerconalAllOrderListViewController ()<WSButtonGroupdelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)TopAverageToggleView*viewTop;
@end

@implementation  PerconalAllOrderListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateStatusBarStyleLightContent];
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarTitle:kST(@"main_order")];
//    [self rightButton:@"" image:@"ricon1" sel:@selector(searchBtnClick:)];
    [self addView];
    [_viewTop.btnGroup btnClickAtIndex:0];
//    {
//        UILabel*titlelable=[self.navView viewWithTag:101];
//        titlelable.textColor=rgbwhiteColor;
//    }
//    {
//        UIImageView*titlelable=[self.navView viewWithTag:99];
//        titlelable.hidden=NO;
//    }
    
}

-(void)searchBtnClick:(UIButton*)btn{
    
    
    
    
}
#pragma mark -   write UI
-(void)addView{
    __weak __typeof(self) weakSelf = self;
    TopAverageToggleView*viewTop=[TopAverageToggleView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 44) backgroundcolor:rgbwhiteColor superView:self.view];
    NSArray*toggleDataArray=@[@{
                                  @"title":kS(@"main_order", @"tab_all"),
                                  @"status":@"1",
                                  },
                              @{
                                  //                                  @"title":@"待审核",
                                  @"title":kS(@"main_order", @"tab_waiting_check"),
                                  @"status":@"2",
                                  },
                              @{
                                  //                                  @"title":@"待支付",
                                  @"title":kS(@"main_order", @"tab_waiting_pay"),
                                  @"status":@"3",
                                  },
                              @{
                                  //                                  @"title":@"进行中",
                                  @"title":kS(@"main_order", @"tab_in_service"),
                                  @"status":@"4",
                                  },
                              @{
                                  //                                  @"title":@"已完成",
                                  @"title":kS(@"main_order", @"tab_complete"),
                                  @"status":@"5",
                                  }];
    [viewTop bendData:toggleDataArray withType:nil];
    _viewTop=viewTop;
    _viewTop.btnGroup.delegate=self;
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, kScreenHeight- viewTop.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    //    _mtableView.defaultSection.dataArray=kfAry(20);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        OrderHomeCellView*viewcell=[OrderHomeCellView viewWithFrame:CGRectMake(0, 10, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        viewcell.type=@"personalCenter";
        [viewcell upDataMeWithData:Datadic];
        [viewcell addBaseViewTarget:weakSelf select:@selector(cellBtnClick:)];
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        [weakSelf pushController:[OrderDetailViewController class] withInfo:[Datadic ojsk:@"orderid"] withTitle:kST(@"order_detail") withOther:@"userCenter"];
    }];
    
}
-(void)cellBtnClick:(OrderHomeCellView*)viewcell{
    __weak __typeof(self) weakSelf = self;
    [kUserCenterService orderActionWithOrderData:viewcell.data WithActionType:[[viewcell.eventView data] ojsk:@"action"] withBlock:^(id data, int status, NSString *msg) {
        [weakSelf request];
    }];
}
#pragma mark  request data from the server use tableview
-(void)request{
    [_mtableView showRefresh:YES LoadMore:YES];
    krequestParam
    [dictparam setObject:[self.viewTop.btnGroup.currentSelectBtn.data ojsk:@"status"] forKey:@"status"];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [pageOrPageSizeData addEntriesFromDictionary:dictparam];
        //        [kCarCenterService carcenter_carlist:pageOrPageSizeData withBlock:dataCallBack];
//        [kOrderService order_index:pageOrPageSizeData withBlock:dataCallBack];
        [kUserCenterService carcenter_orderlist:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}

-(void)WSButtonGroupChange:(WSButtonGroup *)btnCrop{ 
    [self request];
}
#pragma mark - request data from the server
-(void)loadDATA{
//    krequestParam
//
//    [NetEngine createPostAction:@"<#api#>" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
//        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
//            //            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
//
//
//            [SVProgressHUD showSuccessWithStatus:@"<#成功#>"];
//            //            [self addView];
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
//
//        }
//    }];
//
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
