//
//  OrderHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderHomeViewController.h"
#import "MYRHTableView.h"
#import "TopAverageToggleView.h"
#import "OrderHomeCellView.h"
#import "OrderDetailViewController.h"
#import "PaySuccessViewController.h"
#import "AddInsuranceViewController.h"
#import "ApplicationDetailsViewController.h"
#import "PaymentOfExtendedVehicleUseViewController.h"
#import "ConfirmReservationInformationViewController.h"
#import "AddInsurerInformationViewController.h"
#import "IWantToEvaluateViewController.h"
#import "OrderSearchViewController.h"

@interface OrderHomeViewController ()<WSButtonGroupdelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)TopAverageToggleView*viewTop;
@property(nonatomic,strong)UITextField*tfSearch;
@end

@implementation  OrderHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateStatusBarStyleLightContent];
//    if ([[UTILITY getAddValueForKey:@"addOrder"] isEqualToString:@"1"]) {
//        [UTILITY removeAddValueForkey:@"addOrder"];
//       
//    }
 [self request];
    
    
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarTitle:kST(@"main_order")];
    [self rightButton:@"" image:@"ricon1" sel:@selector(searchBtnClick:)];
    [self addView];
    [_viewTop.btnGroup btnClickAtIndex:0];
    {
        UILabel*titlelable=[self.navView viewWithTag:101];
        titlelable.textColor=rgbwhiteColor;
    }
    {
        UIImageView*titlelable=[self.navView viewWithTag:99];
        titlelable.hidden=NO;
    }
    
    [kUtility_Login addEventWithObj:self actionTypeArray:@[@"loginsuccess"] reUseID:@"ddd" WithBlcok:^(MYBaseService *obj) {
        [self request];
    }];
    //    [self leftButton:@"其他頁面" image:nil sel:@selector(leftBtnClick:)];
//    UISearchBar*viewSearch=[UISearchBar viewWithFrame:CGRectMake(10, 100, kScreenWidth-30, 50) backgroundcolor:nil superView:self.navView];
//    viewSearch.frameBY=7;
}

-(void)searchBtnClick:(UIButton*)btn{
    
    
    
    [self pushController:[OrderSearchViewController class] withInfo:nil withTitle:@""];
    return;
    
    
    
    UIView*viewContent=[self.navView getAddValueForKey:@"viewContent"];
    if (viewContent==nil) {
        viewContent=[UIView viewWithFrame:CGRectMake(20, 0, kScreenWidth-20-27-15-15, 39-4) backgroundcolor:rgbwhiteColor superView:self.navView reuseId:@"viewContent"];
        viewContent.frameBY=3+2;
        viewContent.layer.cornerRadius=5;
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(5, 0, viewContent.frameWidth-10, viewContent.frameHeight) font:Font(15) color:rgb(15, 15, 15) placeholder:@"" text:@""  supView:viewContent];
        
        WSSizeButton*btnCancel=[RHMethods buttonWithframe:CGRectMake(0, 0, 27+15+15, viewContent.frameHeight) backgroundColor:nil text:@"取消" font:14 textColor:rgbwhiteColor radius:0 superview:self.navView reuseId:@"btnCancel"];
        [btnCancel addViewTarget:self select:@selector(searchBtnClick:)];
        btnCancel.frameRX=0;
        btnCancel.centerY=viewContent.centerY;
        _tfSearch=tfSearch;
        [tfSearch addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    WSSizeButton*btnCancel=[self.navView getAddValueForKey:@"btnCancel"];
    
    if (self.navrightButton.hidden==YES) {
        self.navrightButton.hidden=NO;
        btnCancel.hidden=YES;
        viewContent.hidden=YES;
        _tfSearch.hidden=YES;
        [self request];
    }else{
        self.navrightButton.hidden=YES;
        btnCancel.hidden=NO;
        viewContent.hidden=NO;
        _tfSearch.hidden=NO;
        [self.viewTop.btnGroup btnClickAtIndex:0];
//        [self request];
    }
    
    
}
-(void)leftBtnClick:(UIButton*)btn{
    
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
//                                  @"title":@"待支付",
                                  @"title":kS(@"main_order", @"tab_waiting_pay"),
                                  @"status":@"2",
                                  },
                              @{
//                                  @"title":@"進行中",
                                  @"title":kS(@"main_order", @"tab_in_service"),
                                  @"status":@"3",
                                  },
                              @{
//                                  @"title":@"待評價",
                                  @"title":kS(@"main_order", @"tab_waiting_comment"),
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
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, kScreenHeight- viewTop.frameYH-49-kIphoneXBottom) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.defaultSection.dataArray=kfAry(20);
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
    if (_tfSearch&&_tfSearch.hidden==NO) {
        [dictparam setObject:_tfSearch.text forKey:@"key"];
    }
    
    [dictparam setObject:[self.viewTop.btnGroup.currentSelectBtn.data ojsk:@"status"] forKey:@"status"];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [pageOrPageSizeData addEntriesFromDictionary:dictparam];
//        [kCarCenterService carcenter_carlist:pageOrPageSizeData withBlock:dataCallBack];
        [kOrderService order_index:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}

-(void)WSButtonGroupChange:(WSButtonGroup *)btnCrop{
    [self request];
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function

-(void)textFieldTextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    [self request];
}
@end
