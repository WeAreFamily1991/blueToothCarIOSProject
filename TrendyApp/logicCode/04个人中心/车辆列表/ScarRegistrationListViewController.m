//
//  ScarRegistrationListViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/18.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ScarRegistrationListViewController.h"
#import "MYRHTableView.h"
#import "ScarRegistrationViewController.h"
#import "ScarRegistrationCellView.h"
#import "RUControllerBottomView.h"
@interface ScarRegistrationListViewController    ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  ScarRegistrationListViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self rightButton:@"添加" image:nil sel:@selector(rightBtnclick:)];
    [self addView];
    [self request];
}

#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.dataArray=kfAry(13);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        ScarRegistrationCellView*viewcell=[ScarRegistrationCellView viewWithFrame:CGRectMake(0, 10, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"ScarRegistrationCellView"];
//        viewcell.backgroundColor=rgbTxtGray;
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    
    _mtableView.frameHeight=_mtableView.frameHeight-60-kIphoneXBottom;
    RUControllerBottomView*viewBottom=[RUControllerBottomView viewWithFrame:CGRectMake(0, _mtableView.frameYH, 0, 60+kIphoneXBottom) backgroundcolor:nil superView:self.view];
    [viewBottom upDataMeWithData:@{@"btnTitle":kS(@"WoundRecord", @"AddingScarRegistration")}];
    [viewBottom addBaseViewTarget:self select:@selector(commitBtnClick:)];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [_mtableView showRefresh:YES LoadMore:YES];
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"12" forKey:@"pagesize"];
    [dictparam setObject:self.userInfo forKey:@"carid"];
    _mtableView.urlString=[NSString stringWithFormat:@"carcenter/getscarlist%@",dictparam.wgetParamStr];
    [_mtableView refresh];
    
    
}
-(void)commitBtnClick:(UIButton*)btn{
      __weak __typeof(self) weakSelf = self;
    [self pushController:[ScarRegistrationViewController class] withInfo:self.userInfo withTitle:kST(@"ScarRegistration") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf request];
    }];
    
    
    
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
