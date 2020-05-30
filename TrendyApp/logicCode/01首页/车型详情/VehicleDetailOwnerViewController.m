//
//  PersonalHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "VehicleDetailOwnerViewController.h"
#import "MYRHTableView.h"
#import "PersonalHomeEvaluationCellView.h"
#import "PersonalHomeMyEvaluationCellView.h"
#import "ModifyPersonalInforViewController.h"
#import "TopAverageToggleView.h"
#import "OFCScoreCellView.h"
#import "XHStarRateView.h"
#import "MyCollectionCellView.h"
@interface VehicleDetailOwnerViewController ()<UITableViewDelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
//@property(nonatomic,strong)TopAverageToggleView*viewTop;
//@property(nonatomic,strong)SectionObj*myEvalueSectionObj;
@property(nonatomic,strong)SectionObj*evalueMeSectionObj;
//@property(nonatomic,strong)UIView*otherVehicleOwnerEvaluationHeaderView;
//@property(nonatomic,strong)OFCScoreCellView*clzkCellView;
//@property(nonatomic,strong)OFCScoreCellView*fwtdCellView;
@end

@implementation  VehicleDetailOwnerViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDATA];
}

-(void)initAll{
    [self addView];
    [self request];
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
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    {
//        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) backgroundcolor:nil superView:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:viewHeader];
//
//        UIImageView*imgVBackGroudImage=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) defaultimage:@"memhead" supView:viewHeader];
//        imgVBackGroudImage.frameX=0;
//        UIView*viewBackGroundRing=[UIView viewWithFrame:CGRectMake(0, 0, 60+10, 60+10) backgroundcolor:RGBACOLOR(62, 131, 168, 0.5) superView:viewHeader];
//        UIImageView*imgVHeaderIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 55, 60, 60) defaultimage:@"photo" supView:viewHeader];
//        [imgVHeaderIcon imageWithURL:[self.data ojsk:@"icon"]];
//        [imgVHeaderIcon beCX];
//        viewBackGroundRing.center=imgVHeaderIcon.center;
//        //        boyi
//        UIImageView*imgVGender=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 15.5, 15.5) defaultimage:[[self.data ojsk:@"gender"] isEqualToString:@"1"]?@"boyi":@"girli" supView:viewHeader];
//        imgVGender.frameXW=viewBackGroundRing.frameXW;
//        imgVGender.frameYH=viewBackGroundRing.frameYH;
//
//        [viewBackGroundRing beRound];
//        [imgVHeaderIcon beRound];
//        UILabel*lbMyName=[RHMethods ClableY:imgVHeaderIcon.frameYH+15 W:kScreenWidth Height:16 font:16 superview:viewHeader withColor:rgbwhiteColor text:[self.data ojsk:@"nickname"]];
//
//    }
    {
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewHeader];
        
        UIImageView*imgVBackGroudImage=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) defaultimage:@"headbg" supView:viewHeader];
        imgVBackGroudImage.frameX=0;
        UIView*viewBackGroundRing=[UIView viewWithFrame:CGRectMake(0, 0, 60+10, 60+10) backgroundcolor:RGBACOLOR(62, 131, 168, 0.5) superView:viewHeader];
        UIImageView*imgVHeaderIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 55-25, 60, 60) defaultimage:@"photo" supView:viewHeader];
        [imgVHeaderIcon imageWithURL:[self.data ojsk:@"icon"]];
        [imgVHeaderIcon beCX];
        viewBackGroundRing.center=imgVHeaderIcon.center;
        UIImageView*imgVGender=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 15.5, 15.5) defaultimage:[[self.data ojsk:@"gender"] isEqualToString:@"1"]?@"boyi":@"girli" supView:viewHeader];
        imgVGender.frameXW=viewBackGroundRing.frameXW;
        imgVGender.frameYH=viewBackGroundRing.frameYH;
        
        [viewBackGroundRing beRound];
        [imgVHeaderIcon beRound];
        UILabel*lbMyName=[RHMethods ClableY:imgVHeaderIcon.frameYH+15 W:kScreenWidth Height:16 font:16 superview:viewHeader withColor:rgbwhiteColor text:[self.data ojsk:@"nickname"]];
        
        XHStarRateView*viewStar=[XHStarRateView viewWithFrame:CGRectMake(0, lbMyName.frameYH+10, 75, 14) backgroundcolor:nil superView:viewHeader];
        [viewStar beCX];
        viewStar.currentScore=[self.data ojsk:@"star"].floatValue;
        
        
    }
    //个人简介
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 110) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        
        UIView*viewMediumContent=[UIView viewWithFrame:CGRectMake(15, 15, kScreenWidth-30, 80) backgroundcolor:rgb(255, 255, 255) superView:viewContent];
        float width=viewMediumContent.frameWidth/3.0;
        
//        NSArray*arraytitle=@[[self.data ojsk:@"answer_rate"],[self.data ojsk:@"answer_time"],[self.data ojsk:@"confirm_rate"],];
//
//        NSArray*arraySubTitle=@[kS(@"carOwnerMessage", @"answerRate"),kS(@"carOwnerMessage", @"answerTime"),kS(@"carOwnerMessage", @"confirmRate"),];
        NSArray*arraytitle=@[[self.data ojsk:@"confirm_rate"],[self.data ojsk:@"answer_time"],[self.data ojsk:@"answer_rate"],];
        
        NSArray*arraySubTitle=@[kS(@"carOwnerMessage", @"confirmRate"),kS(@"carOwnerMessage", @"answerTime"),kS(@"carOwnerMessage", @"answerRate"),];
//        NSArray*arraySubTitle2=@[@"反答率",@"反答时间",@"承认率",];
        for (int i=0; i<arraytitle.count; i++) {
            UIView*viewSmallCellContent=[UIView viewWithFrame:CGRectMake(i*width, 0, width, viewMediumContent.frameHeight) backgroundcolor:nil superView:viewMediumContent];
            UILabel*lbLarge=[RHMethods ClableY:20 W:viewSmallCellContent.frameWidth Height:16 font:16 superview:viewSmallCellContent withColor:rgb(51, 51, 51) text:arraytitle[i]];
            UILabel*lbDescribe=[RHMethods ClableY:lbLarge.frameYH+8 W:lbLarge.frameWidth Height:12 font:12 superview:viewSmallCellContent withColor:rgb(102, 102, 102) text:arraySubTitle[i]];
            if (i!=0) {
                UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 1, 37) backgroundcolor: rgb(238, 238, 238) superView:viewSmallCellContent];
                [viewLine beCY];
            }
        }
        viewMediumContent.layer.borderColor=rgb(238, 238, 238).CGColor;
        viewMediumContent.layer.borderWidth=1;
        viewMediumContent.layer.cornerRadius=5;
        
    }
    
    //个人简介
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbAuthenticationInformation=[RHMethods lableX:15 Y:24.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"carOwnerMessage", @"AuthenticationInformation")];
        float width=kScreenWidth*0.25;
        
        NSArray*arraytitle=@[kS(@"carOwnerMessage", @"emailAuthentication"),kS(@"carOwnerMessage", @"driverAuthentication"),kS(@"carOwnerMessage", @"drivingLicenseAuthentication"),kS(@"carOwnerMessage", @"wechatAuthentication"),];
        
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
    
    //其他車主評價 otherCar
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbTitle=[RHMethods lableX:15 Y:19.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:[NSString stringWithFormat:@"%@",kS(@"carOwnerMessage", @"otherCar")]];
        viewContent.frameHeight=lbTitle.frameYH+10;
        
    }
    //evaluationList
    {
        SectionObj*obj=[SectionObj new];
        [_mtableView.sectionArray addObject:obj];
        _evalueMeSectionObj=obj;
        //            obj.dataArray=kfAry(3);
        [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            MyCollectionCellView*viewcell=[MyCollectionCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"MyCollectionCellView"];
            [viewcell upDataMeWithData:Datadic];
            viewcell.collectionBtn.hidden=YES;
            return viewcell;
        }];
        
    }
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    __weak __typeof(self) weakSelf = self;
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        if (weakSelf.otherInfo==nil) {
            [pageOrPageSizeData setObject:weakSelf.userInfo forKey:@"caruid"];
            weakSelf.evalueMeSectionObj.dataArray=weakSelf.mtableView.dataArray;
            [kUserCenterService car_carucenter:pageOrPageSizeData withBlock:^(id data, int status, NSString *msg) {
//                [weakSelf.clzkCellView setValueStr:[data ojsk:@"car_points_average"]];
//                [weakSelf.fwtdCellView setValueStr:[data ojsk:@"service_points_average"]];
                dataCallBack(data,status,msg);
            }];
            return ;
        }
    }];
//
    
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server
-(void)loadDATA{
        krequestParam
//    NSMutableDictionary*dictparam=[NSMutableDictionary new];
    [dictparam setObject:self.userInfo forKey:@"caruid"];
    [dictparam setObject:@"1" forKey:@"page"];
    [dictparam setObject:@"1" forKey:@"pagesize"];
    __weak __typeof(self) weakSelf = self;
    [NetEngine createPostAction:@"car/carucenter" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
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
