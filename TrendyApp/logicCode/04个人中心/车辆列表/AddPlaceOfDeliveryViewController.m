//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AddPlaceOfDeliveryViewController.h"
#import "MYRHTableView.h"
#import "SelectPlacePointCellView.h"
#import "FCTextFieldCellView.h"

@interface AddPlaceOfDeliveryViewController ()
{
    
    
    
}
@property(nonatomic,strong)FCTextFieldCellView*addressCellView;
@property(nonatomic,strong)SelectPlacePointCellView*mapSelectCellView;
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  AddPlaceOfDeliveryViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [self rightButton:kS(@"EditDeliveryPlace", @"Preservation") image:nil sel:@selector(submitBtnClick:)];
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
            if ([dictparam ojsk:@"city_area"]) {
                [dictparam addEntriesFromDictionary:[dictparam ojsk:@"city_area"]];
                [dictparam removeObjectForKey:@"city_area"];
            }
            
            if ([dictparam ojsk:@"mapaddr_Dic"]) {
                [dictparam addEntriesFromDictionary:[dictparam ojsk:@"mapaddr_Dic"]];
                [dictparam removeObjectForKey:@"mapaddr_Dic"];
            }
            
            if (weakSelf.userInfo) {
                [dictparam setObject:[weakSelf.userInfo ojsk:@"id"] forKey:@"id"];
            }
            [kUserCenterService carcenter_updateaddress:dictparam withBlock:^(id data, int status, NSString *msg) {
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
      __weak __typeof(self) weakSelf = self;
    if (_mtableView==nil) {
        _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mtableView];
    }//EditDeliveryPlace
    NSMutableArray*arraytitle=[@[
                                 @{
//                                     @"name":@"所在区域",
                                     @"name":kS(@"EditDeliveryPlace", @"Location"),
                                     @"placeholder":kS(@"EditDeliveryPlace",@"PleaseChooseArea"),
                                     @"classStr":@"SelectAddplaceFcView",
                                     @"requestkey":@"city_area",
                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"详细地址",
                                     @"name":kS(@"EditDeliveryPlace", @"DetailedAddress"),
                                     @"placeholder":kS(@"EditDeliveryPlace",@"PleaseDetailedAddress"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"address",
                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"地图地址",
                                     @"name":kS(@"EditDeliveryPlace", @"mapAddress"),
                                     @"placeholder":kS(@"EditDeliveryPlace",@"PleaseMapAddress"),
                                     @"classStr":@"SelectPlacePointCellView",
                                     @"requestkey":@"mapaddr_Dic",
                                     @"isMust":@"1",
                                     },
                                 
                                 ] toBeMutableObj];
    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        if ([[dic ojsk:@"requestkey"] isEqualToString:@"address"]) {
            _addressCellView=viewCell;
        }  if ([[dic ojsk:@"requestkey"] isEqualToString:@"mapaddr_Dic"]) {
            _mapSelectCellView=viewCell;
            [_mapSelectCellView setChangeBlock:^(id data, int status, NSString *msg) {
                if (![weakSelf.addressCellView.defaultTextfield.text notEmptyOrNull]) {
                    weakSelf.addressCellView.defaultTextfield.text=data;
                }
            }];
            
        }
        
        
    }
//    http://app.trendycarshare.jp/api/carcenter/updateaddress
    [_mtableView reloadData];
}

#pragma mark  request data from the server use tableview
#pragma mark - request data from the server
-(void)loadDATA{
    __weak __typeof(self) weakSelf = self;
    //    NSMutableDictionary*paramdic=[NSMutableDictionary new];
    //    [paramdic setObject:self.userInfo forKey:@"id"];
    //    [kUserCenterService ucenterInsurerdetailWithParam:paramdic withBlock:^(id data, int status, NSString *msg) {
    weakSelf.data=[NSMutableDictionary dictionaryWithDictionary:self.userInfo];
    
    
    NSMutableDictionary*mapaddr_Dic=[weakSelf.data toBeMutableObj];
    
    [weakSelf.data setObject:mapaddr_Dic forKey:@"mapaddr_Dic"];
    NSMutableDictionary*city_area=[NSMutableDictionary new];
    [city_area setObject:[weakSelf.data ojsk:@"address"] forKey:@"address"];
    [city_area setObject:[weakSelf.data ojsk:@"area"] forKey:@"area"];
    [city_area setObject:[weakSelf.data ojsk:@"mapaddr"] forKey:@"mapaddr"];
    [city_area setObject:[weakSelf.data ojsk:@"city"] forKey:@"city"];
    [city_area setObject:[weakSelf.data ojsk:@"area_name"] forKey:@"area_name"];
    [city_area setObject:[weakSelf.data ojsk:@"lat"] forKey:@"lat"];
    [city_area setObject:[weakSelf.data ojsk:@"lng"] forKey:@"lng"];
    [city_area setObject:[weakSelf.data ojsk:@"city_name"] forKey:@"city_name"];
    
    
    [weakSelf.data setObject:city_area forKey:@"city_area"];
    [weakSelf bendData];
    //    }];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
