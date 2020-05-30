//
//  SpecialVehicleViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SpecialVehicleViewController.h"
#import "MYRHTableView.h"
#import "MyCollectionCellView.h"
#import "VehicleDetailsViewController.h"
#import "CarSearchTypeTopView.h"

@interface SpecialVehicleViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UIView*viewTop;
@property(nonatomic,strong)WSSizeButton *btnDropdown;
@property(nonatomic,strong)NSMutableArray *arraytitle;
@property(nonatomic,strong)id tempRequestData;
@end

@implementation  SpecialVehicleViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    CarSearchTypeTopView *viewTop=[CarSearchTypeTopView  viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:self.view];
    _viewTop=viewTop;
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, H(self.view)-viewTop.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [_mtableView showRefresh:YES LoadMore:YES];
    [self.view addSubview:_mtableView];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        MyCollectionCellView*viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        viewcell.between_time=[weakSelf.tempRequestData ojsk:@"between_time"];
        [viewcell upDataMeWithData:Datadic];
        viewcell.collectionBtn.hidden=YES;
        return viewcell;
    }];
    [viewTop changeValuePopViewBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:@"CarSearchType"];
        [weakSelf request];
    }];
    
}

#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"20" forKey:@"pagesize"];
    if (self.userInfo) {
        //首页数据
        //位置
        if ([self.userInfo ojk:@"Location"] ) {
            [dictparam setObject:[[self.userInfo ojk:@"Location"] ojsk:@"lng"] forKey:@"lng"];
            [dictparam setObject:[[self.userInfo ojk:@"Location"] ojsk:@"lat"] forKey:@"lat"];
        }
        //车型品牌
        if ([self.userInfo ojk:@"BrandModel"] ) {
            [dictparam setObject:[[self.userInfo ojk:@"BrandModel"] ojsk:@"id"] forKey:@"brand"];
        }
        //            SelectDate
        if ([self.userInfo ojk:@"SelectDate"] ) {
            NSDictionary *dt_S=[[self.userInfo ojk:@"SelectDate"] ojk:@"selectStartTime"];
            NSDictionary *dt_E=[[self.userInfo ojk:@"SelectDate"] ojk:@"selectEndTime"];
            [dictparam setObject:[NSString stringWithFormat:@"%@ %@:00,%@ %@:00",[dt_S ojsk:@"formatStr"],[dt_S ojsk:@"timeStr"],[dt_E ojsk:@"formatStr"],[dt_E ojsk:@"timeStr"]] forKey:@"between_time"];
        }
        if ([[self.userInfo ojsk:@"isspecial"] notEmptyOrNull]) {
            [dictparam setObject:[self.userInfo ojsk:@"isspecial"] forKey:@"isspecial"];
        }
    }
    //本页面筛选
    
    if ([self getAddValueForKey:@"CarSearchType"]) {
        [dictparam setObject:[self getAddValueForKey:@"CarSearchType"] forKey:@"searchArr"];
    }
    _tempRequestData=dictparam;
    _mtableView.urlString=[NSString stringWithFormat:@"car%@",dictparam.wgetParamStr];
    [_mtableView refresh];
}
#pragma mark - request data from the server
#pragma mark - event listener function


#pragma mark - delegate function


@end
