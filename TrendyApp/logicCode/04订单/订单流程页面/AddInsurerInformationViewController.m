//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AddInsurerInformationViewController.h"
#import "MYRHTableView.h"
@interface AddInsurerInformationViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  AddInsurerInformationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [self rightButton:kS(@"addInsurerInfo", @"button_complete") image:nil sel:@selector(submitBtnClick:)];
    [super viewDidLoad];
    [self addView];
    if (self.userInfo) {
        [self loadDATA];
    }
}
-(void)submitBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.userInteractionEnabled=YES;
    });
    __weak __typeof(self) weakSelf = self;
    [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            NSMutableDictionary* dictparam=data;
            if (weakSelf.userInfo) {
                [dictparam setObject:weakSelf.userInfo forKey:@"id"];
            }
            [kUserCenterService ucenterInsureraddWithParam:dictparam withBlock:^(id data, int status, NSString *msg) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):0;
                });                
            }];
        }
    }];
}
#pragma mark -   write UI
-(void)addView{
    if (_mtableView==nil) {
        _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mtableView];
    }
    NSMutableArray*arraytitle=[@[
                                 @{
                                     @"name":kS(@"addInsurerInfo", @"name"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"placeholder":kS(@"addInsurerInfo", @"hint_input_name"),
                                     @"requestkey":@"name",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"addInsurerInfo", @"birthday"),
                                     @"classStr":@"FCSelectCellView",
                                     @"placeholder":kS(@"addInsurerInfo", @"notice_select_birthday"),
                                     @"selectsubtype":@"dateselect",
                                     @"requestkey":@"birthday",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"addInsurerInfo", @"address"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"placeholder":kS(@"addInsurerInfo", @"notice_input_address"),
                                     @"requestkey":@"address",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"addInsurerInfo", @"mobile"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"placeholder":kS(@"addInsurerInfo", @"notice_input_mobile"),
                                     @"requestkey":@"mobile",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"addInsurerInfo", @"driving_license_number"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"placeholder":kS(@"addInsurerInfo", @"notice_input_driving_license_number"),
                                     @"requestkey":@"license",
                                     @"unit":@"",
                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"addInsurerInfo", @"driving_license_validity"),
                                     @"classStr":@"FCSelectCellView",
                                     @"placeholder":kS(@"addInsurerInfo", @"notice_select_driving_license_validity"),
                                     @"selectsubtype":@"dateselect",
                                     @"maximumDate":@"forever",
                                     @"requestkey":@"license_time",
                                     @"unit":@"",
                                     @"isMust":@"1",
                                     },
                                 ] toBeMutableObj];
    
    if ([kLanguageService.appLanguage rangeOfString:@"jp"].length) {
        arraytitle=[@[
                      @{
                          @"name":kS(@"addInsurerInfo", @"name"),
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"hint_input_name"),
                          @"requestkey":@"name",
                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"name_Kat"),//片假名
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"hint_input_pls"),
                          @"requestkey":@"name_Kat",
//                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"birthday"),
                          @"classStr":@"FCSelectCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"notice_select_birthday"),
                          @"selectsubtype":@"dateselect",
                          @"requestkey":@"birthday",
                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"Postal_Code"),//@"name":@"郵遞區號",
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"hint_input_pls"),
                          @"requestkey":@"Postal_Code",
//                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"address"),
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"notice_input_address"),
                          @"requestkey":@"address",
                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"address_Kat"),//片假名
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"hint_input_pls"),
                          @"requestkey":@"address_Kat",
//                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"mobile"),
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"notice_input_mobile"),
                          @"requestkey":@"mobile",
                          @"isMust":@"1",
                          },
                      @{
                          
                          @"name":kS(@"addInsurerInfo", @"Carrying"),//@"name":@"手機號碼",
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"hint_input_pls"),
                          @"requestkey":@"Carrying",
//                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"driving_license_number"),
                          @"classStr":@"FCTextFieldCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"notice_input_driving_license_number"),
                          @"requestkey":@"license",
                          @"unit":@"",
                          @"isMust":@"1",
                          },
                      @{
                          @"name":kS(@"addInsurerInfo", @"driving_license_validity"),
                          @"classStr":@"FCSelectCellView",
                          @"placeholder":kS(@"addInsurerInfo", @"notice_select_driving_license_validity"),
                          @"selectsubtype":@"dateselect",
                          @"maximumDate":@"forever",
                          @"requestkey":@"license_time",
                          @"unit":@"",
                          @"isMust":@"1",
                          },
                      ] toBeMutableObj];
    }
    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
    }
    [_mtableView reloadData];
}

#pragma mark  request data from the server use tableview
#pragma mark - request data from the server
-(void)loadDATA{
    __weak __typeof(self) weakSelf = self;
    NSMutableDictionary*paramdic=[NSMutableDictionary new];
    [paramdic setObject:self.userInfo forKey:@"id"];
    [kUserCenterService ucenterInsurerdetailWithParam:paramdic withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf bendData];
    }];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
