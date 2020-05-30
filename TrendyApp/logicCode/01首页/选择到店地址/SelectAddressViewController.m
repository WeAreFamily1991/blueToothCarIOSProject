//
//  SelectAddressViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "MYRHTableView.h"

@interface SelectAddressViewController ()
@property(nonatomic,strong) MYRHTableView*mtableView;

@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    __weak typeof(self) weakSelf=self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtableView];
//    [_mtableView showRefresh:YES LoadMore:YES];
    _mtableView.defaultSection.dataArray=self.otherInfo;
    _mtableView.tableHeaderView=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 20) backgroundcolor:nil superView:nil];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        UIView *viewcell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
        [RHMethods viewWithFrame:CGRectMake(0, H(viewcell)-0.5, kScreenWidth, 0.5) backgroundcolor:rgbLineColor superView:viewcell reuseId:@"viewLine"];
        UILabel *lblAddress=[RHMethods labelWithFrame:CGRectMake(15, 10, kScreenWidth-30, 25) font:fontTitle color:rgbTitleColor text:@"" textAlignment:NSTextAlignmentLeft supView:viewcell reuseId:@"lblAddress"];
        lblAddress.text=[Datadic ojsk:@"address"];
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        weakSelf.allcallBlock?weakSelf.allcallBlock(Datadic, 200, nil):nil;
        [weakSelf backButtonClicked:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
