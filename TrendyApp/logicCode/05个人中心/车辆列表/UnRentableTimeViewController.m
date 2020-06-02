//
//  SelectTimeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/8.
//  Copyright © 2019 55like. All rights reserved.
//

#import "UnRentableTimeViewController.h"
#import "MYRHTableView.h"
#import "DateManager.h"
#import "CalendarCellView.h"
#import "UtilitySelectTime.h"
#import "CostSettingViewController.h"
@interface UnRentableTimeViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableDictionary *dataServer;
@property(nonatomic,strong)DateManager*dateManager;


//@property(nonatomic,strong)UILabel *lblS_time1;
//@property(nonatomic,strong)UILabel *lblS_time2;
//@property(nonatomic,strong)UILabel *lblE_time1;
//@property(nonatomic,strong)UILabel *lblE_time2;

//@property(nonatomic,strong)UILabel *lblSelectTime;
//@property(nonatomic,strong)WSSizeButton *btnOk;
@end

@implementation  UnRentableTimeViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadAll];
    
}
-(void)reloadAll{
    _dataServer=[NSMutableDictionary new];
    [self loadInitData];
    [self addView];
    [self request];
}

#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    
    for (UIView*subview in self.view.subviews) {
        if (subview.tag==1001) {
            [subview removeFromSuperview];
        }
    }
    
    UIView*viewTop=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 14*3) backgroundcolor:rgbwhiteColor superView:self.view];
    viewTop.tag=1001;
    
    {
        
        
        
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
    
    _mtableView.tag=1001;
    [self.view addSubview:_mtableView];
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _mtableView.backgroundColor=rgbwhiteColor;
    _mtableView.defaultPageSize=3;
    _mtableView.defaultSection.dataArray=_dataArray;
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        CalendarCellView*viewcell=[CalendarCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
        //        UILabel*lbNmuber=[RHMethods ClableY:10 W:200 Height:20 font:20 superview:viewcell withColor:nil text:@"dfdfa" reuseId:@"lbNmuber"];
        //        lbNmuber.text=[Datadic ojsk:@"formatStr"];
        //        [viewcell upDataMeWithData:Datadic];
        viewcell.type=@"unRentableTime";
        viewcell.data=Datadic;
        [viewcell upDataMe];
        [viewcell addBaseViewTarget:weakSelf select:@selector(cellBtnClick:)];
        
        return viewcell;
    }];
    {
        UIView*viewBottom=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 60) backgroundcolor:rgbwhiteColor superView:self.view];
        
        viewBottom.tag=1001;
        viewBottom.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        [UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5) backgroundcolor:rgbLineColor superView:viewBottom];
        float fy=0;
        {//@"申请预订"
            
            NSArray*arraytitle=@[
                                 @{
                                     @"image":@"datebg",
                                     @"title":kS(@"cant_rent_time", @"cant_rent"),//全天可租
                                     },];
            float rx=15;
            for (int i=0; i<arraytitle.count; i++) {
                NSDictionary*dic=arraytitle[i];
                UILabel*lbTitle=[RHMethods RlableRX:rx Y:14 W:0 Height:13 font:13 superview:viewBottom withColor:rgb(153, 153, 153) text:[dic ojsk:@"title"]];
                rx=lbTitle.frameWidth+rx;
//                UILabel*imgVIcon=[RHMethods lableX:0 Y:0 W:20 Height:20 font:13 superview:viewBottom withColor:rgb(153, 153, 153) text:@"21"];
                UILabel*imgVIcon=[RHMethods lableX:0 Y:0 W:20 Height:20 font:13 superview:viewBottom withColor:rgb(153, 153, 153) text:@"  "];
                imgVIcon.textAlignment=NSTextAlignmentCenter;
                imgVIcon.frameRX=rx+10;
                imgVIcon.centerY=lbTitle.centerY;
                
                
                UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 20, 1) backgroundcolor:rgb(204, 204, 204) superView:viewBottom];
                viewLine.center=imgVIcon.center;
                viewLine.transform =  CGAffineTransformMakeRotation(M_PI_2*0.5);
                
                
                rx=imgVIcon.frameWidth+imgVIcon.frameRX+10;
            }
            fy+=40;
            [UIView viewWithFrame:CGRectMake(0, fy, kScreenWidth, 0.5) backgroundcolor:rgbLineColor superView:viewBottom];
        }
        
        
//        UILabel*lbName=[RHMethods lableX:15 Y:fy+22 W:kScreenWidth*0.5 Height:15 font:15 superview:viewBottom withColor:rgb(51, 51, 51) text:@""];
        //總計 0小時
//        _lblSelectTime=lbName;
        WSSizeButton*btnOk=[RHMethods buttonWithframe:CGRectMake(14, fy+11, 190, 40) backgroundColor:nil text:[NSString stringWithFormat:@"  %@", kS(@"cant_rent_time", @"set_cost")] font:16 textColor:rgb(13,107,154) radius:0 superview:viewBottom];
        [btnOk setImageStr:@"msetupi" SelectImageStr:nil];
        btnOk.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btnOk addViewClickBlock:^(UIView *view) {
                [weakSelf pushController:[CostSettingViewController class] withInfo:weakSelf.otherInfo withTitle:kST(@"CostSetting") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                    weakSelf.allcallBlock(data, status, msg);
                    [weakSelf reloadAll];
                }];
        }];
//        btnOk.frameRX=15;
//        _btnOk=btnOk;
//        _btnOk.userInteractionEnabled=NO;
//        _btnOk.alpha=0.4;
        fy+=60+kIphoneXBottom;
        viewBottom.frameHeight=fy;
        _mtableView.frameHeight=_mtableView.frameHeight-viewBottom.frameHeight;
        viewBottom.frameY=_mtableView.frameYH;
    }
    
}
-(void)cellBtnClick:(MYViewBase*)btn{
    
    __weak __typeof(self) weakSelf = self;
    if ([[btn.eventView getAddValueForKey:@"actionType"] isEqualToString:@"unRentableTime"]) {
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:kS(@"cant_rent_time", @"dialog_title_cant_rent") message:[NSString stringWithFormat:kS(@"cant_rent_time", @"dialog_notice_cant_rent"),[[btn.eventView data] ojsk:@"formatStr"]] preferredStyle:UIAlertControllerStyleAlert];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"cant_rent_time", @"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            krequestParam
            [dictparam setObject:[[btn.eventView data] ojsk:@"formatStr"] forKey:@"days"];
            [dictparam setObject:weakSelf.userInfo forKey:@"carid"];
            //    language=cn&uid=6&token=22daab63d951e26acafb9b5f294c0f88&carid=7&days=2019-04-18
            [NetEngine createPostAction:@"carcenter/unavailable" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                    //            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                    [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
                    [[[btn.eventView data] ojk:@"dataServer"] setObject:@"2" forKey:@"status"];
                    [btn.eventView upDataMe];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
                    
                }
            }];
        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"cant_rent_time", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
    }

    
}
-(void)loadInitData{
    _dateManager=[DateManager new];
    _dataArray=[NSMutableArray new];
    
}
-(void)loadPreviousMoreData{
    if (_dataArray.count==0) {
        NSMutableDictionary *dicT=[_dateManager geCurrentMonthDic];
//        if ([self.userInfo isEqualToString:@"申请预订"]) {
            //        dataServer
            for (id dt in [dicT ojk:@"dayArray"]) {
                [dt setValue:[_dataServer ojk:[dt ojsk:@"formatStr"]] forKey:@"dataServer"];
            }
//        }
        [_dataArray addObject:dicT];
        [self loadMoreData];
        [self loadMoreData];
        return;
    }
    //    [_dataArray insertObject:[_dateManager gePreViousMonthWithCurrentDic:_dataArray.firstObject] atIndex:0];
}
-(void)loadMoreData{
    NSMutableDictionary *dicT=[_dateManager geNextMonthWithCurrentDic:_dataArray.lastObject];
//    if ([self.userInfo isEqualToString:@"申请预订"]) {
        //        dataServer
        for (id dt in [dicT ojk:@"dayArray"]) {
            [dt setValue:[_dataServer ojk:[dt ojsk:@"formatStr"]] forKey:@"dataServer"];
        }
//    }
    [_dataArray addObject:dicT];
}
#pragma mark button
-(void)rightButtonClicked{
    kUtilitySelectTime.selectStartTime=nil;
    kUtilitySelectTime.selectEndTime=nil;
    kUtilitySelectTime.selectTempTime=nil;
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    __weak __typeof(self) weakSelf = self;
    BOOL abool_server=NO;

    
    abool_server=YES;
    [_mtableView showRefresh:NO LoadMore:YES];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        if ([[pageOrPageSizeData ojsk:@"current"] isEqualToString:@"1"]) {
//            if (abool_server) {
                [weakSelf loadServerDatePage:[pageOrPageSizeData ojsk:@"current"] back:dataCallBack];
//            }else{
//                [weakSelf loadPreviousMoreData];
//            }
        }else{
//            if (abool_server) {
                [weakSelf loadServerDatePage:[pageOrPageSizeData ojsk:@"current"] back:dataCallBack];
//            }else{
//                [weakSelf loadMoreData];
//                [weakSelf loadMoreData];
//                [weakSelf loadMoreData];
//            }
        }
//        if (!abool_server) {
//            dataCallBack(@{@"list":weakSelf.dataArray},200,nil);
//        }
    }];
    [_mtableView refresh];
}
#pragma mark - event listener function
-(void)loadServerDatePage:(NSString *)page back:(AllcallBlock )dataCallBack{
    __weak typeof(self) weakSelf=self;
//    kUtilitySelectTime.selectCarId=self.otherInfo;
    krequestParam
    [dictparam setValue:page forKey:@"page"];
    [dictparam setValue:@"3" forKey:@"pagesize"];
    [dictparam setValue:self.userInfo forKey:@"id"];
//    http://app.trendycarshare.jp/api/car/carCalendarMonth
    [NetEngine createPostAction:@"car/carCalendarMonth" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
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
