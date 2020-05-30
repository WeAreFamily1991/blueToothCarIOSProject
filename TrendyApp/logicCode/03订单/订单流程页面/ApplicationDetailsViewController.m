//
//  ApplicationDetailsViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ApplicationDetailsViewController.h"
#import "MYRHTableView.h"//dfsdfadf
@interface ApplicationDetailsViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  ApplicationDetailsViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addView]; order/applydetail
    krequestParam
    [dictparam setObject:self.userInfo forKey:@"orderid"];
    [dictparam setObject:self.otherInfo forKey:@"type"];//type    字符串    必须        advance/extend
    [NetEngine createPostAction:@"order/applydetail" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData ojk:@"data"];
            self.data=dic;
            if ([self.otherInfo isEqualToString:@"extend"]) {
                [self addViewextend];
            }else{
                [self addViewadvance];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];

}
#pragma mark -   write UI
-(void)addViewextend{//延長用車
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//申請狀態
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 58) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lableStatus=[RHMethods labelWithFrame:CGRectMake(15, 0, kScreenWidth-30, viewContent.frameHeight) font:Font(19) color:rgb(13, 107, 153) text:[self.data ojsk:@"status_name"]];
        [viewContent addSubview:lableStatus];
    }
    //提前還車信息
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 70) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
//        UILabel*lbTitle=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:@"提前還車信息"];
        UILabel*lbTitle=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"apply_detail", @"extend_info")];
//        UILabel*lbContent=[RHMethods lableX:15 Y:lbTitle.frameYH+15 W:kScreenWidth*0.6 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:@"提前還車時間"];
        UILabel*lbContent=[RHMethods lableX:15 Y:lbTitle.frameYH+15 W:kScreenWidth*0.6 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:kS(@"apply_detail", @"extend_time")];
         UILabel*lbTime=[RHMethods RlableRX:15 Y:lbContent.frameY W:kScreenWidth*0.5 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:[self.data ojsk:@"time_str"]];
        
    }
    //最後的提示信息
    {
        UILabel*lbContent=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:0 font:13 superview:nil withColor:rgb(153, 153, 153) text:[NSString stringWithFormat:@"%@\n%@",kS(@"apply_detail", @"extend_agree"),kS(@"apply_detail", @"extend_refuse")]];
        [_mtableView.defaultSection.noReUseViewArray addObject:lbContent];
    }
    
}

-(void)addViewadvance{//延長用車
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    //申請狀態
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 58) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lableStatus=[RHMethods labelWithFrame:CGRectMake(15, 0, kScreenWidth-30, viewContent.frameHeight) font:Font(19) color:rgb(13, 107, 153) text:[self.data ojsk:@"status_name"]];
        [viewContent addSubview:lableStatus];
    }
    //提前還車信息
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 70) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        //        UILabel*lbTitle=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:@"提前還車信息"];
        UILabel*lbTitle=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"apply_detail", @"advance_info")];
        //        UILabel*lbContent=[RHMethods lableX:15 Y:lbTitle.frameYH+15 W:kScreenWidth*0.6 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:@"提前還車時間"];
        UILabel*lbContent=[RHMethods lableX:15 Y:lbTitle.frameYH+15 W:kScreenWidth*0.6 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:kS(@"apply_detail", @"advance_time")];
        UILabel*lbTime=[RHMethods RlableRX:15 Y:lbContent.frameY W:kScreenWidth*0.5 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:[self.data ojsk:@"time_str"]];
        
    }
    //最後的提示信息
    {
        UILabel*lbContent=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:0 font:13 superview:nil withColor:rgb(153, 153, 153) text:[NSString stringWithFormat:@"%@\n%@",kS(@"apply_detail", @"advance_agree"),kS(@"apply_detail", @"advance_refuse")]];
        [_mtableView.defaultSection.noReUseViewArray addObject:lbContent];
    }
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
