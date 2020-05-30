//
//  ExpressCarRentViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ExpressCarRentViewController.h"
#import "MYRHTableView.h"
#import "MyCollectionCellView.h"
@interface ExpressCarRentViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  ExpressCarRentViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    [_mtableView showRefresh:YES LoadMore:YES];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        MyCollectionCellView*viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        viewcell.collectionBtn.hidden=YES;
        if (weakSelf.userInfo) {
            viewcell.between_time=[weakSelf.userInfo ojsk:@"between_time"];
        }
        viewcell.type=@"ExpressCarRentViewController";
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"20" forKey:@"pagesize"];
    
    if (self.userInfo) {
        [dictparam addEntriesFromDictionary:self.userInfo];
    }
    _mtableView.urlString=[NSString stringWithFormat:@"car%@",dictparam.wgetParamStr];
    [_mtableView refresh];
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
