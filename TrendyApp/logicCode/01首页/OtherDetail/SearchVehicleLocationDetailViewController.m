//
//  SearchVehicleLocationDetailViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SearchVehicleLocationDetailViewController.h"
#import "MYRHTableView.h"
@interface SearchVehicleLocationDetailViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  SearchVehicleLocationDetailViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(15, 3, kScreenWidth-15-15, 30) backgroundcolor:rgb(246, 246, 246) superView:viewTopSearch];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:@"請輸入您的用車地點" text:@""  supView:viewSearchContent];
        tfSearch.userInteractionEnabled=NO;
        
    }
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTopSearch.frameYH, kScreenWidth, kScreenHeight-viewTopSearch.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    _mtableView.defaultSection.dataArray=kfAry(15);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        UIView*viewcell=[reuseView getAddValueForKey:@"viewcell"];
        if (viewcell==nil) {
        viewcell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 66) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        UILabel*lbAddress=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:14 superview:viewcell withColor:rgb(14, 112, 161) text:@"上海市"];
            UILabel*lbDetail=[RHMethods lableX:lbAddress.frameX Y:lbAddress.frameYH+10 W:lbAddress.frameWidth Height:11 font:11 superview:viewcell withColor:rgb(153, 153, 153) text:@"上海市上海市上海市上海市上海市上海市上海市上海市"];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:viewcell];
            viewLine.frameBY=0;
            viewcell.backgroundColor=rgb(255, 255, 255);
        }
        
        
        return viewcell;
    }];
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
