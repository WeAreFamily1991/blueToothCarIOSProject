//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CarlistOrderSettingViewController.h"//
#import "MYRHTableView.h"
#import "NSObject+JSONCategories.h"
@interface CarlistOrderSettingViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  CarlistOrderSettingViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [self rightButton:kS(@"AddBasicVehicleInformation", @"complete") image:nil sel:@selector(submitBtnClick:)];
    [super viewDidLoad];
    NSMutableDictionary*mdic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.userInfo,@"id", nil];
      __weak __typeof(self) weakSelf = self;
    [kCarCenterService carcenter_cardatailorder:mdic withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf addView];
    }];
    //    [self addView];
//    if (self.userInfo) {
//        [self bendData];
//    }
    
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
            [dictparam removeObjectForKey:@"confine"];
            [dictparam setObject:self.userInfo forKey:@"carid"];
            
            NSMutableArray*confine_id_Array=[NSMutableArray new];
            NSMutableDictionary*marrayconfine_joon=[NSMutableDictionary new];
            for (UIView*view in weakSelf.mtableView.defaultSection.noReUseViewArray) {
                if ([[view.data ojsk:@"requestkey"] isEqualToString:@"confine"]) {
                    for (NSMutableDictionary*sdic in [view.data ojk:@"valueStr"]) {
                        if ([[sdic ojsk:@"status"] isEqualToString:@"1"]) {
                            [confine_id_Array addObject:[sdic ojsk:@"id"]];
                            if ([[sdic ojsk:@"iscustom"] isEqualToString:@"1"]) {
//                                [marrayconfine_joon addObject:[@{[sdic ojsk:@"id"]:@{@"content":[sdic ojsk:@"customStr"]}} toBeMutableObj]];
                                
                                if (![[view.data ojsk:@"content"] notEmptyOrNull]) {
                                    [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseInput"),[sdic ojsk:@"name"]]];
                                    return ;
                                }
                                [marrayconfine_joon setObject:@{@"content":[view.data ojsk:@"content"]} forKey:[view.data ojsk:@"id"]];
                            }
                        }
                    }
                }
            }
            [dictparam setObject:[confine_id_Array componentsJoinedByString:@","] forKey:@"confine_id"];
            [dictparam setObject:[marrayconfine_joon JSONString_l] forKey:@"confine_joon"];
            
            [kCarCenterService carcenter_updatecarconfine:dictparam withBlock:^(id data, int status, NSString *msg) {
                weakSelf.allcallBlock?weakSelf.allcallBlock(data, 200, nil):nil;
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                
            }];
            
//            [dictparam setObject:@{
//                                   @"city":@"1",
//                                   @"area":@"22"
//                                   } forKey:@"city_area"];
//            //                [dictparam setObject:@"" forKey:@""];
//            weakSelf.allcallBlock?weakSelf.allcallBlock(dictparam,200,nil):nil;
//            [weakSelf.navigationController popViewControllerAnimated:YES];
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
                                     @"name":kS(@"OrderSetting", @"OpenBooking"),
                                     @"classStr":@"FCSwichCellView",
                                     @"valueStr":[self.data ojsk:@"isopen"],
                                     @"requestkey":@"isopen",
//                                     @"placeholder":kS(@"OrderSetting", @"VehicleIntroductionHint"),
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"vijewlin",
                                     @"classStr":@"FCLineCellView",
                                     },
                                 @{
                                     @"name":kS(@"OrderSetting", @"VehicleIntroduction"),
                                     @"classStr":@"FCTextCellView",
                                     @"valueStr":[self.data ojsk:@"content"],
                                     @"placeholder":kS(@"OrderSetting", @"VehicleIntroductionHint"),
                                     @"requestkey":@"content",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"vijewlin",
                                     @"classStr":@"FCLineCellView",
                                     },
                                 
                                 @{
                                     @"name":kS(@"OrderSetting", @"VehicleAttractionKeyword"),
                                     @"classStr":@"FCTextCellView",
                                     @"requestkey":@"keyword",
                                     @"valueStr":[self.data ojsk:@"keyword"],
                                     @"placeholder":kS(@"OrderSetting", @"PleaseFillInTheKeyWords"),
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"vijewlin",
                                     @"classStr":@"FCLineCellView",
                                     },
                                 
                                 @{
                                     @"name":kS(@"OrderSetting", @"InstructionsForTakingCars"),
                                     @"classStr":@"FCTextCellView",
                                     @"requestkey":@"descr",
                                     @"valueStr":[self.data ojsk:@"descr"],
                                     @"placeholder":kS(@"OrderSetting", @"PleaseFillInTheInstructions"),
                                     @"isMust":@"1",
                                     },
//                                 @{
//                                     @"name":@"vijewlin",
//                                     @"classStr":@"FCLineCellView",
//                                     },
                                 @{
                                     @"name":kS(@"OrderSetting", @"CommonConditionsOfUse"),
                                     @"classStr":@"PanTextCellView",
                                     @"requestkey":@"title",
                                     @"isMust":@"1",
                                     },
//                                 @{
//                                     @"name":@"vijewlin",
//                                     @"classStr":@"FCLineCellView",
//                                     },
                                 ] toBeMutableObj];
    [arraytitle addObjectsFromArray:[self.data ojk:@"list"]];
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
    
}
-(void)bendData{
    self.data=self.userInfo;
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
