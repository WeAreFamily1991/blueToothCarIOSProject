//
//  MYRHTableViewPerfomanceTest.m
//  SanTongJingLuo
//
//  Created by 55like on 2018/1/9.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "MYRHTableViewPerfomanceTest.h"
#import "MYRHTableView.h"
#import "PerforManceTestTool.h"
@interface MYRHTableViewPerfomanceTest ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,assign)int times;
@property(nonatomic,assign)int timesh;
@end

@implementation  MYRHTableViewPerfomanceTest
#pragma mark  开始


-(void)openme{
    _times=0;
    _timesh=0;
    
    [UTILITY.currentViewController setAddValue:self forKey:@"MYRHTableViewPerfomanceTest"];
    
    [self addView];
    //    [self loadDATA];
    [UTILITY.currentViewController rightButton:@"重新加载" image:nil sel:nil];
    [UTILITY.currentViewController.navrightButton addTarget:self action:@selector(loadDATA) forControlEvents:UIControlEventTouchUpInside];
}
-(void)loadDATA{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:10];
//    self.times=0;self.timesh=0;
    float timeuse= [PerforManceTestTool testPerforManceWithName:@"tableView加载" WithTimes:1 With:^(id data, int status, NSString *msg) {
        [_mtableView reloadData];
    }];
    NSLog(@"普通绑定：%d   计算高度绑定：%d 消耗时间 %f",self.times,self.timesh,timeuse);
    
    
}
#pragma mark -  写UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mtableView.dataArray=kfAry(200000);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
     
        UIImageView*imgV1=[RHMethods imageviewWithFrame:CGRectMake(10, 10, 100, 100) defaultimage:@"" supView:reuseView reuseId:@"imgV1"];
        [imgV1 imageWithURL:@"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=3359324599,3638334535&fm=85&s=58038918AA8ABE052507C09C0300F0A0"];
        if (reuseView==weakSelf.mtableView) {
            weakSelf.timesh=weakSelf.timesh+1;
        }else{
            weakSelf.times=weakSelf.times+1;
        }
        
        return imgV1;
        
    }];
    
   
    [UTILITY.currentViewController.view addSubview:_mtableView];
    
}
+(void)showMyDemo{
    MYRHTableViewPerfomanceTest*obj= [[MYRHTableViewPerfomanceTest alloc]init];
    [obj openme];
}



@end
