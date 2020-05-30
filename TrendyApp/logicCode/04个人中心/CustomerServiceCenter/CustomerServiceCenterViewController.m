//
//  CustomerServiceCenterViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CustomerServiceCenterViewController.h"
#import "MYRHTableView.h"
#import "CustomerServiceCenterCellView.h"
#import "TopAverageToggleView.h"
@interface CustomerServiceCenterViewController ()<WSButtonGroupdelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)TopAverageToggleView*viewTop;
@end

@implementation  CustomerServiceCenterViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self navbarTitle:kST(@"CustomerServiceCenter")];
    [_viewTop.btnGroup btnClickAtIndex:0];
}
#pragma mark -   write UI
-(void)addView{
    
    TopAverageToggleView*viewTop=[TopAverageToggleView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 44) backgroundcolor:rgbwhiteColor superView:self.view];
    NSArray*toggleDataArray=@[@{
                                  @"title":kS(@"CustomerServiceCenter", @"Tenant"),
                                  @"type":@"1",
                                  },
                              @{
                                  @"title":kS(@"CustomerServiceCenter", @"VehicleOwner"),
                                  @"type":@"2",
                                  },];
    [viewTop bendData:toggleDataArray withType:nil];
    viewTop.frameHeight = 0;
    viewTop.hidden = true;
    _viewTop=viewTop;
    _viewTop.btnGroup.delegate=self;
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, kScreenHeight- viewTop.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.defaultSection.dataArray=kfAry(20);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        CustomerServiceCenterCellView*viewcell=[CustomerServiceCenterCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"CustomerServiceCenterCellView"];
        [viewcell bendData:Datadic withType:nil];
        viewcell.frameY=row==0?10:0;
        return viewcell;
    }];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
//    krequestParam
      __weak __typeof(self) weakSelf = self;
    [_mtableView showRefresh:YES LoadMore:YES];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
//        [pageOrPageSizeData setObject:@"" forKey:@""];
        
        [pageOrPageSizeData setObject:[weakSelf.viewTop.btnGroup.currentSelectBtn.data ojsk:@"type"] forKey:@"type"];
        [kUserCenterService help:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server

#pragma mark - event listener function

-(void)WSButtonGroupChange:(WSButtonGroup *)btnCrop{
    [self request];
}

#pragma mark - delegate function


@end
