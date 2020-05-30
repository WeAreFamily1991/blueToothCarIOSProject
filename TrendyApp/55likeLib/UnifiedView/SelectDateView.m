//
//  SelectDateView.m
//  ZKwwlk
//
//  Created by junseek on 14-7-24.
//  Copyright (c) 2014年 五五来客. All rights reserved.
//

#import "SelectDateView.h"

@interface SelectDateView ()<SelectDateViewDelegate>{
    
}
@property(nonatomic,copy)AllcallBlock myblock;
@property (nonatomic, strong) UIWindow *overlayWindow;

@end
@implementation SelectDateView
@synthesize overlayWindow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=RGBACOLOR(0, 0, 0, 0.4);
        
        UIControl *closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [closeC addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeC];
        closeC.frameHeight=kScreenHeight-(216+64);
        
        
        UIImageView *im=[RHMethods imageviewWithFrame:CGRectMake(0, kScreenHeight-(216+44), kScreenWidth, 44) defaultimage:@""];
        im.backgroundColor=rgbGray;
        [self addSubview:im];
        [RHMethods lineViewWithFrame:CGRectMake(0, YH(im)-0.5, kScreenHeight, 0.5) supView:self];
        UIButton *closeBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn1.frame=CGRectMake(20,  Y(im), 120, 44);
        [closeBtn1 setTitle:@"取消" forState:UIControlStateNormal];
        [closeBtn1 setTitleColor:rgbpublicColor forState:UIControlStateNormal];
        [closeBtn1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [closeBtn1 addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn1];
        
        UIButton *OKBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        OKBtn1.frame=CGRectMake(kScreenWidth-140,  Y(im), 120, 44);
        [OKBtn1 setTitle:@"确定" forState:UIControlStateNormal];
        [OKBtn1 setTitleColor:rgbpublicColor forState:UIControlStateNormal];
        [OKBtn1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [OKBtn1 addTarget:self action:@selector(OkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:OKBtn1];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,YH(im),kScreenWidth,216)];
        //设置中文显示
        NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
        [_datePicker setLocale:locale];
//        _datePicker.minimumDate=[NSDate date];
        //            [[UIDatePicker appearance] setTintColor:RGBCOLOR(245, 245, 245)];
        _datePicker.backgroundColor = rgbGray;//RGBCOLOR(236, 234, 240);
        _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT-8"];
        [self addSubview:_datePicker];
        
        
        
    }
    return self;
}
-(void)closeButtonClicked{
    [self hidden];
}
-(void)OkButtonClicked{
    //发
    if ([self.delegate respondsToSelector:@selector(select:object:)]) {
        if ([self.strType isEqualToString:@"xsUpdate"]) {
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:self.strId forKey:@"strId"];
            [dic setValue:[NSString stringWithFormat:@"%f",[_datePicker.date timeIntervalSince1970]] forKey:@"date"];
            
            [self.delegate select:self object:dic];
            
        }else{
            
            [self.delegate select:self object:_datePicker.date];
        }
    }
    
    [self hidden];
}
- (void)show
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidden) name:@"push_showLogin" object:nil];
    
    
    [self.overlayWindow addSubview:self];
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
    if ([self.strType isEqualToString:@"Birthday"]) {
        //生日
        _datePicker.minimumDate=nil;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.maximumDate=[NSDate date];
    }else if ([self.strType isEqualToString:@"timeUpdateOrder"]){
        NSInteger time_t=[[NSDate date] timeIntervalSince1970];
        NSDate *dateT=[NSDate dateWithTimeIntervalSince1970:time_t+60*30];
        NSDate *datemax=[NSDate dateWithTimeIntervalSince1970:time_t+60*30+3*24*3600];
        _datePicker.minimumDate=dateT;
        _datePicker.maximumDate=datemax;
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        if (self.strTime && [self.strTime notEmptyOrNull]) {
            NSDate *dateTemp=[NSDate dateWithTimeIntervalSince1970:[self.strTime integerValue]];
            [_datePicker setDate:[dateT laterDate:dateTemp] animated:YES];
        }
    }else{
        _datePicker.maximumDate=nil;
        _datePicker.minimumDate=nil;
        _datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    }
    
    if (self.strTime && [self.strTime notEmptyOrNull] && ![self.strType isEqualToString:@"timeUpdateOrder"]) {
        NSDate *dateT=[NSDate dateWithTimeIntervalSince1970:[self.strTime integerValue]];
        [_datePicker setDate:dateT animated:YES];
        
    }else{
        if ([self.strType isEqualToString:@"Birthday"]) {//3600/24/365/25
            NSInteger time_t=[[NSDate date] timeIntervalSince1970];
            NSDate *dateT=[NSDate dateWithTimeIntervalSince1970:time_t-25*3600*24*365];
            [_datePicker setDate:dateT animated:YES];
        }
    }
    
    
    
    self.hidden = NO;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showMe
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidden) name:@"push_showLogin" object:nil];
    
    [self.overlayWindow addSubview:self];
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];

    self.hidden = NO;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidden
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (self.myblock) {
            [self removeFromSuperview];
        }
        [overlayWindow removeFromSuperview];
        overlayWindow = nil;
    }];
}
-(void)select:(SelectDateView *)sview object:(id)dic{
    
 NSString*  strDateTemp=[NSString stringWithFormat:@"%f",[dic timeIntervalSince1970]];
    if (_myblock) {
        _myblock(strDateTemp,200,nil);
    }
}
+(SelectDateView*)showWithTime:(NSString*)currentimestr withCallBack:(AllcallBlock)block{

    SelectDateView*  dateView=[[SelectDateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    dateView.delegate=dateView;
    dateView.myblock=block;
    dateView.strTime=currentimestr;
    [dateView showMe];
    
    [dateView.datePicker setDate:[NSDate dateWithTimeIntervalSince1970:[currentimestr integerValue]] animated:YES];
    
    return dateView;
}
+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    s_view.backgroundColor=rgbGray;

    {
        //        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"月日时间选择" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        UILabel*lbtime=[RHMethods RlableRX:10 Y:yAdd+10 W:kScreenWidth-20 Height:40 font:15 superview:s_view withColor:nil text:@"年月日选择"];
        lbtime.backgroundColor=[UIColor whiteColor];
        [lbtime addViewClickBlock:^(UIView *view) {
            UILabel*currentlb=(UILabel*)view;
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSDate *dateT=[dateFormatter dateFromString:currentlb.text];
            if ([currentlb.text isEqualToString:@"年月日选择"]) {
                dateT=[NSDate date];
            }
            
            SelectDateView *dateView=[SelectDateView showWithTime:[NSString stringWithFormat:@"%f",[dateT timeIntervalSince1970]] withCallBack:^(id data, int status, NSString *msg) {
                
                NSString*timestr= [dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970:[data integerValue]]];
                //                [currentlb setTitle:timestr forState:UIControlStateNormal];
                currentlb.text=timestr;
                
            }];
//            dateView.datePicker.minimumDate=nil;
            dateView.datePicker.datePickerMode = UIDatePickerModeDate;
//            dateView.datePicker.maximumDate=[NSDate date];
        }];
        
        
        yAdd=lbtime.frameYH+10;
    }
    {
        //        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"月日时间选择" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        UILabel*lbtime=[RHMethods RlableRX:10 Y:yAdd+10 W:kScreenWidth-20 Height:40 font:15 superview:s_view withColor:nil text:@"月日时间选择"];
        lbtime.backgroundColor=[UIColor whiteColor];
        [lbtime addViewClickBlock:^(UIView *view) {
            UILabel*currentlb=(UILabel*)view;
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSDate *dateT=[dateFormatter dateFromString:currentlb.text];
            if ([currentlb.text isEqualToString:@"月日时间选择"]) {
                dateT=[NSDate date];
            }
            
            SelectDateView *dateView=[SelectDateView showWithTime:[NSString stringWithFormat:@"%f",[dateT timeIntervalSince1970]] withCallBack:^(id data, int status, NSString *msg) {
                
                NSString*timestr= [dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970:[data integerValue]]];
                //                [currentlb setTitle:timestr forState:UIControlStateNormal];
                currentlb.text=timestr;
                
            }];
//            dateView.datePicker.minimumDate=nil;
            dateView.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//            dateView.datePicker.maximumDate=[NSDate date];
        }];
        
        
        yAdd=lbtime.frameYH+10;
    }
    {
        //        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"月日时间选择" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        UILabel*lbtime=[RHMethods RlableRX:10 Y:yAdd+10 W:kScreenWidth-20 Height:40 font:15 superview:s_view withColor:nil text:@"时间选择"];
        lbtime.backgroundColor=[UIColor whiteColor];
        [lbtime addViewClickBlock:^(UIView *view) {
            UILabel*currentlb=(UILabel*)view;
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSDate *dateT=[dateFormatter dateFromString:currentlb.text];
            if ([currentlb.text isEqualToString:@"时间选择"]) {
                dateT=[NSDate date];
            }
            
            SelectDateView *dateView=[SelectDateView showWithTime:[NSString stringWithFormat:@"%f",[dateT timeIntervalSince1970]] withCallBack:^(id data, int status, NSString *msg) {
                
                NSString*timestr= [dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970:[data integerValue]]];
                //                [currentlb setTitle:timestr forState:UIControlStateNormal];
                currentlb.text=timestr;
                
            }];
//            dateView.datePicker.minimumDate=nil;
            dateView.datePicker.datePickerMode = UIDatePickerModeTime;
//            dateView.datePicker.maximumDate=[NSDate date];
        }];
        
        
        yAdd=lbtime.frameYH+10;
    }
 
    
}


#pragma mark - Getters
- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = YES;
        overlayWindow.windowLevel = UIWindowLevelStatusBar-1;
    }
    overlayWindow.hidden=NO;
    return overlayWindow;
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
