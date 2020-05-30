//
//  CarCenterService.h
//  TrendyApp
//
//  Created by 55like on 2019/3/13.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYBaseService.h"

NS_ASSUME_NONNULL_BEGIN

#define kCarCenterService [CarCenterService shareInstence]
@interface CarCenterService : MYBaseService
-(void)carcenter_cardataildeploy:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)welcome_getcar:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)welcome_cityList:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)welcome_getcity:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_cardatail:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_addcar:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_carlist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;

-(void)carcenter_cardatailorder:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;

-(void)carcenter_updatecarconfine:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_updatecarprice:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)order_orderdetails:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_getaddressWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_updatecaraddress:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_addscar:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;


-(void)carcenter_checkUserwithBlock:(AllcallBlock)block;
@end

NS_ASSUME_NONNULL_END
