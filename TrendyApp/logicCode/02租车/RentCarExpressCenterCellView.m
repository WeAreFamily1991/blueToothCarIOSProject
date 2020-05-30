//
//  RentCarExpressCenterCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "RentCarExpressCenterCellView.h"
#import "UtilitySelectTime.h"
#import "SelectTimeViewController.h"
#import "SearchVehicleLocationViewController.h"
#import "Utility_Location.h"
#import "SelectWebUrlViewController.h"
#import "ExpressCarRentViewController.h"
#import "CommonProblemViewController.h"

@interface RentCarExpressCenterCellView ()

@property (weak, nonatomic) IBOutlet UILabel *lblTip1;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress1;
@property (weak, nonatomic) IBOutlet UILabel *lblTip2;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress2;

@property (weak, nonatomic) IBOutlet UILabel *lblDateS1;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeS1;
@property (weak, nonatomic) IBOutlet UILabel *lblDateS2;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeS2;
@property (weak, nonatomic) IBOutlet UILabel *lblDateNum;

@property (weak, nonatomic) IBOutlet UIButton *btnNote;
@property (weak, nonatomic) IBOutlet UIButton *btnNote2;
@property (weak, nonatomic) IBOutlet UIButton *btnSub;
@end

@implementation RentCarExpressCenterCellView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf=self;
        
        NSMutableDictionary *dicAddressS=[NSMutableDictionary new];
        [self setAddValue:dicAddressS forKey:@"dicAddressS"];
        NSMutableDictionary *dicAddressE=[NSMutableDictionary new];
        [self setAddValue:dicAddressE forKey:@"dicAddressE"];
        
        _lblTip1.text=kS(@"rentCarFast", @"takeCarAddress");
        _lblTip2.text=kS(@"rentCarFast", @"returnCarAddress");
        
        [_lblAddress1 addViewTarget:self select:@selector(selectSAddress)];
        [_lblAddress2 addViewTarget:self select:@selector(selectEAddress)];
        [_btnSub setTitle:kS(@"rentCarFast", @"goChooseCar") forState:UIControlStateNormal];
//        [_btnNote setTitle:[NSString stringWithFormat:@" %@",kS(@"rentCarFast", @"rentCarNotice")] forState:UIControlStateNormal];
        [_btnNote setTitle:[NSString stringWithFormat:@" %@",kS(@"rentCarFast", @"rentCarNotice")] forState:UIControlStateNormal];
        [_btnNote2 setTitle:[NSString stringWithFormat:@" %@",kS(@"rentCarFast", @"rentCarFaq")] forState:UIControlStateNormal];
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            id selectData=[weakSelf getAddValueForKey:@"SelectDate"];
            if (selectData ) {
                id dataS=[selectData ojk:@"selectStartTime"];
                id dataE=[selectData ojk:@"selectEndTime"];
                weakSelf.lblDateS1.text=[dataS ojsk:@"formatStr"];
                weakSelf.lblTimeS1.text=[dataS ojsk:@"timeStr"];
                weakSelf.lblDateS2.text=[dataE ojsk:@"formatStr"];
                weakSelf.lblTimeS2.text=[dataE ojsk:@"timeStr"];
                weakSelf.lblDateNum.text=[selectData  ojsk:@"tipDate1"];
            }else{
                weakSelf.lblDateS1.text=kS(@"setting_take_and_return_time", @"hint_take_date");
                weakSelf.lblDateS2.text=kS(@"setting_take_and_return_time", @"hint_return_date");
                weakSelf.lblTimeS1.text=kS(@"setting_take_and_return_time", @"hint_setting_pls");
                weakSelf.lblTimeS2.text=kS(@"setting_take_and_return_time", @"hint_setting_pls");
                weakSelf.lblDateNum.text=@"";
            }
           
            NSMutableDictionary *dicAddressS=[weakSelf getAddValueForKey:@"dicAddressS"];
            [dicAddressS removeAllObjects];
            //地址
            weakSelf.lblAddress1.userInteractionEnabled=YES;
            id selectAddressS=[weakSelf getAddValueForKey:@"selectAddressS"];
            if (selectAddressS) {
                [dicAddressS setObject:[selectAddressS ojsk:@"title"] forKey:@"address"];
                [dicAddressS setObject:[selectAddressS ojsk:@"lng"] forKey:@"lng"];
                [dicAddressS setObject:[selectAddressS ojsk:@"lat"] forKey:@"lat"];
            }
            
            if ([[dicAddressS allKeys] count]) {
                weakSelf.lblAddress1.text=[dicAddressS ojsk:@"address"];
                weakSelf.lblAddress1.textColor=rgbTitleColor;
            }else{
                weakSelf.lblAddress1.text=kS(@"setting_take_and_return_time", @"hint_setting_pls");
                weakSelf.lblAddress1.textColor=rgbTxtGray;
            }
            
            
            NSMutableDictionary *dicAddressE=[weakSelf getAddValueForKey:@"dicAddressE"];
            [dicAddressE removeAllObjects];
            
            id selectAddressE=[weakSelf getAddValueForKey:@"selectAddressE"];
            if (selectAddressE) {
                [dicAddressE setObject:[selectAddressE ojsk:@"title"] forKey:@"address"];
                [dicAddressE setObject:[selectAddressE ojsk:@"lng"] forKey:@"lng"];
                [dicAddressE setObject:[selectAddressE ojsk:@"lat"] forKey:@"lat"];
            }
            
            if ([[dicAddressE allKeys] count]) {
                weakSelf.lblAddress2.text=[dicAddressE ojsk:@"address"];
                weakSelf.lblAddress2.textColor=rgbTitleColor;
            }else{
                weakSelf.lblAddress2.text=kS(@"setting_take_and_return_time", @"hint_setting_pls");
                weakSelf.lblAddress2.textColor=rgbTxtGray;
            }
        }];
        
        [kUtility_Location loadUserLocation:^(id data, int status, NSString *msg) {
            if (status==200) {
                {
                    NSMutableDictionary *dic=[NSMutableDictionary new];
                    [dic setValue:kUtility_Location.userlatitude forKey:@"lat"];
                    [dic setValue:kUtility_Location.userlongitude forKey:@"lng"];
                    [dic setValue:kUtility_Location.userAddress?kUtility_Location.userAddress:@"" forKey:@"title"];
                    [self setAddValue:dic forKey:@"selectAddressS"];
                }
                {
                    NSMutableDictionary *dic=[NSMutableDictionary new];
                    [dic setValue:kUtility_Location.userlatitude forKey:@"lat"];
                    [dic setValue:kUtility_Location.userlongitude forKey:@"lng"];
                    [dic setValue:kUtility_Location.userAddress?kUtility_Location.userAddress:@"" forKey:@"title"];
                    [self setAddValue:dic forKey:@"selectAddressE"];
                }
                [weakSelf upDataMe];
            }
        }];
        
        //监听选择时间变化
        [kUtilitySelectTime addEventWithObj:self actionTypeArray:@[@"updateHomeDataSelect"] reUseID:NSStringFromClass([self class]) WithBlcok:^(MYBaseService *obj) {
            [weakSelf setAddValue:kUtilitySelectTime.selectHomeDate forKey:@"SelectDate"];
            [weakSelf upDataMe];
        }];
    }
    return self;
}
#pragma mark button
- (IBAction)selectDateButtonClicked:(id)sender {
//    __weak typeof(self) weakSelf=self;    
    kUtilitySelectTime.selectStartTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectStartTime"];
    kUtilitySelectTime.selectEndTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectEndTime"];
    kUtilitySelectTime.selectTempTime=nil;
    [UTILITY.currentViewController pushController:[SelectTimeViewController class] withInfo:@"homeSelectTime" withTitle:@"" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
        kUtilitySelectTime.selectHomeDate=data;
    }];
}
-(void)selectSAddress{
    __weak typeof(self) weakSelf=self;
    [UTILITY.currentViewController pushController:[SearchVehicleLocationViewController class] withInfo:nil withTitle:kST(@"useCarAddress") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:@"selectAddressS"];
        
        [weakSelf setAddValue:data forKey:@"selectAddressE"];
        [weakSelf upDataMe];
    }];
    
}
-(void)selectEAddress{
    __weak typeof(self) weakSelf=self;
    
    [UTILITY.currentViewController pushController:[SearchVehicleLocationViewController class] withInfo:@"end" withTitle:kST( @"returnCarAddress") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:@"selectAddressE"];
        [weakSelf upDataMe];
    }];
    
}

- (IBAction)leftButtonClicked:(id)sender {
//    [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":@"http://www.baidu.com"}];

    [kUserCenterService goWelcom_getruleWithTitle:[sender currentTitle] withtype:@"rule_rentcar"];

}
- (IBAction)rightButtonClicked:(id)sender {
    [UTILITY.currentViewController pushController:[CommonProblemViewController class] withInfo:nil withTitle:kS(@"rentCarFast", @"rentCarFaq") ];
}
- (IBAction)subButtonClicked:(id)sender {
    NSMutableDictionary *dicTemp=[NSMutableDictionary new];
    id selectData=[self getAddValueForKey:@"SelectDate"];
    if (selectData && [[selectData allKeys] count]>0) {
        //时间时间段(逗号隔开:2019-03-05 00:00:00,2019-03-07 02:00:00)
        NSDictionary *dt_S=[selectData ojk:@"selectStartTime"];
        NSDictionary *dt_E=[selectData ojk:@"selectEndTime"];
        [dicTemp setObject:[NSString stringWithFormat:@"%@ %@:00,%@ %@:00",[dt_S ojsk:@"formatStr"],[dt_S ojsk:@"timeStr"],[dt_E ojsk:@"formatStr"],[dt_E ojsk:@"timeStr"]] forKey:@"between_time"];
        
    }
    NSMutableDictionary *dicAddressS=[self getAddValueForKey:@"dicAddressS"];
    if (dicAddressS && [[dicAddressS allKeys] count]>0) {
        [dicTemp setValue:[dicAddressS ojsk:@"lng"] forKey:@"lng"];
        [dicTemp setValue:[dicAddressS ojsk:@"lat"] forKey:@"lat"];
    }
//    NSMutableDictionary *dicAddressE=[self getAddValueForKey:@"dicAddressE"];
//    [dicTemp setValue:[kUtility_Location.userCityTake ojsk:@"id"] forKey:@"city_id"];
    [UTILITY.currentViewController pushController:[ExpressCarRentViewController class] withInfo:dicTemp withTitle:kST(@"rentCarFastChooseCar")];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
