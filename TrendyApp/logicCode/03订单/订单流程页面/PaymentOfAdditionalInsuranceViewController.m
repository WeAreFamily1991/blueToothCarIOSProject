//
//  PaymentOfExtendedVehicleUseViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "PaymentOfAdditionalInsuranceViewController.h"
#import "SelectUrlProtalViewController.h"
#import "MYRHTableView.h"
@interface PaymentOfAdditionalInsuranceViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,copy)NSString*isSelectPolicy;
@property(nonatomic,strong)UISwitch*switchBtn;
@property(nonatomic,strong)UIView*bottomContentView;
@end

@implementation  PaymentOfAdditionalInsuranceViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addView];
    self.isSelectPolicy=@"0";
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    NSArray*titleArray=@[kS(@"pay_for_append_insurance", @"pay_insurance_amount"),[NSString stringWithFormat:@"%@￥%@",kS(@"pay_for_append_insurance", @"pay_for_insurance_total"),[self.data ojsk:@"totalprice"]]];
    for (int i=0; i<titleArray.count; i++) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 55) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:0 W:kScreenWidth-30 Height:viewContent.frameHeight font:16 superview:viewContent withColor:rgb(51, 51, 51) text:titleArray[i]];
        
        UILabel*lbDes=[RHMethods RlableRX:15 Y:0 W:lbName.frameWidth Height:viewContent.frameHeight font:14 superview:viewContent withColor:rgb(153, 153, 153) text:@""];
//        [lbDes setColor:rgb(51, 51, 51) contenttext:@"1500"];
        UIView*viewline= [UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight-1, viewContent.frameWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        if (i==1) {
            lbName.textAlignment=NSTextAlignmentRight;
            [lbName setColor:rgb(244, 58, 58) contenttext:[NSString stringWithFormat:@"￥%@",[self.data ojsk:@"totalprice"]]];
            viewline.hidden=YES;
            lbDes.hidden=YES;
        }else{
            lbDes.text=[NSString stringWithFormat:@"￥%@",[self.data ojsk:@"totalprice"]];
        }
    }
    _mtableView.frameHeight=_mtableView.frameHeight-100;

    {
          __weak __typeof(self) weakSelf = self;
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
//            float price=[weakSelf.data ojsk:@"totalprice"].noformPriceStr.floatValue;
          
            
//            priceLable.text=[NSString stringWithFormat:@"%@￥%.2f",kS(@"confirm_booking_info", @"pay_really"),price];
//            [priceLable setColor:rgb(51, 51, 51) contenttext:[NSString stringWithFormat:@"￥%.2f",price]];
            priceLable.text=[NSString stringWithFormat:@"%@￥%@",kS(@"pay_for_append_insurance", @"pay_for_insurance_total_real"),[weakSelf.data ojsk:@"totalprice"]];
            [priceLable setColor:rgb(51, 51, 51) contenttext:[NSString stringWithFormat:@"￥%@",[weakSelf.data ojsk:@"totalprice"]]];
        }];
        [content upDataMe];
        _bottomContentView=content;
    }
    //    {
//        UIView*content=[UIView viewWithFrame:CGRectMake(0, _mtableView.frameYH, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:self.view];
//        [UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:content];
//        UILabel*lbRead=[RHMethods lableX:15 Y:0 W:kScreenWidth-30 Height:40 font:13 superview:content withColor:rgb(102, 102, 102) text:@"請閱讀並同意《Trendy租車支付協議》"];
//        UIView*viewline=[UIView viewWithFrame:CGRectMake(0, lbRead.frameYH, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:content];
//        UILabel*priceLable=[RHMethods labelWithFrame:CGRectMake(15, viewline.frameYH, kScreenWidth-30-100, 60) font:Font(16) color:rgb(244, 58, 58) text:@"實付金額：2040元" supView:content];
//        [priceLable setColor:rgb(51, 51, 51) contenttext:@"實付金額："];
//
//        WSSizeButton*btnPay=[RHMethods buttonWithframe:CGRectMake(0, viewline.frameYH+ 10, 130, 40) backgroundColor:rgb(13, 112, 161) text:@"立即支付" font:16 textColor:rgb(255, 255, 255) radius:5 superview:content];
//        btnPay.frameRX=15;
//
//    }
    
    
}
-(void)payBtnClick:(UIButton*)btn{
    if (![_isSelectPolicy isEqualToString:@"1"]) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"pls_read_confirm"),kS(@"confirm_booking_info", @"pay_policy")]];
        return;
    }
    if (self.allcallBlock) {
        self.allcallBlock(nil, 200, nil);
    }
}

-(void)swichtBtnclick:(UISwitch*)btn{
    
    
    [self.bottomContentView upDataMe];
    
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
            [dic setObject:[NSString stringWithFormat:@"%@",kS(@"confirm_booking_info", @"pay_policy")] forKey:@"myTitle"];
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
#pragma mark  request data from the server use tableview
-(void)loadDATA{
    krequestParam
    [dictparam setObject:self.userInfo forKey:@"orderid"];
    NSString*apiStr=@"order/insurerpay";
//    if ([self.otherInfo isEqualToString:@"extendpay"]) {
//        apiStr=@"order/extendpay";
//    }
    
    [NetEngine createPostAction:apiStr withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            self.data=dic;
            [self addView];
//            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
