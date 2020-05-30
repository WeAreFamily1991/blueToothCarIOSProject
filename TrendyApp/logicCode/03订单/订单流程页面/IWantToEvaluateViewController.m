//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "IWantToEvaluateViewController.h"
#import "MYRHTableView.h"
@interface IWantToEvaluateViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
/**
 其他煤种
 */
@property(nonatomic,assign)BOOL isOtherTypeCoal;
@end
@implementation  IWantToEvaluateViewController
#pragma mark  bigen
- (void)viewDidLoad {
//    [self rightButton:@"完成" image:nil sel:@selector(submitBtnClick:)];
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
                    [dictparam setObject:weakSelf.userInfo forKey:@"orderid"];
                }
                
                if ([weakSelf.otherInfo isEqualToString:@"userCenter"]) {
                    [kUserCenterService carcenter_addComment:dictparam withBlock:^(id data, int status, NSString *msg) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        });
                    }];
                }else{
                    [kOrderService order_addComment:dictparam withBlock:^(id data, int status, NSString *msg) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        });
                    }];
                }
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
                                     @"name":@"linxxx",
                                     @"classStr":@"FCLineCellView",
                                     @"requestkey":@"",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":@"linxxx2",
                                     @"classStr":@"FCWhiteLineCellView",
                                     @"requestkey":@"",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"車輛狀況",
                                     @"name":kS(@"order_comment", @"comment_car_text"),
                                     @"classStr":@"OFCScoreCellView",
                                     @"requestkey":@"car_point",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"服务態度",
                                     @"name":kS(@"order_comment", @"comment_service_text"),
                                     @"classStr":@"OFCScoreCellView",
                                     @"requestkey":@"service_point",
//                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"訂單評價內容",
                                     @"name":kS(@"order_comment", @"hint_comment_content"),
                                     @"classStr":@"FCOnlyTextCellView",
                                     @"placeholder":kS(@"order_comment", @"hint_comment_content"),
                                     @"requestkey":@"content",
                                     @"placeholder":@"對於本訂單，您還有什麼想說的嗎？",
//                                     @"isMust":@"1",
                                     },
                                 @{
//                                     @"name":@"添加图片",
                                     @"name":kS(@"order_comment", @"comment_add_image"),
                                     @"classStr":@"FCImageSelectCellView",
                                     @"tipStr":kS(@"order_comment", @"comment_add_image_desc"),
                                     @"requestkey":@"pics",
//                                     @"isMust":@"1",
                                     },
                                 
                                 ] toBeMutableObj];
    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        
    }
    
    {
         WSSizeButton*btnConfirm=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"order_comment", @"comment_submit") font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnConfirm];
        [btnConfirm addViewTarget:self select:@selector(submitBtnClick:)];
    }
    
    [_mtableView reloadData];
}

//#pragma mark  request data from the server use tableview
//#pragma mark - request data from the server
//-(void)loadDATA{
//    __weak __typeof(self) weakSelf = self;
//    NSMutableDictionary*paramdic=[NSMutableDictionary new];
//    [paramdic setObject:self.userInfo forKey:@"linkId"];
//    [paramdic setObject:self.otherInfo forKey:@"type"];
//    //    [kBusinessSubmissionService getBusinessSubmissionDetailWithParam:paramdic withBlock:^(id data, int status, NSString *msg) {
//    //        weakSelf.data=data;
//    //
//    //        if ([[weakSelf.data ojsk:@"coal"] isEqualToString:@"其他"]) {
//    //            weakSelf.isOtherTypeCoal=YES;
//    //            //            [weakSelf.mtableView reloadData];
//    //            [weakSelf addView];
//    //        }
//    //        [weakSelf bendData];
//    //    }];
//}
//-(void)bendData{
//    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
//}
@end
