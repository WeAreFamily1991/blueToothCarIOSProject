//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ScarRegistrationViewController.h"
#import "MYRHTableView.h"
@interface ScarRegistrationViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end
@implementation  ScarRegistrationViewController
#pragma mark  bigen
- (void)viewDidLoad {
//    [self rightButton:kS(@"addInsurerInfo", @"button_complete") image:nil sel:@selector(submitBtnClick:)];
    [super viewDidLoad];
    [self addView];
//    if (self.userInfo) {
//        [self loadDATA];
//    }
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
                [dictparam setObject:weakSelf.userInfo forKey:@"carid"];
            }
            if ([[[data ojsk:@"pics"] componentsSeparatedByString:@","] count]<4) {
                [SVProgressHUD showImage:nil status:kS(@"ScarRegistration", @"tapStr")];
                return ;
            }
            
            [kCarCenterService carcenter_addscar:dictparam withBlock:^(id data, int status, NSString *msg) {
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
    {
        UIView*viewCell=[UIView viewWithFrame:CGRectMake(0, 0,kScreenWidth , 44) backgroundcolor:nil superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        UILabel*lbTitle=[RHMethods lableX:15 Y:0 W:kScreenWidth-30 Height:44 font:17 superview:viewCell withColor:rgb(153, 153, 153) text:kS(@"ScarRegistration", @"tapStr")];
    }
    
    
    NSMutableArray*arraytitle=[@[
                                 @{
                                     @"name":kS(@"ScarRegistration", @"addPicture"),
                                     @"classStr":@"FCImageSelectCellView",
                                     @"requestkey":@"pics",
                                     @"tipStr":kS(@"ScarRegistration", @"PhotosAreClear"),
                                     @"isMust":@"1",
                                     @"picturenumber":@"4",
                                     },
                                 ] toBeMutableObj];
    arraytitle=[arraytitle toBeMutableObj];
//    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        
    }
    
    {
        WSSizeButton*btnConfirm=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"AddVehicles", @"Submit") font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnConfirm];
        [btnConfirm addViewTarget:self select:@selector(submitBtnClick:)];
    }
    [_mtableView reloadData];
}

#pragma mark  request data from the server use tableview
#pragma mark - request data from the server
-(void)loadDATA{
    __weak __typeof(self) weakSelf = self;
    weakSelf.data=self.userInfo;
    [weakSelf bendData];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
