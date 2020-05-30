//
//  OrderService.h
//  TrendyApp
//
//  Created by 55like on 2019/3/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "BaseFormCellView.h"
#define kOrderService [OrderService shareInstence]
NS_ASSUME_NONNULL_BEGIN

@interface OrderService : MYBaseService
-(void)order_index:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
-(void)order_details:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;

-(void)orderActionWithOrderData:(NSMutableDictionary*)orderData WithActionType:(NSString*)actionType withBlock:(AllcallBlock)block;

-(void)order_addComment:(NSMutableDictionary*)paramDic withBlock:(AllcallBlock)block;
@end

NS_ASSUME_NONNULL_END
