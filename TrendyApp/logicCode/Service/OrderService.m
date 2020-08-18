//
//  OrderService.m
//  TrendyApp
//
//  Created by 55like on 2019/3/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderService.h"
#import "IWantToEvaluateViewController.h"
#import "AddInsuranceViewController.h"
#import "ConfirmReservationInformationViewController.h"
#import "ExtendUseCarViewController.h"
#import "ApplicationForReservationViewController.h"
#import "SelectWebUrlViewController.h"
#import "PaymentOfAdditionalInsuranceViewController.h"
#import "PaymentOfAdditionalInsurance2ViewController.h"

@implementation OrderService

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)order_index:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"order/index" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
              block(nil,201,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    } onError:^(NSError *error) {
        
        block(nil,201,nil);
    }];
}
-(void)order_details:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"order/details" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            //            block(@{},200,nil);
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}//

-(void)order_addComment:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"order/addComment" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
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
-(void)order_orderOp:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"order/orderOp" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
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


-(void)orderActionWithOrderData:(NSMutableDictionary*)orderData WithActionType:(NSString*)actionType withBlock:(AllcallBlock)block{
    
//    actionType=@"insurance";
    if ([actionType isEqualToString:@"del"]||[actionType isEqualToString:@"cancel"]) {
        NSString*titleStr=kS(@"main_order", @"order_action_notice_cancel");
        titleStr=[NSString stringWithFormat:@"%@ 未測試",actionType];
        if ([actionType isEqualToString:@"del"]) {
            titleStr=kS(@"main_order", @"order_action_notice_del");
        }else if([actionType isEqualToString:@"cancel"]){
            titleStr=kS(@"main_order", @"order_action_notice_cancel");
        }
//        titleStr=[NSString stringWithFormat:@"%@%@",titleStr,actionType];
        titleStr=[NSString stringWithFormat:@"%@",titleStr];
        
        if ([actionType isEqualToString:@"cancel"]) {
           
        }
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];
                
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            krequestParam
            [dictparam setObject:actionType forKey:@"action"];
            [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
            [kOrderService order_orderOp:dictparam withBlock:^(id data, int status, NSString *msg) {
                 [SVProgressHUD showSuccessWithStatus:msg];
                block(nil,200,nil);
            }];
        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
//        [actionType isEqualToString:@"extend"]
    }else if([actionType isEqualToString:@"extend"]||[actionType isEqualToString:@"advance"]){
        krequestParam
        [dictparam setObject:actionType forKey:@"action"];
        [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
        [kOrderService order_orderOp:dictparam withBlock:^(id data, int status, NSString *msg) {
            UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:kS(@"main_order", @"dialog_notice") message:msg preferredStyle:UIAlertControllerStyleAlert];
            [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"advance_return_extend_use", @"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSString*titleStr=kS(@"main_order", @"Application_advance");
                if ([actionType isEqualToString:@"extend"]) {
                    titleStr=kS(@"main_order", @"Application_extend");
                }
                
#warning 注意这里传入的是对象
                [UTILITY.currentViewController pushController:[ExtendUseCarViewController class] withInfo:orderData withTitle:titleStr withOther:actionType withAllBlock:^(id data, int status, NSString *msg) {
                    block(nil,200,nil);
                }];
            }]];
            if ([actionType isEqualToString:@"advance"]) {
                [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"return_car_rule") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/orders/advance?apptype=app%@",@""]}];
                }]];
            }else{
                [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"extend_car_rule") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/orders/extend?apptype=app%@",@""]}];
                }]];
            }
            [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"advance_return_extend_use", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
            [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
                
            }];
        }];
    }else if([actionType isEqualToString:@"comment"]){
        [UTILITY.currentViewController pushController:[IWantToEvaluateViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:kST(@"order_comment") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            block(nil,200,nil);
        }];
    }else if([actionType isEqualToString:@"insurance"]){//apply
        [UTILITY.currentViewController pushController:[AddInsuranceViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:kST(@"fill_insurance_info") withOther:actionType withAllBlock:^(id data, int status, NSString *msg) {
            block(nil,200,nil);
        }];
    }else if([actionType isEqualToString:@"apply"]){//
        [UTILITY.currentViewController pushController:[AddInsuranceViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:@"立即预定" withOther:actionType withAllBlock:^(id data, int status, NSString *msg) {
            block(nil,200,nil);
        }];
    }else if([actionType isEqualToString:@"pay"]){//
        [UTILITY.currentViewController pushController:[ConfirmReservationInformationViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:kST(@"confirm_booking_info") withOther:actionType withAllBlock:^(id data, int status, NSString *msg) {
            block(nil,200,nil);
        }];
        
        //        [self pushController:[ConfirmReservationInformationViewController class] withInfo:weakSelf.userInfo withTitle:@"确认预订信息"];
    }else if([actionType isEqualToString:@"again"]){//
//        [UTILITY.currentViewController pushController:[ConfirmReservationInformationViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:@"确认预订信息" withOther:actionType withAllBlock:^(id data, int status, NSString *msg) {
//            block(nil,200,nil);
//        }];
        
        //        [self pushController:[ConfirmReservationInformationViewController class] withInfo:weakSelf.userInfo withTitle:@"确认预订信息"];
//        [UTILITY.currentViewController pushController:[ApplicationForReservationViewController class] withInfo:[orderData ojsk:@"cid"] withTitle:@"再來一單" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
//            //处理时间回掉
//            //            [weakSelf setAddValue:data forKey:@"SelectDate"];
//        }];
        [UTILITY.currentViewController pushController:[ApplicationForReservationViewController class] withInfo:[orderData ojsk:@"cid"] withTitle:kS(@"carDetails", @"applyBooking") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            //处理时间回掉
            //            [weakSelf setAddValue:data forKey:@"SelectDate"];
        }];
    }else if([actionType isEqualToString:@"receipt"]){//
        krequestParam
        [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
        [dictparam setObject:@"app" forKey:@"apptype"];
        [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:[NSString stringWithFormat:@"h5.trendycarshare.jp/home/welcome/receipt%@",dictparam.wgetParamStr]];
        
        //        [self pushController:[ConfirmReservationInformationViewController class] withInfo:weakSelf.userInfo withTitle:@"确认预订信息"];
    }else if([actionType isEqualToString:@"insurerpay"]){//
        
        
        [UTILITY.currentViewController pushController:[PaymentOfAdditionalInsuranceViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:kST(@"pay_for_append_insurance") withOther:[orderData ojsk:@"orderid"] withAllBlock:^(id data, int status, NSString *msg) {
            
            
            krequestParam
            [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
            
            
            [dictparam setObject:@"app" forKey:@"apptype"];
            [dictparam setObject:@"2" forKey:@"type"];
            //        [dictparam setObject:_switchBtn.on?@"1":@"0" forKey:@"ispoint"];
            //    http://h5.trendycarshare.jp/home/orders/pay?apptype=app&uid=20&orderid=2019071149102525&ispoint=0&type=1
            [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/orders/pay%@",dictparam.wgetParamStr]}];
        }];
        return;
    }else if([actionType isEqualToString:@"extendpay"]){//
        
        
        [UTILITY.currentViewController pushController:[PaymentOfAdditionalInsurance2ViewController class] withInfo:[orderData ojsk:@"orderid"] withTitle:kST(@"Payment_Extended") withOther:[orderData ojsk:@"orderid"] withAllBlock:^(id data, int status, NSString *msg) {
            
            
            krequestParam
            [dictparam setObject:[orderData ojsk:@"orderid"] forKey:@"orderid"];
            
            
            [dictparam setObject:@"app" forKey:@"apptype"];
            [dictparam setObject:@"3" forKey:@"type"];
            //        [dictparam setObject:_switchBtn.on?@"1":@"0" forKey:@"ispoint"];
            //    http://h5.trendycarshare.jp/home/orders/pay?apptype=app&uid=20&orderid=2019071149102525&ispoint=0&type=1
            [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/orders/pay%@",dictparam.wgetParamStr]}];
        }];
        return;
    }else{
//
        
       NSString* titleStr=[NSString stringWithFormat:@"%@ 未实现",actionType];
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];
//        [alertcv addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
    }
    
}

@end
