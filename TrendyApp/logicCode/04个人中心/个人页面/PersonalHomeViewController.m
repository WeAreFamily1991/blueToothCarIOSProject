//
//  PersonalHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "PersonalHomeViewController.h"
#import "MYRHTableView.h"
#import "PersonalHomeEvaluationCellView.h"
#import "PersonalHomeMyEvaluationCellView.h"
#import "ModifyPersonalInforViewController.h"
#import "TopAverageToggleView.h"
#import "OFCScoreCellView.h"
@interface PersonalHomeViewController ()<UITableViewDelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)TopAverageToggleView*viewTop;
@property(nonatomic,strong)SectionObj*myEvalueSectionObj;
@property(nonatomic,strong)SectionObj*evalueMeSectionObj;
@property(nonatomic,strong)UIView*otherVehicleOwnerEvaluationHeaderView;
@property(nonatomic,strong)OFCScoreCellView*clzkCellView;
@property(nonatomic,strong)OFCScoreCellView*fwtdCellView;
@end

@implementation  PersonalHomeViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.otherInfo) {
        
        self.data=self.userInfo;
        [self initAll];
    }else{
        [self loadDATA];
    }
    
    
}

-(void)initAll{
    [self addView];
    if (self.viewTop.btnGroup==nil) {
        [self request];
    }else{
        [self.viewTop.btnGroup btnClickAtIndex:0];
        [self rightButton:nil image:@"writei1on" sel:@selector(editBtnClicK:)];
    }
}

-(void)editBtnClicK:(UIButton*)btn{
    [self pushController:[ModifyPersonalInforViewController class] withInfo:nil withTitle:@" "];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:_mtableView];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, H(self.view)) style:UITableViewStylePlain];
    _mtableView.delegate=self;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    [self.view sendSubviewToBack:_mtableView];
    if (@available(iOS 11.0, *)) {
        _mtableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
//        UIView*viewcell=[UIView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
//        return viewcell;
//    }];
    {
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewHeader];
        
        UIImageView*imgVBackGroudImage=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) defaultimage:@"memhead" supView:viewHeader];
        imgVBackGroudImage.frameX=0;
        UIView*viewBackGroundRing=[UIView viewWithFrame:CGRectMake(0, 0, 60+10, 60+10) backgroundcolor:RGBACOLOR(62, 131, 168, 0.5) superView:viewHeader];
        UIImageView*imgVHeaderIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 55, 60, 60) defaultimage:@"photo" supView:viewHeader];
        [imgVHeaderIcon imageWithURL:[self.data ojsk:@"icon"]];
        [imgVHeaderIcon beCX];
        viewBackGroundRing.center=imgVHeaderIcon.center;
//        boyi
        UIImageView*imgVGender=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 15.5, 15.5) defaultimage:[[self.data ojsk:@"gender"] isEqualToString:@"1"]?@"boyi":@"girli" supView:viewHeader];
        imgVGender.frameXW=viewBackGroundRing.frameXW;
        imgVGender.frameYH=viewBackGroundRing.frameYH;
        
        [viewBackGroundRing beRound];
        [imgVHeaderIcon beRound];
        UILabel*lbMyName=[RHMethods ClableY:imgVHeaderIcon.frameYH+15 W:kScreenWidth Height:16 font:16 superview:viewHeader withColor:rgbwhiteColor text:[self.data ojsk:@"nickname"]];
        
    }
    //个人简介
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbPersonalBrief=[RHMethods lableX:15 Y:24.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carOwnerMessage", @"PersonalProfile")];
        UILabel*lbContent=[RHMethods lableX:15 Y:lbPersonalBrief.frameYH+20 W:kScreenWidth-30 Height:0 font:14 superview:viewContent withColor:rgb(102, 102, 102) text:[self.data ojsk:@"intro"]];
        viewContent.frameHeight=lbContent.frameYH+10;
        
    }
    
    //个人简介
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbAuthenticationInformation=[RHMethods lableX:15 Y:24.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carOwnerMessage", @"AuthenticationInformation")];
        float width=kScreenWidth*0.25;
        
        NSArray*arraytitle=@[kS(@"carOwnerMessage", @"emailAuthentication"),
                             kS(@"carOwnerMessage", @"driverAuthentication"),
//                             kS(@"carOwnerMessage", @"drivingLicenseAuthentication"),
//                             kS(@"carOwnerMessage", @"wechatAuthentication"),
                             ];
        
        NSArray*arrayImageOn=@[@"infoic",@"infoi1c",@"infoi2c",@"infoi3c",];
        NSArray*arrayImageOf=@[@"infoi",@"infoi1",@"infoi2",@"infoi3",];
        NSArray*selectKayStr=@[@"email_auth",@"driving_auth",@"vehicle_auth",@"wechat_auth",];
        for (int i=0; i<arraytitle.count; i++) {
            WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(0+i*width, lbAuthenticationInformation.frameYH, width, 94.5) backgroundColor:nil text:arraytitle[i] font:12 textColor:rgb(153, 153, 153) radius:0 superview:viewContent];
            [btnCell setImageStr:arrayImageOf[i] SelectImageStr:arrayImageOn[i]];
            btnCell.titleLabel.textAlignment=NSTextAlignmentCenter;
            [btnCell setBtnImageViewFrame:CGRectMake(0, 23, btnCell.frameWidth, 17)];
            btnCell.imageView.contentMode=UIViewContentModeScaleAspectFit;
            [btnCell setBtnLableFrame:CGRectMake(0, btnCell.imgframeYH+13-4, width, 12+8)];
            [btnCell setTitleColor:rgb(13, 112, 161) forState:UIControlStateSelected];
            if (i==0) {
                viewContent.frameHeight=btnCell.frameYH;
            }
            if([selectKayStr[i] isEqualToString:@"email_auth"]||[selectKayStr[i] isEqualToString:@"wechat_auth"]){
                
                btnCell.selected=[[self.data ojsk:selectKayStr[i]] isEqualToString:@"1"];
            }else{
                
                btnCell.selected=[[self.data ojsk:selectKayStr[i]] isEqualToString:@"2"];
            }
        }
    }
    
    if(self.otherInfo==nil){
        
        //其他車主評價
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
            UILabel*lbTitle=[RHMethods lableX:15 Y:19.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carOwnerMessage", @"EvaluationOfOtherOwners")];
            viewContent.frameHeight=lbTitle.frameYH+10;
            UIView*viewHeader=[self otherVehicleOwnerEvaluantionHeader];
            viewHeader.frameY=viewContent.frameHeight;
            [viewContent addSubview:viewHeader];
            viewContent.frameHeight=viewHeader.frameYH;
            
        }
        //evaluationList
        {
            SectionObj*obj=[SectionObj new];
            [_mtableView.sectionArray addObject:obj];
            _evalueMeSectionObj=obj;
//            obj.dataArray=kfAry(3);
            [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
                PersonalHomeEvaluationCellView*viewcell=[PersonalHomeEvaluationCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
                [viewcell upDataMeWithData:Datadic];
                return viewcell;
            }];
            
        }
    }else{
        TopAverageToggleView*viewTop=[TopAverageToggleView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 49) backgroundcolor:rgbwhiteColor superView:self.view];
        self.viewTop=viewTop;
        NSArray*toggleDataArray=[@[@{
                                      @"title":kS(@"carOwnerMessage", @"MyEvaluation"),
                                      },
                                  @{
                                      @"title":kS(@"carOwnerMessage", @"EvaluateMe"),
                                      },] toBeMutableObj];
        [viewTop bendData:toggleDataArray withType:nil];

        _otherVehicleOwnerEvaluationHeaderView=[self otherVehicleOwnerEvaluantionHeader];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewTop];
//        [_mtableView.defaultSection.noReUseViewArray addObject:_otherVehicleOwnerEvaluationHeaderView];
          __weak __typeof(self) weakSelf = self;
        [viewTop.btnGroup setGroupChangeBlock:^(WSButtonGroup *group) {
            
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.viewTop.viewline.centerX=group.currentSelectBtn.centerX;
            }];
            [weakSelf.mtableView.defaultSection.noReUseViewArray removeObject:weakSelf.otherVehicleOwnerEvaluationHeaderView];
            [weakSelf.mtableView.sectionArray removeObject:weakSelf.myEvalueSectionObj];
            [weakSelf.mtableView.sectionArray removeObject:weakSelf.evalueMeSectionObj];
            if (group.currentindex==0) {
                [weakSelf.mtableView.sectionArray addObject:weakSelf.myEvalueSectionObj];
            }else{
                [weakSelf.mtableView.defaultSection.noReUseViewArray addObject:weakSelf.otherVehicleOwnerEvaluationHeaderView];
                [weakSelf.mtableView.sectionArray addObject:weakSelf.evalueMeSectionObj];
            }
            [weakSelf.mtableView reloadData];
            [weakSelf request];
        }];
        {
            _myEvalueSectionObj=[SectionObj new];
//            _myEvalueSectionObj.dataArray=kfAry(13);
            [_myEvalueSectionObj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
                PersonalHomeMyEvaluationCellView*viewcell=[PersonalHomeMyEvaluationCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"PersonalHomeMyEvaluationCellView"];
                [viewcell upDataMeWithData:Datadic];
                return viewcell;
            }];
        }
        {
            _evalueMeSectionObj=[SectionObj new];
//            _evalueMeSectionObj.dataArray=kfAry(13);
            [_evalueMeSectionObj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
                PersonalHomeEvaluationCellView*viewcell=[PersonalHomeEvaluationCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"PersonalHomeEvaluationCellView"];
                [viewcell upDataMeWithData:Datadic];
                return viewcell;
            }];
        }
    }
    
}
-(UIView*)otherVehicleOwnerEvaluantionHeader{
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
    viewContent.frameHeight=0;
    NSMutableArray*arraytitle=[@[
                                 @{
                                     @"name":@"linxxx2",
                                     @"classStr":@"FCWhiteLineCellView",
                                     @"requestkey":@"",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"車輛狀況",
                                     @"name":kS(@"carOwnerMessage", @"VehicleCondition"),
                                     @"classStr":@"OFCScoreCellView",
                                     @"requestkey":@"car_points_average",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"服务態度",
                                     @"name":kS(@"carOwnerMessage", @"ServiceAttitude"),
                                     @"classStr":@"OFCScoreCellView",
                                     @"requestkey":@"service_points_average",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"linxxx2",
                                     @"classStr":@"FCWhiteLineCellView",
                                     @"requestkey":@"",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 ] toBeMutableObj];
    for (int i=0; i<arraytitle.count; i++) {
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:arraytitle[i]];
        viewCell.frameY=viewContent.frameHeight;
        viewContent.frameHeight=viewCell.frameYH+10;
        [viewContent addSubview:viewCell];
        viewCell.userInteractionEnabled=NO;
        if ([[arraytitle[i] ojsk:@"requestkey"] isEqualToString:@"car_points_average"]) {
            _clzkCellView=(id)viewCell;
        }
        if ([[arraytitle[i] ojsk:@"requestkey"] isEqualToString:@"service_points_average"]) {
            _fwtdCellView=(id)viewCell;
        }
    }
    [UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight-1, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
    return viewContent;
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    __weak __typeof(self) weakSelf = self;
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        if (weakSelf.otherInfo==nil) {
            [pageOrPageSizeData setObject:weakSelf.userInfo forKey:@"uid"];
            weakSelf.evalueMeSectionObj.dataArray=weakSelf.mtableView.dataArray;
            [kUserCenterService ucenter_userhome:pageOrPageSizeData withBlock:^(id data, int status, NSString *msg) {
                [weakSelf.clzkCellView setValueStr:[data ojsk:@"car_points_average"]];
                [weakSelf.fwtdCellView setValueStr:[data ojsk:@"service_points_average"]];
                dataCallBack(data,status,msg);
            }];
            return ;
        }
        if (weakSelf.viewTop.btnGroup.currentindex==1||weakSelf.viewTop.btnGroup==nil) {
            
            weakSelf.evalueMeSectionObj.dataArray=weakSelf.mtableView.dataArray;
            [kUserCenterService ucenter_commented:pageOrPageSizeData withBlock:^(id data, int status, NSString *msg) {
                [weakSelf.clzkCellView setValueStr:[data ojsk:@"car_points_average"]];
                [weakSelf.fwtdCellView setValueStr:[data ojsk:@"service_points_average"]];
                dataCallBack(data,status,msg);
                
//                [[weakSelf.viewTop.data firstObject] setObject:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"MyEvaluation"),[data ojsk:@"comment_num"]] forKey:@"title"];
//                [[weakSelf.viewTop.data lastObject] setObject:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"EvaluateMe"),[data ojsk:@"commented_num"]] forKey:@"title"];
                
                [[weakSelf.viewTop.btnGroup.buttonArray firstObject] setTitle:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"MyEvaluation"),[data ojsk:@"comment_num"]] forState:UIControlStateNormal];
                [[weakSelf.viewTop.btnGroup.buttonArray lastObject] setTitle:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"EvaluateMe"),[data ojsk:@"commented_num"]] forState:UIControlStateNormal];
                
            }];
        }else{
            weakSelf.myEvalueSectionObj.dataArray=weakSelf.mtableView.dataArray;
            [kUserCenterService ucenter_comment:pageOrPageSizeData withBlock:^(id data, int status, NSString *msg) {
                dataCallBack(data,status,msg);
                [[weakSelf.viewTop.btnGroup.buttonArray firstObject] setTitle:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"MyEvaluation"),[data ojsk:@"comment_num"]] forState:UIControlStateNormal];
                [[weakSelf.viewTop.btnGroup.buttonArray lastObject] setTitle:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"EvaluateMe"),[data ojsk:@"commented_num"]] forState:UIControlStateNormal];
//                [[weakSelf.viewTop.btnGroup.buttonArray firstObject] setObject:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"MyEvaluation"),[data ojsk:@"comment_num"]] forKey:@"title"];
//                [[weakSelf.viewTop.data lastObject] setObject:[NSString stringWithFormat:@"%@(%@)",kS(@"carOwnerMessage", @"EvaluateMe"),[data ojsk:@"commented_num"]] forKey:@"title"];
            }];
        }
    }];
    
    
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server
-(void)loadDATA{
//    krequestParam
    NSMutableDictionary*dictparam=[NSMutableDictionary new];
    [dictparam setObject:self.userInfo forKey:@"uid"];
    [dictparam setObject:@"1" forKey:@"page"];
    [dictparam setObject:@"1" forKey:@"pagesize"];
      __weak __typeof(self) weakSelf = self;
    [NetEngine createPostAction:@"ucenter/userhome" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            weakSelf.data=[dic ojk:@"userInfo"];
            [weakSelf initAll];
//            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
            //            [self addView];
            
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
        [self.navrightButton setImage:[UIImage imageNamed:@"writei1on"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        [self.backButton setImage:[UIImage imageNamed:@"arrowl"] forState:UIControlStateNormal];
        [self.navrightButton setImage:[UIImage imageNamed:@"writei1"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
