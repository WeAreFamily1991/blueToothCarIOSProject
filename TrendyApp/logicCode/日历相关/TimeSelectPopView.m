//
//  TimeSelectPopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/8.
//  Copyright © 2019 55like. All rights reserved.
//

#import "TimeSelectPopView.h"
#import "WSButtonGroup.h"
#import "UtilitySelectTime.h"
@interface TimeSelectPopView()
{
    
}
//@property(nonatomic,strong)WSButtonGroup*btnGroup;
@property(nonatomic,strong)UILabel *lblTip;
@property(nonatomic,strong)UILabel *viewContent;
@property(nonatomic,strong)id selectTime;
//@property(nonatomic,strong)NSMutableArray *arrayTime1;
//@property(nonatomic,strong)NSMutableArray *arrayTime2;

@end

@implementation TimeSelectPopView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=kScreenHeight;
    }
    if (self.isfirstInit) {
        self.backgroundColor=RGBACOLOR(0, 0, 0, 0.3);
        self.autoresizingMask=UIViewAutoresizingFlexibleHeight;
          __weak __typeof(self) weakSelf = self;
        [self addViewClickBlock:^(UIView *view) {
            weakSelf.hidden=YES;
        }];
//        NSMutableArray *arrayTime1=[NSMutableArray new];
//        NSMutableArray *arrayTime2=[NSMutableArray new];
//        for (int i=0; i<12; i++) {
//            if (i<10) {
//                [arrayTime1 addObject:@{@"timeStr":[NSString stringWithFormat:@"0%d:00",i]}];
//                [arrayTime1 addObject:@{@"timeStr":[NSString stringWithFormat:@"0%d:30",i]}];
//            }else{
//                [arrayTime1 addObject:@{@"timeStr":[NSString stringWithFormat:@"%d:00",i]}];
//                [arrayTime1 addObject:@{@"timeStr":[NSString stringWithFormat:@"%d:30",i]}];
//            }
//
//            [arrayTime2 addObject:@{@"timeStr":[NSString stringWithFormat:@"%d:00",i+12]}];
//            [arrayTime2 addObject:@{@"timeStr":[NSString stringWithFormat:@"%d:30",i+12]}];
//        }
//        _arrayTime1=[arrayTime1 toBeMutableObj];
//        _arrayTime2=[arrayTime2 toBeMutableObj];
        
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:self];
        viewContent.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        [viewContent addViewClickBlock:^(UIView *view) {
            
        }];
        _viewContent=viewContent;
        {
            UIView*viewTop=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) backgroundcolor:rgb(245, 245, 245) superView:viewContent];
            {
                WSSizeButton*btnCancel=[RHMethods buttonWithframe:CGRectMake(0, 0, 60, 44) backgroundColor:nil text:kS(@"setting_take_and_return_time", @"cancel") font:16 textColor:rgb(153, 153, 153) radius:0 superview:viewTop ];
                [btnCancel addViewClickBlock:^(UIView *view) {
                    weakSelf.hidden=YES;
                }];
                WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(0, 0, 60, 44) backgroundColor:nil text:kS(@"setting_take_and_return_time", @"confirm") font:16 textColor:rgb(14,112,161) radius:0 superview:viewTop ];
                [btnOK addViewTarget:self select:@selector(okButtonClicked)];
                btnOK.frameRX=0;
//                UILabel*lbTitle=[RHMethods ClableY:0 W:0 Height:viewTop.frameHeight font:17 superview:viewTop withColor:rgb(51, 51, 51) text:@""];
                _lblTip=[RHMethods labelWithFrame:CGRectMake(60, 0, kScreenWidth-120, 44) font:fontTitle color:rgbTitleDeepGray text:@"" textAlignment:NSTextAlignmentCenter supView:viewTop];
                
            }
            //2019-09-05  按照web 调整  单页显示
//            UIView*viewBtnGroup=[UIView viewWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:viewContent];
//            {
//                UIView*viewLine1=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:viewBtnGroup];
//                viewLine1.frameBY=0;
//
//                UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 125, 2) backgroundcolor:rgb(13,107,154) superView:viewBtnGroup];
//                viewLine.frameBY=0;
//                _btnGroup=[WSButtonGroup new];
//                [_btnGroup setGroupClickBlock:^(WSButtonGroup *group) {
//                    viewLine.centerX=group.currentSelectBtn.centerX;
//                }];
//                NSArray*arraytitle=@[[NSString stringWithFormat:@"%@(00:00-11:00)",kS(@"setting_take_and_return_time", @"select_morning")],[NSString stringWithFormat:@"%@(12:00-23:00)",kS(@"setting_take_and_return_time", @"select_Afternoon")],];
//                for (int i=0; i<arraytitle.count; i++) {
//                     WSSizeButton *btnSelect=[RHMethods buttonWithframe:CGRectMake(0+i*kScreenWidth*0.5, 0, viewBtnGroup.frameWidth*0.5, 50) backgroundColor:nil text:arraytitle[i] font:14 textColor:rgb(153, 153, 153) radius:0 superview:viewBtnGroup];
//                    [btnSelect setTitleColor:rgb(14,112,161) forState:UIControlStateSelected];
//                    [_btnGroup addButton:btnSelect];
//                }
//
//            }
//            [_btnGroup setGroupChangeBlock:^(WSButtonGroup *group) {
//                if (group.currentindex==0) {
//                    [weakSelf.viewContent upDataMeWithData:weakSelf.arrayTime1];
//                }else{
//                    [weakSelf.viewContent upDataMeWithData:weakSelf.arrayTime2];
//                }
//            }];
            [viewContent setAddUpdataBlock:^(id data, id weakme) {
                for (UIView *viewT in [weakSelf.viewContent subviews]) {
                    if (viewT.tag==1000) {
                        viewT.hidden=YES;
                    }
                }
                float btnWidth=(kScreenWidth-16*2-10*3)/4;
                NSArray *arrayT=data;
                float fx=16;
                float fy=10+44;
                weakSelf.viewContent.frameHeight=fy;
                for (int i=0; i<arrayT.count; i++) {
                    if (i%4==0 && i!=0) {
                        fx=16;
                        fy+=48;
                    }
                    WSSizeButton*btnOther=[RHMethods buttonWithframe:CGRectMake(fx, fy, btnWidth, 40) backgroundColor:nil text:@"11:00" font:15 textColor:rgb(51, 51, 51) radius:5 superview:weakSelf.viewContent reuseId:[NSString stringWithFormat:@"btnOther%d",i]];
                    btnOther.tag=1000;
                    btnOther.hidden=NO;
                    [btnOther setBackGroundImageviewColor:rgbwhiteColor forState:UIControlStateNormal];
                    [btnOther setBackGroundImageviewColor:rgb(13,107,154) forState:UIControlStateSelected];
                    if ([arrayT[i] isEqual:weakSelf.selectTime]) {
                        btnOther.selected=YES;
                        btnOther.layer.borderWidth=0;
                    }else{
                        btnOther.selected=NO;
                        btnOther.layer.borderColor=rgb(238, 238, 238).CGColor;
                        btnOther.layer.borderWidth=1;
                    }
                    [btnOther setTitle:[arrayT[i] ojsk:@"timeStr"] forState:UIControlStateNormal];
                    btnOther.data=arrayT[i];
                    [btnOther setTitleColor:rgbwhiteColor forState:UIControlStateSelected];
                    [btnOther addViewClickBlock:^(UIView *view) {
                        weakSelf.selectTime=view.data;
                        [weakSelf.viewContent upDataMe];
                    }];
                    
                    //判断能否选择
                    if (kUtilitySelectTime.selectStartTime|| [[btnOther.data ojsk:@"ispass"] isEqualToString:@"1"]) {
                        //
                        NSString *strS=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"],[kUtilitySelectTime.selectStartTime ojsk:@"timeStr"]];
                        NSString *strE=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"],[arrayT[i] ojsk:@"timeStr"]];
                        int sTime=[weakSelf compareOneDay:strS withAnotherDay:strE];
                        if (sTime>=0|| [[btnOther.data ojsk:@"ispass"] isEqualToString:@"1"]) {
                            btnOther.selected=NO;
                            [btnOther setBackGroundImageviewColor:rgbGray forState:UIControlStateNormal];
                            btnOther.userInteractionEnabled=NO;
                        }else{
                            btnOther.userInteractionEnabled=YES;
                        }
                    }else{
                        NSString *strS=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"],[arrayT[i] ojsk:@"timeStr"]];
                        int sTime=[weakSelf compareOneDay:strS];
                        if (sTime<=0) {
                            btnOther.selected=NO;
                            [btnOther setBackGroundImageviewColor:rgbGray forState:UIControlStateNormal];
                            btnOther.userInteractionEnabled=NO;
                        }else{
                            btnOther.userInteractionEnabled=YES;
                        }
                    }
                    //过滤服务器
//                    if ([btnOther.data ojk:@"timeData"]) {
//                    id serverData=[btnOther.data ojk:@"timeData"];
                    {
                        id serverData=btnOther.data;
                        //status    字符串    1 可预约 2 部分可预约 3 不可预约 4 全天已预约
                        if ([[serverData ojsk:@"status"] isEqualToString:@"1"]) {
                            
                        }else{
                            btnOther.selected=NO;
                            [btnOther setBackGroundImageviewColor:rgbGray forState:UIControlStateNormal];
                            btnOther.userInteractionEnabled=NO;
                        }
                    }
//                    }
                    fx+=btnWidth+10;
                    if (i==arrayT.count-1) {
                        weakSelf.viewContent.frameHeight=btnOther.frameYH+20;
                    }
                    
                }
                weakSelf.viewContent.frameHeight+=kIphoneXBottom;
                weakSelf.viewContent.frameBY=0;
            }];
            
        }
        
//        [_btnGroup btnClickAtIndex:0];
    }
    
}
-(void)show{
    self.hidden=NO;
    self.selectTime=nil;
//    [_btnGroup btnClickAtIndex:0];
    [self.viewContent upDataMeWithData:nil];
    if ([self.type isEqualToString:@"申请预订"]) {
        if ([kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]||
            [kUtilitySelectTime.currentSelectType isEqualToString:@"extend"]) {
            //提前还车
            krequestParam
            NSString *strurl=@"order/advanceDay";
            if ([kUtilitySelectTime.currentSelectType isEqualToString:@"extend"]) {
                //延长
               strurl=@"order/extendDay";
            }
            [dictparam setValue:[self.data ojsk:@"orderid"] forKey:@"orderid"];
            [dictparam setValue:[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"] forKey:@"date"];
            [NetEngine createPostAction:strurl withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                    NSDictionary *dicData=[resData objectForJSONKey:@"data"];
                    for (id data in [dicData ojk:@"list"]) {
                        [data setValue:[data ojsk:@"hour"] forKey:@"timeStr"];
                    }
//                    NSMutableDictionary *d_key=[NSMutableDictionary new];
//                    for (id data in [dicData ojk:@"list"]) {
//                        [d_key setValue:data forKey:[data ojsk:@"hour"]];
//                    }
//                    for (id data in self.arrayTime1) {
//                        [data setValue:[d_key ojk:[data ojsk:@"timeStr"]] forKey:@"timeData"];
//                    }
//                    for (id data in self.arrayTime2) {
//                        [data setValue:[d_key ojk:[data ojsk:@"timeStr"]] forKey:@"timeData"];
//                    }
                    [self.viewContent upDataMeWithData:[dicData ojk:@"list"]];
                }else{
                    [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
                }
            }];
      
        }else{
            krequestParam
            [dictparam setValue:kUtilitySelectTime.selectCarId forKey:@"id"];
            [dictparam setValue:[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"] forKey:@"date"];
            [NetEngine createPostAction:@"car/carDay" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                    NSDictionary *dicData=[resData objectForJSONKey:@"data"];
                    for (id data in [dicData ojk:@"list"]) {
                        [data setValue:[data ojsk:@"hour"] forKey:@"timeStr"];
                    }
//                    for (id data in self.arrayTime1) {
//                        [data setValue:[d_key ojk:[data ojsk:@"timeStr"]] forKey:@"timeData"];
//                    }
//                    for (id data in self.arrayTime2) {
//                        [data setValue:[d_key ojk:[data ojsk:@"timeStr"]] forKey:@"timeData"];
//                    }
                    [self.viewContent upDataMeWithData:[dicData ojk:@"list"]];
                }else{
                    [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
                }
            }];
        }
       
    }else{
        //2019-09-05  调整为后台控制显示内容
        krequestParam
        [dictparam setValue:@"0" forKey:@"id"];
        [dictparam setValue:[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"] forKey:@"date"];
        [NetEngine createPostAction:@"car/carDay" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
            if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                NSDictionary *dicData=[resData objectForJSONKey:@"data"];
                for (id data in [dicData ojk:@"list"]) {
                    [data setValue:[data ojsk:@"hour"] forKey:@"timeStr"];
                }
                [self.viewContent upDataMeWithData:[dicData ojk:@"list"]];
            }else{
                [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            }
        }];
    }
    if (kUtilitySelectTime.selectStartTime) {
        //还车时间
        _lblTip.text=kS(@"setting_take_and_return_time", @"dialog_title_return_car");
//        NSString *strS=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"],[kUtilitySelectTime.selectStartTime ojsk:@"timeStr"]];
//        NSString *strE=[NSString stringWithFormat:@"%@ 11:30",[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"]];
//        int sTime=[self compareOneDay:strS withAnotherDay:strE];
//        if (sTime>=0) {
//            [_btnGroup btnClickAtIndex:1];
//        }
    }else{
        _lblTip.text=kS(@"setting_take_and_return_time", @"dialog_title_take_car");
//        //取车
//        NSString *strS=[NSString stringWithFormat:@"%@ 11:30",[kUtilitySelectTime.selectTempTime ojsk:@"formatStr"]];
//        int sTime=[self compareOneDay:strS];
//        if (sTime<=0) {
//            [_btnGroup btnClickAtIndex:1];
//        }
    }
}
#pragma mark button
-(void)okButtonClicked{
    if (!_selectTime) {
        [SVProgressHUD showImage:nil status:_lblTip.text];
        return;//[SVProgressHUD showImage:nil status:kS(@"setting_take_and_return_time", @"selectTimeTip")];
    }
    if(!kUtilitySelectTime.selectStartTime){
        NSMutableDictionary *dic=[ NSMutableDictionary dictionaryWithDictionary:kUtilitySelectTime.selectTempTime];
        [dic addEntriesFromDictionary:_selectTime];
        kUtilitySelectTime.selectStartTime=dic;
    }else{
        NSMutableDictionary *dic=[ NSMutableDictionary dictionaryWithDictionary:kUtilitySelectTime.selectTempTime];
        [dic addEntriesFromDictionary:_selectTime];
        kUtilitySelectTime.selectEndTime=dic;
    }
    kUtilitySelectTime.selectTempTime=nil;
    self.hidden=YES;
}

-(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
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
