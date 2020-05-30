//
//  MYRHTableView.h
//  jinYingWu
//
//  Created by 55like on 2017/11/8.
//  Copyright © 2017年 55like lj. All rights reserved.
//
@class MYRHTableView;
#import "RHTableView.h"
#import "WsUseweekObj.h"

@class SectionObj;
typedef UIView* (^SectionReUseViewBlock)(UIView*reuseView, id Datadic,NSInteger row);
typedef UIView* (^SectionReUseViewBlock_indexP)(UIView*reuseView, id Datadic,NSIndexPath * indexP);
typedef void (^SectionIndexClickBlock)(id Datadic,NSInteger row);
@interface SectionObj : NSObject
@property(nonatomic,weak)MYRHTableView*mytableview;

/**
 tableview 的头
 */
@property(nonatomic,strong)UIView*selctionHeaderView;

/**
 tableView 的尾部
 */
@property(nonatomic,strong)UIView*selctionFooterView;

/**
 tableView的 数据
 */
@property(nonatomic,strong)NSArray*dataArray;
/**
 没有重用的viewArray 如果设置之后
 dataArray 就无效了，
 sectionreUseViewBlock 也是无效
 */
@property(nonatomic,strong)NSMutableArray<UIView*>*noReUseViewArray;

/**
 tableview 每个cell显示的view
 */
@property(nonatomic,copy)SectionReUseViewBlock sectionreUseViewBlock;
@property(nonatomic,copy)SectionReUseViewBlock_indexP sectionreUseViewBlock_indexP;

/**
 tableview 选中的时候的回调
 */
@property(nonatomic,copy)SectionIndexClickBlock sectionIndexClickBlock;

/**
 tableview 每个cell的高度，如果不设置则通过cell 上显示的view 确定
 */
@property(nonatomic,assign)float cellHeight;
#pragma mark  自定义的创建方法 类方法
+(SectionObj*)SectionWithTableView:(MYRHTableView*)tableView DataArray:(NSArray*)dataArray WithReUseViewBlock:(SectionReUseViewBlock)block;
+(SectionObj*)SectionWithTableView:(MYRHTableView*)tableView DataArray:(NSArray*)dataArray WithReUseViewBlock_index:(SectionReUseViewBlock_indexP)block;
+(SectionObj*)SectionWithTableView:(MYRHTableView*)tableView DataArray:(NSArray*)dataArray WithReUseViewBlock:(SectionReUseViewBlock)block WithsectionIndexClickBlock:(SectionIndexClickBlock)sectionblock;

//+(MYv)
@end
@interface MYRHTableView : RHTableView

+(BOOL)isRefreshOnlySize;
+(void)SetIsRefreshOnlySize:(BOOL)isRefreshOnlySize;

/**
 SectionObj 的数组
 */
@property(nonatomic,strong)NSMutableArray*sectionArray;

/**
 默认的Section obj 如果没有设置的话默认是sectionArray中的第一个
 懒加载会自动创建
 */
@property(nonatomic,weak)SectionObj*defaultSection;
//@property(nonatomic,weak)SectionObj*defue;

+(NSMutableArray*)fArrayWithCont:(NSInteger)number;

@end
