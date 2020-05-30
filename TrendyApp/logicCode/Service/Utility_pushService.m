//
//  Utility_pushService.m
//  TrendyApp
//
//  Created by 55like on 2019/4/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "Utility_pushService.h"
#import "OrderDetailViewController.h"
#import "CarListViewController.h"
@implementation Utility_pushService
-(void)receviveNoticeWithDic:(NSMutableDictionary*)dic{
    NSString*type=[dic ojsk:@"type"];
    NSString*txt=[dic ojsk:@"txt"];
//      __weak __typeof(self) weakSelf = self;
    
    if ([type isEqualToString:@"order"]) {
        [UTILITY.currentViewController pushController:[OrderDetailViewController class] withInfo:txt withTitle:kST(@"order_detail") withOther:nil];
    }else if ([type isEqualToString:@"car"]) {
        [UTILITY.currentViewController pushController:[CarListViewController class] withInfo:nil withTitle:kST(@"CarList") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
//            [weakSelf loadDATA];
        }];
    }else{
        
    }
    
}
-(void)receviveNoticeforwordWithDic:(NSMutableDictionary*)dic{
    
}
@end
