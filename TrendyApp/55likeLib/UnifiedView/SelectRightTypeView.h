//
//  SelectRightTypeView.h
//  ZhuiKe55like
//
//  Created by junseek on 15/11/11.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//
/*
 右上角黑色底类别选择
 @“headTcBg_20151111”背景图片
 
 
 */

@class SelectRightTypeView;
@protocol SelectRightTypeViewDelegate <NSObject>

@optional  //可选
-(void)selectRightTypeView:(SelectRightTypeView *)sview object:(NSDictionary * )dic index:(NSIndexPath *)indexPath;

@end

#import <UIKit/UIKit.h>

typedef void (^SelectRightTypeViewBlock)(NSDictionary *dicSelect);
@interface SelectRightTypeView : UIView

@property (nonatomic, strong) SelectRightTypeViewBlock rightType;
@property (nonatomic, weak) id<SelectRightTypeViewDelegate> delegate;


/**
 @{
    @“list”:@[@{@"image":@"",@"title":@"xxxx"}...]
    @"type":@"xxxxx"
 } 
 */
@property (strong,nonatomic) NSDictionary *dicType;
@property (assign,nonatomic) BOOL contentConter;//内容是否居中

- (void)show;
- (void)showRightTypeBlock:(SelectRightTypeViewBlock)aTypeBlock;
- (void)hidden;

@end
