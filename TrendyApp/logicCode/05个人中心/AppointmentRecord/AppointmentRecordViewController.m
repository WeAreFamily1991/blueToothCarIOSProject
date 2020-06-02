//
//  AppointmentRecordViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AppointmentRecordViewController.h"
#import "MYRHTableView.h"
#import "AppointmentRecordCellView.h"
#import "AppointmentRecordCellView.h"
#import "KKNavigationController.h"
@interface AppointmentRecordViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  AppointmentRecordViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
    [self navbarTitle:kST(@"booking_record")];
}
- (void)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(KKNavigationController*)self.navigationController removeGesture];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [(KKNavigationController*)self.navigationController addGesture];
}

#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        AppointmentRecordCellView*viewcell=[AppointmentRecordCellView viewWithFrame:CGRectMake(0, 10, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    [_mtableView showRefresh:YES LoadMore:YES];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [kUserCenterService ucenter_rental:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
