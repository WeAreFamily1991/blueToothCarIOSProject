//
//  SystemMessageViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SystemMessageViewController.h"
#import "MYRHTableView.h"
#import "SystermMessageCellView.h"
@interface SystemMessageViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  SystemMessageViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.defaultSection.dataArray=kfAry(13);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        SystermMessageCellView*viewcell=[SystermMessageCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    
}
#pragma mark  request data from the server use tableview
-(void)request{
    [_mtableView showRefresh:YES LoadMore:YES];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [pageOrPageSizeData setObject:@"system" forKey:@"type"];
        
  
        
        [kUserCenterService ucenter_noticeslist:pageOrPageSizeData withBlock:^(id data, int status, NSString *msg) {
            dataCallBack(data,status,msg);
            NSArray*listArray=[data ojk:@"list"];
            NSMutableArray*ids=[NSMutableArray new];
            for (NSMutableDictionary*mdic in listArray) {
                if ([[mdic ojsk:@"is_read"] isEqualToString:@"0"]) {
                }else{
                    [ids addObject:[mdic ojsk:@"id"]];
                }
            }
            
            if (ids.count) {
                NSMutableDictionary*mdic=[NSMutableDictionary new];
                [mdic setObject:[ids componentsJoinedByString:@","] forKey:@"ids"];
                [kUserCenterService ucenter_noticesop:mdic withBlock:^(id data, int status, NSString *msg) {
                    
                }];
            }
        }];
        
        
    }];
    [_mtableView refresh];
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end

