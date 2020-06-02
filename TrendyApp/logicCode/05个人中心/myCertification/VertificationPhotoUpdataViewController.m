//
//  VertificationPhotoUpdataViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VertificationPhotoUpdataViewController.h"
#import "MYRHTableView.h"
@interface VertificationPhotoUpdataViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,copy)NSString*is_auth;
//@"is_auth":_is_auth,;
@end

@implementation  VertificationPhotoUpdataViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.is_auth=[self.otherInfo ojsk:@"is_auth"];
//    self.otherInfo=@{
//                     @"title":@"國際駕證",
//                     @"describe":@"請上傳您本人的國際駕證,請確保圖片清晰,四角完整！",
//                     @"list":@[
//                             @{
//                                 @"placeholder":@"上傳國際駕證主頁",
//                                 },
//                             @{
//                                 @"placeholder":@"上傳國際駕證副頁",
//                                 },
//                             ],
//                     };
    
    [self addView];
    [self rightButton:kS(@"AddBasicVehicleInformation", @"complete") image:nil sel:@selector(submitBtnClick:)];
    if ([self.is_auth isEqualToString:@"1"]) {
        self.navrightButton.hidden=YES;
    }
    if (self.userInfo) {
        [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.userInfo];
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
//            [kUserCenterService ucenterUpdateWithParam:dictparam withBlock:^(id data, int status, NSString *msg) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                });
//
//            }];
            if (weakSelf.allcallBlock) {
                weakSelf.allcallBlock(dictparam, 200, nil);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        }
    }];
}
#pragma mark -   write UI
-(void)addView{
    [self navbarTitle:[self.otherInfo ojsk:@"title"] ];
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    {
        UILabel*lbDes=[RHMethods lableX:22 Y:20 W:kScreenWidth Height:0 font:13 superview:nil withColor:rgb(152, 152, 152) text:[self.otherInfo ojsk:@"describe"]];
        [_mtableView.defaultSection.noReUseViewArray addObject:lbDes];
    }
    
    
    {
        
        NSMutableArray*arraytitle=[self.otherInfo ojsk:@"list"];
        arraytitle=[arraytitle toBeMutableObj];
        for (int i=0; i<arraytitle.count; i++) {
            NSMutableDictionary*dic=arraytitle[i];
            [dic setObject:@"OFCImageUpLoadCellView" forKey:@"classStr"];
            [dic setObject:@"1" forKey:@"isMust"];
            BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
            if ([self.is_auth isEqualToString:@"1"]) {
                viewCell.userInteractionEnabled=NO;
            }
        }
        
        [_mtableView reloadData];
    }
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
