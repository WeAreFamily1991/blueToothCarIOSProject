//
//  WSSizeButton.h
//  HairDressing
//
//  Created by 55like on 22/03/2017.
//  Copyright © 2017 55like. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSSizeButton;
typedef CGRect (^ButtonSize)(WSSizeButton*btn);

@class WSSizeButton;

@interface WSSizeButton : UIButton
-(void)setImageviewColor:(UIColor *)color forState:(UIControlState)state;

-(void)setBackGroundImageviewColor:(UIColor *)color forState:(UIControlState)state;


/**
 设置图片
 
 @param imageStr 图片字符串
 @param seletImagStr 选中图片的字符串
 */
-(void)setImageStr:(NSString*)imageStr SelectImageStr:(NSString*)seletImagStr;

/**
 设置按钮的lable位置
 */
@property(nonatomic,assign)CGRect btnLableFrame;

/**
 设置按钮的 图片 位置
 */
@property(nonatomic,assign)CGRect btnImageViewFrame;



@property(nonatomic,copy)ButtonSize imageviewsize;

@property(nonatomic,copy)ButtonSize lableviewSize;

@property (nonatomic, assign) CGFloat lbframeX;
@property (nonatomic, assign) CGFloat lbframeY;
@property (nonatomic, assign) CGFloat lbcenterX;
@property (nonatomic, assign) CGFloat lbcenterY;
@property (nonatomic, assign) CGFloat lbframeWidth;
@property (nonatomic, assign) CGFloat lbframeHeight;
@property (nonatomic, assign) CGSize lbframeSize;
@property (nonatomic, assign) CGPoint lbframeOrigin;
@property(nonatomic,assign)CGFloat lbframeXW;
@property(nonatomic,assign)CGFloat lbframeYH;
@property(nonatomic,assign)CGFloat lbframeRX;
@property(nonatomic,assign)CGFloat lbframeBY;
-(void)lbbeCenter;
-(void)lbbeCX;
-(void)lbbeCY;
-(void)lbbeRound;

@property (nonatomic, assign) CGFloat imgframeX;
@property (nonatomic, assign) CGFloat imgframeY;
@property (nonatomic, assign) CGFloat imgcenterX;
@property (nonatomic, assign) CGFloat imgcenterY;
@property (nonatomic, assign) CGFloat imgframeWidth;
@property (nonatomic, assign) CGFloat imgframeHeight;
@property (nonatomic, assign) CGSize imgframeSize;
@property (nonatomic, assign) CGPoint imgframeOrigin;
@property(nonatomic,assign)CGFloat imgframeXW;
@property(nonatomic,assign)CGFloat imgframeYH;
@property(nonatomic,assign)CGFloat imgframeRX;
@property(nonatomic,assign)CGFloat imgframeBY;
-(void)imgbeCenter;
-(void)imgbeCX;
-(void)imgbeCY;
-(void)imgbeRound;
@end

