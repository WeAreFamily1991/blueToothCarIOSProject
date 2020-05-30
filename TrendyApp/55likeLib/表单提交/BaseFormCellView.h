//
//  BaseFormCellView.h
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "MYViewBase.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BaseFormCellViewProtocol <NSObject>

@required
- (void)addSimplicView;
- (void)addFCView;
@end


@interface BaseFormCellView : MYViewBase<BaseFormCellViewProtocol>


/**
 不会懒加载
 */
@property(nonatomic,strong)UITextField*myTextfield;
/**
提供 默认格式 的 ui 懒加载
 */
@property(nonatomic,strong)UITextField*defaultTextfield;
/**
 提供 默认格式 的 ui 懒加载 展示 name 字段
 */
@property(nonatomic,strong)UILabel*defaultNameLabel;
/**
 提供 默认格式 的 ui 懒加载 line
 */
@property(nonatomic,strong)UIView*defaultLineView;

/**
 字典格式数据 set方法用来初始化 get方法获取当前数据并得到 valueStr
 */
//@property(nonatomic,strong)NSMutableDictionary*dicformatData;
-(NSMutableDictionary*)getDataAndValueStrDic;


/**
 需要图片上传或者文件视频上传的 获取未上传数组

 @return 数组
 */
-(NSMutableArray*)getNoUploadImageViewArray;
/**
 set 方法用来设置数据 get 方法用来获取上传数据，格式都是自字符串 子类需要单独实现
 */
@property(nonatomic,strong)NSString*valueStr;

//外部不调用，内部使用

/**
 添加普通格式的ui 非编辑类
 */
-(void)addSimplicView;

//外部不调用，内部使用

/**
 设置编辑类格式的数据
 */
-(void)addFCView;
-(UITableView*)mysuperTableView;
@end

NS_ASSUME_NONNULL_END
