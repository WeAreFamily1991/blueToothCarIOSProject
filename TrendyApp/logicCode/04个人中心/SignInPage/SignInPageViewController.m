//
//  SignInPageViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/8.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SignInPageViewController.h"
#import "MYRHTableView.h"
#import "DateManager.h"
#import "SigninPagePopView.h"
#import "SigninPagePopView.h"
@interface SignInPageViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  SignInPageViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addView];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
//    [_mtableView removeFromSuperview];
//    _mtableView=nil;
    if (_mtableView==nil) {
        
        _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mtableView];
    }else{
        [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    }
//    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
//        UIView*viewcell=[UIView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
//        return viewcell;
//    }];
    
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 487) backgroundcolor:rgbwhiteColor superView:nil];
    UIImageView*imgVBg=[RHMethods imageviewWithFrame:viewContent.bounds defaultimage:@"signbg" supView:viewContent];
    imgVBg.contentMode=UIViewContentModeScaleAspectFill;
    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    
    {
        UIView*viewRealContent=[UIView viewWithFrame:CGRectMake(0, 20, 310, 447) backgroundcolor:rgbwhiteColor superView:viewContent];
        UIImageView*imgVTop=[RHMethods imageviewWithFrame:CGRectMake(0, 0, viewRealContent.frameWidth, 90) defaultimage:@"signbg1" supView:viewRealContent];
        {
            UILabel*lbTitle=[RHMethods ClableY:26 W:viewRealContent.frameWidth Height:22 font:22 superview:imgVTop withColor:rgb(255, 255, 255) text:[NSString stringWithFormat:@"%@%@%@",kS(@"SignInStr", @"AccumulatedCheck"),[self.data ojsk:@"num"],kS(@"SignInStr", @"day")]];
            /*UILabel*lbScore=*/[RHMethods ClableY:lbTitle.frameYH+11 W:lbTitle.frameWidth Height:13 font:13 superview:imgVTop withColor:rgb(255, 255, 255) text:[NSString stringWithFormat:@"%@%ld",kS(@"SignInStr", @"CurrentScore"),(long)[[self.data ojsk:@"userpoint"] integerValue]]];
        }
        UIView*viewSubContent=[UIView viewWithFrame:CGRectMake(0, imgVTop.frameYH-10, viewRealContent.frameWidth, viewRealContent.frameHeight-imgVTop.frameHeight+10) backgroundcolor:rgbwhiteColor superView:viewRealContent];
        [viewRealContent addSubview:imgVTop];
        viewRealContent.layer.cornerRadius=5;
        viewSubContent.layer.cornerRadius=5;
        viewSubContent.layer.borderWidth=1;
        viewSubContent.layer.borderColor=RGBACOLOR(238, 238, 238, 0.3).CGColor;
        [viewRealContent beCX];
        float calendarYh=0;
        {
            
#pragma mark 日期
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd";
            //#warning 真机调试下, 必须加上这段
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            
            NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
            NSString*tadaydatestr=[fmt stringFromDate:date];
            
            
            UILabel*lbYear=[RHMethods ClableY:15+10 W:viewSubContent.frameWidth Height:14 font:14 superview:viewSubContent withColor:rgb(13, 107, 154) text:@""];//[NSString stringWithFormat:@"%@%@",kS(@"SignInStr", @"CurrentScore"),[self.data ojsk:@""]]
            float width=(viewRealContent.frameWidth-32)/7.0;
            
            
            NSArray*arrayweekdaytitle=@[kS(@"SignInStr", @"sun"),kS(@"SignInStr", @"One"),kS(@"SignInStr", @"Two"),kS(@"SignInStr", @"Three"),kS(@"SignInStr", @"Four"),kS(@"SignInStr", @"Five"),kS(@"SignInStr", @"Six"),];
            for (int i=0; i<arrayweekdaytitle.count; i++) {
                UILabel*lbTite=[RHMethods lableX:16+i*width Y:lbYear.frameYH+20 W:width Height:15 font:15 superview:viewSubContent withColor:rgb(51, 51, 51) text:arrayweekdaytitle[i]];
                lbTite.textAlignment=NSTextAlignmentCenter;
            }
            //            NSMutableArray*marray=[[[DateManager new] geCurrentMonthDic] ojsk:@"dayArray"];
            NSMutableArray*marray=[self.data ojsk:@"monthlist"];
            for (int i=0; i<marray.count; i++) {
                NSDictionary*dataDic=marray[i];
                UIView*viewContentCell=[viewSubContent getAddValueForKey:[NSString stringWithFormat:@"viewContentCell%d",i]];
                if (viewContentCell==nil) {
                    viewContentCell= [UIView viewWithFrame:CGRectMake(23+i%7*width, lbYear.frameYH+50+i/7*35, 25, 25) backgroundcolor:nil superView:viewSubContent reuseId:[NSString stringWithFormat:@"viewContentCell%d",i]];
                    viewContentCell.tag=1999;
                    //                    viewContentCell.frameX=0;
                    //                    viewContentCell.frameY=0;
                    viewContentCell.tag=1999;
                    UILabel*lbTitle=[RHMethods ClableY:0 W:25 Height:25 font:12 superview:viewContentCell withColor:rgb(51, 51, 51) text:@"名称"];
                    //                    lbTitle.backgroundColor=rgb(153,153,153);
                    lbTitle.layer.borderColor=rgb(255,166,0).CGColor;
                    lbTitle.layer.borderWidth=1;
                    [lbTitle beRound];
                    [viewContentCell setAddUpdataBlock:^(id data, id weakme) {
                        lbTitle.text=[data ojsk:@"day"];
                        lbTitle.layer.borderWidth=[[dataDic ojsk:@"status"] isEqualToString:@"1"]?1:0;
                        if ([[data ojsk:@"date"] isEqualToString:tadaydatestr]) {
                            lbTitle.text=kS(@"SignInStr", @"thisDay");
                            lbTitle.textColor=rgbwhiteColor;
                            lbTitle.backgroundColor=rgb(255,166,0);
                        }
                        
                    }];
                }
                [viewContentCell upDataMeWithData:dataDic];
                viewContentCell.hidden=![[dataDic ojsk:@"ishave"] isEqualToString:@"1"];
                calendarYh=viewContentCell.frameYH;
                
                if (![lbYear.text notEmptyOrNull]&&viewContentCell.hidden==NO) {
                    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                    //@"yyyy%@MM%@"
                    fmt.dateFormat =@"yyyy %@ MM %@" ;
                    //#warning 真机调试下, 必须加上这段
                    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[[dataDic ojsk:@"timestamp"] floatValue]];
                    NSString*datestr=[fmt stringFromDate:date];
                    
                    lbYear.text= [NSString stringWithFormat:datestr,kS(@"SignInStr", @"year"),kS(@"SignInStr", @"month")];
//                    lbYear.text=datestr;
                }
            }
            
            WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(0, 0, 200, 44) backgroundColor:nil text:kS(@"SignInStr", @"SignInImmediately") font:16 textColor:rgbwhiteColor radius:5 superview:viewSubContent];
            [btnOK beCX];
            btnOK.frameBY=(viewSubContent.frameHeight-calendarYh-btnOK.frameHeight)*0.5;
            [btnOK setTitle:kS(@"SignInStr", @"todayAlreadySigh") forState:UIControlStateSelected];
            [btnOK setBackGroundImageviewColor:rgb(13,107,154) forState:UIControlStateNormal];
            [btnOK setBackGroundImageviewColor:rgb(204,204,204) forState:UIControlStateSelected];
            btnOK.selected=[[self.data ojsk:@"sdaytatus"] isEqualToString:@"0"];
            
            [btnOK addViewTarget:self select:@selector(okBtnClick:)];
            
        }
    }
    
    
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 106) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UIImageView*imgVIconLeft=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 105, 7) defaultimage:@"lineil" supView:viewContent];
        imgVIconLeft.frameRX=kScreenWidth*0.5+45;
        UIImageView*imgVIconRight=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 105, 7) defaultimage:@"lineir" supView:viewContent];
        imgVIconRight.frameX=kScreenWidth*0.5+45;
        UILabel*lbQiandao=[RHMethods ClableY:16.5 W:kScreenWidth*0.5 Height:15 font:15 superview:viewContent withColor:rgb(102, 102, 102) text:kS(@"SignInStr", @"AttendanceRules")];
        imgVIconLeft.centerY=imgVIconRight.centerY=lbQiandao.centerY;
        UILabel*lbOther=[RHMethods lableX:15 Y:lbQiandao.frameYH+20 W:kScreenWidth-30 Height:0 font:13 superview:viewContent withColor:rgb(102, 102, 102) text:[self.data ojsk:@"sign_descr"]];
        
        
        
    }
    
    [_mtableView reloadData];
}
#pragma mark  request data from the server use tableview

-(void)okBtnClick:(UIButton*)btn{
  __weak __typeof(self) weakSelf = self;
    [kUserCenterService ucenter_addsgins:@{} withBlock:^(id data, int status, NSString *msg) {
        SigninPagePopView*view0=[SigninPagePopView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:weakSelf.view reuseId:@"SigninPagePopView"];
        view0.hidden=NO;
        [view0 upDataMeWithData:data];
        [weakSelf loadDATA];
    }];
    
    
    
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
      __weak __typeof(self) weakSelf = self;
    [kUserCenterService ucenter_getsgins:dictparam withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf addView];
    }];
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
