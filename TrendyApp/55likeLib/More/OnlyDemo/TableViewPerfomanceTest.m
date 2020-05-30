//
//  RHTableViewDemo.m
//  55likeLibDemo
//
//  Created by 55like on 20/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "TableViewPerfomanceTest.h"
#import "RHTableView.h"
#import "PerforManceTestTool.h"
@interface TableViewPerfomanceTest()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property(nonatomic,assign)float cellH;
@property(nonatomic,strong)RHTableView*mtableView;
@end
@implementation TableViewPerfomanceTest


-(void)openme{
    [UTILITY.currentViewController setAddValue:self forKey:@"RHTableViewDemo"];
    
    [self addView];
//    [self loadDATA];
    [UTILITY.currentViewController rightButton:@"重新加载" image:nil sel:nil];
    [UTILITY.currentViewController.navrightButton addTarget:self action:@selector(loadDATA) forControlEvents:UIControlEventTouchUpInside];
}


-(void)addView{
    _mtableView =[[RHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    [_mtableView showRefresh:YES LoadMore:YES];
    
    _mtableView.delegate = self;
    _mtableView.dataSource = self;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [UTILITY.currentViewController.view addSubview:_mtableView];
    
    
}
-(void)loadDATA{
    //    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"Appdata" ofType:@"plist"];
//    NSMutableArray*maarray=[NSMutableArray new];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑编辑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑编辑"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
//    _mtableView.dataArray=maarray;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:10];
   float timeuse= [PerforManceTestTool testPerforManceWithName:@"tableView加载" WithTimes:3000 With:^(id data, int status, NSString *msg) {
        
//        [_mtableView reloadData];
     
       [self tableView:_mtableView cellForRowAtIndexPath: indexPath];
     
    }];
     [_mtableView reloadData];
       [UTILITY.currentViewController rightButton:[NSString stringWithFormat:@"%f",timeuse] image:nil sel:nil];
        [UTILITY.currentViewController.navrightButton addTarget:self action:@selector(loadDATA) forControlEvents:UIControlEventTouchUpInside];
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    //    self.provinces = [dict objectForKey:@"address"];        //取出address数组
    
    
}

#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(RHTableView *)tableView{
    
    
    return 1;
    
}

-(NSInteger)tableView:(RHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return 30;
}

-(CGFloat)tableView:(RHTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(RHTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return self.cellH;
    return 60;
}
-(CGFloat)tableView:(RHTableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    return 0.001;
}

-(UIView *)tableView:(RHTableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
    
    
}

#pragma mark  cell处理
- (UITableViewCell *)tableView:(RHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==_mtableView){
        //
        static NSString *strCell=@"cellT";
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:strCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        }
        UILabel*lb1=[RHMethods lableX:10 Y:10 W:kScreenWidth-20 Height:0 font:12 superview:cell withColor:nil text:@"测试" reuseId:@"lb1"];
        UIImageView*imgV1=[RHMethods imageviewWithFrame:CGRectMake(10, lb1.frameYH+10, kScreenWidth-20, 20) defaultimage:@"listimg" supView:cell  reuseId:@"imgV1"];
        
//        lb1.text=[NSString stringWithFormat:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试%ld",(long)indexPath.row];
        lb1.text=@"测试";
//        for (int i=0; i<indexPath.row; i++) {
//            lb1.text=[NSString stringWithFormat:@"%@%@",lb1.text,@"测试"];
//        }
        lb1.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        [imgV1 setAddValue:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"indexpath"];
        [imgV1 imageWithURL:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];//@"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=3359324599,3638334535&fm=85&s=58038918AA8ABE052507C09C0300F0A0"
        
        
       lb1= [RHMethods lableX:10 Y:10 W:kScreenWidth-20 Height:0 font:12 superview:cell withColor:nil text:@"测试" reuseId:@"lb1"];
      imgV1= [RHMethods imageviewWithFrame:CGRectMake(10, lb1.frameYH+10, kScreenWidth-20, 20) defaultimage:@"listimg" supView:cell  reuseId:@"imgV1"];
        self.cellH=imgV1.frameYH+10;
        if (indexPath.row==0) {
//            NSLog(@"55");
        }
        
        return cell;
        
    }
    return [UITableViewCell new];
}
#pragma mark  选中cell
-(void)tableView:(RHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    NSDictionary *dic=tableView.dataArray[indexPath.row];
//    NSLog(@"%@",[dic objectForJSONKey:@"classname"]);
    
    
    
}





+(void)showMyDemo{
    TableViewPerfomanceTest*obj= [[TableViewPerfomanceTest alloc]init];
    [obj openme];
}

@end

