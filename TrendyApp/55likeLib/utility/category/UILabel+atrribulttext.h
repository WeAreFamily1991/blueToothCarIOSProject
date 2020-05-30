//
//  UILabel+atrribulttext.h
//  GangFuBao
//
//  Created by home on 15/12/6.
//  Copyright © 2015年 55like. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZHLlabelColor,        // 颜色
    ZHLlabelFont,         // 字体大小
    ZHLlabelLine,          // 带斜线
    ZHLlabelDownLine,      //下划线
    ZHLlabelBackColor,     // 背景颜色
    ZHLlabelshadow,          // 阴影
    ZHLlabelsloping          //字体倾斜
    
} ZHLLabelType;

@interface UILabel (atrribulttext)

/**
 放置图片的
 
 @param t_image 目标颜色
 @param t_size 目标大小
 @param t_index 目标下标
 */
-(void)setImage:(UIImage *)t_image contentSize:(CGSize)t_size atIndex:(NSInteger)t_index;
/**
 局部文字颜色变化
 
 @param textcoler 目标颜色
 @param text 目标文字
 */
-(void)setColor:(UIColor *)textcoler contenttext:(NSString*)text;
/**
 局部文字颜色变化
 
 @param textcoler 目标颜色
 @param textFont 目标字体
 @param text 目标文字
 */
-(void)setColor:(UIColor *)textcoler font:(UIFont *)textFont contenttext:(NSString*)text;
/**
 局部文字颜色变化
 @param textcoler 目标颜色
 @param textFont 目标字体
 @param text 目标文字
 @param a_bool 目标文字是否循环全部
 */
-(void)setColor:(UIColor *)textcoler font:(UIFont *)textFont contenttext:(NSString *)text CycleText:(BOOL)a_bool;
/**
 文字行间距
 
 @param lineS 目标行间距
 */
-(void)setAllTextLineSpacing:(CGFloat)lineS;

//ZHLlabelColor,        // 颜色
//ZHLlabelFont,         // 字体大小
//ZHLlabelLine,          // 带斜线
//ZHLlabelDownLine,      //下划线
//ZHLlabelBackColor,     // 背景颜色
//ZHLlabelshadow,          // 阴影
//ZHLlabelsloping          //字体倾斜
-(void)labelSetColorWithAttributedStringType:(ZHLLabelType)type textstr:(NSString *)text content:(id)content location:(NSInteger)loc length:(NSInteger)len;

/**
 *  改变行间距
 */
- (void)changeLineSpaceForLabelWithSpace:(float)space;

/**
 *  改变字间距
 */
-(void)changeWordSpaceForLabelWithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
-(void)changeSpaceForLabelWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


///改变lbl宽度
-(void)changeLabelWidth;
///改变lbl高度
-(void)changeLabelHeight;

@end
