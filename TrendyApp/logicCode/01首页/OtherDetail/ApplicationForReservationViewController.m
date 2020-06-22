//
//  ApplicationForReservationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ApplicationForReservationViewController.h"
#import "MYRHTableView.h"
#import "ApplicationForReservationCellView.h"
#import "ApplicationForReservationFindCellView.h"
#import "RUControllerBottomView.h"
#import "UtilitySelectTime.h"
#import "SuccessfulApplicationViewController.h"
#import "AddInsuranceViewController.h"
@interface ApplicationForReservationViewController ()
{
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableDictionary *dicAll;
@property(nonatomic,strong)ApplicationForReservationFindCellView *viewCellTemp;

/**
 保险信息数据
 */
@property(nonatomic,strong)NSMutableDictionary*baoxianDic;
@property(nonatomic,strong)UIView*viewPriceContent;
@end

@implementation  ApplicationForReservationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    {
        ApplicationForReservationCellView *viewCell=[ApplicationForReservationCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:viewContent];
        [viewCell upDataMeWithData:[_dicAll ojsk:@"car"]];
        
        ApplicationForReservationFindCellView *viewCell2 = [ApplicationForReservationFindCellView viewWithFrame:CGRectMake(15, viewCell.frameYH+5, kScreenWidth-30, 0) backgroundcolor:nil superView:viewContent];
        
        _viewCellTemp=viewCell2;
        [viewCell2 setUpdataMyBlock:^(id data, int status, NSString *msg) {
            [weakSelf updataPrice];
        }];
        
        if ([[UTILITY getAddValueForKey:@"mySelect"] isEqualToString:@"自助找车"]) {
            viewCell2.swich1.isOn=UTILITY.swich1.isOn;
            viewCell2.swich2.isOn=UTILITY.swich2.isOn;
            
            [viewCell2 setAddValue:[UTILITY getAddValueForKey:@"selectAddressS_on"] forKey:@"selectAddressS_on"];
            [viewCell2 setAddValue:[UTILITY getAddValueForKey:@"selectAddressS"] forKey:@"selectAddressS"];
            
            [viewCell2 setAddValue:[UTILITY getAddValueForKey:@"selectAddressE_on"] forKey:@"selectAddressE_on"];
            [viewCell2 setAddValue:[UTILITY getAddValueForKey:@"selectAddressE"] forKey:@"selectAddressE"];
        }
        
     
        
        if (self.otherInfo) {
            [viewCell2 setAddValue:self.otherInfo forKey:@"SelectDate"];
        }
        [viewCell2 upDataMeWithData:_dicAll];
        viewCell2.layer.borderWidth=1;
        viewCell2.layer.borderColor=RGBACOLOR(238, 238, 238, 0.8).CGColor;
        viewCell2.layer.cornerRadius=5;
//        UIImageView*imgVImportant=[RHMethods imageviewWithFrame:CGRectMake(15, viewCell2.frameYH+25, 16, 16) defaultimage:@"prompti" supView:viewContent];
//        UILabel *lbImportant=[RHMethods lableX:46 Y:imgVImportant.frameY W:kScreenWidth-46-15 Height:0 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:[NSString stringWithFormat:@"%@：%@",kS(@"carApplyBooking", @"DoorExpenses"),[_dicAll ojsk:@"configs"]]];
//        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[lbImportant.text  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, } documentAttributes:nil error:nil];//NSFontAttributeName:[UIFont systemFontOfSize:13.0f]
//        lbImportant.attributedText = attrStr;//用于显示
//        lbImportant.frameHeight=1000;
//        [lbImportant sizeToFit];
        
//        viewContent.frameHeight=lbImportant.frameYH+25;
    }
    
    {
        
        NSArray*arraytitle=@[kS(@"order_detail", @"price_item_car"),kS(@"order_detail", @"price_item_door_price"),kS(@"order_detail", @"price_item_guarantee_price"),kS(@"order_detail", @"price_item_procedures_price"),kS(@"order_detail", @"price_item_insurer_price"),kS(@"order_detail", @"price_item_favorable_price")];
        
        NSArray*arraykey=@[@"rentprice",@"doorprice",@"guaranteeprice",@"proceduresprice",@"insurerprices",@"preferentialprice",];

        UIView*viewPriceContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgbwhiteColor superView:nil];
        _viewPriceContent=viewPriceContent;
        [_mtableView.defaultSection.noReUseViewArray addObject:viewPriceContent];
        for (int i=0; i<arraytitle.count; i++) {
            UILabel*lbTile=[RHMethods lableX:15 Y:15+i*(23) W:0 Height:13 font:13 superview:viewPriceContent withColor:rgb(153, 153, 153) text:arraytitle[i]];
             UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbTile.frameY W:kScreenWidth-30 Height:13 font:13 superview:viewPriceContent withColor:rgb(153, 153, 153) text:@" "];
            viewPriceContent.frameHeight=lbPrice.frameYH+15;
            lbPrice.tag=10019;
            [lbPrice setAddUpdataBlock:^(id data, id weakme) {
                UILabel*lbPrice=weakme;
                lbPrice.text=[data ojsk:arraykey[i]];
                if ([lbPrice.text notEmptyOrNull]) {
                    lbPrice.text=[NSString stringWithFormat:@"￥%@",lbPrice.text];
                    
                    
                    if ([arraykey[i] isEqualToString:@"preferentialprice"]) {
                        lbPrice.text=[NSString stringWithFormat:@"-%@",lbPrice.text];
                    }
                }
            }];
        }
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, viewPriceContent.frameHeight, kScreenWidth-30, 1) backgroundcolor:RGBACOLOR(240, 240, 240, 0.5) superView:viewPriceContent];
         UILabel*lbPriceAll=[RHMethods RlableRX:15 Y:viewLine.frameYH W:kScreenWidth-30 Height:44 font:18 superview:viewPriceContent withColor:rgb(244,58,58) text:kS(@"confirm_booking_info", @"total_price")];
        [lbPriceAll setColor:rgb(51, 51, 51) contenttext:kS(@"confirm_booking_info", @"total_price")];
        viewPriceContent.frameHeight=lbPriceAll.frameYH;
        [viewPriceContent setAddUpdataBlock:^(id data, id weakme) {
            lbPriceAll.text=[NSString stringWithFormat:@"%@￥%@",kS(@"confirm_booking_info", @"total_price"),[data ojsk:@"totalprice"]];
            lbPriceAll.textColor=rgb(244,58,58);
            lbPriceAll.textColor=rgb(244,58,58);
            [lbPriceAll setColor:rgb(51, 51, 51) contenttext:kS(@"confirm_booking_info", @"total_price")];
            for (UILabel*lbPrice in [weakme subviews]) {
                if (lbPrice.tag==10019) {
                    [lbPrice upDataMeWithData:data];
                    
                }
            }
            if (![[data ojsk:@"totalprice"] notEmptyOrNull]) {
                lbPriceAll.text=kS(@"confirm_booking_info", @"total_price");
            }
            
        }];
    }
    
    {
        
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:rgbwhiteColor superView:nil];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"insurance_info")];
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 20, 8, 15) defaultimage:@"arrowr2" supView:viewContent];
        imgVRow.frameRX=15;
        imgVRow.centerY=lbName.centerY;
        NSArray*arraytitle=@[kS(@"order_detail", @"insurance_person"),kS(@"order_detail", @"append_insurance_person"),];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        lbName.textColor =rgb(244,58,58);
        UILabel*firstLable=nil;
        UILabel*secondLable=nil;
        for (int i=0; i<arraytitle.count; i++) {
            UILabel*lbTile=[RHMethods lableX:15 Y:lbName.frameYH+15+i*(23) W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:arraytitle[i]];
            UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbTile.frameY W:kScreenWidth-30 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:@" "];
            viewContent.frameHeight=lbPrice.frameYH+15;
            
            lbTile.textColor =rgb(244,58,58);
            lbPrice.textColor =rgb(244,58,58);
            if (i==0) {
                firstLable=lbPrice;
            }else{
                secondLable=lbPrice;
            }
        }
        [viewContent addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[AddInsuranceViewController class] withInfo:weakSelf.baoxianDic withTitle:kST(@"fill_insurance_info") withOther:@"confirmOrder" withAllBlock:^(id data, int status, NSString *msg) {
                weakSelf.baoxianDic=data;
                firstLable.text=[[data ojk:@"master"] ojsk:@"name"];
                NSMutableArray*marray=[NSMutableArray new];
                for (NSDictionary*mdic in [data ojk:@"append"]) {
                    [marray addObject:[mdic ojsk:@"name"]];
                }
                secondLable.text=[marray componentsJoinedByString:@","];
                
                [weakSelf updataPrice];
//                block(nil,200,nil);
            }];
        }];
        kOrderService.apiUrl(@"order/master").success(^(id data, NSString *msg) {
//            data = [data ojk:@"master"];
            if ([[[data ojk:@"master"] ojsk:@"id"] notEmptyOrNull]) {
                weakSelf.baoxianDic=data;
                firstLable.text=[[data ojk:@"master"] ojsk:@"name"];
                NSMutableArray*marray=[NSMutableArray new];
                for (NSDictionary*mdic in [data ojk:@"append"]) {
                    [marray addObject:[mdic ojsk:@"name"]];
                }
                secondLable.text=[marray componentsJoinedByString:@","];
                
                [weakSelf updataPrice];
            }
            
            
        }).startload();
        
        
    }
    {
        NSDictionary*dic=@{
                           @"classStr":@"FCTextCellView",
                           @"name":kS(@"carApplyBooking", @"remark"),//@"備註說明",
                           @"frameY":@"10",
                           @"requestkey":@"remark",
                           @"placeholder":kS(@"carApplyBooking", @"remarkHint"),//@"可以簡要說明租車的用途等...",
                           };
        dic=[dic toBeMutableObj];
        UIView*viewcell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewcell];
    }
    
    
    _mtableView.frameHeight=_mtableView.frameHeight-60-kIphoneXBottom;
    RUControllerBottomView*viewBottom=[RUControllerBottomView viewWithFrame:CGRectMake(0, _mtableView.frameYH, 0, 60+kIphoneXBottom) backgroundcolor:nil superView:self.view];
    [viewBottom upDataMeWithData:@{@"btnTitle":kS(@"carApplyBooking", @"submitBtn")}];
    [viewBottom addBaseViewTarget:self select:@selector(commitBtnClick:)];
    
    [_mtableView reloadData];
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"carid"];
    [NetEngine createPostAction:@"order/confirmOrder" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.dicAll=dicData;
            [self addView];
            
            [self updataPrice];
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
-(void)commitBtnClick:(UIButton*)actionBtn{
    __weak __typeof(self) weakSelf = self;
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"carid"];
    
    actionBtn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        actionBtn.userInteractionEnabled = YES;
    });
    
    [_viewCellTemp getRequestDataBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            [dictparam addEntriesFromDictionary:data];
          
            [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
                
                if (status==200) {
                    [dictparam addEntriesFromDictionary:data];
                    if ([[[weakSelf.baoxianDic ojk:@"master"] ojsk:@"id"] notEmptyOrNull]) {
                        [dictparam setObject:[[weakSelf.baoxianDic ojk:@"master"] ojsk:@"id"] forKey:@"masterid"];
                    }
                     NSMutableArray*marray=[NSMutableArray new];
                    for (NSDictionary*mdic in [weakSelf.baoxianDic ojk:@"append"]) {
                        [marray addObject:[mdic ojsk:@"id"]];
                    }
                    [dictparam setObject:[marray componentsJoinedByString:@","] forKey:@"appendid"];
                    
                    actionBtn.userInteractionEnabled = NO;
                    kOrderService.apiUrl(@"order/submitOrder").paraDic(dictparam).success(^(id data, NSString *msg) {
                        
                        [UTILITY setAddValue:@"1" forKey:@"addOrder"];
                        //                            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
                        kUtilitySelectTime.selectStartTime=nil;
                        kUtilitySelectTime.selectEndTime=nil;
                        kUtilitySelectTime.selectTempTime=nil;
                        //隐藏成功的提示
//                        [SVProgressHUD  showSuccessWithStatus:msg];
                        [weakSelf pushViewController];
                    }).allBlock(^(id data, int status, NSString *msg) {
                        
                        actionBtn.userInteractionEnabled = YES;
                    }).startload();
                    
                }else{
                }
            }];
        }
    }];
    
   
}

-(void)updataPrice{
    __weak __typeof(self) weakSelf = self;
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"carid"];
    _viewCellTemp.showMessage=NO;
    
    [weakSelf.viewPriceContent upDataMeWithData:@{}];
    [_viewCellTemp getRequestDataBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            [dictparam addEntriesFromDictionary:data];
            [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
                if (status==200) {
                    [dictparam addEntriesFromDictionary:data];
                    NSInteger allNmumber=0;
                    if ([[[weakSelf.baoxianDic ojk:@"master"] ojsk:@"id"] notEmptyOrNull]) {
                        allNmumber++;
                    }
                    allNmumber=[[weakSelf.baoxianDic ojk:@"append"] count]+allNmumber;
                    [dictparam setObject:[NSString stringWithFormat:@"%ld",(long)allNmumber] forKey:@"countinsurer"];
                    kOrderService.apiUrl(@"order/orderCarPrice").paraDic(dictparam).success(^(id data, NSString *msg) {
                        [weakSelf.viewPriceContent upDataMeWithData:data];
                    }).startload();
                    
                }
            }];
        }
    }];
    _viewCellTemp.showMessage=YES;
    
}
//[self pushController:[SuccessfulApplicationViewController class] withInfo:nil withTitle:@"支付成功"]
-(void)pushViewController{
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    [viewControllers removeObject:self];
//    for (NSInteger i=self.navigationController.viewControllers.count-1; i>0; i--) {
//        id controller=self.navigationController.viewControllers[i];
//        [viewControllers removeObject:controller];
//        continue;
//        //        if ([NSStringFromClass([controller class]) isEqualToString:NSStringFromClass([self class])]) {
//        //            [viewControllers removeObject:controller];
//        //            continue;
//        //        }
//    }
    SuccessfulApplicationViewController *pcV=[[SuccessfulApplicationViewController alloc] init];
    pcV.hidesBottomBarWhenPushed=YES;
    [viewControllers addObject:pcV];
    [self.navigationController setViewControllers:viewControllers animated:YES];
    
    [pcV navbarTitle:kST(@"carApplyBookingSuccess")];
    [pcV backButton];

}
#pragma mark - delegate function


@end
