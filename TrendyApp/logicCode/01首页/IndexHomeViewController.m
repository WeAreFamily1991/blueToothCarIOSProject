//
//  IndexHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "IndexHomeViewController.h"
#import "MYRHTableView.h"
#import "RentCarExpressCenterCellView.h"
#import "LJImageRollingView.h"
#import "HomeCenterCellView.h"
//#import "HomeCenterCellView.h"
#import "HomeCellectionCellView.h"
#import "SuccessfulApplicationViewController.h"
#import "SpecialVehicleViewController.h"
#import "UserEvaluationViewController.h"
#import "ApplicationForReservationViewController.h"
#import "SearchVehicleLocationViewController.h"
#import "BrandModelSearchViewController.h"
#import "HVehicleOwnerViewController.h"
#import "MyLoginViewController.h"
#import "BindingEmailBoxViewController.h"
#import "VehicleDetailsViewController.h"
#import "CalendarViewController.h"
#import "SelectTimeViewController.h"

#import "SelectWebUrlViewController.h"
#import "Utility_Location.h"
#import "SelectCityViewController.h"
#import "MessageCenterViewController.h"

#import <ImSDK/ImSDK.h>
#import "TUIKit.h"
#import "MyTXIMUIKitViewController.h"
#import "MapSelectPointViewController.h"

@interface IndexHomeViewController ()<UITableViewDelegate,RHTableViewDelegate,LJImageRollingViewDelegate>
{
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableArray*dataList;
@property(nonatomic,strong) WSSizeButton *btnSearch;
@property(nonatomic,strong) UIImageView *imageICON;
@property(nonatomic,strong) LJImageRollingView *viewScrollView;
@end

@implementation  IndexHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:_mtableView];
    [_viewScrollView startAnimation];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_viewScrollView stopAnimation];
   
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [kLanguageService loadLanguageData];
    _dataList=[NSMutableArray new];
      __weak __typeof(self) weakSelf = self;
    [kLanguageService loadLanguageDataWithBlock:^(id data, int status, NSString *msg) {
        [weakSelf initAll];
    }];
    [kUtility_Location loadUserLocation:^(id data, int status, NSString *msg) {
        if (status==200) {
            [weakSelf request];
        }
    }];
    
//    if (![[UTILITY getAddValueForKey:@"showStartTransitionViewshowStartTransitionView"] notEmptyOrNull]) {
        //版本更新y检查
//        [UTILITY versionUpdate:NO];

        [UTILITY showStartTransitionView];
        [UTILITY setAddValue:@"1" forKey:@"showStartTransitionViewshowStartTransitionView"];
//    }
}

-(void)initAll{
    [self addView];
    [self navbarTitle:@""];
    //    104
    self.navView.backgroundColor=RGBACOLOR(0, 0, 0, 0);
    UIView*line=[self.navView viewWithTag:104];
    line.hidden=YES;
    _imageICON=[RHMethods imageviewWithFrame:CGRectMake(0,kTopHeight-36, kScreenWidth, 28) defaultimage:@"logoi1" contentMode:UIViewContentModeScaleAspectFit supView:self.navView];
    _imageICON.hidden=YES;
    [self rightButton:nil image:@"noticei" sel:@selector(navBtnClick:)];
    WSSizeButton*btnSearch=[RHMethods buttonWithframe:CGRectMake(0, 0, 80, 16+20) backgroundColor:nil text:@" " font:16 textColor:rgbwhiteColor radius:0 superview:self.navView];
    btnSearch.centerY=self.navrightButton.centerY;
    _btnSearch=btnSearch;
    [btnSearch setImageStr:@"arrowb" SelectImageStr:nil];    
    [btnSearch setAddUpdataBlock:^(id data, id weakme) {
        WSSizeButton*btnSearch=weakme;
        float mywith=[btnSearch.currentTitle widthWithFont:btnSearch.titleLabel.font.pointSize];
        [btnSearch setBtnLableFrame:CGRectMake(15, 0, mywith, btnSearch.frameHeight)];
        [btnSearch setBtnImageViewFrame:CGRectMake(15+mywith+5, 0, 10, btnSearch.frameHeight)];
        btnSearch.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }];
    [btnSearch upDataMe];
    __weak typeof(self) weakSelf=self;
    [btnSearch addViewClickBlock:^(UIView *view) {
        [weakSelf pushController:[SelectCityViewController class] withInfo:@"" withTitle:kST(@"CitySelect") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            
        }];
    }];
    if (kUtility_Location.userCityTake) {
        [weakSelf.btnSearch setTitle:[kUtility_Location.userCityTake ojsk:@"name"] forState:UIControlStateNormal];
        [weakSelf.btnSearch upDataMe];
    }
    
    [kUtility_Location addEventWithObj:self actionTypeArray:@[@"SaveSelectUserCityUpdate"] reUseID:@"SaveSelectUserCityUpdatexxxxx" WithBlcok:^(MYBaseService *obj) {
        [weakSelf.btnSearch setTitle:[kUtility_Location.userCityTake ojsk:@"name"] forState:UIControlStateNormal];
        [weakSelf.btnSearch upDataMe];
        [weakSelf request];
    }];
    
    [kUtility_Location readUserLocationFromDefault:^(id data, int status, NSString *msg) {
//        [weakSelf.btnSearch setTitle:[kUtility_Location.userCityTake ojsk:@"name"] forState:UIControlStateNormal];
//        [weakSelf.btnSearch upDataMe];
//        [weakSelf request];
    }];
    
    [self request];
    [self loadDATA];
    NSInteger sdkAppid = 1400206761; //填入自己app的sdkAppid
    NSString *accountType = @"36862"; //填入自己app的accountType
    TUIKitConfig *config = [TUIKitConfig defaultConfig];//默认TUIKit配置，这个您可以根据自己的需求在 TUIKitConfig 里面自行配置
    [[TUIKit sharedInstance] initKit:sdkAppid accountType:accountType withConfig:config];
}

-(void)navBtnClick:(UIButton*)btn{
    if(btn==self.navrightButton){
        
        __weak typeof(self) weakSelf=self;
        //        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
        //            [weakSelf pushController:[MyTXIMUIKitViewController class] withInfo:nil withTitle:@"聊天"];
        //        }];
        
        
        [self pushController:[MessageCenterViewController class] withInfo:nil withTitle:kST(@"systemMessage")];
        
    }
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-kIphoneXBottom) style:UITableViewStyleGrouped];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    _mtableView.isHiddenNull=YES;
    [_mtableView showRefresh:YES LoadMore:YES];
    _mtableView.delegate=self;
    _mtableView.delegate2=self;
    if (@available(iOS 11.0, *)) {
        _mtableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    {
        
        SectionObj*obj=[SectionObj new];
        [_mtableView.sectionArray addObject:obj];
        
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 557) backgroundcolor:rgb(246, 246, 246) superView:nil];
        
        [obj.noReUseViewArray addObject:viewHeader];
        LJImageRollingView*viewScrollView=[LJImageRollingView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 286+kTopHeight-64-60) backgroundcolor:nil superView:viewHeader];
        _viewScrollView=viewScrollView;
        _viewScrollView.delegateDiscount=self;
        viewScrollView.pageControl.frameYH=185+kTopHeight-64-60-15;
        HomeCenterCellView*viewxx=[HomeCenterCellView viewWithFrame:CGRectMake(15,185+kTopHeight-64, kScreenWidth-30, 0) backgroundcolor:nil superView:viewHeader];
        [viewxx upDataMe];
        {
            UIView*viewCenterMenu=[UIView viewWithFrame:CGRectMake(0, viewxx.frameYH+15, kScreenWidth, 109) backgroundcolor:rgbwhiteColor superView:viewHeader];
            
//            NSArray*arraytitle=@[@"自助找車",@"快捷租車",@"超值租車",@"租新車",@"特殊车辆",];
            NSArray*arraytitle=@[kS(@"KeyHome", @"selfHelpFindingCar"),
                                 kS(@"KeyHome", @"quickRentCar"),
                                 kS(@"KeyHome", @"overFlowRentCar"),
                                 kS(@"KeyHome", @"newRentCar"),
                                 kS(@"KeyHome", @"specialCar"),
                                 ];
            NSArray*arrayImage=@[@"homei",@"homei1",@"homei2",@"homei3",@"homei4",];
            float width=(kScreenWidth-30)/5;
            
            for (int i=0; i<arraytitle.count; i++) {
                WSSizeButton*viewContent=[RHMethods buttonWithframe:CGRectMake(15+i*width, 0, width, viewCenterMenu.frameHeight) backgroundColor:nil text:arraytitle[i] font:13 textColor:rgb(51,51,51) radius:0 superview:viewCenterMenu];
                
                [viewContent setBtnLableFrame:CGRectMake(0, 76-5, width, 13+10)];
                viewContent.titleLabel.textAlignment=NSTextAlignmentCenter;
                [viewContent setImageStr:arrayImage[i] SelectImageStr:nil];
                [viewContent setBtnImageViewFrame:CGRectMake(0, 20, 42, 42)];
                [viewContent imgbeCX];
                viewContent.tag=i;
                [viewContent addViewClickBlock:^(UIView *view) {
                    if (view.tag==4) {
                        [UTILITY.currentViewController pushController:[SpecialVehicleViewController class] withInfo:@{@"isspecial":@"1"} withTitle:kS(@"KeyHome", @"specialCar")];
                    }else if (view.tag==0){
                        UTILITY.selectIndex=@"0";
                        [UTILITY.CustomTabBar_zk selectedTabIndex:@"1"];
                        
                    }else if (view.tag==1){
                        UTILITY.selectIndex=@"1";
                        [UTILITY.CustomTabBar_zk selectedTabIndex:@"1"];
                        
                    }else if (view.tag==2){
                        UTILITY.selectIndex=@"2";
                        [UTILITY.CustomTabBar_zk selectedTabIndex:@"1"];
                        
                    }else if (view.tag==3){
                        //租新车
                        UTILITY.selectIndex=@"3";
                        [UTILITY.CustomTabBar_zk selectedTabIndex:@"1"];
                    }
                }];
            }
            
            viewHeader.frameHeight=viewCenterMenu.frameYH+20;
            
        }
    }
    
    {
        SectionObj*obj=[SectionObj new];
        [_mtableView.sectionArray addObject:obj];
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 59) backgroundcolor:rgbwhiteColor superView:nil];
        obj.selctionHeaderView=viewHeader;
        {
            /*UILabel*lbName=*/[RHMethods lableX:16 Y:25 W:0 Height:19 font:19 superview:viewHeader withColor:rgb(0,0,0) text:kS(@"KeyHome", @"carRecommend")];//@"車型推薦"
            /*UILabel*lbTip=*/[RHMethods RlableRX:16 Y:28 W:0 Height:13 font:13 superview:viewHeader withColor:rgb(153,153,153) text:kS(@"KeyHome", @"carRecommendHint")];//@"根據您所在城市推薦"
        }
        obj.dataArray=_dataList;
        
        [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            UIView*viewcell=[reuseView getAddValueForKey:@"viewcell"];
            
            if (viewcell==nil) {
                viewcell= [UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
                viewcell.backgroundColor=rgbwhiteColor;
                //                HomeCenterCellView
                [viewcell setAddUpdataBlock:^(id data, id weakme) {
                    UIView*viewcell=weakme;
                    NSMutableArray *arrayT=data;
//                    for (UIView*viewsub in viewcell) {
//                        <#statements#>
//                    }
                    for (int i=0; i<2; i++) {
                        HomeCellectionCellView*view1=[HomeCellectionCellView viewWithFrame:CGRectMake(15, 0, (kScreenWidth-30-10)*0.5, 0) backgroundcolor:0 superView:viewcell reuseId:[NSString stringWithFormat:@"view%d",i]];
                        if (i==1) {
                            view1.frameRX=15;
                            viewcell.frameHeight=view1.frameYH;
                        }
                        view1.tag=1999;
                        if (arrayT.count>i) {
                            view1.hidden=NO;
                            [view1 upDataMeWithData:data[i]];
                        }else{                            
                            view1.hidden=YES;
                        }
                        
                    }
                }];
            }
            
            [viewcell upDataMeWithData:Datadic];
            return viewcell;
        }];
        
        
        
    }
    
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"4" forKey:@"pagesize"];
    [dictparam setObject:@"1" forKey:@"isrec"];
    if (kUtility_Location.userCityTake) {
        [dictparam setValue:[kUtility_Location.userCityTake ojsk:@"id"] forKey:@"city_id"];
    }
    if ([kUtility_Location.userlatitude notEmptyOrNull] && [kUtility_Location.userlongitude notEmptyOrNull]) {
        [dictparam setValue:kUtility_Location.userlatitude forKey:@"lat"];
        [dictparam setValue:kUtility_Location.userlongitude forKey:@"lng"];
    }
    [_mtableView showRefresh:YES LoadMore:NO];
    _mtableView.urlString=[NSString stringWithFormat:@"car%@",dictparam.wgetParamStr];
    [_mtableView refresh];
}
#pragma mark RHTableViewDelegate
-(void)refreshDataFinished:(RHTableView *)view{
    [_dataList removeAllObjects];
    NSMutableArray *arrayt;
    for (int i=0;i<view.dataArray.count;i++) {
        if (i%2==0) {
            arrayt=[NSMutableArray new];
            [_dataList addObject:arrayt];
        }
        [arrayt addObject:view.dataArray[i]];
    }
    [view reloadData];
}
- (void)tableViewWillRefresh:(RHTableView *)view{
    [self loadDATA];
}
#pragma mark LJImageRollingViewDelegate
- (void)selectView:(LJImageRollingView *)selectView ad:(NSDictionary *)dic index:(NSInteger)index{
    if ([[dic ojsk:@"links"] notEmptyOrNull]) {
        [self pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":[dic ojsk:@"links"]}];
    }
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [dictparam setValue:@"51" forKey:@"sub"];
    [NetEngine createGetAction_LJ:[NSString stringWithFormat:@"welcome/banner%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSArray *arrT=[[resData ojk:@"data"] ojk:@"list"];
            NSMutableArray *arraytitle=[NSMutableArray new];
            for (NSDictionary *dic in arrT) {
                [arraytitle addObject:@{@"url":[dic ojsk:@"path"],@"data":dic}];
            }
            [self.viewScrollView reloadImageView:arraytitle selectIndex:0];
            
            self.viewScrollView.pageControl.frameYH=185+kTopHeight-64-20;
            
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    }];
}
#pragma mark - event listener function


#pragma mark - delegate function

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    scrollView.contentOffset.y;
//    NSLog(@"%f",scrollView.contentOffset.y);
    float fy=scrollView.contentOffset.y;
    if (fy<=5) {
        self.navView.backgroundColor=[UIColor clearColor];
        [[self.navView viewWithTag:104] setHidden:YES];
        [[self.navView viewWithTag:102] setHidden:YES];
        _imageICON.hidden=YES;
    }else{
        [[self.navView viewWithTag:104] setHidden:NO];
        [[self.navView viewWithTag:102] setHidden:NO];
        _imageICON.hidden=NO;
        if (fy<kTopHeight) {
            float f_b=fy/kTopHeight;
            self.navView.backgroundColor=RGBACOLOR(255,255,255, f_b);
            _imageICON.alpha=f_b;
        }else{
            _imageICON.alpha=1;
            self.navView.backgroundColor=rgbwhiteColor;
        }
    }
    if (fy<kTopHeight-30) {
        [self.btnSearch setTitleColor:rgbwhiteColor forState:UIControlStateNormal];
        [_btnSearch setImage:[UIImage imageNamed:@"arrowb"] forState:UIControlStateNormal];
        [self.navrightButton setImage:[UIImage imageNamed:@"noticei"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        [self.btnSearch setTitleColor:rgbTitleColor forState:UIControlStateNormal];
        [_btnSearch setImage:[UIImage imageNamed:@"arrowb1"] forState:UIControlStateNormal];
        [self.navrightButton setImage:[UIImage imageNamed:@"noticei1"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    
//    float y=scrollView.contentOffset.y;
//    if (y<40) {
//        self.navView.alpha=1;
//    }else if (y<250) {
//        self.navView.alpha=((250-y)/(250-40.0));
//    }else{
//        self.navView.alpha=0;
//    }
    
//        CGFloat pageWidth = scrollView.frame.size.width;
////        selectIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//
//
//        [self setNumValue:[NSString stringWithFormat:@"%ld/%lu",(long)selectIndex+1,(unsigned long)[mutArrayImageData count]]];
//
//        NSString *strIndex=[NSString stringWithFormat:@"%ld",(long)selectIndex];
//        btnDelete.selected=[selectIndexArray containsObject:strIndex];
    
        
}
@end
