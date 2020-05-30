//
//  MYViewBase.h
//  jinYingWu
//
//  Created by 55like on 2017/11/4.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYViewBase;
typedef void (^MYViewBaseBlock)(MYViewBase*baseView);
@interface MYViewBase : UIView
#pragma mark  - 初始化 绑定数据


@property(nonatomic,assign)BOOL isfirstInit;
/**
 控件的类型 根据类型来绑定数据或者设置frame
 */
@property(nonatomic,copy)NSString*type;
/**
 绑定的数据 可以是dic 可以是 实体类
 */
@property(nonatomic,copy)id bindData;

/**
 首次执行初始化控件，之后执行只会重新计算frame，设置frame
 */
-(void)initOrReframeView;

/**
 绑定数据 绑定数据之后如果frame 需要变换 调用 initOrReframeView
 
 @param data 数据对象 可以是实体类 字典 字符串
 @param type 控件的类型 根据类型来绑定数据或者设置frame
 */
-(void)bendData:(id)data withType:(NSString*)type;

/**
 重新调用 bendData:(id)data withType:(NSString*)type;函数
 如果用可变对象绑定的时候可以通过刷新进行重新调用
 */
-(void)refreshData;

/**
 是第一次绑定还是单纯的刷新
 */
@property(nonatomic,assign)BOOL isRefresh;


#pragma mark  - 事件交互

/**
 当前交互的view  同样的类型（MYViewBase） 如果是同级的话就是自己（只可能是自己的子代或者是自己）
 */
@property(nonatomic,weak)MYViewBase* subEvnetBaseView;
/**
 当前交互的view  同样的类型（MYViewBase） 如果是同级的话就是自己（ 可以是任意代 eventView 最近的）
 */
@property(nonatomic,weak)MYViewBase* currentEvnetBaseView;



/**
 所有的事件都要绑定此方法
 
 @param view 控件对象
 */
-(void)baseViewButtonClick:(UIView*)view;
/**
 当前点击到的view button lable imageview 都有可能
 */
@property(nonatomic,weak)id eventView;


/**
 点击事件回调blcok
 */
@property(nonatomic,copy)MYViewBaseBlock baseViewEventBlock;


/**
 添加交互事件
 
 @param obj target 对象
 @param selctor 需要执行的方法
 */
-(void)addBaseViewTarget:(id)obj select:(SEL)selctor;


//子控件点击 可以对事件进行拦截
-(void)subViewBeClick:(UIView*)subView withBaseView:(MYViewBase*)baseView;


/**
 把一个原生控件设置成为可以与baseView交互的view
 
 @param eventView eventView原生控件
 */
-(void)setEventBtn:(UIView*)eventView;

#pragma mark  - 类方法 创建方法

/**
 初始化 重用 view 第一次设置frame 第二次frame 也不设置 ，只是调用 initOrReframeView 方法
 
 @param frame 设置的frame 高度无效
 @param sView 父控件
 @param reuseID 重用id
 @return 返回实例对象
 */
+(instancetype)viewWithframe:(CGRect)frame supView:(UIView *)sView reuseId:(NSString*)reuseID;


///**
// 初始化 重用 view 第一次设置frame 第二次frame 也不设置 ，只是调用 initOrReframeView 方法
//
// @param frame 设置的frame 高度无效
// @param sView 父控件
// @param reuseID 重用id
// @return 返回实例对象
// */
//+(instancetype)xibviewWithframe:(CGRect)frame supView:(UIView *)sView reuseId:(NSString*)reuseID;
/**
 初始化 重用 view 第一次设置frame 第二次frame 也不设置 ，只是调用 initOrReframeView 方法
 
 @param frame 设置的frame 高度无效
 @param sView 父控件
 @param type view type
 @param reuseID 重用id
 @return 返回实例对象
 */
+(instancetype)viewWithframe:(CGRect)frame supView:(UIView *)sView type:(NSString*)type reuseId:(NSString*)reuseID;


//+(instancetype)getDedefaultView;

@end
