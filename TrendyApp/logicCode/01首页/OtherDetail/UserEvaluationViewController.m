//
//  UserEvaluationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "UserEvaluationViewController.h"
#import "MYRHTableView.h"
#import "UserEvaluationCellView.h"
@interface UserEvaluationViewController ()<RHTableViewDelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  UserEvaluationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
    [self navbarTitle:kST(@"userComment")];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    _mtableView.delegate2=self;
    [_mtableView showRefresh:YES LoadMore:YES];
    _mtableView.defaultSection.selctionHeaderView=[self getUserEvaluantionHeader];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        UserEvaluationCellView *viewcell=[UserEvaluationCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    
}
-(UIView*)getUserEvaluantionHeader{
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 10) backgroundcolor:rgb(255, 255, 255) superView:nil];
    NSMutableArray*arraytitle=[@[
//                                 @{
//                                     @"name":@"linxxx2",
//                                     @"classStr":@"FCWhiteLineCellView",
//                                     @"requestkey":@"",
//                                     @"unit":@"",
//                                     //                                     @"isMust":@"1",
//                                     },
                                 @{
                                     @"name":kS(@"userComment", @"carStatusRate"),//@"車輛狀況",
                                     @"classStr":@"OFCScoreCellView",
                                     @"requestkey":@"",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"userComment", @"serviceAttitudeRate"),//@"服务態度",
                                     @"classStr":@"OFCScoreCellView",
                                     @"requestkey":@"",
                                     @"valueStr":@"",
                                     @"unit":@"",
                                     //                                     @"isMust":@"1",
                                     },
//                                 @{
//                                     @"name":@"linxxx2",
//                                     @"classStr":@"FCWhiteLineCellView",
//                                     @"requestkey":@"",
//                                     @"unit":@"",
//                                     //                                     @"isMust":@"1",
//                                     },
                                 ] toBeMutableObj];
    for (int i=0; i<arraytitle.count; i++) {
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:arraytitle[i]];
        viewCell.frameY=viewContent.frameHeight;
        [viewContent addSubview:viewCell];
        viewCell.userInteractionEnabled=NO;
        viewCell.tag=100+i;
        viewContent.frameHeight=viewCell.frameYH;
    }
    viewContent.frameHeight+=10;
    [UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight-0.5, kScreenWidth-30, 0.5) backgroundcolor:rgbLineColor superView:viewContent];
    return viewContent;
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"20" forKey:@"pagesize"];
    [dictparam setValue:self.userInfo forKey:@"cid"];
    _mtableView.urlString=[NSString stringWithFormat:@"welcome/comment%@",dictparam.wgetParamStr];
    [_mtableView refresh];
}
#pragma mark - request data from the server
-(void)loadDATA{
   
    
}
#pragma mark - event listener function


#pragma mark - delegate function
#pragma mark RHTableViewDelegate
-(void)refreshData:(RHTableView *)view{
    for (BaseFormCellView *vieCell in [_mtableView.defaultSection.selctionHeaderView subviews]) {
        if (vieCell.tag==100) {
            vieCell.valueStr=[view.dataDic ojsk:@"car_points_average"];
        }else if (vieCell.tag==101){
            vieCell.valueStr=[view.dataDic ojsk:@"service_points_average"];
        }
    }
}

@end
