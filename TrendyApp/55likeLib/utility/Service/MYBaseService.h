//
//  OrderService.h
//  HanBaApp
//
//  Created by 55like on 2018/1/11.
//  Copyright © 2018年 55like. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 这个类的功是单例，全局都能获取，
 其子类可以添加属性用来存储数据，添加方法派发事件通知；（此类不直接使用必须被继承）
 其他对象可以监听他的事件，派发事件后 每个被添加的对象都可以收到事件通知
 */
@class MYBaseService;

typedef void (^MYBaseServicecallBlock)(MYBaseService*obj);
@interface MYBaseService : NSObject

/**
 单例获取
 */
+(instancetype)shareInstence;




/**
 当前事件传递的数据
 */
@property(nonatomic,strong)id currentEventData;

/**
 当前事件的提示语句
 */
@property(nonatomic,copy)NSString*currentEventMsg;
@property(nonatomic,assign)int currentEventStatus;
/**
 当前事件的类型
 */
@property(nonatomic,copy)NSString*currentEvnetType;





/**
 派发事件
 
 @param evnetType 事件类型
 @param actionData 事件参数
 */
-(void)dispatchEventWithActionType:(NSString*)evnetType actionData:(id)actionData;

/**
 添加事件监听
 
 @param obj 事件监听者的对象
 @param actionTypeArray 所监听事件的类型数组 如果为空的时候监听所有事件
 @param reUseID 重用id 防止一个对象多次添加 为空的时候可以多次添加
 @param evenBlock 事件回掉block
 */
-(void)addEventWithObj:(id)obj actionTypeArray:(NSArray*)actionTypeArray reUseID:(NSString*)reUseID WithBlcok:(MYBaseServicecallBlock)evenBlock;
/**
 添加事件监听
 
 @param obj 事件监听者的对象
 @param actionTypeArray 所监听事件的类型数组 如果为空的时候监听所有事件
 @param reUseID 重用id 防止一个对象多次添加 为空的时候可以多次添加
 @param eventSelector 事件回掉block
 */
-(void)addEventWithObj:(id)obj actionTypeArray:(NSArray*)actionTypeArray reUseID:(NSString*)reUseID WitheventSelector:(SEL)eventSelector;

#pragma mark  网络请求部分

/**
 请求网络分的默认方法，网络请求添加了一层实现逻辑，主要目的就是为了能够在网络请求数据到达程序内部的时候能够多一层处理
 每个逻辑服务了里面可以根据apiStr进行单独处理，如果没有进行单独处理的话就用默认方法不处理（因为大部分的情况下是不需要处理的，减少了无用的代码的）
 
 @param apiStr 请求接口的地址
 @param param 需要穿进去的参数
 @param block 网络请求回调，成功的话status是200，网络错误是status是1001，其他的是服务器返回的错误
 */
-(void)loadDataWithApi:(NSString*)apiStr withParam:(NSMutableDictionary*)param withBlock:(AllcallBlock)block;

//网络请求的链式写法
@property (nonatomic,copy
           ,readonly) MYBaseService *(^ apiUrl)(NSString* apiUrl);
@property (nonatomic,copy,readonly) MYBaseService *(^ paraDic)(NSMutableDictionary* paraDic);

@property (nonatomic,copy,readonly) MYBaseService *(^ allBlock)(AllcallBlock allBlock);

@property (nonatomic,copy,readonly) MYBaseService *(^ success)(void (^successBlock)(id data,NSString*msg));
@property (nonatomic,copy,readonly) MYBaseService *(^ erro)(AllcallBlock erroBlock);
//默认 SVProgressHUDMaskTypeClear
@property (nonatomic,copy,readonly) MYBaseService *(^ masktyp)(SVProgressHUDMaskType masktyp);
//隐藏错误提示
@property (nonatomic,copy,readonly) MYBaseService *(^ hiddenErrMSG)();


/**
 这种写法的好处是 参数的数量没有限制 参数的顺序没有限制 可扩展性强 容易优化
 [MYBaseService shareInstence].apiUrl(@"mm/list").success(^(id data) {
 
 }).erro(^(id data, int status, NSString *msg) {
 
 }).paraDic(nil).startload;
 */

@property (nonatomic,copy,readonly) void (^ startload)();
//-(void)startload;

@end



