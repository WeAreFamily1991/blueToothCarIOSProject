//
//  ConfirmReservationInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ConfirmReservationInformationViewController.h"
#import "OrderHomeSmallCellView.h"
#import "OrderHomeSmallTimeCellView.h"
#import "MYRHTableView.h"
#import "PaySuccessViewController.h"
#import "SelectUrlProtalViewController.h"
#import "SelectWebUrlViewController.h"
@interface ConfirmReservationInformationViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,copy)NSString*isSelectPolicy;
@property(nonatomic,strong)UISwitch*switchBtn;
@property(nonatomic,strong)UIView*bottomContentView;
@end

@implementation  ConfirmReservationInformationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    self.isSelectPolicy=@"0";
    [super viewDidLoad];
    [self loadDATA];
    //    [self addView];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//
//    /**
//     * 取车方式  1上门  2到店
//     */
//    public String pickup;
//    /**
//     * 还车方式  1上门  2到店
//     */
//    public String dropoff; 当取车 还车都是到店的时候不显示
    if ([[self.data ojsk:@"pickup"] isEqualToString:@"2"]&&[[self.data ojsk:@"dropoff"] isEqualToString:@"2"]) {
    }else{
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 35) backgroundcolor:RGBACOLOR(244, 58, 58, 0.1) superView:nil];
        _mtableView.defaultSection.selctionHeaderView=viewContent;
        UIImageView*imgVLB=[RHMethods imageviewWithFrame:CGRectMake(15, 11, 15, 15) defaultimage:@"noticei3" supView:viewContent];
        UILabel*lbTitle=[RHMethods lableX:imgVLB.frameXW+6 Y:0 W:viewContent.frameWidth-imgVLB.frameXW-6-15 Height:viewContent.frameHeight font:13 superview:viewContent withColor:RGBACOLOR(244, 58, 28, 1) text:kS(@"confirm_booking_info", @"on_door_notice")];
        lbTitle.frameY=0;
        
        
    }
    //头像姓名
//    {
//        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 52) backgroundcolor:rgb(255, 255, 255) superView:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
//
//        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 11, 30, 30) defaultimage:@"photo" supView:viewContent];
//        [imgVIcon beCY];
//        [imgVIcon beRound];
//        /*UILabel*lbName =*/[RHMethods lableX:imgVIcon.frameXW+11 Y:0 W:kScreenWidth*0.5 Height:viewContent.frameHeight font:16 superview:viewContent withColor:rgb(51, 51, 51) text:@"张晨晨"];
//        WSSizeButton*btnContact=[RHMethods buttonWithframe:CGRectMake(0, 0, 99, 30) backgroundColor:nil text:@"聯繫TA" font:14 textColor:rgb(13, 107, 153) radius:3 superview:viewContent];
//        [btnContact setImageStr:@"noticeblue" SelectImageStr:nil];
//        [btnContact setBtnImageViewFrame:CGRectMake(15, 7, 16, 16)];
//        [btnContact setBtnLableFrame:CGRectMake(38, 0, btnContact.frameWidth-38, btnContact.frameHeight)];
//        btnContact.layer.borderColor=rgb(13, 107, 153 ).CGColor;
//        btnContact.layer.borderWidth=1;
//        btnContact.frameRX=15;
//        [btnContact beCY];
//    }
    //    車輛信息
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        
        OrderHomeSmallCellView*viewCell=[OrderHomeSmallCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:viewContent];
        
        OrderHomeSmallTimeCellView*viewCell2=[OrderHomeSmallTimeCellView viewWithFrame:CGRectMake(0, viewCell.frameYH, 0, 0) backgroundcolor:nil superView:viewContent];
        
        viewContent.frameHeight=viewCell2.frameYH;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15,viewContent.frameHeight, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        viewLine.frameBY=0;
        [viewCell upDataMeWithData:self.data];
        [viewCell2 upDataMeWithData:self.data];
        
        
        //        {
        //
        //            NSArray*arrayTitle=@[@"車齡租金",@"上門費用",@"平台保障費",@"手續費",@"保險費",@"積分抵扣"];
        //
        //            NSArray*arrayPrice=@[@"1500元",@"1340元",@"180元",@"50元",@"540元",@"-20元",];
        //
        //            NSArray*arraySubPrice=@[@"499元*3天",@"5~10公里",@"60元*3天",@"",@"60元*3人*3天",@""];
        //            for (int i=0; i<arrayTitle.count; i++) {
        //                UILabel*lbTitle=[RHMethods lableX:15 Y:viewLine.frameYH+15+i*24 W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:arrayTitle[i]];
        //                UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbTitle.frameY W:0 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:arrayPrice[i]];
        //                 UILabel*lbSubPrice=[RHMethods RlableRX:viewContent.frameWidth-lbPrice.frameX+10 Y:0 W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:arraySubPrice[i]];
        //                lbSubPrice.centerY=lbPrice.centerY=lbTitle.centerY;
        //                if (i==arrayTitle.count-1) {
        //                    viewContent.frameHeight=lbTitle.frameYH+15;
        //                }
        //            }
        //        }
        //         NSArray*arrayTitle=@[@"車齡租金",@"上門費用",@"平台保障費",@"手續費",@"保險費",@"積分抵扣"];
        NSArray*arraytitle=@[
                             @{
                                 @"name":kS(@"order_detail", @"price_item_car"),
                                 @"value":[self.data ojsk:@"rentprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_door_price"),
                                 @"value":[self.data ojsk:@"doorprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_guarantee_price"),
                                 @"value":[self.data ojsk:@"guaranteeprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_procedures_price"),
                                 @"value":[self.data ojsk:@"proceduresprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_insurer_price"),
                                 @"value":[self.data ojsk:@"insurerprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_point_price"),
                                 @"value":[[self.data ojsk:@"pointprice"] notEmptyOrNull]?[NSString stringWithFormat:@"%@",[self.data ojsk:@"pointprice"]]:@"",
                                 @"unit":@"-￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_favorable_price"),
                                 @"value":[[self.data ojsk:@"preferentialprice"] notEmptyOrNull]?[NSString stringWithFormat:@"%@",[self.data ojsk:@"preferentialprice"]]:@"",
                                 @"unit":@"-￥",
                                 },
                             ];
        
        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=viewContent.frameHeight+10;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
        
        UIView*viewLine2=[UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        UILabel*lbfinalPrice=[RHMethods RlableRX:15 Y:viewLine2.frameYH W:kScreenWidth-30 Height:55 font:18 superview:viewContent withColor:rgb(244, 58, 58) text:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"total_price"),[self.data ojsk:@"payableprice"]]];
        [lbfinalPrice setColor:rgb(51, 51, 51) contenttext:kS(@"confirm_booking_info", @"total_price")];
        viewContent.frameHeight=lbfinalPrice.frameYH+5;
        
    }
//    //延长用车信息
//    if ([[[self.data ojk:@"extendinfo"] ojsk:@"rentprice"] notEmptyOrNull]) {
//        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
//        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"extend_info")];
//        NSArray*arraytitle=@[
//                             @{
//                                 @"name":kS(@"order_detail", @"extend_item_time"),
//                                 @"value":[self.data ojsk:@"extendtime_str"],
//                                 },
//                             @{
//                                 @"name":kS(@"order_detail", @"price_item_car"),
//                                 @"value":[[self.data ojk:@"extendinfo"] ojsk:@"rentprice"],
//                                 },
//                             @{
//                                 @"name":kS(@"order_detail", @"price_item_insurer_price"),
//                                 @"value":[[self.data ojk:@"extendinfo"] ojsk:@"insurerprice"],
//                                 },
//                             ];
//        
//        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
//        contentListView.frameY=lbName.frameYH+13;
//        [viewContent addSubview:contentListView];
//        viewContent.frameHeight=contentListView.frameYH+5;
//    }
//    //备注信息
//    if ([[self.data ojk:@"remark"] notEmptyOrNull]) {
//        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
//        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"remark")];
//        UILabel*lbRemark=[RHMethods lableX:15 Y:lbName.frameYH+13 W:kScreenWidth-30 Height:0 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:[self.data ojk:@"remark"]];
//        viewContent.frameHeight=lbRemark.frameYH+13;
//    }
    
    //保险信息
    if ([[self.data ojk:@"mastername"] notEmptyOrNull]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"insurance_info")];
        NSMutableArray*arraytitle=[
                                   @[
                                     @{
                                         @"name":kS(@"order_detail", @"insurance_person"),
                                         @"value":[self.data ojsk:@"mastername"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"append_insurance_person"),
                                         @"value":[self.data ojsk:@"appendname"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"insurance_person_number"),
                                         @"value":[self.data ojsk:@"masternumbers"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"append_insurance_person_number"),
                                         @"value":[self.data ojsk:@"appendnumbers"],
                                         },
                                     ] toBeMutableObj
                                   ];
        
        
        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=lbName.frameYH+13;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
    }
    //可用200積分抵用200元
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 55) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbContent=[RHMethods lableX:15 Y:0 W:0 Height:viewContent.frameHeight font:16 superview:viewContent withColor:rgb(153, 153, 153) text:[NSString stringWithFormat:kS(@"confirm_booking_info", @"use_integral_instead_price"),[self.data ojsk:@"usepoint"].intValue,[self.data ojsk:@"usepointprice"].intValue]];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(lbContent.frameXW+10, 0, 15, 15) defaultimage:@"questioni" supView:viewContent];
        [imgVIcon beCY];
        UISwitch*swichControl=[UISwitch viewWithFrame:CGRectMake(0, 12, 54, 34) backgroundcolor:nil superView:viewContent];
//        [swichControl setTintColor:rgb(13, 112, 161)];
        [swichControl setOnTintColor:rgb(13, 112, 161)];
        
        _switchBtn=swichControl;
        swichControl.frameRX=15;
        [swichControl addTarget:self action:@selector(swichtBtnclick:) forControlEvents:UIControlEventValueChanged];
        
    }

    _mtableView.frameHeight=_mtableView.frameHeight-100;
    {
        UIView*content=[UIView viewWithFrame:CGRectMake(0, _mtableView.frameYH, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:self.view];
        [UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:content];
        UILabel*lbRead=[RHMethods lableX:15 Y:0 W:kScreenWidth-30 Height:40 font:13 superview:content withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"pls_read_confirm"),kS(@"pay_for_append_insurance", @"pay_license")]];
        [lbRead setColor:rgb(13, 112, 161) contenttext:kS(@"pay_for_append_insurance", @"pay_license")];
        
        
        [lbRead addViewTarget:self select:@selector(seeProlicy:)];
        
        
        
        UIView*viewline=[UIView viewWithFrame:CGRectMake(0, lbRead.frameYH, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:content];
        UILabel*priceLable=[RHMethods labelWithFrame:CGRectMake(15, viewline.frameYH, kScreenWidth-30-100, 60) font:Font(16) color:rgb(244, 58, 58) text:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"pay_really"),[self.data ojsk:@"payableprice"]] supView:content];
        [priceLable setColor:rgb(51, 51, 51) contenttext:kS(@"confirm_booking_info", @"pay_really")];
        
        WSSizeButton*btnPay=[RHMethods buttonWithframe:CGRectMake(0, viewline.frameYH+ 10, 130, 40) backgroundColor:rgb(13, 112, 161) text:kS(@"confirm_booking_info", @"booking_now") font:16 textColor:rgb(255, 255, 255) radius:5 superview:content];
        btnPay.frameRX=15;
        [btnPay addViewTarget:self select:@selector(payBtnClick:)];
        
        [content setAddUpdataBlock:^(id data, id weakme) {
            float price=[weakSelf.data ojsk:@"payableprice"].noformPriceStr.floatValue;
            if (weakSelf.switchBtn.on) {
                price=price -[self.data ojsk:@"usepointprice"].noformPriceStr.floatValue;
            }
            
//            priceLable.text=[NSString stringWithFormat:@"%@%.2f",kS(@"confirm_booking_info", @"pay_really"),price];
            NSString*strPrice= [NSString stringWithFormat:@"%.0f",price];
            
            priceLable.text=[NSString stringWithFormat:@"%@%@",kS(@"pay_for_append_insurance", @"pay_for_insurance_total_real"),strPrice.formPriceStr];
            [priceLable setColor:rgb(51, 51, 51) contenttext:kS(@"pay_for_append_insurance", @"pay_for_insurance_total_real")];
        }];
        _bottomContentView=content;
    }
    
    
}
-(void)seeProlicy:(UIButton*)btn{
      __weak __typeof(self) weakSelf = self;
    krequestParam
    [dictparam setObject:@"rule_rentcar" forKey:@"type"];
    [NetEngine createPostAction:@"welcome/getRule" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
            [dic setObject:self.isSelectPolicy forKey:@"isSelectPolicy"];
            [dic setObject:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"pls_read_confirm"),kS(@"confirm_booking_info", @"pay_policy")] forKey:@"btnTitle"];
            
            [dic setObject:kS(@"confirm_booking_info", @"pay_policy") forKey:@"myTitle"];
//            @"http://h5.trendycarshare.jp/home/orders/rule_orderpay?apptype=app&language=cn/en/jp"
            [dic setObject:[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/orders/rule_orderpay?apptype=app&language=%@",kLanguageService.appLanguage] forKey:@"url"];
            [weakSelf pushController:[SelectUrlProtalViewController class] withInfo:dic withTitle:@"" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                weakSelf.isSelectPolicy=[data ojsk:@"isSelectPolicy"];
            }];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];
}
-(UIView*)loadRightListViewWithArray:(NSMutableArray*)arrayTitle{
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
    //    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    float my_y=3.0;
    
    for (int i=0; i<arrayTitle.count; i++) {
        NSMutableDictionary*dic=arrayTitle[i];
        //        [dic setObject:@"dfadf" forKey:@"value"];
        if (![[dic ojsk:@"value"] notEmptyOrNull]||([[dic ojsk:@"value"] floatValue]==0&&[[dic ojsk:@"value"] rangeOfString:@"0"].length)) {
            continue;
        }
        if (![[dic ojsk:@"value"] notEmptyOrNull]) {
            continue;
        }
        NSString*valueStr=[dic ojsk:@"value"];
        if ([[dic ojsk:@"unit"] notEmptyOrNull]) {
            valueStr=[NSString stringWithFormat:@"%@%@",[dic ojsk:@"unit"],valueStr];
        }
        UILabel*lbTitle=[RHMethods lableX:15 Y:my_y W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:[dic ojsk:@"name"]];
        UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbTitle.frameY W:0 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:valueStr];
        lbPrice.centerY=lbTitle.centerY;
        my_y=my_y+24;
    }
    viewContent.frameHeight=my_y;
    return viewContent;
}

-(void)swichtBtnclick:(UISwitch*)btn{
    
    
    [self.bottomContentView upDataMe];
    
}

-(void)updataPrice{
    
}
-(void)payBtnClick:(UIButton*)btn{
    if (![_isSelectPolicy isEqualToString:@"1"]) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"pls_read_confirm"),kS(@"confirm_booking_info", @"pay_policy")]];
        return;
    }
    
//    [self pushController:[PaySuccessViewController class] withInfo:nil withTitle:@"支付成功"];
    krequestParam
    [dictparam setObject:self.userInfo forKey:@"orderid"];
    [dictparam setObject:@"app" forKey:@"apptype"];
    [dictparam setObject:@"1" forKey:@"type"];
    [dictparam setObject:_switchBtn.on?@"1":@"0" forKey:@"ispoint"];
//    http://h5.trendycarshare.jp/home/orders/pay?apptype=app&uid=20&orderid=2019071149102525&ispoint=0&type=1
    [self pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:@{@"url":[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/orders/pay%@",dictparam.wgetParamStr]}];
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    [mdic setObject:self.userInfo forKey:@"orderid"];
    __weak __typeof(self) weakSelf = self;
    [kOrderService order_details:mdic withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf addView];
    }];
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
