//
//  UtilitySelectTime.h
//  TrendyApp
//
//  Created by 55like on 2019/3/14.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYBaseService.h"

#define kUtilitySelectTime [UtilitySelectTime shareInstence]
NS_ASSUME_NONNULL_BEGIN

@interface UtilitySelectTime : MYBaseService

/**
 当前选中状态 extend 延长  advance 提前还车 nil 为其他
 */
@property(nonatomic,copy)NSString*currentSelectType;


@property(nonatomic,strong,nullable)id selectStartTime;
@property(nonatomic,strong,nullable)id selectEndTime;
@property(nonatomic,strong,nullable)id selectTempTime;
///标记不能选择起点（选择了起始点后，这个点为第一个全部预约或不可以预约点，之后的点都不能选择）
@property(nonatomic,strong,nullable)id noSelectTime;

@property(nonatomic,strong,nullable)id selectCarId;

/**
 home 选中时间
 */
@property(nonatomic,strong,nullable)id selectHomeDate;


/**
 格式提交参数（选择时间确认参数）
 
 @param ashow 是否提示
 */
-(id)updateFormatSubDataWithShowTip:(BOOL)ashow;

@end

NS_ASSUME_NONNULL_END
