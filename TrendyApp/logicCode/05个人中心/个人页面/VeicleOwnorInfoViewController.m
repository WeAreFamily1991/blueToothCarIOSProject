//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VeicleOwnorInfoViewController.h"
#import "MYRHTableView.h"
@interface VeicleOwnorInfoViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  VeicleOwnorInfoViewController 
#pragma mark  bigen
- (void)viewDidLoad {
    if (!self.otherInfo || ![self.otherInfo isEqualToString:@"1"]) {        
        [self rightButton:kS(@"OwnerInformation", @"complete") image:nil sel:@selector(submitBtnClick:)];
    }
    [super viewDidLoad];
    [self addView];
    if (self.userInfo) {
        [self loadDATA];
    }
}
-(void)submitBtnClick:(UIButton*)btn{
    //    btn.userInteractionEnabled=NO;
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        btn.userInteractionEnabled=YES;
    //    });
        __weak __typeof(self) weakSelf = self;
        [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
            if (status==200) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                weakSelf.allcallBlock?weakSelf.allcallBlock(data,200,nil):0;
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
                                     @"name":kS(@"OwnerInformation", @"Name"),
                                     @"placeholder":kS(@"OwnerInformation",@"PleaseEnterYourName"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"user_name",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"OwnerInformation", @"Address"),
                                     @"placeholder":kS(@"OwnerInformation",@"PleaseEnterYourAddress"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"user_address",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"OwnerInformation", @"Birthday"),
                                     @"placeholder":kS(@"OwnerInformation",@"PleaseChooseYourBirthday"),
                                     @"classStr":@"FCSelectCellView",
                                     @"selectsubtype":@"dateselect",
                                     @"requestkey":@"birthday",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"vijewlin",
                                     @"classStr":@"FCLineCellView",
                                     },
//                                 @{
//                                     @"name":@"車檢證照片",
//                                     @"classStr":@"OFCVehicleInspectionPhotoCellView",
//                                     @"requestkey":@"",
//                                     //                                     @"isMust":@"1",
//                                     },
//                                 @{
//                                     @"name":@"vijewlin",
//                                     @"classStr":@"FCLineCellView",
//                                     },
                                 @{
                                     @"name":kS(@"OwnerInformation", @"LicensePlateNumber"),
                                     @"placeholder":kS(@"OwnerInformation",@"PleaseEnterTheLicensePlateNumber"),
//                                     @"classStr":@"OFCLicensePlateNumberCellView",
                                     @"classStr":@"FCTextFieldCellView",
                                     @"selectsubtype":@"timeselect",
//                                     @"placeholder":@"请输入",
                                     @"requestkey":@"plate_number",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"OwnerInformation", @"ValidityPeriod"),
                                     @"placeholder":kS(@"OwnerInformation",@"PleaseSelectTheValidTime"),
                                     @"classStr":@"FCSelectCellView",
                                     @"maximumDate":@"forever",
                                     @"selectsubtype":@"dateselect",
                                     @"requestkey":@"indate",
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
//    __weak __typeof(self) weakSelf = self;
//    NSMutableDictionary*paramdic=[NSMutableDictionary new];
//    [paramdic setObject:self.userInfo forKey:@"linkId"];
//    [paramdic setObject:self.otherInfo forKey:@"type"];
    self.data=[self.userInfo toBeMutableObj];
    [self bendData];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
