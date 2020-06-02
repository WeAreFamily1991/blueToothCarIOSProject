//
//  MinHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MinHomeViewController.h"
#import "MYRHTableView.h"
#import "CarListViewController.h"
#import "PersonalHomeViewController.h"
#import "VehicleOwnerViewController.h"
#import "MyCollectionViewController.h"
#import "MessageCenterViewController.h"
#import "SettingViewController.h"
#import "FeedBackViewController.h"
#import "CustomerServiceCenterViewController.h"
#import "MyCertificationViewController.h"
#import "InsurerListViewController.h"
#import "MyIncomeViewController.h"
#import "MyIntegralViewController.h"
#import "SignInPageViewController.h"
#import "ModifyPersonalInforViewController.h"
#import "AppointmentRecordViewController.h"
#import "MyTXIMUIKitViewController.h"

#import "TUIKit.h"
#import "TIMFriendshipManager.h"
@interface MinHomeViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UIView*viewHeader;
@property(nonatomic,strong)UIView*scoreStatisticsView;
@property(nonatomic,strong)UILabel*lbMessage;
@end

@implementation  MinHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateStatusBarStyleLightContent];
    
    [self loadDATA];
    
}
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllUserInterface];
    
    
    
//    [self loadDATA];
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//}
-(void)initAllUserInterface{
    [self addView];
    [self navbarTitle:kST(@"myIndexPage")];
    //    [_viewTop.btnGroup btnClickAtIndex:0];
    [self rightButton:nil image:@"noticei" sel:@selector(navBtnClick:)];
    [self leftButton:nil image:@"datei" sel:@selector(navBtnClick:)];
    {
        UILabel*titlelable=[self.navView viewWithTag:101];
        titlelable.textColor=rgbwhiteColor;
    }
    {
        UIImageView*titlelable=[self.navView viewWithTag:99];
        titlelable.hidden=NO;
        titlelable.image=[UIImage imageNamed:@"memhead"];
        titlelable.contentMode=UIViewContentModeScaleAspectFill;
    }
    
    {
        UILabel*lbMessage=[RHMethods lableX:0 Y:0 W:0 Height:15 font:10 superview:self.navView withColor:rgbwhiteColor text:@"000"];
        lbMessage.backgroundColor=rgb(244,58,58);
        self.navrightButton.frameRX=10;
//          __weak __typeof(self) weakSelf = self;
        lbMessage.layer.cornerRadius=7.5;
        lbMessage.layer.masksToBounds=YES;
        [lbMessage setAddUpdataBlock:^(id data, id weakme) {
            UILabel*lbMessage=weakme;
//            lbMessage.text=@"1";
            if ([lbMessage.text notEmptyOrNull]&&lbMessage.text.integerValue>0) {
                lbMessage.hidden=NO;
                lbMessage.textAlignment=NSTextAlignmentCenter;
                lbMessage.frameWidth=[lbMessage.text widthWithFont:lbMessage.font.pointSize]+10;
                lbMessage.frameRX=6;
                lbMessage.frameBY=25;
            }else{
                lbMessage.hidden=YES;
            }
            
//            [lbMessage beRound];
        }];
        [lbMessage upDataMe];
        _lbMessage=lbMessage;
    }
    
}
-(void)navBtnClick:(UIButton*)btn{
    if (btn==self.navleftButton) {
        [self pushController:[SignInPageViewController class] withInfo:nil withTitle:kST(@"SignInStr")];
    }else if(btn==self.navrightButton){
        [self pushController:[MessageCenterViewController class] withInfo:nil withTitle:kST(@"systemMessage")];
        //        [self pushController:[MyTXIMUIKitViewController class] withInfo:nil withTitle:@"聊天"];
    }
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight-49-kIphoneXBottom) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    {
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 164-44-20) backgroundcolor:nil superView:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:viewHeader];
        [_mtableView setTableHeaderView:viewHeader];
        
        
        
        
        UIImageView*imgVBG=[RHMethods imageviewWithFrame:CGRectMake(0, 0, viewHeader.frameWidth, viewHeader.frameHeight) defaultimage:@"memhead" supView:viewHeader];//@"memhead"
        imgVBG.backgroundColor=imgVBG.backgroundColor;
        
        imgVBG.contentMode=UIViewContentModeScaleAspectFill;
        
        UIImageView*imgVMyIcon=[RHMethods imageviewWithFrame:CGRectMake(20, 0, 60, 60) defaultimage:@"photo" supView:viewHeader];
        imgVMyIcon.frameBY=27;
        [imgVMyIcon beRound];
        [imgVMyIcon addViewClickBlock:^(UIView *view) { 
             [weakSelf pushController:[PersonalHomeViewController class] withInfo:weakSelf.data withTitle:@" " withOther:@"mine"];
            
//            UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:@"个人主页" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            [alertcv addAction:[UIAlertAction actionWithTitle:@"车主" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            }]];
//            [alertcv addAction:[UIAlertAction actionWithTitle:@"非车主" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf pushController:[PersonalHomeViewController class] withInfo:weakSelf.data withTitle:@" "];
//            }]];
//            [alertcv addAction:[UIAlertAction actionWithTitle:@"修改個人信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf pushController:[ModifyPersonalInforViewController class] withInfo:nil withTitle:@" "];
//            }]];
//
//            [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//            [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
//
//            }];
            
        }];
        
        UILabel*lbName=[RHMethods lableX:imgVMyIcon.frameXW+16 Y:imgVMyIcon.frameY+10 W:kScreenWidth-120-imgVMyIcon.frameXW-16 Height:20 font:20 superview:viewHeader withColor:rgb(255, 255, 255) text:@"--"];
        UILabel*lbLable=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+9 W:0 Height:15 font:10 superview:viewHeader withColor:rgb(255, 255, 255) text:kS(@"myIndexPage", @"rental_master")];
        lbLable.textAlignment=NSTextAlignmentCenter;
        lbLable.frameWidth=lbLable.frameWidth+6*2;
        lbLable.backgroundColor=RGBACOLOR(255, 255, 255, 0.15);
        lbLable.layer.cornerRadius=3;
        UILabel*lbService=[RHMethods lableX:0 Y:0 W:0 Height:30 font:13 superview:viewHeader withColor:rgb(255, 255, 255) text:[NSString stringWithFormat:@"   %@ >      ",kS(@"myIndexPage", @"vehicle_owner_service")]];
        [lbService beRound];
        lbService.frameBY=42;
        lbService.frameX=kScreenWidth-85;
        lbService.backgroundColor=RGBACOLOR(255, 255, 255, 0.1);
        [lbService addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[VehicleOwnerViewController class] withInfo:nil withTitle:kST(@"VehicleOwnerService")];
        }];
        UILabel*lbTip=[RHMethods lableX:lbLable.frameX Y:0 W:0 Height:10 font:10 superview:viewHeader withColor:rgbwhiteColor text:kS(@"myIndexPage", @"EnjoyMoreBenefitsAfterLogin")];
        lbTip.centerY=lbLable.centerY;
        [lbName addViewClickBlock:^(UIView *view) {
            [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
                
            }];
        }];
        
        _viewHeader=viewHeader;
        [viewHeader setAddUpdataBlock:^(id data, id weakme) {
            if (weakSelf.data==nil) {
                lbName.text=kS(@"myIndexPage", @"LoginImmediately");
                lbLable.hidden=YES;
                lbTip.hidden=NO;
                lbName.userInteractionEnabled=YES;
                return ;
            }
            lbTip.hidden=YES;
            
            lbName.userInteractionEnabled=NO;
            
            [imgVMyIcon imageWithURL:[weakSelf.data ojsk:@"icon"] useProgress:NO useActivity:NO defaultImage:@"avatar-1"];
            lbName.text=[[weakSelf.data ojsk:@"nickname"] notEmptyOrNull]?[weakSelf.data ojsk:@"nickname"]:[weakSelf.data ojsk:@"email"];
            lbLable.text=[weakSelf.data ojsk:@"tagname"];
            lbLable.frameWidth=[lbLable.text widthWithFont:lbLable.font.pointSize];
            lbLable.frameWidth=lbLable.frameWidth+6*2;
            lbLable.hidden=![[weakSelf.data ojsk:@"tagname"] notEmptyOrNull];
         
        }];
    }
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 80) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*integralStatisticsLable;
        UILabel*profitStatisticsLable;
        NSArray*arrayNameStr=@[kS(@"myIndexPage", @"point"),kS(@"myIndexPage", @"profit")];
        for (int i=0; i<arrayNameStr.count; i++) {
            UILabel*lbNumber=[RHMethods lableX:0 Y:0 W:kScreenWidth*0.5 Height:24 font:24 superview:viewContent withColor:rgb(242, 84, 50) text:@"0分"];
            lbNumber.textAlignment=NSTextAlignmentCenter;
            lbNumber.frameBY=35;
            UILabel*lbNameStr=[RHMethods lableX:0 Y:lbNumber.frameYH+8 W:kScreenWidth*0.5 Height:13 font:13 superview:viewContent withColor:rgb(68, 68, 68) text:arrayNameStr[i]];
            lbNameStr.textAlignment=NSTextAlignmentCenter;
            lbNameStr.frameX=lbNumber.frameX=i==1?(kScreenWidth*0.5):0;
            
            [lbNumber setColor:rgb(238,157,32) font:Font(12) contenttext:@"分"];
            WSSizeButton*viewBtn=[WSSizeButton viewWithFrame:CGRectMake(i*kScreenWidth*0.5, 0, kScreenWidth*0.5, viewContent.frameHeight) backgroundcolor:nil superView:viewContent];
            
            
            if (i==1) {
                lbNumber.text=@"0元";
                lbNumber.textColor=rgb(238,157,32);
                [lbNumber setColor:rgb(238,157,32) font:Font(12) contenttext:@"元"];
                [viewBtn addViewClickBlock:^(UIView *view) {
                    [weakSelf pushController:[MyIncomeViewController class] withInfo:nil withTitle:kST(@"MyIncome") withOther:nil];
                }];
                profitStatisticsLable=lbNumber;
            }else{
                [viewBtn addViewClickBlock:^(UIView *view) {
                    [weakSelf pushController:[MyIntegralViewController class] withInfo:nil withTitle:kST(@"MyPoints") withOther:nil];
                }];
                integralStatisticsLable=lbNumber;
            }
            
        }
        /*UIView*viewVline=*/[UIView viewWithFrame:CGRectMake(kScreenWidth*0.5, 20, 1,40) backgroundcolor: rgb(238, 238, 238) superView:viewContent];
        _scoreStatisticsView=viewContent;
        [_scoreStatisticsView setAddUpdataBlock:^(id data, id weakme) {
            if (weakSelf.data==nil) {
                
                integralStatisticsLable.text=[NSString stringWithFormat:@"%@%@",@"0",kS(@"generalPage", @"score")];
                profitStatisticsLable.text=[NSString stringWithFormat:@"%@%@",@"0",kS(@"generalPage", @"yuan")];
                
                [integralStatisticsLable setColor:rgb(238,157,32) font:Font(12) contenttext:kS(@"generalPage", @"score")];
                [profitStatisticsLable setColor:rgb(238,157,32) font:Font(12) contenttext:kS(@"generalPage", @"yuan")];
                
                return ;
            }
            
            
            integralStatisticsLable.text=[NSString stringWithFormat:@"%@%@",[weakSelf.data ojsk:@"point"],kS(@"myIndexPage", @"branch")];
            profitStatisticsLable.text=[NSString stringWithFormat:@"%@%@",[weakSelf.data ojsk:@"cash"].formPriceStr,kS(@"myIndexPage", @"riyuan")];
            
            [integralStatisticsLable setColor:rgb(238,157,32) font:Font(12) contenttext:kS(@"myIndexPage", @"branch")];
            [profitStatisticsLable setColor:rgb(238,157,32) font:Font(12) contenttext:kS(@"myIndexPage", @"riyuan")];
        }];
    }
    
    {
        
        NSArray*arrayCell=@[@{
                                @"classStr":@"UIView",
                                @"frameY":@"10",
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui",
                                @"keyStr":@"myCertification",
                                @"title":kS(@"myIndexPage", @"myCertification"),
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui1",
                                @"keyStr":@"myCollection",
                                @"title":kS(@"myIndexPage", @"myCollection"),
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui2",
                                @"keyStr":@"insurerInformation",
                                @"title":kS(@"myIndexPage", @"insurerInformation"),
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui3",
                                @"keyStr":@"appointmentRecord",
                                @"title":kS(@"myIndexPage", @"appointmentRecord"),
                                },
                            @{
                                @"classStr":@"UIView",
                                @"frameY":@"10",
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui4",
                                @"keyStr":@"customerServiceCenter",
                                @"title":kS(@"myIndexPage", @"customerServiceCenter"),
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui5",
                                @"keyStr":@"feedBack",
                                @"title":kS(@"myIndexPage", @"feedBack"),
                                },
                            @{
                                @"classStr":@"MinHomeCellView",
                                @"icon":@"mmenui6",
                                @"keyStr":@"setUp",
                                @"title":kS(@"myIndexPage", @"setUp"),
                                },
                            @{
                                @"classStr":@"UIView",
                                @"frameY":@"10",
                                },
                            ];
        for (int i=0; i<arrayCell.count; i++) {
            UIView*view=[UIView getViewWithConfigData:arrayCell[i]];
            [_mtableView.defaultSection.noReUseViewArray addObject:view];
            [view addViewTarget:self select:@selector(menuBtnClick:)];
        }
        
    }

    
}
-(void)menuBtnClick:(UIView*)cellView{
    NSString*titleStr=[cellView.data ojsk:@"title"];
    NSString*keyStr=[cellView.data ojsk:@"keyStr"];
//    [self pushController:[CarListViewController class] withInfo:nil withTitle:@"車輛列表"];
    if ([keyStr isEqualToString:@"myCollection"]) {
        [self pushController:[MyCollectionViewController class] withInfo:nil withTitle:titleStr];
    }else    if ([keyStr isEqualToString:@"setUp"]) {
        [self pushController:[SettingViewController class] withInfo:nil withTitle:titleStr];
    }else    if ([keyStr isEqualToString:@"feedBack"]) {
        [self pushController:[FeedBackViewController class] withInfo:nil withTitle:titleStr];
    }else    if ([keyStr isEqualToString:@"customerServiceCenter"]) {
        
        [self pushController:[CustomerServiceCenterViewController class] withInfo:nil withTitle:titleStr];
    }else    if ([keyStr isEqualToString:@"myCertification"]) {
        if (self.data==nil) {
            return;
        }
        [self pushController:[MyCertificationViewController class] withInfo:self.data withTitle:kST(@"IdentityAuthentication")];
    }else    if ([keyStr isEqualToString:@"insurerInformation"]) {
        [self pushController:[InsurerListViewController class] withInfo:nil withTitle:titleStr withOther:@"userCenter"];
    }else    if ([keyStr isEqualToString:@"appointmentRecord"]) {
        [self pushController:[AppointmentRecordViewController class] withInfo:nil withTitle:titleStr withOther:nil];
    }
//AppointmentRecordViewController
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
    
    __weak __typeof(self) weakSelf = self;
    if (!kUtility_Login.isLogIn) {
        self.data=nil;
        [weakSelf.viewHeader upDataMe];
        [weakSelf.scoreStatisticsView upDataMe];
        weakSelf.lbMessage.text=@"0";
        [weakSelf.lbMessage upDataMe];
        return;
    }
    

    
    
    [kUserCenterService getUserCenterIndexData:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        
        if ([kUtility_Login.userAccount rangeOfString:@"@"].length==0) {
            kUtility_Login.userAccount=[weakSelf.data ojsk:@"email"];
        }
        [weakSelf.viewHeader upDataMe];
        [weakSelf.scoreStatisticsView upDataMe];
    }];
    [kUserCenterService ucenter_getnoticesindex:@{} withBlock:^(id data, int status, NSString *msg) {
        
        
        TIMManager *manager = [TIMManager sharedInstance];
        NSArray *convs = [manager getConversationList];
        
        int noread=0;
        for (TIMConversation *conv in convs) {
            if([conv getType] == TIM_SYSTEM){
                continue;
            }
            noread += [conv getUnReadMessageNum];
        }
        
        weakSelf.lbMessage.text=[NSString stringWithFormat:@"%d",[data ojsk:@"count"].intValue+noread];
//        weakSelf.lbMessage.text=@"123443";
        [weakSelf.lbMessage upDataMe];
    }];
    [SVProgressHUD dismiss];
    
}
- (BaseViewController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other tabBar:(BOOL)tbool pushAdimated:(BOOL)abool{
    
    if ([SettingViewController class]==controller) {
          return [super pushController:controller withInfo:info withTitle:title withOther:other tabBar:tbool pushAdimated:abool];
    }
    
    if (!kUtility_Login.isLogIn) {
        
        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
            [super pushController:controller withInfo:info withTitle:title withOther:other tabBar:tbool pushAdimated:abool];
        }];
        return nil;
    }
    
    return [super pushController:controller withInfo:info withTitle:title withOther:other tabBar:tbool pushAdimated:abool];
}

#pragma mark - event listener function


#pragma mark - delegate function


@end
