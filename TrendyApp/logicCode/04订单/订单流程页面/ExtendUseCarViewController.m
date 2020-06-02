//
//  SelectTimeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/8.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ExtendUseCarViewController.h"
#import "MYRHTableView.h"
#import "DateManager.h"
#import "CalendarCellView.h"
#import "UtilitySelectTime.h"
@interface ExtendUseCarViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableDictionary *dataServer;
@property(nonatomic,strong)DateManager*dateManager;


@property(nonatomic,strong)UILabel *lblS_time1;
@property(nonatomic,strong)UILabel *lblS_time2;
@property(nonatomic,strong)UILabel *lblE_time1;
@property(nonatomic,strong)UILabel *lblE_time2;

@property(nonatomic,strong)UILabel *lblSelectTime;
@property(nonatomic,strong)WSSizeButton *btnOk;
@end

@implementation  ExtendUseCarViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf=self;
    
    kUtilitySelectTime.currentSelectType=self.otherInfo;
#pragma mark 日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //#warning 真机调试下, 必须加上这段
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    {
        fmt.dateFormat = @"yyyy-MM-dd";
        NSMutableDictionary*mdic=[NSMutableDictionary new];
        [mdic setObject:[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.userInfo ojsk:@"starttime"].integerValue+2]] forKey:@"formatStr"];
        fmt.dateFormat = @"HH:mm";
        [mdic setObject:[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.userInfo ojsk:@"starttime"].integerValue+2]] forKey:@"timeStr"];
        if ([kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]) {
            kUtilitySelectTime.selectStartTime=mdic;
        }
    }
    {
        fmt.dateFormat = @"yyyy-MM-dd";
        NSMutableDictionary*mdic=[NSMutableDictionary new];
        [mdic setObject:[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.userInfo ojsk:@"endtime"].integerValue+2]] forKey:@"formatStr"];
        fmt.dateFormat = @"HH:mm";
        [mdic setObject:[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.userInfo ojsk:@"endtime"].integerValue+2]] forKey:@"timeStr"];
        
        if ([kUtilitySelectTime.currentSelectType isEqualToString:@"extend"]) {
            kUtilitySelectTime.selectStartTime=mdic;
        }
//        kUtilitySelectTime.selectEndTime=mdic;
    }
    
//    if ([kUtilitySelectTime.currentSelectType isEqualToString:@"extend"]) {
//        kUtilitySelectTime.selectStartTime=kUtilitySelectTime.selectEndTime;
//        kUtilitySelectTime.selectEndTime=nil;
//    }
    
    
    
    _dataServer=[NSMutableDictionary new];
    [self loadInitData];
    [self addView];
    [self request];
    
    [kUtilitySelectTime addEventWithObj:self actionTypeArray:@[@"updateSelectTime"] reUseID:@"SelectTimeViewController" WithBlcok:^(MYBaseService *obj) {
        if (kUtilitySelectTime.selectStartTime) {
            weakSelf.lblS_time1.text=[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"];
            weakSelf.lblS_time2.text=[kUtilitySelectTime.selectStartTime ojsk:@"timeStr"];
            weakSelf.lblS_time1.textColor=rgb(51, 51, 51);
            weakSelf.lblS_time2.textColor=rgb(51, 51, 51);
        }else{
            weakSelf.lblS_time1.text=kS(@"setting_take_and_return_time", @"hint_take_date");
            weakSelf.lblS_time2.text=kS(@"setting_take_and_return_time", @"hint_return_date");
        }
        if (kUtilitySelectTime.selectEndTime) {
            weakSelf.lblE_time1.text=[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"];
            weakSelf.lblE_time2.text=[kUtilitySelectTime.selectEndTime ojsk:@"timeStr"];
        }else{
//            weakSelf.lblE_time1.text=kS(@"KeyHome", @"endDate");
            if ([kUtilitySelectTime.currentSelectType isEqualToString:@"extend"]) {
//                weakSelf.lblE_time1.text=@"延长用车时间";
//                weakSelf.lblE_time1.text=@"延长用车时间";
                weakSelf.lblE_time1.text=kS(@"advance_return_extend_use", @"hint_extend_date");
//                advance_return_extend_use
            }else{
//                weakSelf.lblE_time1.text=@"提前还车时间";
                weakSelf.lblE_time1.text=kS(@"advance_return_extend_use", @"hint_return_date");
            }
//            weakSelf.lblE_time2.text=kS(@"setting_take_and_return_time", @"hint_return_date");
            weakSelf.lblE_time2.text=kS(@"advance_return_extend_use", @"hint_return_date");
        }
        NSString *strH=@" 0";
        NSString *strKey=kS(@"KeyHome", @"FormatTime3");
        if (kUtilitySelectTime.selectStartTime && kUtilitySelectTime.selectEndTime) {
            NSString *strS=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"],[kUtilitySelectTime.selectStartTime ojsk:@"timeStr"]];
            NSString *strE=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"],[kUtilitySelectTime.selectEndTime ojsk:@"timeStr"]];
            
            
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate* d = [dateFormatter dateFromString:strS];
            NSTimeInterval late=[d timeIntervalSince1970]*1;
            //结束
            NSDate* dat = [dateFormatter dateFromString:strE];
            NSTimeInterval now=[dat timeIntervalSince1970]*1;
            
            NSTimeInterval cha=(now-late)>0 ? (now-late) : 0;
//            if (cha/(3600*24)>1) {
//                NSInteger chaInt=cha;
//                NSString *strTemp=[NSString stringWithFormat:@" %ld",chaInt/(3600*24)];
//                NSInteger chaY=chaInt%(3600*24);
//                strH=[NSString stringWithFormat:@"%.1f",chaY/(3600.0)];
//
//                weakSelf.lblSelectTime.text=[NSString stringWithFormat:kS(@"KeyHome", @"FormatTime4"),strTemp,strH];
//            }else{
                strH=[NSString stringWithFormat:@" %.1f",cha/3600];
//                weakSelf.lblSelectTime.text=[NSString stringWithFormat:strKey,strH];
            
            weakSelf.lblSelectTime.text=[NSString stringWithFormat:@"%@ %@%@",kS(@"setting_take_and_return_time", @"total"),strH,kS(@"setting_take_and_return_time", @"hour")];
//            }
            
            weakSelf.btnOk.userInteractionEnabled=YES;
            weakSelf.btnOk.alpha=1;
        }else{
//            weakSelf.lblSelectTime.text=[NSString stringWithFormat:strKey,strH];
            
            weakSelf.lblSelectTime.text=[NSString stringWithFormat:@"%@ %@%@",kS(@"setting_take_and_return_time", @"total"),strH,kS(@"setting_take_and_return_time", @"hour")];
            
            weakSelf.btnOk.userInteractionEnabled=NO;
            weakSelf.btnOk.alpha=0.4;
        }
    }];
    
    
    [kUtilitySelectTime dispatchEventWithActionType:@"updateSelectTime" actionData:nil];
    
    
    
}

-(void)dealloc{
    
    kUtilitySelectTime.currentSelectType=nil;
    kUtilitySelectTime.selectStartTime=nil;
    kUtilitySelectTime.selectEndTime=nil;
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    [self rightButton:kS(@"KeyHome", @"ButtonCancel") image:nil sel:@selector(rightButtonClicked)];
    
    UIView*viewTop=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 119) backgroundcolor:rgbwhiteColor superView:self.view];
    
    {
        float width=(kScreenWidth-30)*0.5;
        
        NSArray*arraytitle=@[kS(@"KeyHome", @"startData"),kS(@"KeyHome", @"endDate"),];
        for (int i=0; i<arraytitle.count; i++) {
            UIView*viewBtn=[UIView viewWithFrame:CGRectMake(0, 0, width, viewTop.frameHeight-14*3) backgroundcolor:nil superView:viewTop];
            UILabel*lbBiger=[RHMethods lableX:16 Y:20 W:viewBtn.frameWidth-16 Height:17 font:17 superview:viewBtn withColor:rgb(13,112,161) text:arraytitle[i]];
            UILabel*lbSmaller=[RHMethods lableX:lbBiger.frameX Y:lbBiger.frameYH+14 W:lbBiger.frameWidth Height:14 font:14 superview:viewBtn withColor:rgb(13,112,161) text:kS(@"setting_take_and_return_time", @"hint_setting_pls")];//@"请设置"
            if(i==1){
                viewBtn.frameRX=viewBtn.frameX;
                lbBiger.frameRX=lbBiger.frameX;
                lbSmaller.frameRX=lbSmaller.frameX;
                lbBiger.textAlignment=lbSmaller.textAlignment=NSTextAlignmentRight;
                _lblE_time1=lbBiger;
                _lblE_time2=lbSmaller;
            }else{
                _lblS_time1=lbBiger;
                _lblS_time2=lbSmaller;
            }
        }
        NSArray*arraydayTitle=@[kS(@"KeyHome", @"week7"),
                                kS(@"KeyHome", @"week1"),
                                kS(@"KeyHome", @"week2"),
                                kS(@"KeyHome", @"week3"),
                                kS(@"KeyHome", @"week4"),
                                kS(@"KeyHome", @"week5"),
                                kS(@"KeyHome", @"week6"),];//@[@"日",@"一",@"二",@"三",@"四",@"五",@"六",];
        float mywidth=(kScreenWidth-10)/7;
        for (int i=0; i<arraydayTitle.count; i++) {
            UILabel*lbWeakDay=[RHMethods lableX:5+mywidth*i Y:0 W:mywidth Height:14*3 font:14 superview:viewTop withColor:rgb(102, 102, 102) text:arraydayTitle[i]];
            lbWeakDay.frameBY=0;
            lbWeakDay.textAlignment=NSTextAlignmentCenter;
        }
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewTop];
        viewLine.frameBY=0;
        
    }
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, H(self.view)-viewTop.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _mtableView.backgroundColor=rgbwhiteColor;
    _mtableView.defaultPageSize=3;
    _mtableView.defaultSection.dataArray=_dataArray;
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        CalendarCellView*viewcell=[CalendarCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
        viewcell.type=@"申请预订";
        viewcell.data=Datadic;
        [viewcell upDataMe];
        return viewcell;
    }];
    {
        UIView*viewBottom=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 60) backgroundcolor:rgbwhiteColor superView:self.view];
        viewBottom.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        [UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5) backgroundcolor:rgbLineColor superView:viewBottom];
        float fy=0;
//        WSSizeButton*btnOk=[RHMethods buttonWithframe:CGRectMake(0, fy+11, kScreenWidth-30, 40) backgroundColor:rgb(13,112,161) text:@"提交" font:16 textColor:rgbwhiteColor radius:5 superview:viewBottom];
        WSSizeButton*btnOk=[RHMethods buttonWithframe:CGRectMake(0, fy+11, kScreenWidth-30, 40) backgroundColor:rgb(13,112,161) text: kS(@"advance_return_extend_use", @"submit") font:16 textColor:rgbwhiteColor radius:5 superview:viewBottom];
        btnOk.frameRX=15;
        _btnOk=btnOk;
        _btnOk.userInteractionEnabled=NO;
        _btnOk.alpha=0.4;
        [btnOk addViewTarget:self select:@selector(okBtnClick:)];
        //        fy+=60+kIphoneXBottom;
        fy=60+kIphoneXBottom;
        
        viewBottom.frameHeight=fy;
        viewBottom.frameBY=0;
        _mtableView.frameHeight=viewBottom.frameY-_mtableView.frameY;
//        viewBottom.frameY=_mtableView.frameYH;
    }
    
}
-(void)okBtnClick:(UIButton*)btn{
    krequestParam
    [dictparam setValue:[self.userInfo ojsk:@"orderid"] forKey:@"orderid"];
    NSString *strE=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"],[kUtilitySelectTime.selectEndTime ojsk:@"timeStr"]];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* dat = [dateFormatter dateFromString:strE];
    NSTimeInterval now=[dat timeIntervalSince1970];
    [dictparam setObject:[NSString stringWithFormat:@"%.0f",now] forKey:@"advancetime"];
    
    NSString*apiUrl=@"order/setextend";
    if ([kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]) {
        apiUrl=@"order/setadvance";
        
        [dictparam setObject:[NSString stringWithFormat:@"%.0f",now] forKey:@"advancetime"];
    }else{
        apiUrl=@"order/setextend";
        [dictparam setObject:[NSString stringWithFormat:@"%.0f",now] forKey:@"extendtime"];
    }
      __weak __typeof(self) weakSelf = self;
    [NetEngine createPostAction:apiUrl withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
//            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
                weakSelf.allcallBlock?weakSelf.allcallBlock(nil, 200, nil):nil;
            });
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];
}
-(void)loadInitData{
    _dateManager=[DateManager new];
    _dataArray=[NSMutableArray new];
    
}
-(void)loadPreviousMoreData{
    if (_dataArray.count==0) {
        NSMutableDictionary *dicT=[_dateManager geCurrentMonthDic];
//        if ([self.userInfo isEqualToString:@"申请预订"])
        {
            //        dataServer
            for (id dt in [dicT ojk:@"dayArray"]) {
                [dt setValue:[_dataServer ojk:[dt ojsk:@"formatStr"]] forKey:@"dataServer"];
            }
        }
        [_dataArray addObject:dicT];
        [self loadMoreData];
        [self loadMoreData];
        return;
    }
    //    [_dataArray insertObject:[_dateManager gePreViousMonthWithCurrentDic:_dataArray.firstObject] atIndex:0];
}
-(void)loadMoreData{
    NSMutableDictionary *dicT=[_dateManager geNextMonthWithCurrentDic:_dataArray.lastObject];
//    if ([self.userInfo isEqualToString:@"申请预订"])
    {
        //        dataServer
        for (id dt in [dicT ojk:@"dayArray"]) {
            [dt setValue:[_dataServer ojk:[dt ojsk:@"formatStr"]] forKey:@"dataServer"];
        }
    }
    [_dataArray addObject:dicT];
}
#pragma mark button
-(void)rightButtonClicked{
//    kUtilitySelectTime.selectStartTime=nil;
    kUtilitySelectTime.selectEndTime=nil;
//    kUtilitySelectTime.selectTempTime=nil;
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    __weak __typeof(self) weakSelf = self;
    BOOL abool_server=NO;
//    if ([weakSelf.userInfo isEqualToString:@"申请预订"]) {
        abool_server=YES;
        //        [_mtableView showRefresh:YES LoadMore:YES];
        //        [dictparam setValue:@"%@" forKey:@"page"];
        //        [dictparam setValue:@"3" forKey:@"pagesize"];
        //        [dictparam setValue:self.otherInfo forKey:@"id"];
        //        _mtableView.defaultSection.dataArray=_mtableView.dataArray;
        //        _mtableView.urlString=[NSString stringWithFormat:@"car/carCalendarMonth%@",dictparam.wgetParamStr];
        //        [_mtableView refresh];
//    }else{
//
//    }
    [_mtableView showRefresh:NO LoadMore:YES];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        if ([[pageOrPageSizeData ojsk:@"current"] isEqualToString:@"1"]) {
            if (abool_server) {
                [weakSelf loadServerDatePage:[pageOrPageSizeData ojsk:@"current"] back:dataCallBack];
            }else{
                [weakSelf loadPreviousMoreData];
            }
        }else{
            if (abool_server) {
                [weakSelf loadServerDatePage:[pageOrPageSizeData ojsk:@"current"] back:dataCallBack];
            }else{
                [weakSelf loadMoreData];
                [weakSelf loadMoreData];
                [weakSelf loadMoreData];
            }
        }
        if (!abool_server) {
            dataCallBack(@{@"list":weakSelf.dataArray},200,nil);
        }
    }];
    [_mtableView refresh];
}
#pragma mark - event listener function
-(void)loadServerDatePage:(NSString *)page back:(AllcallBlock )dataCallBack{
    __weak typeof(self) weakSelf=self;
    kUtilitySelectTime.selectCarId=[self.userInfo ojsk:@"cid"];
    krequestParam
    [dictparam setValue:page forKey:@"page"];
    [dictparam setValue:@"3" forKey:@"pagesize"];
    [dictparam setValue:[self.userInfo ojsk:@"orderid"] forKey:@"orderid"];
//    http://app.trendycarshare.jp/api/order/advanceCalendarMonth
    NSString*apiUrl=@"order/extendCalendarMonth";
    if ([kUtilitySelectTime.currentSelectType isEqualToString:@"advance"]) {
        apiUrl=@"order/advanceCalendarMonth";
    }
    
    
    [NetEngine createPostAction:apiUrl withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            [self.dataServer removeAllObjects];
            for (id date_1 in [dicData ojk:@"list"]) {
                for (id date_2 in [date_1 ojk:@"calendar"]) {
                    [self.dataServer setValue:date_2 forKey:[date_2 ojsk:@"date"]];
                }
            }
            if ([page isEqualToString:@"1"]) {
                [weakSelf loadPreviousMoreData];
            }else{
                [weakSelf loadMoreData];
                [weakSelf loadMoreData];
                [weakSelf loadMoreData];
            }
            dataCallBack(@{@"list":self.dataArray},200,nil);
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
        }
    }];
}

#pragma mark - delegate function


@end
