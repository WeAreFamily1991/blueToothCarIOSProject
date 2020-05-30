//
//  HomeCenterCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/20.
//  Copyright © 2019 55like. All rights reserved.
//

#import "HomeCenterCellView.h"
#import "SearchVehicleLocationViewController.h"
#import "BrandModelSearchViewController.h"
#import "Utility_Location.h"
#import "SelectTimeViewController.h"
#import "SpecialVehicleViewController.h"
#import "UtilitySelectTime.h"

@interface HomeCenterCellView()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *trademarkLb;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLable1;
@property (weak, nonatomic) IBOutlet UILabel *timeLable2;
@property (weak, nonatomic) IBOutlet UIButton *queryBtn;
@end
@implementation HomeCenterCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        __weak typeof(self) weakSelf=self;
        [kUtility_Location addEventWithObj:self actionTypeArray:@[@"homepageLocationUpdata"] reUseID:@"HomeCenterCellView" WithBlcok:^(MYBaseService *obj) {
            [weakSelf locationUpdata];
        }];
        
        self.data=[NSMutableDictionary new];
        [self.addressBtn setTitle:[NSString stringWithFormat:@" %@",kS(@"KeyHome", @"myAddress")] forState:UIControlStateNormal];
        [_queryBtn setTitle:kS(@"KeyHome", @"query") forState:UIControlStateNormal];
        //用车地点
        [weakSelf.addressLb addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[SearchVehicleLocationViewController class] withInfo:nil withTitle:kST(@"useCarAddress") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {                
                [weakSelf.data setValue:data forKey:@"Location"];
                [weakSelf upDataMe];
            }];
        }];
        //车型品牌
        [weakSelf.trademarkLb addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[BrandModelSearchViewController class] withInfo:nil withTitle:kS(@"KeyHome", @"BrandModel") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                
                [weakSelf.data setValue:data forKey:@"BrandModel"];
                [weakSelf upDataMe];
            }];
        }];
        [weakSelf.addressBtn addViewClickBlock:^(UIView *view) {
            
            
            [weakSelf locationUpdata];
        }];
        //选择时间
        [weakSelf.timeLable1 addViewClickBlock:^(UIView *view) {
            kUtilitySelectTime.selectStartTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectStartTime"];
            kUtilitySelectTime.selectEndTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectEndTime"];
            kUtilitySelectTime.selectTempTime=nil;
            [UTILITY.currentViewController pushController:[SelectTimeViewController class] withInfo:@"homeSelectTime" withTitle:@"" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                kUtilitySelectTime.selectHomeDate=data;
            }];
        }];
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            //位置
            if ([data ojk:@"Location"] ) {
                weakSelf.addressLb.text=[[data ojk:@"Location"] ojsk:@"title"];
                weakSelf.addressLb.textColor=rgbTitleColor;
                weakSelf.queryBtn.alpha=1;
                weakSelf.queryBtn.userInteractionEnabled=YES;
            }else{
                weakSelf.addressLb.text=kS(@"KeyHome", @"VehicleLocation");
                weakSelf.addressLb.textColor=rgbTxtGray;
                weakSelf.queryBtn.alpha=0.4;
                weakSelf.queryBtn.userInteractionEnabled=NO;
            }
            //车型品牌
            if ([data ojk:@"BrandModel"] ) {
                weakSelf.trademarkLb.text=[[data ojk:@"BrandModel"] ojsk:@"name"];
            }else{
                weakSelf.trademarkLb.text=kS(@"KeyHome", @"AllBrandModel");
            }
//            SelectDate
            if ([data ojk:@"SelectDate"] ) {
                weakSelf.timeLable1.text=[[data ojk:@"SelectDate"] ojsk:@"tipDate2"];//FormatTime1
                weakSelf.timeLable2.text=[[data ojk:@"SelectDate"] ojsk:@"tipDate1"];
                
            }else{
                weakSelf.timeLable1.text=kS(@"KeyHome", @"NOTime");
                weakSelf.timeLable2.text=@"";
            }
//
        }];
        
        //监听选择时间变化
        [kUtilitySelectTime addEventWithObj:self actionTypeArray:@[@"updateHomeDataSelect"] reUseID:NSStringFromClass([self class]) WithBlcok:^(MYBaseService *obj) {
            [weakSelf.data setValue:kUtilitySelectTime.selectHomeDate forKey:@"SelectDate"];
            [weakSelf upDataMe];
        }];
    }
    return self;
}
- (IBAction)queryBtnClick:(UIButton *)sender {
    //SpecialVehicleViewController
    [UTILITY.currentViewController pushController:[SpecialVehicleViewController class] withInfo:self.data withTitle:kST( @"homeCarQueryResult")];
}
-(void)locationUpdata{
    //設置當前位置
      __weak __typeof(self) weakSelf = self;
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:kUtility_Location.userlatitude forKey:@"lat"];
    [dic setValue:kUtility_Location.userlongitude forKey:@"lng"];
    [dic setValue:kUtility_Location.userAddress?kUtility_Location.userAddress:@"" forKey:@"title"];
    [weakSelf.data setValue:dic forKey:@"Location"];
    [weakSelf upDataMe];
    
    
}

@end
