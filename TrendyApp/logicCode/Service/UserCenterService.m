//
//  UserCenterService.m
//  TrendyApp
//
//  Created by 55like on 2019/3/12.
//  Copyright © 2019 55like. All rights reserved.
//

#import "UserCenterService.h"
#import "IWantToEvaluateViewController.h"
#import "SelectUrlProtalViewController.h"

@implementation UserCenterService
-(void)getUserCenterIndexData:(AllcallBlock)block{
    krequestParam
    
    [NetEngine createPostAction:@"ucenter/index" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            {
                [dic setObject:[[dic ojsk:@"gender"]  isEqualToString:@"1"]?kS(@"personalInfo", @"gender_male"):kS(@"personalInfo", @"gender_female") forKey:@"gender-t"];
            }{
                [dic setObject:[dic ojsk:@"birthday_str"] forKey:@"birthday"];
            }
            
            kUtility_Login.userNickName=[dic ojsk:@"nickname"];
            kUtility_Login.userNickName=[dic ojsk:@"nickname"];
            
            block(dic,200,nil);
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)addfeedBackWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/feedback" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
             block(dic,200,nil);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
            //            [self addView];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenterUpdateWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    {
        [paramDic setObject:[[paramDic ojsk:@"gender-t"]  isEqualToString:kS(@"personalInfo", @"gender_male")]?@"1":@"2" forKey:@"gender"];
        [paramDic removeObjectForKey:@"gender-t"];
        
    }
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/update" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
            //            [self addView];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}


-(void)ucenterInsureraddWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/insureradd" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenterInsurerdWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/insurer" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
//            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)ucenterInsurerdetailWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/insurerdetail" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            {
                [dic setObject:[dic ojsk:@"birthday_str"] forKey:@"birthday"];
            }{
                [dic setObject:[dic ojsk:@"license_str"] forKey:@"license_time"];
            }
            
            
            block(dic,200,nil);
//            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}


-(void)ucenter_authentication:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/authentication" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)ucenter_getsgins:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/getsgins" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_addsgins:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/addsgins" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
//            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)ucenter_getfav:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/getfav" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)ucenter_rental:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/rental" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_getaccount:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/getaccount" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_getaccountlist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/getaccountlist" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

//http://app.trendycarshare.jp/api/help

-(void)help:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"help" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)carcenter_index:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/index" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)carcenter_orderlist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/orderlist" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)carcenter_addComment:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/addComment" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)orderActionWithOrderData:(NSMutableDictionary*)orderData WithActionType:(NSString*)actionType withBlock:(AllcallBlock)block{
    
    //    actionType=@"insurance";
//    操作类型：删除：del、取消：cancel、预约同意：agree、预约拒绝：refuse、确认取车：pick、确认还车：return、提前还车申请（弹窗）：advance、提前还车同意：advanceagree、提前还车拒绝：advancerefuse、延长用车申请（弹窗）：extend、延长用车同意：extendagree、延长用车拒绝：extendrefuse
    if ([actionType isEqualToString:@"del"]||[actionType isEqualToString:@"cancel"]||[actionType isEqualToString:@"agree"]||[actionType isEqualToString:@"refuse"]||[actionType isEqualToString:@"pick"]||[actionType isEqualToString:@"return"]||[actionType isEqualToString:@"advanceagree"]||[actionType isEqualToString:@"extendagree"]||[actionType isEqualToString:@"extendrefuse"]) {
        NSString*titleStr=kS(@"main_order", @"order_action_notice_confirm");
//        ||[actionType isEqualToString:@"advance"]
//        ||[actionType isEqualToString:@"extend"]
//        titleStr=[NSString stringWithFormat:@"您是否確定要執行此操作？"];
//        titleStr=[NSString stringWithFormat:@"%@ ",actionType];
        if ([actionType isEqualToString:@"del"]) {
            titleStr=kS(@"main_order", @"order_action_notice_del");
        }else if([actionType isEqualToString:@"cancel"]){
            titleStr=kS(@"main_order", @"order_action_notice_cancel");
        }
//        titleStr=[NSString stringWithFormat:@"%@%@",titleStr,actionType];
        titleStr=[NSString stringWithFormat:@"%@",titleStr];

        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];


        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            krequestParam
            [dictparam setObject:actionType forKey:@"action"];
            [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
            [NetEngine createPostAction:@"carcenter/orderOp" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                    //                    NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                    block(nil,200,nil);
                    [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
                }else{
                    [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];

                }
            }];
        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{

        }];

    }else if([actionType isEqualToString:@"comment"]){
        [UTILITY.currentViewController pushController:[IWantToEvaluateViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:kST(@"order_comment") withOther:@"userCenter" withAllBlock:^(id data, int status, NSString *msg) {
            block(nil,200,nil);
        }];
    }else if([actionType isEqualToString:@"extend"]||[actionType isEqualToString:@"advance"]){
        
        NSString*titleStr=kS(@"main_order", @"order_action_notice_confirm");
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];
        krequestParam
//        [dictparam setObject:actionType forKey:@"action"];
        [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"agree") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([actionType isEqualToString:@"extend"]) {
                 [dictparam setObject:@"extendagree" forKey:@"action"];
            }else{
                [dictparam setObject:@"advanceagree" forKey:@"action"];
            }
            
            [NetEngine createPostAction:@"carcenter/orderOp" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                    //                    NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                    block(nil,200,nil);
                    [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
                }else{
                    [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
                }
            }];
        }]];
        
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"refuse") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([actionType isEqualToString:@"extend"]) {
                [dictparam setObject:@"extendrefuse" forKey:@"action"];
            }else{
                [dictparam setObject:@"advancerefuse" forKey:@"action"];
            }
            [NetEngine createPostAction:@"carcenter/orderOp" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                    //                    NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                    block(nil,200,nil);
                    [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
                }else{
                    [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
                }
            }];
        }]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
        
    }else{
        //所有的未实现操作都是这样的不做单独的设置
        NSString*titleStr=kS(@"main_order", @"order_action_notice_confirm");
        
//        titleStr=[NSString stringWithFormat:@"您是否確定要執行此操作？"];
        //        titleStr=[NSString stringWithFormat:@"%@ ",actionType];
        if ([actionType isEqualToString:@"del"]) {
            titleStr=kS(@"main_order", @"order_action_notice_del");
        }else if([actionType isEqualToString:@"cancel"]){
            titleStr=kS(@"main_order", @"order_action_notice_cancel");
        }
        //        titleStr=[NSString stringWithFormat:@"%@%@",titleStr,actionType];
        titleStr=[NSString stringWithFormat:@"%@",titleStr];
        
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            krequestParam
            [dictparam setObject:actionType forKey:@"action"];
            [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
            [NetEngine createPostAction:@"carcenter/orderOp" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                    //                    NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                    block(nil,200,nil);
                    [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
                }else{
                    [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
                    
                }
            }];
        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
        
//        NSString* titleStr=[NSString stringWithFormat:@"%@ 未实现",actionType];
//        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];
//        //        [alertcv addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //        }]];
//        [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
//
//        }];
    }
    
}


-(void)ucenter_comment:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/comment" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_commented:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [dictparam setObject:[dictparam ojsk:@"uid"] forKey:@"to_uid"];
    [NetEngine createPostAction:@"ucenter/commented" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}


-(void)ucenter_userhome:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
//    krequestParam
//    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/userhome" withParams:paramDic onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_noticeslist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/noticeslist" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_noticesop:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/noticesop" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)goWelcom_getruleWithTitle:(NSString*)title withtype:(NSString*)type{
    __weak __typeof(self) weakSelf = self;
    krequestParam
    [dictparam setObject:type forKey:@"type"];
    [NetEngine createPostAction:@"welcome/getRule" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
//            [dic setObject:self.isSelectPolicy forKey:@"isSelectPolicy"];
//            [dic setObject:kS(@"registerPolicy", @"policy_check_agree") forKey:@"btnTitle"];
            [UTILITY.currentViewController pushController:[SelectUrlProtalViewController class] withInfo:dic withTitle:title withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];
}


-(void)carcenter_updateaddress:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/updateaddress" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)ucenter_getnoticesindex:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/getnoticesindex" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
//            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}



-(void)car_carucenter:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
        krequestParam
        [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"car/carucenter" withParams:paramDic onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            [dic setObject:[dic ojsk:@"carlist"] forKey:@"list"];
            [dic removeObjectForKey:@"carlist"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
@end
/*
 最近几个项目的总结：
 总的问题都一样，信息沟通不畅。
 
 
 */
