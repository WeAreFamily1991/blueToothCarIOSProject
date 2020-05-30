//
//  CalendarViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/7.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CalendarViewController.h"
#import "MYRHTableView.h"
#import "DateManager.h"
#import "CalendarCellView.h"
@interface CalendarViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)DateManager*dateManager;
@end

@implementation  CalendarViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInitData];
    
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    _mtableView.defaultSection.dataArray=_dataArray;
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        CalendarCellView*viewcell=[CalendarCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
//        UILabel*lbNmuber=[RHMethods ClableY:10 W:200 Height:20 font:20 superview:viewcell withColor:nil text:@"dfdfa" reuseId:@"lbNmuber"];
//        lbNmuber.text=[Datadic ojsk:@"formatStr"];
//        [viewcell upDataMeWithData:Datadic];
        viewcell.data=Datadic;
        [viewcell upDataMe];
        return viewcell;
    }];
    [self request];
}
-(void)loadInitData{
    _dateManager=[DateManager new];
    _dataArray=[NSMutableArray new];
    
}
-(void)loadPreviousMoreData{
    if (_dataArray.count==0) {
        
        [_dataArray addObject:[_dateManager geCurrentMonthDic]];
        [self loadMoreData];
        [self loadMoreData];
//        [self loadMoreData];
        return;
    }
    [_dataArray insertObject:[_dateManager gePreViousMonthWithCurrentDic:_dataArray.firstObject] atIndex:0];
}
-(void)loadMoreData{
    [_dataArray addObject:[_dateManager geNextMonthWithCurrentDic:_dataArray.lastObject]];
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [_mtableView showRefresh:YES LoadMore:YES];
//    [dictparam setObject:@"%@" forKey:@"page"];
//    [dictparam setObject:@"12" forKey:@"limit"];
//    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
//    [_mtableView refresh];@"records"
      __weak __typeof(self) weakSelf = self;
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        if ([[pageOrPageSizeData ojsk:@"current"] isEqualToString:@"1"]) {
            [weakSelf loadPreviousMoreData];
//            [weakSelf loadPreviousMoreData];
//            [weakSelf loadPreviousMoreData];
//            [weakSelf loadPreviousMoreData];
//            [weakSelf loadPreviousMoreData];
        }else{
//            [weakSelf loadMoreData];
            [weakSelf loadMoreData];
            [weakSelf loadMoreData];
            [weakSelf loadMoreData];
            [weakSelf loadMoreData];
        }
        
        dataCallBack(@{@"records":kfAry(20)},200,nil);
    }];
    [_mtableView refresh];
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
