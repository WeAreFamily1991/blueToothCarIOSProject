//
//  ApplicationForAppointmentViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ApplicationForAppointmentViewController.h"
#import "MYRHTableView.h"
#import "DetailRentCarHomeCellView.h"
#import "AppointmentRecordViewController.h"
@interface ApplicationForAppointmentViewController ()
{
    
    
    
}
@property(nonatomic,strong)NSMutableDictionary *dicAll;
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)BaseFormCellView *viewCellType;
@end

@implementation  ApplicationForAppointmentViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    {
        id detail=[self.dicAll ojk:@"detail"];
        UIView *viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 112) backgroundcolor:rgbwhiteColor superView:nil];
        UIImageView *imageV=[RHMethods imageviewWithFrame:CGRectMake(15, 20, 95, 70) defaultimage:nil supView:viewContent];
        [imageV imageWithURL:[detail ojsk:@"wappath"]];
        UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(XW(imageV)+10, Y(imageV), kScreenWidth-XW(imageV)-25, 20) font:fontTitle color:rgbTitleColor text:[detail ojsk:@"title"] supView:viewContent];
        UILabel *lbldescr=[RHMethods labelWithFrame:CGRectMake(X(lblTitle), YH(lblTitle), W(lblTitle), 20) font:fontSmallTxtContent color:rgbTxtGray text:[detail ojsk:@"descr"] supView:viewContent];
        
//        NSString*str=kS(@"longRental", @"ioslongRentalTip1");
        
        NSString *strOld=[NSString stringWithFormat:kS(@"longRental", @"ioslongRentalTip1"),[detail ojsk:@"mktprice"]];
        NSString *strNew=[NSString stringWithFormat:kS(@"longRental", @"ioslongRentalTip1"),[detail ojsk:@"price"]];
        UILabel *lblMoney=[RHMethods labelWithFrame:CGRectMake(X(lblTitle), YH(lbldescr)+5, 0, 25) font:Font(18) color:rgbRedColor text:strNew supView:viewContent];
        
        UILabel *lblOld=[RHMethods labelWithFrame:CGRectMake(XW(lblMoney)+10, Y(lblMoney), 0, 25) font:fontSmallTxtContent color:rgbTxtGray text:strOld supView:viewContent];
        [RHMethods viewWithFrame:CGRectMake(X(lblOld), Y(lblOld)+12, W(lblOld), 1) backgroundcolor:rgbLineColor superView:viewContent];
        
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    }
    {
       
        NSMutableArray*arraytitle=[@[
                                     @{
//                                         @"name":@"用車城市",
                                         @"classStr":@"FCLineCellView",
                                         @"requestkey":@"",
                                         @"frameY":@"10",
                                         @"isMust":@"1",
                                         },
                                     @{
                                         @"name":kS(@"rentLongTimeApplyBooking", @"cityOfUse"),//@"用車城市",
                                         @"classStr":@"FCTextFieldCellView",
                                         @"requestkey":@"city",
                                         @"isMust":@"1",
                                         @"placeholder":kS(@"rentLongTimeApplyBooking", @"cityOfUseHint"),
                                         },
                                     @{
                                         @"name":kS(@"rentLongTimeApplyBooking", @"phoneNumber"),//@"手機號碼",
                                         @"classStr":@"FCTextFieldCellView",
                                         @"requestkey":@"mobile",
                                         @"isMust":@"1",
                                         @"placeholder":kS(@"rentLongTimeApplyBooking", @"phoneNumberHint"),
                                         },
                                     @{
                                         @"name":kS(@"rentLongTimeApplyBooking", @"name"),//@"姓名",
                                         @"classStr":@"FCTextFieldCellView",
                                         @"requestkey":@"name",
                                         @"isMust":@"1",
                                         @"placeholder":kS(@"rentLongTimeApplyBooking", @"nameHint"),
                                         },
                                     @{
                                         @"name":kS(@"rentLongTimeApplyBooking", @"rentPurposes"),//@"租車用途",
                                         @"classStr":@"FCSelectCellView",
                                         @"requestkey":@"cid",
                                         @"selectsubtype":@"selectCate",
                                         @"cateList":[_dicAll ojk:@"cateList"],
                                         @"isMust":@"1",
                                         @"placeholder":kS(@"rentLongTimeApplyBooking", @"rentPurposesHint"),
                                         },
                                     ] toBeMutableObj];
        arraytitle=[arraytitle toBeMutableObj];
//        [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
        for (int i=0; i<arraytitle.count; i++) {
            NSMutableDictionary*dic=arraytitle[i];
            BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
            if (i==arraytitle.count-1) {
                _viewCellType=viewCell;
            }
        }
        
        {
            WSSizeButton*btnConfirm=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"rentLongTimeApplyBooking", @"submit") font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:btnConfirm];
            [btnConfirm addViewTarget:self select:@selector(subButtonClicked)];
        }
        
        
        [_mtableView reloadData];
        
        
        UILabel*lbTips=[RHMethods ClableY:0 W:kScreenWidth-30 Height:13+40 font:13 superview:self.view withColor:rgb(153, 153, 153) text:kS(@"rentLongTimeApplyBooking", @"note")];
        lbTips.frameBY=0;
    }
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
   //rental/detail
    [dictparam setValue:self.userInfo forKey:@"carid"];
    
    [NetEngine createPostAction:@"rental/detail" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.dicAll=dicData;
            [self addView];
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
-(void)subButtonClicked{
    __weak typeof(self) weakSelf=self;
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"rentalcarid"];
    [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            [dictparam addEntriesFromDictionary:data];
            BaseFormCellView*viewCell=weakSelf.viewCellType;
            if (viewCell.defaultTextfield.data) {
                [dictparam setValue:[viewCell.defaultTextfield.data ojsk:@"id"] forKey:@"cid"];
            }
            [NetEngine createPostAction:@"rental/apply" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                    //                            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
//                   隐藏提示
                    [SVProgressHUD  showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [weakSelf backButtonClicked:nil];
                          [weakSelf pushController:[AppointmentRecordViewController class] withInfo:nil withTitle:@"d" withOther:nil];
                    });;
                }else{
                    [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
                }
            }];
        }
    }];
}

#pragma mark - delegate function


@end
