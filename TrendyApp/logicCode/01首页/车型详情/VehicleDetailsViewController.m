//
//  VehicleDetailsViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/25.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleDetailsViewController.h"
#import "MYRHTableView.h"
#import "VehicleInfoCellView.h"
#import "RentableTimeCellView.h"
#import "RentCarHomeCellView.h"
#import "UserEvaluationCellView.h"
#import "Utility_Location.h"
#import "LJImageRollingView.h"
#import "XHImageUrlViewer.h"
#import "VehicleDetailsCarDeployViewController.h"
#import "UserEvaluationViewController.h"
#import "MyCollectionCellView.h"
#import "ApplicationForReservationViewController.h"
#import "UtilitySelectTime.h"
#import "SelectTimeViewController.h"
#import "UtilityShareDefault.h"
#import "VehicleDetailUserInfoCellView.h"
#import "VehicleDetailOwnerViewController.h"
@interface VehicleDetailsViewController ()<LJImageRollingViewDelegate,UITableViewDelegate>
{
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableDictionary *dicAll;
@property(nonatomic,strong)UIButton *btnfav;
@property(nonatomic,strong) LJImageRollingView *viewScrollView;
@end

@implementation  VehicleDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:_mtableView];
    if (![self getAddValueForKey:@"SelectDate"]) {
        kUtilitySelectTime.selectStartTime=nil;
        kUtilitySelectTime.selectEndTime=nil;
        if ([self.otherInfo notEmptyOrNull] &&
            [kUtilitySelectTime.selectHomeDate ojk:@"selectStartTime"] &&
            [kUtilitySelectTime.selectHomeDate ojk:@"selectEndTime"]) {
            kUtilitySelectTime.selectStartTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectStartTime"];
            kUtilitySelectTime.selectEndTime=[kUtilitySelectTime.selectHomeDate ojk:@"selectEndTime"];
            
            NSMutableDictionary *dic=[kUtilitySelectTime updateFormatSubDataWithShowTip:NO];
            [self setAddValue:dic forKey:@"SelectDate"];
        }
        kUtilitySelectTime.selectTempTime=nil;
    }else{
        id SelectDate=[self getAddValueForKey:@"SelectDate"];
        //重新赋值
        kUtilitySelectTime.selectStartTime=[SelectDate ojk:@"selectStartTime"];
        kUtilitySelectTime.selectEndTime=[SelectDate ojk:@"selectEndTime"];
        
        kUtilitySelectTime.selectTempTime=nil;
    }
    
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    self.navView.backgroundColor=RGBACOLOR(0, 0, 0, 0);
    UIView*line=[self.navView viewWithTag:104];
    line.hidden=YES;
    [self.backButton setImage:[UIImage imageNamed:@"arrowil1"] forState:UIControlStateNormal];
    [self rightButton:nil image:@"sharei" sel:@selector(rightButtonClicked)];
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, H(self.view)) style:UITableViewStylePlain];
    _mtableView.delegate=self;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtableView];
    [self.view sendSubviewToBack:_mtableView];
    if (@available(iOS 11.0, *)) {
        _mtableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //车辆图片
    {
        UIView *viewBaner=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 520.0/750*kScreenWidth) backgroundcolor:RGBACOLOR(0, 0, 0, 0.3) superView:nil];
        LJImageRollingView*viewScrollView=[LJImageRollingView viewWithFrame:viewBaner.bounds backgroundcolor:nil superView:viewBaner];
        _viewScrollView=viewScrollView;
        _viewScrollView.delegateDiscount=self;
        _viewScrollView.pageControl.hidden=YES;
        NSMutableArray *arraytitle=[NSMutableArray new];
        for (NSString *strUrl in [_dicAll ojk:@"path"]) {
            [arraytitle addObject:@{@"url":strUrl,}];
        }
        [self.viewScrollView reloadImageView:arraytitle selectIndex:0];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewBaner];
    }
    
    
    //
    
    {
        VehicleInfoCellView *viewInfo=[VehicleInfoCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgbwhiteColor superView:nil];
        [viewInfo upDataMeWithData:_dicAll];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewInfo];
    }
    if([[_dicAll ojk:@"type"] isEqualToString:@"1"]){
        VehicleDetailUserInfoCellView *viewInfo=[VehicleDetailUserInfoCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgbwhiteColor superView:nil];
        [viewInfo upDataMeWithData:[_dicAll ojk:@"owner"]];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewInfo];
          __weak __typeof(self) weakSelf = self;
        [viewInfo addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[VehicleDetailOwnerViewController class] withInfo:[view.data ojsk:@"uid"] withTitle:[view.data ojsk:@"nickname"]];
            
        }];
    }
    //車輛介紹
    {
        UIView*viewVehicleIntroduction=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewVehicleIntroduction];
        
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewVehicleIntroduction.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewVehicleIntroduction];
        viewLine.frameBY=0;
        viewLine.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        
        UILabel*lbTitle=[RHMethods lableX:15 Y:25 W:kScreenWidth-30 Height:17 font:16 superview:viewVehicleIntroduction withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"carIntroduce")];//@"車輛介紹"
        UILabel*lbIntroduction=[RHMethods lableX:lbTitle.frameX Y:lbTitle.frameYH+20 W:kScreenWidth-30 Height:0 font:14 superview:viewVehicleIntroduction withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@",[_dicAll ojsk:@"content"]]];
        if ([[_dicAll ojsk:@"content"] length]>100) {
            NSString *strC=[[_dicAll ojsk:@"content"] substringToIndex:100];
            lbIntroduction.text=[NSString stringWithFormat:@"%@...%@",strC,kS(@"carDetails", @"textExpandHint")];
            [lbIntroduction setColor:rgb(13, 112, 161) contenttext:kS(@"carDetails", @"textExpandHint")];//查看更多
            [lbIntroduction addViewClickBlock:^(UIView *view) {//textShrinkHint 收起
                UILabel *lblC=view;
                
                if ([[viewVehicleIntroduction getAddValueForKey:@"isShowAll"] isEqualToString:@"1"]) {
                    [viewVehicleIntroduction setAddValue:@"0" forKey:@"isShowAll"];
                    lblC.text=[NSString stringWithFormat:@"%@...%@",strC,kS(@"carDetails", @"textExpandHint")];
                    [lblC setColor:rgb(13, 112, 161) contenttext:kS(@"carDetails", @"textExpandHint")];
                }else{
                    [viewVehicleIntroduction setAddValue:@"1" forKey:@"isShowAll"];
                    lblC.text=[NSString stringWithFormat:@"%@  %@",[_dicAll ojsk:@"content"],kS(@"carDetails", @"textShrinkHint")];
                    [lblC setColor:rgb(13, 112, 161) contenttext:kS(@"carDetails", @"textShrinkHint")];
                }
                [viewVehicleIntroduction upDataMe];
            }];
        }
        [lbIntroduction setAllTextLineSpacing:4];
        [lbIntroduction changeLabelHeight];
        viewVehicleIntroduction.frameHeight=lbIntroduction.frameYH+20;
        
        [viewVehicleIntroduction setAddUpdataBlock:^(id data, id weakme) {
            UIView *viewTemp=(UIView *)weakme;
            
            [lbIntroduction setAllTextLineSpacing:4];
            [lbIntroduction changeLabelHeight];
            viewTemp.frameHeight=lbIntroduction.frameYH+20;
            [weakSelf.mtableView reloadData];
        }];
        
    }
    
    //可租用时间
    {
        UIView*viewVehicleIntroduction=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewVehicleIntroduction];
        UILabel*lbTitle=[RHMethods lableX:15 Y:25 W:kScreenWidth-30 Height:17 font:17 superview:viewVehicleIntroduction withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"usefulRentTime")];//@"可租用時間"
        RentableTimeCellView *viewRentableTime=[RentableTimeCellView viewWithFrame:CGRectMake(0, lbTitle.frameYH+10, kScreenWidth, 0) backgroundcolor:nil superView:viewVehicleIntroduction];
        [viewRentableTime upDataMeWithData:_dicAll];
        viewVehicleIntroduction.frameHeight=viewRentableTime.frameYH;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewVehicleIntroduction.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewVehicleIntroduction];
        viewLine.frameBY=0;
        
        [viewVehicleIntroduction addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[SelectTimeViewController class] withInfo:@"申请预订" withTitle:@"" withOther:self.userInfo withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf setAddValue:data forKey:@"SelectDate"];
            }];
        }];
    }
    
    //车型配置
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbTitle=[RHMethods lableX:15 Y:25 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"carConfigure")];//@"车型配置"
        UILabel*lbSeeAll=[RHMethods RlableRX:15 Y:0 W:0 Height:40 font:14 superview:viewContent withColor:rgb(102, 102, 102) text:kS(@"carDetails", @"all")];//@"全部"        
        [lbSeeAll addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[VehicleDetailsCarDeployViewController class] withInfo:weakSelf.userInfo withTitle:kS(@"carDetails", @"carConfigure")];
        }];
        lbSeeAll.centerY=lbTitle.centerY;
        {
            NSArray*arraytitle=[_dicAll ojk:@"deploylist"];
//            float fx=0;
            float fw=kScreenWidth/3;
//            float fy=45;
            for(int i=0;i<arraytitle.count;i++){
                NSDictionary*currentdic=arraytitle[i];
                WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(0, lbTitle.frameYH+10+ 64*(i/3), fw, 64) backgroundColor:nil text:[currentdic ojsk:@"title"] font:13 textColor:rgb(51, 51, 51) radius:0 superview:viewContent];
                [btnItem imageWithURL:[currentdic ojsk:@"path"]];
//                [btnItem setImageStr:@"datai4" SelectImageStr:@"datai5"];
                [btnItem setTitleColor:RGBACOLOR(51, 51, 51, 0.3) forState:UIControlStateNormal];
                [btnItem setBtnImageViewFrame:CGRectMake(0, 13, 27, 27)];
                btnItem.imageView.contentMode=UIViewContentModeScaleAspectFit;
                [btnItem imgbeCX];
                [btnItem setBtnLableFrame:CGRectMake(0, btnItem.imgframeYH+5-3, btnItem.frameWidth, 12+6)];
                
                btnItem.titleLabel.textAlignment=NSTextAlignmentCenter;
                if (i%3==2) {
                    btnItem.frameRX=0;
                }else if(i%3==1){
                    [btnItem beCX];
                }
                if (i==arraytitle.count-1) {
                    viewContent.frameHeight=btnItem.frameYH+10;
                }
            }
        }
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewContent.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewContent];
        viewLine.frameBY=0;
        
    }
    
    //取車須知
    {
        UIView*viewVehicleIntroduction=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewVehicleIntroduction];
        UILabel*lbTitle=[RHMethods lableX:15 Y:25 W:kScreenWidth-30 Height:17 font:17 superview:viewVehicleIntroduction withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"carNotice")];//@"取車須知"
        UILabel *lbIntroduction=[RHMethods lableX:lbTitle.frameX Y:lbTitle.frameYH+20 W:kScreenWidth-30 Height:0 font:14 superview:viewVehicleIntroduction withColor:rgb(102, 102, 102) text:[_dicAll ojsk:@"descr"]];
        viewVehicleIntroduction.frameHeight=lbIntroduction.frameYH+26;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewVehicleIntroduction.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewVehicleIntroduction];
        viewLine.frameBY=0;
        
    }
    
    //交車地點
    {
        UIView*viewVehicleIntroduction=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewVehicleIntroduction];
        UILabel*lbTitle=[RHMethods lableX:15 Y:25 W:kScreenWidth-30 Height:17 font:17 superview:viewVehicleIntroduction withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"carLocation")];//@"交車地點"
        UILabel*lbIntroduction=[RHMethods lableX:lbTitle.frameX Y:lbTitle.frameYH+20 W:kScreenWidth-30 Height:0 font:14 superview:viewVehicleIntroduction withColor:rgb(102, 102, 102) text:kS(@"carDetails", @"carLocationHint")];//@"車主暫未填寫其他交車地點"
        if ([[_dicAll ojsk:@"drop_descr"] notEmptyOrNull]) {
            lbIntroduction.text=[_dicAll ojsk:@"drop_descr"];
        }
        viewVehicleIntroduction.frameHeight=lbIntroduction.frameYH+26;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewVehicleIntroduction.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewVehicleIntroduction];
        viewLine.frameBY=0;
    }
    
    //租車注意事項
    {
        UIView*viewVehicleIntroduction=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewVehicleIntroduction];
        UILabel*lbTitle=[RHMethods lableX:15 Y:25 W:kScreenWidth-30 Height:17 font:17 superview:viewVehicleIntroduction withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"rentNotice")];//@"租車注意事項"
//        UILabel*lbIntroduction=[RHMethods lableX:lbTitle.frameX Y:lbTitle.frameYH+20 W:kScreenWidth-30 Height:0 font:14 superview:viewVehicleIntroduction withColor:rgb(102, 102, 102) text:@"吸煙\n寵物\n汽油補給\n事故發生時的責任\n取消的條件 "];
        NSArray *arrayT=[_dicAll ojk:@"confineList"];
        float fy=lbTitle.frameYH+20;
        for (int i=0; i<[arrayT count]; i++) {
            NSDictionary *dicT=arrayT[i];
            UILabel *lblLeft=[RHMethods labelWithFrame:CGRectMake(15, fy, 0, 20) font:fontTxtContent color:rgbTxtDeepGray text:[dicT ojsk:@"title"] supView:viewVehicleIntroduction];
            if (W(lblLeft)>kScreenWidth/2) {
                lblLeft.numberOfLines=0;
                lblLeft.frameWidth=kScreenWidth/2;
                [lblLeft changeLabelHeight];
            }
            NSMutableArray *arraySon=[NSMutableArray new];
            for (id d_son in [dicT ojk:@"son"]) {
                [arraySon addObject:[d_son ojsk:@"title"]];
            }
            NSString *strC=[arraySon componentsJoinedByString:@"\n"];
            UILabel *lblRight=[RHMethods labelWithFrame:CGRectMake(XW(lblLeft)+20, fy, kScreenWidth-XW(lblLeft)-35, 20) font:fontTxtContent color:rgbTxtDeepGray text:strC textAlignment:NSTextAlignmentRight supView:viewVehicleIntroduction];
            if ([[dicT ojsk:@"confine_content"] notEmptyOrNull]) {
                lblRight.textColor=rgb(13, 112, 161);
                [lblRight addViewClickBlock:^(UIView *view) {
                    UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:strC message:[dicT ojsk:@"confine_content"] preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"carDetails", @"Sure") style:UIAlertActionStyleCancel handler:nil]];
                    [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
                        
                    }];
                }];
            }
            float fw=[lblRight sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width;
            if (fw>W(lblRight)) {
                lblRight.numberOfLines=0;
                [lblRight changeLabelHeight];
            }
            fy+=H(lblRight)>H(lblLeft)?H(lblRight):H(lblLeft)+8;
        }
        viewVehicleIntroduction.frameHeight=fy+20;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewVehicleIntroduction.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewVehicleIntroduction];
        viewLine.frameBY=0;
    }
    
//    用戶評價
    {
        NSArray *arrayT=[_dicAll ojk:@"commentList"];
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
            NSString *strT=kS(@"carDetails", @"userEvaluation");
//            if ([[_dicAll ojsk:@"commentCount"] integerValue]>0) {
                strT=[NSString stringWithFormat:@"%@(%@)",kS(@"carDetails", @"userEvaluation"),[_dicAll ojsk:@"commentCount"]];
//            }
            UILabel*lbTitle=[RHMethods lableX:15 Y:19.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:strT];////@"用戶評價（10）"
            viewContent.frameHeight=lbTitle.frameYH+10;
            UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 20, 8, 15) defaultimage:@"arrowr2" supView:viewContent];
            imgVRow.frameRX=15;
            imgVRow.centerY=lbTitle.centerY;
            
            [viewContent addViewClickBlock:^(UIView *view) {
                [weakSelf pushController:[UserEvaluationViewController class] withInfo:weakSelf.userInfo withTitle:kS(@"carDetails", @"userEvaluation")];
            }];
            if (!arrayT || arrayT.count==0) {
                UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewContent.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewContent];
                viewLine.frameBY=0;
                viewLine.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            }
        }
        for (id dataT in arrayT) {
            UserEvaluationCellView *viewCell=[UserEvaluationCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:nil];
            [viewCell upDataMeWithData:dataT];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        }
    }
    
    //相似車型
    {
        
    
        SectionObj*obj=[SectionObj new];
        [_mtableView.sectionArray addObject:obj];
        obj.dataArray=[_dicAll ojk:@"carList"];
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
            obj.selctionHeaderView=viewContent;
            UILabel*lbTitle=[RHMethods lableX:15 Y:19.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carDetails", @"similarCar")];//@"相似車型"
            viewContent.frameHeight=lbTitle.frameYH+10;
            if (!obj.dataArray || obj.dataArray.count==0) {
                UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, viewContent.frameWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewContent];
                viewLine.frameBY=0;
                viewLine.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            }
        }
        
        [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            MyCollectionCellView *viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
            [viewcell upDataMeWithData:Datadic];
            viewcell.collectionBtn.hidden=YES;
            viewcell.between_time=weakSelf.otherInfo;
//            RentCarHomeCellView *viewcell=[RentCarHomeCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"RentCarHomeCellView"];
//            [viewcell upDataMeWithData:Datadic];
            return viewcell;
        }];
    }
    
    if (![[_dicAll ojsk:@"uid"] isEqualToString:kUtility_Login.userId]) {
        UIView *viewBottum=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 60) backgroundcolor:rgbwhiteColor superView:self.view];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:viewBottum];
        viewLine.alpha=0.8;
         WSSizeButton*btnOk=[RHMethods buttonWithframe:CGRectMake(0, 0, kScreenWidth-123-15, 40) backgroundColor:rgb(13, 112, 161) text:kS(@"carDetails", @"applyBooking") font:16 textColor:rgb(255, 255, 255) radius:5 superview:viewBottum];
        btnOk.frameRX=15;//@"申请预定"
        [btnOk beCY];
        [btnOk addViewClickBlock:^(UIView *view) {
            [kUtility_Login isLogin:^(id data, int status, NSString *msg) {
                if (status==200) {
                    [kCarCenterService carcenter_checkUserwithBlock:^(id data, int status, NSString *msg) {
                        [weakSelf pushController:[ApplicationForReservationViewController class] withInfo:weakSelf.userInfo withTitle:kS(@"carDetails", @"applyBooking") withOther:[weakSelf getAddValueForKey:@"SelectDate"] withAllBlock:^(id data, int status, NSString *msg) {
                            //处理时间回掉
                            [weakSelf setAddValue:data forKey:@"SelectDate"];
                        }];
                    }];
                }
            }];
            
        }];
        
        NSArray*arraytitle=@[kS(@"carDetails",@"collect"),kS(@"carDetails",@"CustomerService"),];//@"客服"
        if ([[_dicAll ojsk:@"type"] isEqualToString:@"1"]) {//0：平台，1：个人
            arraytitle=@[kS(@"carDetails",@"collect"),kS(@"carDetails",@"contactOwner"),];
        }
        
        NSArray*arrayImgStr=@[@"ficon1",@"ficon2",];
        NSArray*arrayImgStrSelect=@[@"ficon1on",@"ficon2",];
        
        float myx = 15;
      
        for (int i=0; i<arraytitle.count; i++) {
            NSString*titleStr = arraytitle[i];
             WSSizeButton*btnCollection=[RHMethods buttonWithframe:CGRectMake(myx, 0, 48.0, viewBottum.frameHeight) backgroundColor:nil text:arraytitle[i] font:11 textColor:rgb(153, 153, 153) radius:0 superview:viewBottum];
            [btnCollection setImageStr:arrayImgStr[i] SelectImageStr:arrayImgStrSelect[i]];
            
            float btnWith = [titleStr widthWithFont:11] +8;
            if (48.0<btnWith) {
                btnCollection.frameWidth =btnWith;
            }
            myx = btnCollection.frameXW;
            [btnCollection setBtnImageViewFrame:CGRectMake(0, 13, 18, 18)];
            [btnCollection setBtnLableFrame:CGRectMake(0, btnCollection.imgframeYH+5-5, btnCollection.frameWidth, 11+10)];
            [btnCollection imgbeCX];
            btnCollection.titleLabel.textAlignment=NSTextAlignmentCenter;
            [btnCollection setTitleColor:rgb(248,158,59) forState:UIControlStateSelected];
            if (i==0) {
                [btnCollection setTitle:kS(@"carDetails",@"isCollect") forState:UIControlStateSelected];//@"已收藏xxxxx"
                btnCollection.selected=[[_dicAll ojsk:@"isfav"] isEqualToString:@"1"];//isfav    字符串    1 已收藏 未收藏
                _btnfav=btnCollection;
                [btnCollection addViewTarget:self select:@selector(collectionClicked)];
            }else{
                [btnCollection addViewTarget:self select:@selector(customerServiceClicked)];
            }
        }
        
        btnOk.frameWidth = kScreenWidth -(myx ) -15-15;
        btnOk.frameRX =15;
        viewBottum.frameHeight=viewBottum.frameHeight+kIphoneXBottom;
        viewBottum.frameBY=0;
        viewBottum.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        _mtableView.frameHeight=viewBottum.frameY-_mtableView.frameY;
        
    }
    
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"id"];
    if ([kUtility_Location.userlatitude notEmptyOrNull] && [kUtility_Location.userlongitude notEmptyOrNull]) {
        [dictparam setValue:kUtility_Location.userlatitude forKey:@"lat"];
        [dictparam setValue:kUtility_Location.userlongitude forKey:@"lng"];
    }
    if (self.otherInfo) {
        [dictparam setValue:self.otherInfo forKey:@"between_time"];
    }
    [NetEngine createPostAction:@"car/carDetail" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.dicAll=dicData;
            [self addView];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClicked:nil];
            });
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showImage:nil status:alertErrorTxt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClicked:nil];
        });
    }];
}
#pragma mark - event listener function
#pragma mark button
-(void)collectionClicked{
    [kUtility_Login isLogin:^(id data, int status, NSString *msg) {
        if (status==200) {
            krequestParam
            [dictparam setValue:self.userInfo forKey:@"ids"];
            [NetEngine createGetAction:[NSString stringWithFormat:@"ucenter/fav%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
                if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                    self.btnfav.selected=!self.btnfav.selected;
                    ////isfav    字符串    1 已收藏 未收藏
                    [self.dicAll setValue:self.btnfav.selected?@"1":@"0" forKey:@"isfav"];
//                    [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
                }else{
                    [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
                }
            }];
        }
    }];
    
}
-(void)customerServiceClicked{
       __weak __typeof(self) weakSelf = self;
    if ([kUtility_Login isLogIn]) {
        [kUtility_Login chatWithUser:[_dicAll ojk:@"owner"] withCar:YES];
    }else{
        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
            if (status == 200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 
                    [kUtility_Login chatWithUser:[weakSelf.dicAll ojk:@"owner"] withCar:YES];
                });
             
            }
        }];
    }
  
    
//    [kUtility_Login chatWithUser:[_dicAll ojk:@"owner"] withCar:YES];
}
-(void)rightButtonClicked{
    krequestParam
    [dictparam setObject:self.userInfo forKey:@"id"];
    [NetEngine createPostAction:@"car/get_shares" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            [dic setObject:[dic ojsk:@"pic"] forKey:@"imageUrl"];
            //分享
//            [kUtilityShareDefault showShareUrlData:@{@"imageUrl":@"",@"title":@"测试分享2",@"url":@"http://www.baidu.com"} suc:^(id data, int status, NSString *msg) {
//
//            }];
//            "data": {
//                "title": "奥迪A1-不错哟",
//                "content": "测试",
//                "pic": "http://h5.trendycarshare.jp/upload/2019-04-24/1556105548.jpeg",
//                "url": "http://h5.trendycarshare.jp/home/car/detail?id=37&language=cn"
//            },
            [kUtilityShareDefault showShareUrlData:dic suc:^(id data, int status, NSString *msg) {
                
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];

    
 
}
#pragma mark - delegate function

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    scrollView.contentOffset.y;
    //    NSLog(@"%f",scrollView.contentOffset.y);
    float fy=scrollView.contentOffset.y;
    if (fy<=5) {
        self.navView.backgroundColor=[UIColor clearColor];
        [[self.navView viewWithTag:104] setHidden:YES];
        [[self.navView viewWithTag:102] setHidden:YES];
    }else{
        [[self.navView viewWithTag:104] setHidden:NO];
        [[self.navView viewWithTag:102] setHidden:NO];
        if (fy<kTopHeight) {
            float f_b=fy/kTopHeight;
            self.navView.backgroundColor=RGBACOLOR(255,255,255, f_b);
        }else{
            self.navView.backgroundColor=rgbwhiteColor;
        }
    }
    if (fy<kTopHeight-30) {//
        [self.backButton setImage:[UIImage imageNamed:@"arrowil1"] forState:UIControlStateNormal];
        [self.navrightButton setImage:[UIImage imageNamed:@"sharei"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        [self.backButton setImage:[UIImage imageNamed:@"arrowl"] forState:UIControlStateNormal];
        [self.navrightButton setImage:[UIImage imageNamed:@"shareigray"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}
#pragma mark LJImageRollingViewDelegate
- (void)selectView:(LJImageRollingView *)selectView ad:(NSDictionary *)dic index:(NSInteger)index{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (NSString *strUrl in [_dicAll ojk:@"path"]) {
        [array addObject:@{@"url":strUrl,}];
    }
    if (array.count) {
        XHImageUrlViewer *xhView=[self getAddValueForKey:@"ImageUrlViewer"];
        if (!xhView) {
            xhView=[[XHImageUrlViewer alloc] init];
            [self setAddValue:xhView forKey:@"ImageUrlViewer"];
        }
        [xhView showWithImageDatas:array selectedIndex:index];
    }
}

@end
