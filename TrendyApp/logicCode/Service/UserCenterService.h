//
//  UserCenterService.h
//  TrendyApp
//
//  Created by 55like on 2019/3/12.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYBaseService.h"

NS_ASSUME_NONNULL_BEGIN
#define kUserCenterService [UserCenterService shareInstence]
@interface UserCenterService : MYBaseService
-(void)getUserCenterIndexData:(AllcallBlock)block;

//mobile    字符串    必须        联系号码
//content    字符串    必须        反馈内容
-(void)addfeedBackWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenterUpdateWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenterInsureraddWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenterInsurerdWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenterInsurerdetailWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_authentication:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_getsgins:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_addsgins:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_getfav:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_rental:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_getaccount:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_getaccountlist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)help:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_index:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_orderlist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)carcenter_addComment:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)orderActionWithOrderData:(NSMutableDictionary*)orderData WithActionType:(NSString*)actionType withBlock:(AllcallBlock)block;
-(void)ucenter_comment:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_commented:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_userhome:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_noticeslist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_noticesop:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;

-(void)goWelcom_getruleWithTitle:(NSString*)title withtype:(NSString*)type;
-(void)carcenter_updateaddress:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)ucenter_getnoticesindex:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)car_carucenter:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
@end

NS_ASSUME_NONNULL_END
