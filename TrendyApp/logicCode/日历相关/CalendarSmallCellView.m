
//
//  CalendarSmallCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/8.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CalendarSmallCellView.h"
#import "TimeSelectPopView.h"
#import "UtilitySelectTime.h"
@interface CalendarSmallCellView()
{
    
}
@property(nonatomic,strong)UIImageView*bgImageView;
@property(nonatomic,strong)UILabel*showLable;
@property(nonatomic,strong)UILabel*priceLable;
@end
@implementation CalendarSmallCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth= (kScreenWidth-10)/7;
    }
    if (self.frameHeight==0) {
        self.frameHeight=self.frameWidth*86.0/51.0;
    }
    if (self.isfirstInit) {
        __weak typeof(self) weakSelf=self;
        float width=self.frameWidth*40/51.0;
//        UIView *viewBG=[RHMethods viewWithFrame:CGRectMake(0, 0, 10, width) backgroundcolor:rgbHexColor(@"00729e") superView:self];
//        viewBG.hidden=YES;
        UIImageView*bgImageView=[RHMethods imageviewWithFrame:CGRectMake(0, 0, width, width) defaultimage:@"datebg" supView:self];
        [bgImageView beCX];
        [bgImageView beRound];
        UILabel*showLable=[RHMethods ClableY:0 W:width - 8 Height:width font:15 superview:self withColor:rgb(51,51,51) text:@"名称"];
        [showLable beCX];
        showLable.adjustsFontSizeToFitWidth = YES;
        UILabel*priceLable=[RHMethods ClableY:bgImageView.frameYH+12*self.frameWidth/51.0 W:self.frameWidth Height:12 font:12 superview:self withColor:rgb(153, 153, 153) text:@"￥1256"];
        priceLable.adjustsFontSizeToFitWidth=YES;
        
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 22, 1) backgroundcolor:rgb(204, 204, 204) superView:self];      
        viewLine.center=bgImageView.center;
        viewLine.transform =  CGAffineTransformMakeRotation(M_PI_2*0.5);
        
        [kUtilitySelectTime addEventWithObj:self actionTypeArray:@[@"updateSelectTime"] reUseID:@"CalendarSmallCellView" WithBlcok:^(MYBaseService *obj) {
            [weakSelf upDataMe];
        }];
        
        _bgImageView=bgImageView;
        _showLable=showLable;
        _priceLable=priceLable;
        _priceLable.adjustsFontSizeToFitWidth=YES;
        
        showLable.adjustsFontSizeToFitWidth = YES;
        showLable.numberOfLines = 1;
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            NSString*showStr=[data ojsk:@"showStr"];
            showLable.text=showStr;
            showLable.textColor=rgb(153, 153, 153);
            priceLable.textColor=rgb(153, 153, 153);
            priceLable.hidden=NO;
            bgImageView.hidden=NO;
            viewLine.hidden=YES;
//            viewBG.hidden=YES;
            if ([weakSelf.type isEqualToString:@"homeSelectTime"]) {
                priceLable.hidden=YES;
                viewLine.hidden=YES;
                //判断时间是否小于今天
                if ([weakSelf compareOneDay:[data ojsk:@"formatStr"] ]>=0) {
                    showLable.textColor=rgbTitleColor;
                    bgImageView.image=[UIImage imageNamed:@"datebg"];
                }else{
                    showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                    bgImageView.hidden=YES;
                }
                
                //判断时间------开始时间
                if (kUtilitySelectTime.selectStartTime) {
                    //开始时间有了
                    int sTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"]];
                    if (sTime==0) {
                        //等于开始时间
                        showLable.textColor=rgbwhiteColor;
                        bgImageView.image=[UIImage imageNamed:@"datebg1"];
//                        if (kUtilitySelectTime.selectEndTime) {
//                            int EndTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"]];
//                            if (EndTime<0) {
//                                //结束时间较大
//                                viewBG.hidden=NO;
//                                viewBG.frame=CGRectMake(X(bgImageView), Y(bgImageView), W(weakSelf)-X(bgImageView), H(bgImageView));
//                                //圆角
//                                //得到view的遮罩路径
//                                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewBG.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(W(bgImageView)/2,W(bgImageView)/2)];
//                                //创建 layer
//                                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//                                maskLayer.frame = viewBG.bounds;
//                                //赋值
//                                maskLayer.path = maskPath.CGPath;
//                                viewBG.layer.mask = maskLayer;
//
//                            }
//                        }
                    }else if(sTime>0 && kUtilitySelectTime.selectEndTime){
                        //结束时间
                        int EndTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"]];
                        if (EndTime<0) {
                            //小于结束时间
                            showLable.textColor=rgbwhiteColor;
                            bgImageView.image=[UIImage imageNamed:@"datebg1"];
                            
//                            viewBG.hidden=NO;
//                            viewBG.frame=CGRectMake(0, Y(bgImageView), W(weakSelf), H(bgImageView));
//                            viewBG.layer.mask = nil;
                        }else if (EndTime==0){
                            //
                            showLable.textColor=rgbwhiteColor;
                            bgImageView.image=[UIImage imageNamed:@"datebg1"];
                            
//                            viewBG.hidden=NO;
//                            viewBG.frame=CGRectMake(0, Y(bgImageView), XW(bgImageView), H(bgImageView));
//                            //圆角
//                            //得到view的遮罩路径
//                            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewBG.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(W(bgImageView)/2,W(bgImageView)/2)];
//                            //创建 layer
//                            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//                            maskLayer.frame = viewBG.bounds;
//                            //赋值
//                            maskLayer.path = maskPath.CGPath;
//                            viewBG.layer.mask = maskLayer;
                        }
                    }
                }
            }else if ([weakSelf.type isEqualToString:@"服务器数据"]) {
                priceLable.hidden=YES;
                viewLine.hidden=YES;
                if (![showStr notEmptyOrNull]) {
                    showStr=[weakSelf.serverData ojsk:@"day"];
                }
                showLable.text=showStr;
//                [showLable ]
                /*
                 calendar.date    字符串    日期(年月日)
                 calendar.day    字符串    几号
                 calendar.weekday    字符串    星期几
                 calendar.timestamp    字符串    时间戳
                 calendar.today    字符串    1 过去日子 2 今天 3 未来日子
                 calendar.status    字符串    1 可预约 2 部分可预约 3 不可预约 4 全天已预约
                 calendar.price    字符串    价格
                 */
                //判断时间是否小于今天
                int bToday=[weakSelf compareOneDay:[weakSelf.serverData ojsk:@"date"] ];
                if (bToday==0) {
                    showLable.text=kS(@"setting_take_and_return_time", @"selectToday");
                }
                if (bToday>=0) {
                    //isholiday 0 平日价 1 节日假
                    if ([[weakSelf.serverData ojsk:@"isholiday"] isEqualToString:@"1"]) {
                        priceLable.textColor=rgbRedColor;
                    }
                    if ([[weakSelf.serverData ojsk:@"status"] isEqualToString:@"1"]) {
                        showLable.textColor=rgbTitleColor;
                        bgImageView.image=[UIImage imageNamed:@"datebg"];
                        priceLable.hidden=NO;
                        priceLable.text=[NSString stringWithFormat:@"￥%@",[weakSelf.serverData ojsk:@"price"]];
                    }else if ([[weakSelf.serverData ojsk:@"status"] isEqualToString:@"2"]) {
                        showLable.textColor=rgbTitleColor;
                        bgImageView.image=[UIImage imageNamed:@"memtimei1"];
                        priceLable.hidden=NO;
                        priceLable.text=[NSString stringWithFormat:@"￥%@",[weakSelf.serverData ojsk:@"price"]];
                    }else if ([[weakSelf.serverData ojsk:@"status"] isEqualToString:@"3"]) {
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                    }else {
                        //  4 全天已预约
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                    }
                }else{
                    showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                    bgImageView.hidden=YES;
                }
                
            }else if ([weakSelf.type isEqualToString:@"申请预订"]) {
//                @"申请预订"
                priceLable.hidden=YES;
                viewLine.hidden=YES;
//                priceLable.numberOfLines
                
                //判断时间是否小于今天
                int bToday=[weakSelf compareOneDay:[data ojsk:@"formatStr"]];
                if (bToday>=0) {
                    id dataServer=[data ojk:@"dataServer"];
                    //isholiday 0 平日价 1 节日假
                    if ([[dataServer ojsk:@"isholiday"] isEqualToString:@"1"]) {
                        priceLable.textColor=rgbRedColor;
                    }
                    //status    字符串    1 可预约 2 部分可预约 3 不可预约 4 全天已预约
                    if ([[dataServer ojsk:@"status"] isEqualToString:@"1"]) {
                        showLable.textColor=rgbTitleColor;
                        bgImageView.image=[UIImage imageNamed:@"datebg"];
                        priceLable.hidden=NO;
                        priceLable.text=[NSString stringWithFormat:@"￥%@",[dataServer ojsk:@"price"]];
                        if (kUtilitySelectTime.noSelectTime) {
                            //判断时间大小
                            int noTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.noSelectTime ojsk:@"formatStr"]];
                            if (noTime>=0) {
                                showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                                bgImageView.hidden=YES;
                            }
                        }
                    }else if ([[dataServer ojsk:@"status"] isEqualToString:@"2"]) {
                        showLable.textColor=rgbTitleColor;
                        bgImageView.image=[UIImage imageNamed:@"memtimei1"];
                        priceLable.hidden=NO;
                        priceLable.text=[NSString stringWithFormat:@"￥%@",[dataServer ojsk:@"price"]];
                        if (kUtilitySelectTime.noSelectTime) {
                            //判断时间大小
                            int noTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.noSelectTime ojsk:@"formatStr"]];
                            if (noTime>=0) {
                                showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                                bgImageView.hidden=YES;
                            }
                        }
                    }else if ([[dataServer ojsk:@"status"] isEqualToString:@"3"]) {
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                        if (kUtilitySelectTime.selectStartTime && !kUtilitySelectTime.noSelectTime) {
                            NSDictionary*dict=kUtilitySelectTime.selectStartTime;
                            int sTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"]];
                            //标记可选范围
                            if (sTime>0) {
                                kUtilitySelectTime.noSelectTime=data;
                            }
                        }
                    }else {
                        //  4 全天已预约
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                        if (kUtilitySelectTime.selectStartTime && !kUtilitySelectTime.noSelectTime) {
                            int sTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"]];
                            //标记可选范围
                            if (sTime>0) {
                                kUtilitySelectTime.noSelectTime=data;
                            }
                        }
                    }
                    //判断时间------开始时间
                    if (kUtilitySelectTime.selectStartTime&&![kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]) {
                        //开始时间有了
                        int sTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"]];
                        if (sTime==0) {
                            //等于开始时间
                            showLable.textColor=rgbwhiteColor;
                            bgImageView.image=[UIImage imageNamed:@"datebg1"];
                            bgImageView.hidden=NO;
                            
                        }else if(sTime>0 && kUtilitySelectTime.selectEndTime){
                            //结束时间
                            int EndTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"]];
                            if (EndTime<0) {
                                //小于结束时间
                                showLable.textColor=rgbwhiteColor;
                                bgImageView.image=[UIImage imageNamed:@"datebg1"];
                                bgImageView.hidden=NO;
                                
                            }else if (EndTime==0){
                                //
                                showLable.textColor=rgbwhiteColor;
                                bgImageView.image=[UIImage imageNamed:@"datebg1"];
                                bgImageView.hidden=NO;
                            }
                        }
                    }
                    if (kUtilitySelectTime.selectEndTime&&[kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]) {
                        //结束时间
                        int EndTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"]];
                        if (EndTime==0){
                            //
                            showLable.textColor=rgbwhiteColor;
                            bgImageView.image=[UIImage imageNamed:@"datebg1"];
                            bgImageView.hidden=NO;
                        }
                    }
                    
                }else{
                    showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                    bgImageView.hidden=YES;
                }
                if ([kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]) {
                    priceLable.hidden=YES;
                }
                
            }else if ([weakSelf.type isEqualToString:@"unRentableTime"]) {
                //不可租时间和申请预约的显示规则一模一样
                priceLable.hidden=YES;
                viewLine.hidden=YES;
                weakSelf.userInteractionEnabled=NO;
                //判断时间是否小于今天
                int bToday=[weakSelf compareOneDay:[data ojsk:@"formatStr"]];
                if (bToday>=0) {
                    id dataServer=[data ojk:@"dataServer"];
                    //isholiday 0 平日价 1 节日假
                    if ([[dataServer ojsk:@"isholiday"] isEqualToString:@"1"]) {
                        priceLable.textColor=rgbRedColor;
                    }
                    //status    字符串    1 可预约 2 部分可预约 3 不可预约 4 全天已预约
                    if ([[dataServer ojsk:@"status"] isEqualToString:@"1"]) {
                        
                        weakSelf.userInteractionEnabled=YES;
                        [weakSelf setEventBtn:weakSelf];
                        [weakSelf setAddValue:@"unRentableTime" forKey:@"actionType"];
                        showLable.textColor=rgbTitleColor;
//                        bgImageView.image=[UIImage imageNamed:@"datebg"];
                        
                        bgImageView.image=nil;
                        bgImageView.layer.borderColor=rgb(238,238,238).CGColor;
                        bgImageView.layer.borderWidth=1;
                        
                        priceLable.hidden=NO;
                        priceLable.text=[NSString stringWithFormat:@"￥%@",[dataServer ojsk:@"price"]];
                     //2 部分可预约
                    }else if ([[dataServer ojsk:@"status"] isEqualToString:@"2"]) {
//                        showLable.textColor=rgbTitleColor;
//                        bgImageView.image=[UIImage imageNamed:@"memtimei1"];
//                        priceLable.hidden=NO;
//                        priceLable.text=[NSString stringWithFormat:@"￥%@",[dataServer ojsk:@"price"]];
//                        if (kUtilitySelectTime.noSelectTime) {
//                            //判断时间大小
//                            int noTime=[weakSelf compareOneDay:[weakSelf.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.noSelectTime ojsk:@"formatStr"]];
//                            if (noTime>=0) {
//                                showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
//                                bgImageView.hidden=YES;
//                            }
//                        }
                        
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                    }else if ([[dataServer ojsk:@"status"] isEqualToString:@"3"]) {
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                    }else {
                        //  4 全天已预约
                        viewLine.hidden=NO;
                        showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                        bgImageView.hidden=YES;
                    }
                }else{
                    showLable.textColor=RGBACOLOR(153, 153, 153,0.5);
                    bgImageView.hidden=YES;
                }
            }else{
                bgImageView.image=[UIImage imageNamed:@"datebg"];
                if ([showStr isEqualToString:@"1"]) {
                    bgImageView.image=[UIImage imageNamed:@"datebg"];
                }else   if ([showStr isEqualToString:@"2"]) {
                    bgImageView.image=[UIImage imageNamed:@"datebg1"];
                    showLable.textColor=rgbwhiteColor;
                }else   if ([showStr isEqualToString:@"3"]) {
                    bgImageView.image=[UIImage imageNamed:@"memtimei"];
                    showLable.textColor=rgbwhiteColor;
                }else   if ([showStr isEqualToString:@"4"]) {
                    bgImageView.image=[UIImage imageNamed:@"memtimei1"];
                }else   if ([showStr isEqualToString:@"5"]) {
                    priceLable.hidden=YES;
                }else   if ([showStr isEqualToString:@"6"]) {
                    priceLable.hidden=YES;
                    bgImageView.hidden=YES;
                }else   if ([showStr isEqualToString:@"7"]) {
                    priceLable.textColor=rgb(244,58,58);
                }else   if ([showStr isEqualToString:@"8"]) {
                    //                priceLable.textColor=rgb(244,58,58);
                    bgImageView.image=nil;
                    bgImageView.layer.borderColor=rgb(238,238,238).CGColor;
                    bgImageView.layer.borderWidth=1;
                }else   if ([showStr isEqualToString:@"9"]) {
                    //                priceLable.textColor=rgb(244,58,58);
                    //                bgImageView.image=nil;
                    //                bgImageView.layer.borderColor=rgb(238,238,238).CGColor;
                    //                bgImageView.layer.borderWidth=1;
                }else   if ([showStr isEqualToString:@"10"]) {
                    priceLable.hidden=YES;
                    bgImageView.hidden=YES;
                    showLable.textColor=rgb(204,204,204);
                    viewLine.hidden=NO;
                }
            }
            
            
            
        }];
    }
    [self addViewTarget:self select:@selector(clickMySelf)];

    
}
-(void)clickMySelf{
    if ([self.type isEqualToString:@"homeSelectTime"]||
        [self.type isEqualToString:@"申请预订"]) {
        //判断时间是否小于今天(不能点击)
        if ([self compareOneDay:[self.data ojsk:@"formatStr"] ]>=0) {
            if ([self.type isEqualToString:@"申请预订"]) {
//                status    字符串    1 可预约 2 部分可预约 3 不可预约 4 全天已预约
                id dataServer=[self.data ojk:@"dataServer"];
                if ([[dataServer ojsk:@"status"] isEqualToString:@"3"]||
                    [[dataServer ojsk:@"status"] isEqualToString:@"4"]) {
                    return;
                }
                if (kUtilitySelectTime.noSelectTime) {
                    //判断时间大小
                    int noTime=[self compareOneDay:[self.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.noSelectTime ojsk:@"formatStr"]];
                    if (noTime>=0) {
                        return;
                    }
                }
            }
            //处理选择
            if(!kUtilitySelectTime.selectStartTime){
                kUtilitySelectTime.selectTempTime=self.data;
            }else{
                int sTime=[self compareOneDay:[self.data ojsk:@"formatStr"] withAnotherDay:[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"]];
                if (sTime<0) {
                    [SVProgressHUD showImage:nil status:kS(@"setting_take_and_return_time", @"selectTimeTip")];
                    return;
                }
                if (sTime>=0) {
                    kUtilitySelectTime.selectTempTime=self.data;
                }
            }
            BaseViewController *veiwC=(BaseViewController *)[self supViewController];
            TimeSelectPopView*viewPop=[TimeSelectPopView viewWithFrame:CGRectMake(0, 0, kScreenWidth, H(UTILITY.currentViewController.view)) backgroundcolor:nil superView:UTILITY.currentViewController.view reuseId:@"CalendarSmallCellView"];
            viewPop.type=self.type;
            viewPop.data=veiwC.userInfo;
            [viewPop show];
        }
       
    }else{
    
        if ([[self.data ojsk:@"showStr"] isEqualToString:@"1"]) {
            BaseViewController *veiwC=(BaseViewController *)[self supViewController];
            TimeSelectPopView*viewPop=[TimeSelectPopView viewWithFrame:CGRectMake(0, 0, kScreenWidth, H(UTILITY.currentViewController.view)) backgroundcolor:nil superView:UTILITY.currentViewController.view reuseId:@"CalendarSmallCellView"];
            viewPop.data=veiwC.userInfo;
            [viewPop show];
        }
    }
    
}

-(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}
-(int)compareOneDay:(NSString *)oneDayStr
{// withAnotherDay:(NSString *)anotherDayStr
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[UTILITY.strtimestamp integerValue]]];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
