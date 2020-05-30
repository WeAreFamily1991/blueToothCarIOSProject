//
//  RentCarHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "RentCarHomeViewController.h"
#import "MYRHTableView.h"
#import "WSButtonGroup.h"
//#import "SelfHelpFindingCarHeaderView.h"
#import "RentCarExpressCenterCellView.h"
#import "SuperLongRentalCenterView.h"
#import "CommonProblemViewController.h"
#import "ApplicationForAppointmentViewController.h"
#import "ExpressCarRentViewController.h"
#import "ChooseAStoreViewController.h"

#import "CarSearchTypeTopView.h"
#import "MyCollectionCellView.h"
#import "ApplicationForReservationFindCellView.h"
#import "UtilitySelectTime.h"
#import "SuperLongRentalCarView.h"
#import "GoogleMapMyViewController.h"
#import "Utility_Location.h"

@interface RentCarHomeViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView1;
@property(nonatomic,strong)MYRHTableView*mtableView2;
@property(nonatomic,strong)MYRHTableView*mtableView3;
@property(nonatomic,strong)MYRHTableView*mtableView4;
@property(nonatomic,strong)WSButtonGroup*btnGroup;
//@property(nonatomic,strong)WSButtonGroup*btnGroupTableview3;
@property(nonatomic,strong)UIView*viewNav;
@property(nonatomic,strong)WSSizeButton*mapBtn;
@property(nonatomic,strong)ApplicationForReservationFindCellView *viewCellTemp;
@property(nonatomic,strong)SuperLongRentalCenterView *viewLongRental;
@property(nonatomic,strong)SuperLongRentalCarView *viewCarScoroll;
@end

@implementation  RentCarHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateStatusBarStyleLightContent];
    if ([UTILITY.selectIndex notEmptyOrNull]) {
        [_btnGroup btnClickAtIndex:[UTILITY.selectIndex intValue]];
        UTILITY.selectIndex=nil;
    }
    [UTILITY setAddValue:@"" forKey:@"mySelect"];
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
      __weak __typeof(self) weakSelf = self;
    _mapBtn=[WSSizeButton viewWithFrame:CGRectMake(0, 0, 70,70) backgroundcolor:nil superView:self.view];
    _mapBtn.frameRX=10;
    _mapBtn.frameBY=30+49+kIphoneXBottom;
    [_mapBtn setImageStr:@"address0" SelectImageStr:nil];
    
    [_mapBtn addViewClickBlock:^(UIView *view) {
       
        [weakSelf pushController:[GoogleMapMyViewController class] withInfo:nil withTitle:@" "];
    }];
    
    [_btnGroup btnClickAtIndex:0];
//    {
//         WSSizeButton*btnOtherPage=[RHMethods buttonWithframe:CGRectMake(0, kTopHeight-44, 80, 30) backgroundColor:RGBACOLOR(255, 255, 255, 0.3) text:@"其他页面" font:15 textColor:rgb(51, 51, 51) radius:10 superview:self.view];
//        [btnOtherPage addViewTarget:self select:@selector(otherPageBtnClick:)];
//        
//    }
    
    
    [kUtility_Location addEventWithObj:self actionTypeArray:@[@"SaveSelectUserCityUpdate"] reUseID:@"xxxxx" WithBlcok:^(MYBaseService *obj) {
        [weakSelf request4];
    }];
    [kUtility_Location readUserLocationFromDefault:^(id data, int status, NSString *msg) {
//        [weakSelf request4];
    }];
}
//-(void)otherPageBtnClick:(UIButton*)btn{
//    UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:@"其他頁面" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertcv addAction:[UIAlertAction actionWithTitle:@"常见问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self pushController:[CommonProblemViewController class] withInfo:nil withTitle:@"常见问题"];
//    }]];
//    [alertcv addAction:[UIAlertAction actionWithTitle:@"申請預約" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self pushController:[ApplicationForAppointmentViewController class] withInfo:nil withTitle:@"申請預約"];
//    }]];
//    [alertcv addAction:[UIAlertAction actionWithTitle:@"快捷租车" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self pushController:[ExpressCarRentViewController class] withInfo:nil withTitle:@"快捷租车"];
//    }]];
//    [alertcv addAction:[UIAlertAction actionWithTitle:@"選擇門店" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self pushController:[ChooseAStoreViewController class] withInfo:nil withTitle:@"選擇門店"];
//    }]];
//
//    [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
//    }];
//}
#pragma mark -   write UI
-(void)addView{
    
    _btnGroup=[WSButtonGroup new];
    UIView*viewNav=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight+108-64) backgroundcolor:nil superView:self.view];
    _viewNav=viewNav;
    UIImageView *iamgeBG=[RHMethods imageviewWithFrame:viewNav.bounds defaultimage:@"headerbg" contentMode:UIViewContentModeScaleToFill];
//    iamgeBG.tag=99;//stretchW:10 stretchH:10
    [viewNav addSubview:iamgeBG];
    iamgeBG.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    {
        NSArray*arrayImage=@[@"ricon1",@"ricon2",@"ricon3",@"ricon4",];
//        NSArray*arrayTitle=@[@"自助找車",@"快捷租車",@"超值長租",@"租新車",];
        NSArray *arrayTitle=@[kS(@"KeyHome", @"selfHelpFindingCar"),
                             kS(@"KeyHome", @"quickRentCar"),
                             kS(@"KeyHome", @"overFlowRentCar"),
                             kS(@"KeyHome", @"newRentCar"),
                             kS(@"KeyHome", @"specialCar"),
                             ];
        float mywidth=kScreenWidth/4;
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 46, 8) defaultimage:@"ron" supView:viewNav];
        imgVRow.frameBY=-2;
        
          __weak __typeof(self) weakSelf = self;
        [_btnGroup setGroupChangeBlock:^(WSButtonGroup *group) {
            imgVRow.centerX=group.currentSelectBtn.centerX;
            weakSelf.mtableView1.hidden=YES;
            weakSelf.mtableView2.hidden=YES;
            weakSelf.mtableView3.hidden=YES;
            weakSelf.mtableView4.hidden=YES;
            weakSelf.mapBtn.hidden=YES;
            if (group.currentindex==0) {
                 weakSelf.mtableView1.hidden=NO;
                weakSelf.mapBtn.hidden=NO;
                if ([[weakSelf.mtableView1.dataDic allKeys] count]==0) {
//                    [weakSelf request1];
                    [weakSelf.viewCellTemp updateData];
                }
            }else  if (group.currentindex==1) {
                 weakSelf.mtableView2.hidden=NO;
            }else  if (group.currentindex==2) {
                 weakSelf.mtableView3.hidden=NO;
                [weakSelf loadRentalIndex];
            }else  if (group.currentindex==3) {
                 weakSelf.mtableView4.hidden=NO;
                if ([[weakSelf.mtableView4.dataDic allKeys] count]==0) {
                    [weakSelf request4];
                }
            }
        
        
        }];
        for (int i=0; i<arrayImage.count; i++) {
             WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(mywidth*i, 0, mywidth, 39+24) backgroundColor:nil text:arrayTitle[i] font:12 textColor:rgbwhiteColor radius:0 superview:viewNav];
            btnCell.frameBY=0;
            [btnCell setImageStr:arrayImage[i] SelectImageStr:nil];
            btnCell.imageView.contentMode=UIViewContentModeScaleAspectFit;
            [btnCell setBtnImageViewFrame:CGRectMake(0, 0, mywidth, 27)];
            [btnCell setBtnLableFrame:CGRectMake(0, 32-2, mywidth, 12+4)];
            btnCell.titleLabel.textAlignment=NSTextAlignmentCenter;
            [_btnGroup addButton:btnCell];
        }
        
    }
    
    [self loadTableView1];

    [self loadTableView2];

    [self loadTableView3];

    [self loadTableView4];
    
}
-(void)loadTableView1{
    _mtableView1= [self getMytableView];
    {
        UIView *viewHeader=[RHMethods viewWithFrame:CGRectMake(0, 0, kScreenWidth, 10) backgroundcolor:nil superView:nil];
        ApplicationForReservationFindCellView *viewCell2 = [ApplicationForReservationFindCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:viewHeader];
        _viewCellTemp=viewCell2;        
        [viewCell2 setAddValue:kUtilitySelectTime.selectHomeDate forKey:@"SelectDate"];
        viewCell2.type=@"租车首页";
        [viewCell2 upDataMeWithData:nil];
//        SelfHelpFindingCarHeaderView*viewTop=[SelfHelpFindingCarHeaderView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:viewHeader];
        viewHeader.frameHeight=YH(viewCell2)+10;
        _mtableView1.tableHeaderView=viewHeader;
        
        _mtableView1.floatContentY=H(viewHeader)+100;
    }
    
    {
        SectionObj*obj=_mtableView1.defaultSection;//[SectionObj new];
//        [_mtableView1.sectionArray addObject:obj];
        __weak typeof(self) weakSelf=self;
        CarSearchTypeTopView *viewTopSelectView=[CarSearchTypeTopView  viewWithFrame:CGRectMake(0, 0, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:nil];
        [viewTopSelectView changeValuePopViewBlock:^(id data, int status, NSString *msg) {
            [weakSelf setAddValue:data forKey:@"CarSearchType1"];
            [weakSelf request1];
        }];
        obj.selctionHeaderView=viewTopSelectView;
        [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            MyCollectionCellView*viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
            viewcell.collectionBtn.hidden=YES;
            if ([weakSelf getAddValueForKey:@"selectAddressDate"]) {
                viewcell.between_time=[[weakSelf getAddValueForKey:@"selectAddressDate"] ojsk:@"between_time"];
            }
            [Datadic setObject:@"自助找车" forKey:@"mySelect"];
            
            [viewcell upDataMeWithData:Datadic];
            return viewcell;
        }];
    }
}
-(void)loadTableView2{
    _mtableView2= [self getMytableView];
    _mtableView2.backgroundColor=rgbwhiteColor;
    UIView *viewHeader=[RHMethods viewWithFrame:CGRectMake(15, 15, kScreenWidth-30, (kScreenWidth-30)*100.0/345) backgroundcolor:rgbwhiteColor superView:nil];
    UIImageView*imgVHeader=[RHMethods imageviewWithFrame:viewHeader.bounds defaultimage:@"ii-img01" supView:viewHeader];
    imgVHeader.contentMode=UIViewContentModeScaleToFill;
    imgVHeader.layer.cornerRadius=8;
    [self addShadowToView:viewHeader withColor:[UIColor blackColor]];
    [_mtableView2.defaultSection.noReUseViewArray addObject:viewHeader];
    
     RentCarExpressCenterCellView *viewcell=[RentCarExpressCenterCellView viewWithFrame:CGRectMake(15, 15, (kScreenWidth-30), 0) backgroundcolor:rgbwhiteColor superView:nil reuseId:nil];
    [viewcell setAddValue:kUtilitySelectTime.selectHomeDate forKey:@"SelectDate"];
    [viewcell upDataMeWithData:nil];
    [self addShadowToView:viewcell withColor:[UIColor blackColor]];
    [_mtableView2.defaultSection.noReUseViewArray addObject:viewcell];
    kOrderService.apiUrl(@"car/getpath").success(^(id data, NSString *msg) {
        [imgVHeader imageWithURL:[data ojsk:@"wappath"]];
    }).startload();
    
    
}

/*
 

 执行力的因素
  1要知道做什么
  2要知道怎么做
  3做起来要流畅
  4要知道做好了有什么好处
  5要知道做不好有什么惩罚
  
  
  1要知道做什么
  任务要明确,没有明确的任务就没法执行
  2要知道怎么做
  不知道怎么做,干着急也不会出结果,慢慢的就不想做了
  3做起来要流畅
  做起来遇见各种问题就慢慢的没有耐心了,所以要流程优化,八仙过海难成系统,也很难推广,
  4要知道做好了有什么好处
  上面的都实现了,但是不知道做好了有什么好处,也会慢慢的疲惫了.可以是口头鼓励,也可以是奖励,肯定完成的成果.
  5要知道做不好有什么惩罚
  上面都好了,做的时间长了,人可能偶尔变懒了,死气沉沉的,无欲无求的,所以也需要惩罚.可以是口头的,可以各种的
 赏罚都是为了引导一个正确的价值观,
  
  总的来说就是,
  任务交接要明确,
  流程要优化,
  制度完善,赏罚要分明
 
 
 1、项目成果（你做了什么）
 2、项目的重、难点分析和解决方案。
 3、项目中遇到的最大困难是什么？
 4、项目中学到什么？值得推广的有？
 5、跨部门沟通方面
 
 相对于上一个项目我们有什么进步，闪光点（技术方面，团队合作方面，流程优化方面）？
 
 如果重新完成这个项目，你会做出哪些改进或者有什么合理的建议（技术方面，团队合作方面，流程优化方面）？
 
 这次与我们合作的其他团队有哪些优点？有哪些值得我们借鉴的地方？
 
 我们对其他团队有哪些合理的建议？
 
 优点的继续发扬，不足的指出并给出意见
 
 相对于上一个项目我们有什么进步，闪光点（技术方面，团队合作方面，流程优化方面）？
 相对于上一个项目我(自己 与 团队) 有什么进步，闪光点（技术方面，团队合作方面，流程优化方面）？
 怕只谈个人，或者只谈团队
 
 
 
 */
-(void)loadTableView3{
    __weak typeof(self) weakSelf=self;
    _mtableView3= [self getMytableView];
      SuperLongRentalCenterView*viewcell=[SuperLongRentalCenterView viewWithFrame:CGRectMake(0, 0, (kScreenWidth-0), 0) backgroundcolor:nil superView:nil reuseId:nil];
    _viewLongRental=viewcell;
    [_mtableView3.defaultSection.noReUseViewArray addObject:viewcell];
    _mtableView3.backgroundColor=rgbwhiteColor;
    
    UIView*viewSwichContent=[UIView viewWithFrame:CGRectMake(0, 15, kScreenWidth, 264) backgroundcolor:rgbwhiteColor superView:nil];
    [_mtableView3.defaultSection.noReUseViewArray addObject:viewSwichContent];
    {
        SuperLongRentalCarView *viewScoroll=[SuperLongRentalCarView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 155) backgroundcolor:rgbwhiteColor superView:viewSwichContent];
        _viewCarScoroll=viewScoroll;
        [_viewCarScoroll didChangeValueWithBlock:^(id data, int status, NSString *msg) {
            [weakSelf.viewLongRental upDataMeWithData:data];
            [weakSelf.mtableView3 reloadData];
        }];
         WSSizeButton*btnShenqing=[RHMethods buttonWithframe:CGRectMake(15, viewScoroll.frameYH+5, viewSwichContent.frameWidth-30, 44) backgroundColor:rgb(13,112,161) text:kS(@"longRental", @"applyBooking") font:16 textColor:rgb(255,255,255) radius:5 superview:viewSwichContent];
        [btnShenqing addViewClickBlock:^(UIView *view) {
           ///选中数据
//            weakSelf.viewLongRental.data
//            [weakSelf pushController:[ApplicationForAppointmentViewController class] withInfo:[weakSelf.viewLongRental.data ojsk:@"id"] withTitle:kS(@"longRental", @"applyBooking")];
            [weakSelf pushController:[ApplicationForAppointmentViewController class] withInfo:[weakSelf.viewLongRental.data ojsk:@"id"] withTitle:kST(@"rentLongTimeApplyBooking")];
        }];
         WSSizeButton*btnCJWT=[RHMethods buttonWithframe:CGRectMake(15, btnShenqing.frameYH, btnShenqing.frameWidth, 13+21+21) backgroundColor:nil text:[NSString stringWithFormat:@" %@",kS(@"longRental", @"faq")] font:14 textColor:rgb(88,192,255) radius:0 superview:viewSwichContent];
        [btnCJWT setImageStr:@"questioni" SelectImageStr:nil];
        [btnCJWT addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[CommonProblemViewController class] withInfo:nil withTitle:kS(@"longRental", @"faq") ];
        }];
        
    }
    
    [self loadRentalIndex];
    
}
-(void)loadTableView4{
    _mtableView4= [self getMytableView];

    
    {
        SectionObj*obj=_mtableView4.defaultSection;
        
        __weak typeof(self) weakSelf=self;
        CarSearchTypeTopView *viewTopSelectView=[CarSearchTypeTopView  viewWithFrame:CGRectMake(0, 0, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:nil];
        [viewTopSelectView changeValuePopViewBlock:^(id data, int status, NSString *msg) {
            [weakSelf setAddValue:data forKey:@"CarSearchType4"];
            [weakSelf request4];
        }];
        obj.selctionHeaderView=viewTopSelectView;
        [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            MyCollectionCellView*viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
            viewcell.collectionBtn.hidden=YES;
            [viewcell upDataMeWithData:Datadic];
            return viewcell;
        }];
        
    }
}


-(MYRHTableView*)getMytableView{
    MYRHTableView* _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, _viewNav.frameYH, kScreenWidth, H(self.view)-_viewNav.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtableView];
    _mtableView.hidden=YES;
    return _mtableView;
}

-(void)updateUIOfBtnSelect:(WSSizeButton*)btn{//11 6 4
    float myWidth=[btn.currentTitle widthWithFont:btn.titleLabel.font.pointSize];
    float myx=(btn.frameWidth-(11+6+myWidth))/2;
    [btn setBtnLableFrame:CGRectMake(myx, 0, myWidth, btn.frameHeight)];
    [btn setBtnImageViewFrame:CGRectMake(myx+myWidth+11, (btn.frameHeight-4)*0.5, 6, 4)];
    
}
#pragma mark  request data from the server use tableview
-(void)request1{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"20" forKey:@"pagesize"];
    
    if ([self getAddValueForKey:@"CarSearchType1"]) {
        [dictparam setObject:[self getAddValueForKey:@"CarSearchType1"] forKey:@"searchArr"];
    }
    if ([self getAddValueForKey:@"selectAddressDate"]) {
        [dictparam addEntriesFromDictionary:[self getAddValueForKey:@"selectAddressDate"]];
    }
    [_mtableView1 showRefresh:YES LoadMore:YES];
    _mtableView1.urlString=[NSString stringWithFormat:@"car%@",dictparam.wgetParamStr];
    [_mtableView1 refresh];
}
-(void)request4{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"20" forKey:@"pagesize"];
    [dictparam setObject:@"1" forKey:@"isnew"];
    
    if ([self getAddValueForKey:@"CarSearchType4"]) {
        [dictparam setObject:[self getAddValueForKey:@"CarSearchType4"] forKey:@"searchArr"];
    }
    NSDictionary *d_Location=kUtility_Location.userCityTake;
    if (d_Location) {
        [dictparam setValue:[d_Location ojsk:@"id"] forKey:@"city_id"];
    }
    [_mtableView4 showRefresh:YES LoadMore:YES];
    _mtableView4.urlString=[NSString stringWithFormat:@"car%@",dictparam.wgetParamStr];
    [_mtableView4 refresh];
}
-(void)loadRentalIndex{
    if (!_viewCarScoroll.data) {
        krequestParam
        [NetEngine createGetAction_LJ:@"rental/index" onCompletion:^(id resData, BOOL isCache) {
            if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                NSDictionary *dicData=[resData objectForJSONKey:@"data"];
                [self.viewCarScoroll upDataMeWithData:[dicData ojk:@"list"]];
            }else{
                [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            }
        }];
    }
}
#pragma mark - event listener function


#pragma mark - delegate function


/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.3;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 9;
    //圆角
    theView.layer.cornerRadius=8;
}
@end
