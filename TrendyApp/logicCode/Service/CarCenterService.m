//
//  CarCenterService.m
//  TrendyApp
//
//  Created by 55like on 2019/3/13.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CarCenterService.h"
#import "MyCertificationViewController.h"

@implementation CarCenterService

-(void)carcenter_cardataildeploy:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/cardataildeploy" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)welcome_getcar:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"welcome/getcar" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)welcome_cityList:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"welcome/cityList" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil); 
            // [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)welcome_getcity:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"welcome/getcity" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            for (int i=0; i<[[dic ojk:@"list"] count]; i++) {
                NSMutableDictionary*mdic =[dic ojk:@"list"][i];
                [mdic setObject:[mdic ojk:@"son"] forKey:@"addresses"];
                
                for (int i=0; i<[[mdic ojk:@"addresses"] count]; i++) {
                    NSMutableDictionary*mdics =[mdic ojk:@"addresses"][i];
                    [mdics setObject:[mdics ojk:@"name"] forKey:@"address"];
                }
            }
            
            block(dic,200,nil);
            // [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)carcenter_cardatail:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/cardatail" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            {
                NSMutableDictionary*mdic=[NSMutableDictionary new];
                [mdic setObject:[dic ojsk:@"city"] forKey:@"city"];
                [mdic setObject:[dic ojsk:@"area"] forKey:@"area"];
                [dic setObject:mdic forKey:@"city_area"];
            }
            {
                NSMutableDictionary*mdic=[NSMutableDictionary new];
                [mdic setObject:[dic ojsk:@"fid"] forKey:@"fid"];
                [mdic setObject:[dic ojsk:@"sid"] forKey:@"sid"];
                [dic setObject:mdic forKey:@"fid_sid"];
            }
            {
                NSArray*pathArray=[dic ojk:@"path"];
                if (pathArray) {
                    NSMutableArray*marray=[NSMutableArray new];
                    for (NSString*strpath in pathArray) {
                        NSRange range=[strpath rangeOfString:basePicPath];
                        if (range.length == 0) {
                            range=[strpath rangeOfString:@"trendycarshare.jp/upload/"];
                        }
                        NSString* subpathStr=[strpath substringFromIndex:range.location+range.length];
                        [marray addObject:subpathStr];
                    }
                    NSString*pathStr=[marray componentsJoinedByString:@","];//http://
                    [dic setObject:pathStr forKey:@"path"];
                }
            }
            {
//                indate birthday
#pragma mark 日期
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                fmt.dateFormat = @"yyyy-MM-dd";
                fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                NSDate *date=[NSDate dateWithTimeIntervalSince1970:[dic ojsk:@"indate"].floatValue];
                [dic setObject:[fmt stringFromDate:date] forKey:@"indate"];
                date=[NSDate dateWithTimeIntervalSince1970:[dic ojsk:@"birthday"].floatValue];
                [dic setObject:[fmt stringFromDate:date] forKey:@"birthday"];
                
            }
            block(dic,200,nil);
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)carcenter_addcar:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    
    if ([paramDic ojk:@"city_area"]) {
        [paramDic addEntriesFromDictionary:[paramDic ojk:@"city_area"]];
    }
    if ([paramDic ojk:@"fid_sid"]) {
        [paramDic addEntriesFromDictionary:[paramDic ojk:@"fid_sid"]];
    }
    
    [dictparam addEntriesFromDictionary:paramDic];
    
    [NetEngine createPostAction:@"carcenter/addcar" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
//carcenter/carlist


-(void)carcenter_carlist:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/carlist" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)carcenter_cardatailorder:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/cardatailorder" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
//            NSMutableDictionary*listArray=[NSMutableDictionary new];
            [dic setObject:[dic ojk:@"confine"] forKey:@"list"];
            [dic removeObjectForKey:@"confine"];
            int i=0;
            for (NSMutableDictionary*mdic in dic[@"list"]) {
                if (i==0) {
//                    [mdic setObject:@"10" forKey:@"frameY"];
                }
                i++;
                [mdic setObject:[mdic ojsk:@"title"] forKey:@"name"];
//                [mdic setObject: forKey:@"OFCSelectItemButtonCellView"];
                [mdic setObject:@"OFCSelectItemButtonCellView" forKey:@"classStr"];
                [mdic setObject:[mdic ojsk:@"son"] forKey:@"valueStr"];
                [mdic setObject:@"confine" forKey:@"requestkey"];
                [mdic removeObjectForKey:@"son"];
                for (NSMutableDictionary*smdic in mdic[@"valueStr"]) {
                    [smdic setObject:[smdic ojsk:@"title"] forKey:@"name"];
                }
            }
            
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}


-(void)carcenter_updatecarconfine:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/updatecarconfine" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccess  WithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}


-(void)carcenter_updatecarprice:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/updatecarprice" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)order_orderdetails:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/orderdetails" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
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

-(void)carcenter_getaddressWithParam:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/getaddress" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
-(void)carcenter_updatecaraddress:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/updatecaraddress" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)carcenter_addscar:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block{
    krequestParam
    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"carcenter/addscar" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}

-(void)carcenter_checkUserwithBlock:(AllcallBlock)block{
    krequestParam
//    [dictparam addEntriesFromDictionary:paramDic];
    [NetEngine createPostAction:@"ucenter/checkUser" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            block(nil,200,nil);
        }else{
            UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:kS(@"rentCarFastChooseCar", @"dialogTitle") message:kS(@"rentCarFastChooseCar", @"dialogMessage") preferredStyle:UIAlertControllerStyleAlert];
            [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"rentCarFastChooseCar", @"dialogPositiveString") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [kUserCenterService getUserCenterIndexData:^(id data, int status, NSString *msg) {
                    
                    [UTILITY.currentViewController pushController:[MyCertificationViewController class] withInfo:data withTitle:kST(@"IdentityAuthentication")];
                }];
            }]];
            [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"generalPage", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
            [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
                
            }];
            
            
//            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
    
}
@end
