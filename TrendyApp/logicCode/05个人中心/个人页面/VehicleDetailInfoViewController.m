//
//  VehicleDetailInfoViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleDetailInfoViewController.h"
#import "MYRHTableView.h"
#import "VehicleDetailInfoCellView.h"//VehicleDetailsInfo
@interface VehicleDetailInfoViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  VehicleDetailInfoViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addView];
      __weak __typeof(self) weakSelf = self;
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    if (self.otherInfo) {
        [mdic setObject:self.otherInfo forKey:@"id"];
    }
//    else{
////        [mdic setObject:@"3" forKey:@"id"];
//    }
    [kCarCenterService carcenter_cardataildeploy:mdic withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        if (weakSelf.userInfo) {
            NSMutableArray*marray=[[weakSelf.userInfo ojsk:@"deploy_id"] componentsSeparatedByString:@","];
            
            for (NSString*myIdStr in marray) {
                for (NSMutableDictionary*mdic in self.data[@"list"] ) { 
                    for (NSMutableDictionary*sonDic in mdic[@"son"]) {
                        if ([[sonDic ojsk:@"id"] isEqualToString:myIdStr]) {
                            [sonDic setObject:@"1" forKey:@"selected"];
                        }
                    }
                }
            }
        }
        [weakSelf addView];
    }];
    if (!self.otherInfo || ![self.otherInfo isEqualToString:@"1"]) {
        
        [self rightButton:kS(@"VehicleDetailsInfo", @"complete") image:nil sel:@selector(submitBtnClick:)];
    }
}
-(void)submitBtnClick:(UIButton*)btn{
    NSMutableArray*marray=[NSMutableArray new];
    for (NSMutableDictionary*mdic in self.data[@"list"] ) {
        for (NSMutableDictionary*sonDic in mdic[@"son"]) {
            if ([[sonDic ojsk:@"selected"] isEqualToString:@"1"]) {
                [marray addObject:[sonDic ojsk:@"id"]];
            }
        }
    }
    NSMutableDictionary*mdic=[NSMutableDictionary dictionaryWithObject:[marray componentsJoinedByString:@","] forKey:@"deploy_id"];
    if (self.allcallBlock) {
        self.allcallBlock(mdic, 200, nil);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -   write UI
-(void)addView{
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    {
     UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgb(246, 246, 246) superView:nil];
        _mtableView.defaultSection.selctionHeaderView=viewContent;
        UILabel*lbContent=[RHMethods lableX:15 Y:20 W:kScreenWidth-30 Height:0 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:@"添加更多車輛配置信息可以幫助租客更好的了解您的車輛詳情，提高訂單量哦~"];
        viewContent.frameHeight=lbContent.frameYH + 20;
    }
    _mtableView.defaultSection.dataArray=[self.data ojk:@"list"];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        VehicleDetailInfoCellView*viewcell=[VehicleDetailInfoCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
}

#pragma mark - event listener function


#pragma mark - delegate function


@end
