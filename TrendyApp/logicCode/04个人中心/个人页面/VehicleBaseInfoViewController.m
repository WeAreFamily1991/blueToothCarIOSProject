//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleBaseInfoViewController.h"//
#import "MYRHTableView.h"
@interface VehicleBaseInfoViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  VehicleBaseInfoViewController
#pragma mark  bigen
- (void)viewDidLoad {
    if (!self.otherInfo || ![self.otherInfo isEqualToString:@"1"]) {
        
        [self rightButton:kS(@"AddBasicVehicleInformation", @"complete") image:nil sel:@selector(submitBtnClick:)];
    }
    [super viewDidLoad];
    [self addView];
    if (self.userInfo) {
        [self bendData];
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
//                [dictparam setObject:@{
//                                       @"city":@"1",
//                                       @"area":@"22"
//                                       } forKey:@"city_area"];
//                [dictparam setObject:@"" forKey:@""];
                weakSelf.allcallBlock?weakSelf.allcallBlock(dictparam,200,nil):nil;
                [weakSelf.navigationController popViewControllerAnimated:YES];
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
                                 @{
                                     @"name":@"vijewlin",
                                     @"classStr":@"FCLineCellView",
                                     },
                                 @{
                                     @"name":kS(@"AddBasicVehicleInformation", @"carName"),
                                     @"placeholder":kS(@"AddBasicVehicleInformation",@"PleaseVehicleName"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"title",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"AddBasicVehicleInformation", @"BrandModel"),
                                     @"placeholder":kS(@"AddBasicVehicleInformation",@"PleaseChooseTheModel"),
                                     @"classStr":@"SelectAutoMobileBandModelCellView",
                                     @"requestkey":@"fid_sid",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"AddBasicVehicleInformation", @"VehicleYear"),
                                     @"placeholder":kS(@"AddBasicVehicleInformation",@"PleaseVehicleYear"),
                                     @"classStr":@"FCSelectCellView",
                                     @"selectsubtype":@"yearselect",
                                     @"requestkey":@"year",
                                     //                                     @"placeholder":@"请上传",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"AddBasicVehicleInformation", @"LocationOfVehicles"),
                                     @"placeholder":kS(@"AddBasicVehicleInformation",@"PleaseSelectVehiclePhotos"),
                                     @"classStr":@"SelectCityMyCellView",
                                     @"requestkey":@"city_area",
                                     //                                     @"placeholder":@"请上传",
                                     @"unit":@"",
                                     @"isMust":@"1",
                                     },
//                                 @{
//                                     @"name":kS(@"OwnerInformation", @"Address"),
//                                     @"classStr":@"FCTextFieldCellView",
//                                     @"requestkey":@"user_address",
//                                     @"isMust":@"1",
//                                     },
                                 @{
                                     @"name":kS(@"AddBasicVehicleInformation", @"VehiclePhotos"),
                                     @"placeholder":kS(@"AddBasicVehicleInformation",@"PleaseVehicleArea"),
                                     @"classStr":@"FCImageSelectCellView",
                                     @"tipStr":kS(@"AddBasicVehicleInformation", @"PhotosAreClear"),
                                     @"requestkey":@"path",
                                     //                                     @"placeholder":@"请上传",
                                     @"unit":@"",
                                     @"isMust":@"1", 
                                     },
                                 ] toBeMutableObj];
//    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
    }
    
    
    
    [_mtableView reloadData];
}
/*
 
 */

#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{

}
-(void)bendData{
    self.data=self.userInfo;
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
