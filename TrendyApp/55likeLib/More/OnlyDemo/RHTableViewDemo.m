//
//  RHTableViewDemo.m
//  55likeLibDemo
//
//  Created by 55like on 20/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "RHTableViewDemo.h"
#import "RHTableView.h"
@interface RHTableViewDemo()<UITableViewDelegate,UITableViewDataSource>
{

}
@property(nonatomic,strong)RHTableView*mtableView;
@end
@implementation RHTableViewDemo


-(void)openme{
    [UTILITY.currentViewController setAddValue:self forKey:@"RHTableViewDemo"];
    
    [self addView];
    [self loadDATA];
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
    NSMutableArray*maarray=[NSMutableArray new];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑编辑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑编辑"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    [maarray addObject:@{@"name":@"例子",@"describe":@"侧滑删除"}];
    _mtableView.dataArray=maarray;
    [_mtableView reloadData];
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    //    self.provinces = [dict objectForKey:@"address"];        //取出address数组
    
    
}

#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(RHTableView *)tableView{
    
    
    return 1;
    
}

-(NSInteger)tableView:(RHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return tableView.dataArray.count;
}

-(CGFloat)tableView:(RHTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(RHTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            cell.frameWidth=kScreenWidth;
            
            UILabel*lbTitle=[RHMethods labelWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20) font:Font(15) color:[UIColor blackColor] text:@"xx"];
            UILabel*classNamelb=[RHMethods labelWithFrame:CGRectMake(10, 35, kScreenWidth-20, 20) font:Font(13) color:[UIColor blackColor] text:@"xx"];
            UIView*linView=[[UIView alloc]initWithFrame:CGRectMake(10, 59.5, kScreenWidth-20, 0.5)];
            linView.backgroundColor=[UIColor grayColor];
            [cell addSubview:lbTitle];
            [cell addSubview:classNamelb];
            [cell addSubview:linView];
            [cell setAddValue:lbTitle forKey:@"lbTitle"];
            [cell setAddValue:classNamelb forKey:@"classNamelb"];
            
            
        }
        UILabel*lbTitle=[cell getAddValueForKey:@"lbTitle"];
        UILabel*classNamelb=[cell getAddValueForKey:@"classNamelb"];
        NSDictionary*dic=tableView.dataArray[indexPath.row];
        lbTitle.text=[dic objectForJSONKey:@"name"];
        classNamelb.text=[dic objectForJSONKey:@"describe"];
        return cell;
        
    }
    return [UITableViewCell new];
}
#pragma mark  选中cell
-(void)tableView:(RHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic=tableView.dataArray[indexPath.row];
    NSLog(@"%@",[dic objectForJSONKey:@"classname"]);
    
    
    
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath      //当在Cell上滑动时会调用此函数
//{
//    //    NSDictionary *dic=[table_user.dataArray objectAtIndex:indexPath.row];
//    //    if ([[dic valueForJSONStrKey:@"del"] isEqualToString:@"1"]) {//del 自营销列表 del字段判断是否可以删除 1是 0 否
//    if(indexPath.row==0){
//    
//    }else if(indexPath.row==1){
//    
//    }
//    return  UITableViewCellEditingStyleDelete;
//    //    }else{
//    //        return  UITableViewCellEditingStyleNone;
//    //    }
//}
//
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) { NSLog(@"点击了删除"); }];
    // 删除一个置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) { NSLog(@"点击了编辑"); }];
    topRowAction.backgroundColor = [UIColor grayColor];
//    // 添加一个更多按钮
//    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) { NSLog(@"点击了更多"); }];
//    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // 将设置好的按钮放到数组中返回
    
        if(indexPath.row==0){
    return @[deleteRowAction, topRowAction];
        }else if(indexPath.row==1){
    return @[ topRowAction];
        }
    
    return @[deleteRowAction];
}
    
  


+(void)showMyDemo{
   RHTableViewDemo*obj= [[RHTableViewDemo alloc]init];
    [obj openme];
}

@end
