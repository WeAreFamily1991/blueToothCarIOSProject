//
//  MyCollectionViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MYRHTableView.h"
#import "MyCollectionCellView.h"
@interface MyCollectionViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  MyCollectionViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
    [self navbarTitle:kST(@"myCollection")];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
      __weak __typeof(self) weakSelf = self;
//    _mtableView.defaultSection.dataArray=kfAry(13);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        MyCollectionCellView*viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell bendData:Datadic withType:@"collection"];
        [viewcell addBaseViewTarget:weakSelf select:@selector(cellBtnClick:)];
        return viewcell;
    }];
    
}
-(void)cellBtnClick:(MyCollectionCellView*)cellView{
      __weak __typeof(self) weakSelf = self;
    krequestParam
    [dictparam setValue:[cellView.data ojsk:@"objid"] forKey:@"ids"];
    [NetEngine createGetAction:[NSString stringWithFormat:@"ucenter/fav%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            [weakSelf request];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
        }
    }];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    [_mtableView showRefresh:YES LoadMore:NO];
//    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [kUserCenterService ucenter_getfav:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
