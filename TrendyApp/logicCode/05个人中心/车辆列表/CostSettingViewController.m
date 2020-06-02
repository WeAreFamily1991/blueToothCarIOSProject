//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CostSettingViewController.h"
#import "MYRHTableView.h"
@interface CostSettingViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  CostSettingViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [self rightButton:kS(@"addInsurerInfo", @"button_complete") image:nil sel:@selector(submitBtnClick:)];
    [super viewDidLoad];
    [self addView];
    if (self.userInfo) {
        [self loadDATA];
    }
}
-(void)submitBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.userInteractionEnabled=YES;
    });
    __weak __typeof(self) weakSelf = self;
    [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            NSMutableDictionary* dictparam=data;
            if (weakSelf.userInfo) {
                [dictparam setObject:[weakSelf.userInfo ojsk:@"id"] forKey:@"carid"];
            }
            [kCarCenterService carcenter_updatecarprice:dictparam withBlock:^(id data, int status, NSString *msg) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):0;
                });
                
            }];
        }
    }];
}
#pragma mark -   write UI
-(void)addView{
    if (_mtableView==nil) {
        _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mtableView];
    }
    NSMutableArray*arraytitle=[@[
//                                 @{
//                                     @"name":kS(@"addInsurerInfo", @"name"),
//                                     @"classStr":@"FCTextFieldCellView",
//                                     @"requestkey":@"name",
//                                     @"isMust":@"1",
//                                     },
                                 @{
                                     @"name":kS(@"CostSetting", @"HolidayExpenses"),
                                     @"placeholder":kS(@"CostSetting",@"PleaseInput"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"selectsubtype":@"dateselect",
                                     @"frameY":@"10",
                                     @"requestkey":@"price_holiday",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"CostSetting", @"WeekdayExpenses"),
                                     @"placeholder":kS(@"CostSetting",@"PleaseInput"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"price",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"CostSetting", @"IsItFavorable"),
                                     @"classStr":@"FCSwichCellView",
                                     @"requestkey":@"discounts_status",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"CostSetting", @"PreferentialAmountAfterDays"),
                                     @"placeholder":kS(@"CostSetting",@"PleaseInput"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"price_discounts",
                                     @"isMust":@"1",
                                     },
                                 ] toBeMutableObj];
    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        
    }
    
    [_mtableView reloadData];
}

#pragma mark  request data from the server use tableview
#pragma mark - request data from the server
-(void)loadDATA{
    __weak __typeof(self) weakSelf = self;
    
        weakSelf.data=self.userInfo;
        [weakSelf bendData];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
