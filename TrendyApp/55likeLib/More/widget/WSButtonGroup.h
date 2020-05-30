//
//  WSButtonGroup.h
//  jinYingWu
//
//  Created by 55like on 11/08/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSButtonGroup;
typedef void (^WSButtonGroupBlock)(WSButtonGroup* group);


/**
 按钮群组的代理，用来监听选中变换
 */
@protocol WSButtonGroupdelegate <NSObject>
@optional

/**
 选中的按钮发生改变

 @param btnCrop 当前操作的按钮数组
 */
-(void)WSButtonGroupChange:(WSButtonGroup*)btnCrop;


/**
 选中的按钮点击时候就调用
 
 @param btnCrop 当前操作的按钮数组
 */
-(void)WSButtonGroupClick:(WSButtonGroup*)btnCrop;
//- (void)dropdownMenuDidShow:(listViewController *)menu;
@end

@interface WSButtonGroup : NSObject
-(void)addButton:(UIButton*)button;

/**
 所有的按钮数组
 */
@property(nonatomic,strong)NSMutableArray*buttonArray;

/**
 当前选中的按钮
 */
@property(nonatomic,weak)UIButton*currentSelectBtn;

/**
 当前选中的索引
 */
@property(nonatomic,assign)NSInteger currentindex;

/**
 按钮点击的时候调用，每次点击都要调用

 @param clickBlock 会掉每次点击都要回掉
 */
-(void)setGroupClickBlock:(WSButtonGroupBlock)clickBlock;

/**
 当前选中的按钮发生改变时候会调用

 @param ChangeBlock 只用选中按钮发生改变的时候才会调用
 */
-(void)setGroupChangeBlock:(WSButtonGroupBlock)ChangeBlock;

/**
 监听选中状态的代理实现
 */
@property(nonatomic,weak)id<WSButtonGroupdelegate> delegate;
-(void)btnClickAtIndex:(int)index;
@end
