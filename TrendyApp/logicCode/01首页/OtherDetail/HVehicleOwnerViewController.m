//
//  PersonalHomeViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "HVehicleOwnerViewController.h"
#import "MYRHTableView.h"
#import "RentCarHomeCellView.h"
#import "XHStarRateView.h"
@interface HVehicleOwnerViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)SectionObj*myEvalueSectionObj;
@end

@implementation  HVehicleOwnerViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    //    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
    //        UIView*viewcell=[UIView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
    //        return viewcell;
    //    }];
    {
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewHeader];
        
        UIImageView*imgVBackGroudImage=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 165) defaultimage:@"headbg" supView:viewHeader];
        imgVBackGroudImage.frameX=0;
        UIView*viewBackGroundRing=[UIView viewWithFrame:CGRectMake(0, 0, 60+10, 60+10) backgroundcolor:RGBACOLOR(62, 131, 168, 0.5) superView:viewHeader];
        UIImageView*imgVHeaderIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 55-25, 60, 60) defaultimage:@"photo" supView:viewHeader];
        [imgVHeaderIcon beCX];
        viewBackGroundRing.center=imgVHeaderIcon.center;
        UIImageView*imgVGender=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 15.5, 15.5) defaultimage:@"girli" supView:viewHeader];
        imgVGender.frameXW=viewBackGroundRing.frameXW;
        imgVGender.frameYH=viewBackGroundRing.frameYH;
        
        [viewBackGroundRing beRound];
        [imgVHeaderIcon beRound];
        UILabel*lbMyName=[RHMethods ClableY:imgVHeaderIcon.frameYH+15 W:kScreenWidth Height:16 font:16 superview:viewHeader withColor:rgbwhiteColor text:@"荀彧域"];
        
        XHStarRateView*viewStar=[XHStarRateView viewWithFrame:CGRectMake(0, lbMyName.frameYH+10, 75, 14) backgroundcolor:nil superView:viewHeader];
        [viewStar beCX];
        
        
    }
    //个人简介
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 110) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
      
        UIView*viewMediumContent=[UIView viewWithFrame:CGRectMake(15, 15, kScreenWidth-30, 80) backgroundcolor:rgb(255, 255, 255) superView:viewContent];
        float width=viewMediumContent.frameWidth/3.0;
        
        NSArray*arraytitle=@[@"90%",@"3小时内",@"90%",];
        
        NSArray*arraySubTitle=@[@"反答率",@"反答时间",@"承认率",];
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
        UILabel*lbAuthenticationInformation=[RHMethods lableX:15 Y:24.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:@"認證信息"];
        float width=kScreenWidth*0.25;
        
        NSArray*arraytitle=@[@"郵箱認證",@"駕照認證",@"行駛證認證",@"微信認證",];
        
        NSArray*arrayImageOn=@[@"infoi",@"infoi1",@"infoi2",@"infoi3",];
        for (int i=0; i<arraytitle.count; i++) {
            WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(0+i*width, lbAuthenticationInformation.frameYH, width, 94.5) backgroundColor:nil text:arraytitle[i] font:12 textColor:rgb(13, 112, 161) radius:0 superview:viewContent];
            [btnCell setImageStr:arrayImageOn[i] SelectImageStr:nil];
            btnCell.titleLabel.textAlignment=NSTextAlignmentCenter;
            [btnCell setBtnImageViewFrame:CGRectMake(0, 23, btnCell.frameWidth, 17)];
            btnCell.imageView.contentMode=UIViewContentModeScaleAspectFit;
            [btnCell setBtnLableFrame:CGRectMake(0, btnCell.imgframeYH+13-4, width, 12+8)];
            [btnCell setTitleColor:rgb(153, 153, 153) forState:UIControlStateSelected];
            if (i==0) {
                viewContent.frameHeight=btnCell.frameYH;
            }else if(i==3){
                btnCell.selected=YES;
            }
        }
    }
    
    
    //其他車主評價
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbTitle=[RHMethods lableX:15 Y:19.5 W:kScreenWidth-30 Height:17 font:17 superview:viewContent withColor:rgb(51, 51, 51) text:@"其他车辆（4）"];
        viewContent.frameHeight=lbTitle.frameYH+10;
        
    }
    //evaluationList
    {
        SectionObj*obj=[SectionObj new];
        [_mtableView.sectionArray addObject:obj];
        obj.dataArray=kfAry(3);
        [obj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            RentCarHomeCellView*viewcell=[RentCarHomeCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"RentCarHomeCellView"];
            return viewcell;
        }];
        
    }
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    
    [NetEngine createPostAction:@"<#api#>" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            //            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            
            
            [SVProgressHUD showSuccessWithStatus:@"<#成功#>"];
            //            [self addView];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
