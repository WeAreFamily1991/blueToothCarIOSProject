//
//  ModifyPersonalInforViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/12.
//  Copyright © 2019 55like. All rights reserved.
//


#import "ModifyPersonalInforViewController.h"
#import "MYRHTableView.h"
@interface ModifyPersonalInforViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  ModifyPersonalInforViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [self navbarTitle:kST(@"personalInfo")];
    [self rightButton:kS(@"generalPage", @"save") image:nil sel:@selector(submitBtnClick:)];
    [super viewDidLoad];
    [self addView];
    [self loadDATA];
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
                [kUserCenterService ucenterUpdateWithParam:dictparam withBlock:^(id data, int status, NSString *msg) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [weakSelf.navigationController popViewControllerAnimated:YES];
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
                                     @"name":@"line",
                                     @"classStr":@"UIView",
                                     @"frameY":@"10",
                                     @"unit":@"",
                                     },
                                 @{
                                     @"name":kS(@"personalInfo", @"head_image"),
                                     @"classStr":@"OFCHeaderImageSelectCellView",
                                     @"requestkey":@"icon",
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"personalInfo", @"nickname"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"nickname",
                                     @"placeholder":kS(@"personalInfo", @"PleaseYourNickname"),
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"personalInfo", @"gender"),
                                     @"classStr":@"FCSelectCellView",
                                     @"dictCode":@"gender",
                                     @"requestkey":@"gender-t",
                                     @"placeholder":kS(@"personalInfo", @"PleaseChooseGender"),
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"personalInfo", @"birthday"),
                                     @"classStr":@"FCSelectCellView",
                                     @"selectsubtype":@"dateselect",
                                     @"requestkey":@"birthday",
                                     @"placeholder":kS(@"personalInfo", @"PleaseChooseYourBirthday"),
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"personalInfo", @"email"),
                                     @"classStr":@"FCTextFieldCellView",
                                     @"requestkey":@"email",
//                                     @"placeholder":kS(@"personalInfo", @"PleaseChooseYourBirthday"),
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"line",
                                     @"classStr":@"UIView",
                                     @"frameY":@"10",
                                     },
                                 @{
                                     @"name":kS(@"personalInfo", @"personal_introduction"),
                                     @"classStr":@"FCTextCellView",
                                     @"requestkey":@"intro",
                                     @"placeholder":kS(@"personalInfo", @"hint_personal_introduction"),
//                                     @"isMust":@"1",
                                     },
                                 ] toBeMutableObj];
    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        
        
        
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        if ([[dic ojsk:@"requestkey"] isEqualToString:@"email"]) {
            viewCell.userInteractionEnabled=NO;
            viewCell.defaultTextfield.textColor=rgb(153, 153, 153);
        }
        
    }
    
    [_mtableView reloadData];
}

#pragma mark  request data from the server use tableview
#pragma mark - request data from the server
-(void)loadDATA{
    __weak __typeof(self) weakSelf = self;
    [kUserCenterService getUserCenterIndexData:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf bendData];
    }];
//        [kBusinessSubmissionService getBusinessSubmissionDetailWithParam:paramdic withBlock:^(id data, int status, NSString *msg) {
//            weakSelf.data=data;
//
//            if ([[weakSelf.data ojsk:@"coal"] isEqualToString:@"其他"]) {
//                weakSelf.isOtherTypeCoal=YES;
//                //            [weakSelf.mtableView reloadData];
//                [weakSelf addView];
//            }
//            [weakSelf bendData];
//        }];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
