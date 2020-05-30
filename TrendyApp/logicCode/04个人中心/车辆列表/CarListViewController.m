//
//  CarListViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/22.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CarListViewController.h"

#import "MYRHTableView.h"
#import "CarListCellView.h"
#import "TopAverageToggleView.h"
#import "UploadVeicleViewController.h"
#import "RUControllerBottomView.h"
#import "VehicleDetailsViewController.h"
@interface CarListViewController ()<WSButtonGroupdelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)TopAverageToggleView*viewTop;
@end

@implementation  CarListViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [_viewTop.btnGroup btnClickAtIndex:0];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    TopAverageToggleView*viewTop=[TopAverageToggleView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 44) backgroundcolor:rgbwhiteColor superView:self.view];
    NSArray*toggleDataArray=@[@{
                                  @"title":kS(@"CarList", @"whole"),
                                  @"status":@"1",
                                  },
                              @{
                                  @"title":kS(@"CarList", @"ToBeAudited"),
                                  @"status":@"2",
                                  },
                              @{
                                  @"title":kS(@"CarList", @"Audited"),
                                  @"status":@"3",
                                  },
                              @{
                                  @"title":kS(@"CarList", @"refuse"),
                                  @"status":@"4",
                                  },];
    [viewTop bendData:toggleDataArray withType:nil];
    _viewTop=viewTop;
    _viewTop.btnGroup.delegate=self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, kScreenHeight-viewTop.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.defaultSection.dataArray=kfAry(15);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        CarListCellView*viewcell=[CarListCellView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell addBaseViewTarget:weakSelf select:@selector(cellViewUpdataEvent:)];
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        
//        if ([[Datadic ojsk:@"audit"] isEqualToString:@"1"]) {
//            [UTILITY.currentViewController pushController:[VehicleDetailsViewController class] withInfo:[Datadic ojsk:@"id"] withTitle:[Datadic ojsk:@"title"]];
//        }else{
            [weakSelf pushController:[UploadVeicleViewController class] withInfo:[Datadic ojsk:@"id"] withTitle:@"" withOther:[Datadic ojsk:@"audit"] withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf request];
            }];
//        }
    }];
    _mtableView.frameHeight=_mtableView.frameHeight-60-kIphoneXBottom;
    RUControllerBottomView*viewBottom=[RUControllerBottomView viewWithFrame:CGRectMake(0, _mtableView.frameYH, 0, 60+kIphoneXBottom) backgroundcolor:nil superView:self.view];
    [viewBottom upDataMeWithData:@{@"btnTitle":kS(@"CarList", @"AddNewCar")}];
    [viewBottom addBaseViewTarget:self select:@selector(commitBtnClick:)];
    
//    {
//        WSSizeButton*btnUploadCar=[RHMethods buttonWithframe:CGRectMake(0, 0, 280, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"VehicleOwnerService", @"AddVehicles") font:16 textColor:rgb(255, 255, 255) radius:5 superview:viewBtnContent];
//        [btnUploadCar beCX];
//        [btnUploadCar beCY ];
//        [btnUploadCar addViewClickBlock:^(UIView *view) {
//            [weakSelf pushController:[UploadVeicleViewController class] withInfo:nil withTitle:kST(@"AddVehicles")];
//        }];
//    }
    
}
-(void)commitBtnClick:(UIButton*)btn{
      __weak __typeof(self) weakSelf = self;
    [self pushController:[UploadVeicleViewController class] withInfo:nil withTitle:kST(@"AddVehicles") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf request];
        weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
    }];
    
    
}
-(void)cellViewUpdataEvent:(CarListCellView*)viewcell{
    [self request];
}

#pragma mark  request data from the server use tableview
-(void)request{
    [_mtableView showRefresh:YES LoadMore:YES];
//    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
//    [_mtableView refresh];
//    [kCarCenterService carcenter_carlist:nil withBlock:<#^(id data, int status, NSString *msg)block#>];
//      __weak __typeof(self) weakSelf = self;
    krequestParam
    [dictparam setObject:[self.viewTop.btnGroup.currentSelectBtn.data ojsk:@"status"] forKey:@"status"];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [pageOrPageSizeData addEntriesFromDictionary:dictparam];
        [kCarCenterService carcenter_carlist:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function
-(void)WSButtonGroupChange:(WSButtonGroup *)btnCrop{
    [self request];
}

@end
