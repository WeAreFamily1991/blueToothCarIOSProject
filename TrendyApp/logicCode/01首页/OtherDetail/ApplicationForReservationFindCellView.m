//
//  ApplicationForReservationFindCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ApplicationForReservationFindCellView.h"
#import "SwichButtonView.h"
#import "SelectTimeViewController.h"
#import "SearchVehicleLocationViewController.h"
#import "SelectAddressViewController.h"
#import "UtilitySelectTime.h"
#import "SelectCityViewController.h"
#import "Utility_Location.h"
#import "ChooseAStoreViewController.h"

@interface ApplicationForReservationFindCellView ()
@property (weak, nonatomic) IBOutlet UILabel *lblTip1;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress1;
@property (weak, nonatomic) IBOutlet UILabel *lblTip2;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress2;
@property (weak, nonatomic) IBOutlet UILabel *lblTip3;
@property (weak, nonatomic) IBOutlet UILabel *lblTip4;

@property (weak, nonatomic) IBOutlet UILabel *lblDateS1;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeS1;
@property (weak, nonatomic) IBOutlet UILabel *lblDateS2;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeS2;
@property (weak, nonatomic) IBOutlet UILabel *lblDateNum;


@property (strong, nonatomic)UIButton *btnCity1;
@property (strong, nonatomic)UIButton *btnCity2;
@end
@implementation ApplicationForReservationFindCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _showMessage=YES;
        __weak typeof(self) weakSelf=self;
        _swich1=[SwichButtonView viewWithFrame:CGRectMake(W(self)-70-15,0, 0, 0) backgroundcolor:nil superView:self];
        _swich2=[SwichButtonView viewWithFrame:CGRectMake(W(self)-70-15, 0, 0, 0) backgroundcolor:nil superView:self];
        _swich1.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
        _swich2.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
        _swich1.centerY=_lblAddress1.centerY;
        _swich2.centerY=_lblAddress2.centerY;
        
        _btnCity1=[RHMethods buttonWithFrame:CGRectMake(15, Y(_lblAddress1), 80, 45) title:@"" image:@"arrowb02" bgimage:nil supView:self];
        _btnCity2=[RHMethods buttonWithFrame:CGRectMake(15, Y(_lblAddress2), 80, 45) title:@"" image:@"arrowb02" bgimage:nil supView:self];
        _btnCity1.hidden=YES;
        _btnCity2.hidden=YES;
        [_btnCity1 addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[SelectCityViewController class] withInfo:@"" withTitle:kST(@"CitySelect") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                
            }];
        }];
        [_btnCity2 addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[SelectCityViewController class] withInfo:@"还车地址" withTitle:kST(@"CitySelect") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                
            }];
        }];
        
        NSMutableDictionary *dicAddressS=[NSMutableDictionary new];
        [self setAddValue:dicAddressS forKey:@"dicAddressS"];
        NSMutableDictionary *dicAddressE=[NSMutableDictionary new];
        [self setAddValue:dicAddressE forKey:@"dicAddressE"];
        
        _lblTip1.text=kS(@"findSelfHelp", @"takeCarAddress");
        _lblTip2.text=kS(@"findSelfHelp", @"returnCarAddress");
        _lblTip3.text=kS(@"setting_take_and_return_time", @"hint_take_date");
        _lblTip4.text=kS(@"setting_take_and_return_time", @"hint_return_date");
        
        [_lblAddress1 addViewTarget:self select:@selector(selectSAddress)];
        [_lblAddress2 addViewTarget:self select:@selector(selectEAddress)];
        
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
            if ([weakSelf.type isEqualToString:@"租车首页"]) {
                weakSelf.btnCity1.hidden=NO;
                weakSelf.btnCity2.hidden=NO;
                [UTILITY setAddValue:[weakSelf getAddValueForKey:@"selectAddressS_on"] forKey:@"selectAddressS_on"];
                [UTILITY setAddValue:[weakSelf getAddValueForKey:@"selectAddressS"] forKey:@"selectAddressS"];
                [UTILITY setAddValue:[weakSelf getAddValueForKey:@"selectAddressE_on"] forKey:@"selectAddressE_on"];
                [UTILITY setAddValue:[weakSelf getAddValueForKey:@"selectAddressE"] forKey:@"selectAddressE"];
                UTILITY.swich1=weakSelf.swich1;
                UTILITY.swich2=weakSelf.swich2;
//                UTILITY.swich2=weakSelf.swich2;
                
                weakSelf.lblAddress1.frame=CGRectMake(XW(weakSelf.btnCity1)+5, Y(weakSelf.lblAddress1), X(_swich1)-XW(weakSelf.btnCity1)-10, H(weakSelf.lblAddress1));
                weakSelf.lblAddress2.frame=CGRectMake(XW(weakSelf.btnCity2)+5, Y(weakSelf.lblAddress2), X(_swich2)-XW(weakSelf.btnCity2)-10, H(weakSelf.lblAddress2));
                [weakSelf.btnCity1 setTitle:[kUtility_Location.userCityTake ojsk:@"name"] forState:UIControlStateNormal];
                [weakSelf.btnCity2 setTitle:[kUtility_Location.userCityReturn ojsk:@"name"] forState:UIControlStateNormal];
                [UTILITY updateButtonImageTitleEdgeInsets_leftRight:weakSelf.btnCity1 space:4];
                [UTILITY updateButtonImageTitleEdgeInsets_leftRight:weakSelf.btnCity2 space:4];
            }
            NSMutableDictionary *dicAddressS=[weakSelf getAddValueForKey:@"dicAddressS"];
            [dicAddressS removeAllObjects];
            //地址
            weakSelf.lblAddress1.userInteractionEnabled=YES;
            if (weakSelf.swich1.isOn) {
                if ([weakSelf.type isEqualToString:@"租车首页"]) {
                    id selectAddressS=[weakSelf getAddValueForKey:@"selectAddressS_on"];
                    if (selectAddressS) {
                        [dicAddressS setObject:[selectAddressS ojsk:@"address"] forKey:@"address"];
                        [dicAddressS setObject:[selectAddressS ojsk:@"lng"] forKey:@"lng"];
                        [dicAddressS setObject:[selectAddressS ojsk:@"lat"] forKey:@"lat"];
                        [dicAddressS setObject:[selectAddressS ojsk:@"id"] forKey:@"id"];
                    }
                }else{
                    weakSelf.lblAddress1.userInteractionEnabled=NO;
                    //到店-只有一个门店-不能选择
                    if ([data ojk:@"car"]) {
                        [dicAddressS setObject:[[data ojk:@"car"] ojsk:@"pickup_address"] forKey:@"address"];
                        [dicAddressS setObject:[[data ojk:@"car"] ojsk:@"pickup_lng"] forKey:@"lng"];
                        [dicAddressS setObject:[[data ojk:@"car"] ojsk:@"pickup_lat"] forKey:@"lat"];
                    }
                }
            }else{
                //上门
                id selectAddressS=[weakSelf getAddValueForKey:@"selectAddressS"];
                if (selectAddressS) {
                    [dicAddressS setObject:[selectAddressS ojsk:@"title"] forKey:@"address"];
                    [dicAddressS setObject:[selectAddressS ojsk:@"lng"] forKey:@"lng"];
                    [dicAddressS setObject:[selectAddressS ojsk:@"lat"] forKey:@"lat"];
                }
            }
            if ([[dicAddressS allKeys] count]) {
                weakSelf.lblAddress1.text=[dicAddressS ojsk:@"address"];
                if (weakSelf.swich1.isOn && ![weakSelf.type isEqualToString:@"租车首页"]) {
                    weakSelf.lblAddress1.textColor=rgbTxtDeepGray;
                }else{
                    weakSelf.lblAddress1.textColor=rgbTitleColor;
                }
            }else{
                weakSelf.lblAddress1.text=kS(@"findSelfHelp", @"takeCarAddressHint");
                weakSelf.lblAddress1.textColor=rgbTxtGray;
            }
            
            
            NSMutableDictionary *dicAddressE=[weakSelf getAddValueForKey:@"dicAddressE"];
            [dicAddressE removeAllObjects];
            if (weakSelf.swich2.isOn) {
                id selectAddressE=[weakSelf getAddValueForKey:@"selectAddressE_on"];
                
                //到店--//默认第一个
                NSArray *array=[data ojk:@"dropList"];
                
                if (selectAddressE&&!array.count) {
                    [dicAddressE setObject:[selectAddressE ojsk:@"address"] forKey:@"address"];
                    [dicAddressE setObject:[selectAddressE ojsk:@"lng"] forKey:@"lng"];
                    [dicAddressE setObject:[selectAddressE ojsk:@"lat"] forKey:@"lat"];
                    [dicAddressE setObject:[selectAddressE ojsk:@"id"] forKey:@"id"];
                    [dicAddressE setObject:[selectAddressE ojsk:@"address_id"] forKey:@"address_id"];
                }else{
                    
                    if (array.count>0) {
                        [dicAddressE setObject:[array[0] ojsk:@"address"] forKey:@"address"];
                        [dicAddressE setObject:[array[0] ojsk:@"lng"] forKey:@"lng"];
                        [dicAddressE setObject:[array[0] ojsk:@"lat"] forKey:@"lat"];
                        [dicAddressE setObject:[array[0] ojsk:@"id"] forKey:@"id"];
                        [dicAddressE setObject:[array[0] ojsk:@"address_id"] forKey:@"address_id"];
//                        [dicAddressE setObject:[selectAddressE ojsk:@"address_id"] forKey:@"address_id"];
                    }
                }
            }else{
                //上门
                id selectAddressE=[weakSelf getAddValueForKey:@"selectAddressE"];
                if (selectAddressE) {
                    [dicAddressE setObject:[selectAddressE ojsk:@"title"] forKey:@"address"];
                    [dicAddressE setObject:[selectAddressE ojsk:@"lng"] forKey:@"lng"];
                    [dicAddressE setObject:[selectAddressE ojsk:@"lat"] forKey:@"lat"];
                }
            }
            if ([[dicAddressE allKeys] count]) {
                weakSelf.lblAddress2.text=[dicAddressE ojsk:@"address"];
                weakSelf.lblAddress2.textColor=rgbTitleColor;
            }else{
                weakSelf.lblAddress2.text=kS(@"findSelfHelp", @"returnCarAddressHint");
                weakSelf.lblAddress2.textColor=rgbTxtGray;
            }
        }];
        
        [_swich1 swichChangeValue:^(id data, int status, NSString *msg) {
            [weakSelf upDataMe];
            [weakSelf updateData];
            [weakSelf dispachEvent];
        }];
        [_swich2 swichChangeValue:^(id data, int status, NSString *msg) {
            [weakSelf upDataMe];
            [weakSelf updateData];
            [weakSelf dispachEvent];
        }];
        _swich1.isOn=YES;
        _swich2.isOn=YES;
        
        
        
        //监听选择时间变化
        [kUtilitySelectTime addEventWithObj:self actionTypeArray:@[@"updateHomeDataSelect"] reUseID:NSStringFromClass([self class]) WithBlcok:^(MYBaseService *obj) {
            if ([weakSelf.type isEqualToString:@"租车首页"]) {
                [weakSelf setAddValue:kUtilitySelectTime.selectHomeDate forKey:@"SelectDate"];
                [weakSelf upDataMe];
                [weakSelf updateData];
                [weakSelf dispachEvent];
            }
        }];
        //监听城市切换
        [kUtility_Location addEventWithObj:self actionTypeArray:@[@"SaveSelectUserCityUpdate",@"SaveSelectUserReturnCityUpdate"] reUseID:NSStringFromClass([self class]) WithBlcok:^(MYBaseService *obj) {
            //
            if ([weakSelf.type isEqualToString:@"租车首页"]) {
                if ([obj.currentEvnetType isEqualToString:@"SaveSelectUserCityUpdate"]) {//更新了取车城市
                    //更新了几乎所有的东西 还车地址也需要更换
                    
                    //清空 到店地址 取车地址
                    [self setAddValue:[NSMutableDictionary new] forKey:@"selectAddressS"];
                    [self setAddValue:[NSMutableDictionary new] forKey:@"selectAddressS_on"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        kUtility_Location.userCityReturn= [kUtility_Location.userCityTake toBeMutableObj];
                        //这个时候会发送 SaveSelectUserReturnCityUpdate
                    });
//                    @"selectAddressS_on"
                }
                if ([obj.currentEvnetType isEqualToString:@"SaveSelectUserReturnCityUpdate"]) {//取车地址更换 还车地址一定更换 并且 取车地址先更换
                    
                    //清空 到店地址 取车地址
                    [self setAddValue:[NSMutableDictionary new] forKey:@"selectAddressE"];
                    [self setAddValue:[NSMutableDictionary new] forKey:@"selectAddressE_on"];
                    [weakSelf upDataMe];
                    [weakSelf updateData];
                    [weakSelf dispachEvent];
                }
                
            }
        }];
    }
    return self;
}
#pragma mark button
- (IBAction)selectDateButtonClicked:(id)sender {
    __weak typeof(self) weakSelf=self;
    BaseViewController *baseV=(BaseViewController *)[self supViewController];
    if ([weakSelf.type isEqualToString:@"租车首页"]) {
        kUtilitySelectTime.selectStartTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectStartTime"];
        kUtilitySelectTime.selectEndTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectEndTime"];
        kUtilitySelectTime.selectTempTime=nil;
    }
    [UTILITY.currentViewController pushController:[SelectTimeViewController class] withInfo:[weakSelf.type isEqualToString:@"租车首页"]?@"homeSelectTime":@"申请预订" withTitle:@"" withOther:[[self.data ojk:@"car"] ojsk:@"id"] withAllBlock:^(id data, int status, NSString *msg) {
        if (![weakSelf.type isEqualToString:@"租车首页"]) {
            [weakSelf setAddValue:data forKey:@"SelectDate"];
            [weakSelf upDataMe];
        }else{
            kUtilitySelectTime.selectHomeDate=data;
            [weakSelf updateData];
        }
        baseV.allcallBlock?baseV.allcallBlock(data, status, msg):nil;
        [weakSelf dispachEvent];
    }];
}
//选择开始地址 这里面的很重要
-(void)selectSAddress{
    __weak typeof(self) weakSelf=self;
    if (weakSelf.swich1.isOn ) {
        if ([weakSelf.type isEqualToString:@"租车首页"]) {
            //选择
            [UTILITY.currentViewController pushController:[ChooseAStoreViewController class] withInfo:[kUtility_Location.userCityTake ojsk:@"id"] withTitle:kST(@"selectStores") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf setAddValue:data forKey:@"selectAddressS_on"];
                //选择到店 同时是在租车首页的情况下 还车到店地址 和 取车到店地址同步，
                //取车城市为空 或者还车城市与取车城市相同的时候
                if ( ![[kUtility_Location.userCityReturn ojsk:@"name"] notEmptyOrNull]||[[kUtility_Location.userCityReturn ojsk:@"name"] isEqualToString:[kUtility_Location.userCityTake ojsk:@"name"]]) {
                    
                    //同时选中还车地点
                    [weakSelf setAddValue:[data toBeMutableObj] forKey:@"selectAddressE_on"];
                }
                
                
                
                
                [weakSelf upDataMe];
                [weakSelf updateData];
                [weakSelf dispachEvent];
            }];
        }
       
    }else{
        [UTILITY.currentViewController pushController:[SearchVehicleLocationViewController class] withInfo:nil withTitle:kST(@"useCarAddress") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            [weakSelf setAddValue:data forKey:@"selectAddressS"];
            
            if ([weakSelf.type isEqualToString:@"租车首页"]) {
                
                //选择上门 同时是在租车首页的情况下 还车上门地址和 取车上门地址同步，
                   //取车城市为空 或者还车城市与取车城市相同的时候
                if ( ![[kUtility_Location.userCityReturn ojsk:@"name"] notEmptyOrNull]||[[kUtility_Location.userCityReturn ojsk:@"name"] isEqualToString:[kUtility_Location.userCityTake ojsk:@"name"]]) {
                    [weakSelf setAddValue:[data toBeMutableObj] forKey:@"selectAddressE"];
                }
                
            }
            
            //同时选中还车地点
//            [weakSelf setAddValue:[data toBeMutableObj] forKey:@"selectAddressE"];
            [weakSelf upDataMe];
            [weakSelf updateData];
            [weakSelf dispachEvent];
        }];
    }
}

//选择到达地址
-(void)selectEAddress{
    __weak typeof(self) weakSelf=self;
    if (weakSelf.swich2.isOn) {
        if ([weakSelf.type isEqualToString:@"租车首页"]) {
            //选择
            [UTILITY.currentViewController pushController:[ChooseAStoreViewController class] withInfo:[kUtility_Location.userCityReturn ojsk:@"id"] withTitle:kST(@"selectStores") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf setAddValue:data forKey:@"selectAddressE_on"];
                [weakSelf upDataMe];
                [weakSelf updateData];
                [weakSelf dispachEvent];
            }];
        }else{
            //选择
            [UTILITY.currentViewController pushController:[SelectAddressViewController class] withInfo:nil withTitle:kST(@"selectStores") withOther:[weakSelf.data ojk:@"dropList"] withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf setAddValue:data forKey:@"selectAddressE_on"];
                [weakSelf upDataMe];
                [weakSelf updateData];
                [weakSelf dispachEvent];
            }];
        }
       
    }else{
        [UTILITY.currentViewController pushController:[SearchVehicleLocationViewController class] withInfo:@"end" withTitle:kST(@"returnCarAddress") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            [weakSelf setAddValue:data forKey:@"selectAddressE"];
            [weakSelf upDataMe];
            [weakSelf updateData];
            [weakSelf dispachEvent];
        }];
    }
}
-(void)updateData{
    //
    if ([self.type isEqualToString:@"租车首页"]) {
        NSMutableDictionary *dicTemp=[NSMutableDictionary new];
        UIViewController *viewC=[self supViewController];
        
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
            if (_swich1.isOn) {
                [dicTemp setValue:[dicAddressS ojsk:@"id"] forKey:@"pick_up_id"];
            }
        }
        NSMutableDictionary *dicAddressE=[self getAddValueForKey:@"dicAddressE"];
        if (dicAddressE && [[dicAddressE allKeys] count]>0 && _swich2.isOn) {
            [dicTemp setValue:[dicAddressE ojsk:@"id"] forKey:@"drop_off_id"];
            if ([[dicAddressE ojsk:@"address_id"] notEmptyOrNull]) {
//                [dicTemp setValue:[dicAddressE ojsk:@"address_id"] forKey:@"drop_off_id"];
            }
        }
        [dicTemp setValue:[kUtility_Location.userCityTake ojsk:@"id"] forKey:@"city_id"];
        [viewC setAddValue:dicTemp forKey:@"selectAddressDate"];
        
        [dicTemp setValue:_swich1.isOn?@"2":@"1" forKey:@"pick_up_type"];
        [dicTemp setValue:_swich2.isOn?@"2":@"1" forKey:@"drop_off_type"];
        DLog(@"值变更:%@",dicTemp);
        if (viewC!=nil && [viewC respondsToSelector:@selector(request1)]) {
            [viewC performSelector:@selector(request1) withObject:nil afterDelay:0.01];
        }
//        https://app.trendycarshare.jp/api/car?uid=101&pagesize=20&pick_up_id=18&lat=35.667257&city_id=34&token=dae02b5b9107ceff052e03a7ef8ddee1&language=cn&drop_off_type=2&pick_up_type=2&drop_off_id=1&page=1&lng=139.89342599999998?token=dae02b5b9107ceff052e03a7ef8ddee1&uid=101&language=cn
    }
}
-(void)getRequestDataBlock:(AllcallBlock)aBlock{
    NSMutableDictionary *dicAddressS=[self getAddValueForKey:@"dicAddressS"];
    if (!dicAddressS || [[dicAddressS allKeys] count]==0) {
        if (_showMessage) {
            [SVProgressHUD showImage:nil status:kS(@"carApplyBooking", @"pickUpAddressHint")];
        }
        return;
    }
    NSMutableDictionary *dicAddressE=[self getAddValueForKey:@"dicAddressE"];
    if (!dicAddressE || [[dicAddressE allKeys] count]==0) {
        if (_showMessage) {
            [SVProgressHUD showImage:nil status:kS(@"carApplyBooking", @"returnCarAddressHint")];
        }
        return;
    }
    id selectData=[self getAddValueForKey:@"SelectDate"];
    if (!selectData || [[selectData allKeys] count]==0) {
        if (_showMessage){
            [SVProgressHUD showImage:nil status:kS(@"carApplyBooking", @"dateSetTip")];
        }
        return;
    }
    NSMutableDictionary *dicTemp=[NSMutableDictionary new];
    //还车方式 1 上门 2 到店
    [dicTemp setValue:_swich1.isOn?@"2":@"1" forKey:@"pickup"];
    [dicTemp setValue:_swich1.isOn?@"2":@"1" forKey:@"pick_up_type"];
    [dicTemp setValue:[dicAddressS ojsk:@"address"] forKey:@"pickup_address"];
    [dicTemp setValue:[dicAddressS ojsk:@"lng"] forKey:@"pickup_lng"];
    [dicTemp setValue:[dicAddressS ojsk:@"lat"] forKey:@"pickup_lat"];
    //还车方式 1 上门 2 到店
    [dicTemp setValue:_swich2.isOn?@"2":@"1" forKey:@"dropoff"];
    [dicTemp setValue:_swich2.isOn?@"2":@"1" forKey:@"drop_off_type"];
    if (_swich2.isOn) {
//        drop_off_id
        [dicTemp setValue:[dicAddressE ojsk:@"id"] forKey:@"drop_off_id"];
        if ([[dicAddressE ojsk:@"address_id"] notEmptyOrNull]) {
//            [dicTemp setValue:[dicAddressE ojsk:@"address_id"] forKey:@"drop_off_id"];
        }
        
    }
    [dicTemp setValue:[dicAddressE ojsk:@"address"] forKey:@"dropoff_address"];
    [dicTemp setValue:[dicAddressE ojsk:@"lng"] forKey:@"dropoff_lng"];
    [dicTemp setValue:[dicAddressE ojsk:@"lat"] forKey:@"dropoff_lat"];
    //时间时间段(逗号隔开:2019-03-05 00:00:00,2019-03-07 02:00:00)
    NSDictionary *dt_S=[selectData ojk:@"selectStartTime"];
    NSDictionary *dt_E=[selectData ojk:@"selectEndTime"];
    [dicTemp setObject:[NSString stringWithFormat:@"%@ %@:00,%@ %@:00",[dt_S ojsk:@"formatStr"],[dt_S ojsk:@"timeStr"],[dt_E ojsk:@"formatStr"],[dt_E ojsk:@"timeStr"]] forKey:@"between_time"];
    
    aBlock?aBlock(dicTemp,200,nil):nil;
}

-(void)dispachEvent{
    self.updataMyBlock?self.updataMyBlock(nil,200,nil):nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
