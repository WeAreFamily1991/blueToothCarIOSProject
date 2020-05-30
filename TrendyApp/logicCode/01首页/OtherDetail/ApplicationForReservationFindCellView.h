//
//  ApplicationForReservationFindCellView.h
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYViewBase.h"
#import "MyXibView.h"
#import "SwichButtonView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplicationForReservationFindCellView : MyXibView


@property (strong, nonatomic)SwichButtonView *swich1;
@property (strong, nonatomic)SwichButtonView *swich2;

/**
 获取上传数据回调（确认订单页面使用）

 @param aBlock 回调内容
 */
-(void)getRequestDataBlock:(AllcallBlock)aBlock;

/**
 显示 弹框 消息
 */
@property(nonatomic,assign)BOOL showMessage;


-(void)updateData;

@property(nonatomic,copy)AllcallBlock updataMyBlock;

@end

NS_ASSUME_NONNULL_END
