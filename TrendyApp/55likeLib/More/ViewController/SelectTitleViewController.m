//
//  PayTypeViewController.m
//  EastCollection
//
//  Created by 55like on 2017/2/10.
//  Copyright © 2017年 55like. All rights reserved.
//
#import "SelectTitleViewController.h"
#import "RHTableView.h"
@interface SelectTitleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    RHTableView*_tableView;
    
}
@property(nonatomic,assign)float cellH;
@property(nonatomic,copy)NSString*currenttitle;
@property(nonatomic,strong)NSDictionary*currentdic;
@end
@implementation SelectTitleViewController
#pragma mark  开始
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}
#pragma mark -  写UI
-(void)addView{
    
    //创建btn
    WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49) backgroundColor:rgb(52,52,52) text:@"提交" font:17 textColor:rgb(210,181,103) radius:0 superview:self.view];
      __weak __typeof(self) weakSelf = self;
    [btn1 addViewClickBlock:^(UIView *view) {
        if (weakSelf.currentdic==nil) {
            [SVProgressHUD showErrorWithStatus:@"请选择条目"];
            
            return;
        }
        
        if (weakSelf.allcallBlock) {
            weakSelf.allcallBlock(weakSelf.currentdic,200,nil);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _tableView =[[RHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.backgroundColor = lightYellow ;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _currenttitle=[self.otherInfo objectForKey:@"currentTitle"];
    NSArray*array=[self.otherInfo objectForKey:@"titleArray"];
    if (array.count>0&&[array[0] isKindOfClass:[NSString class]]) {
        NSMutableArray*marray=[NSMutableArray new];
        for (int i=0; i<array.count; i++) {
            NSMutableDictionary*dic=[NSMutableDictionary new];
            [dic setObject:array[i] forKey:@"title"];
            [marray addObject:dic];
            
        }
        
        _tableView.dataArray=marray;
        
        
    }else{
        
        _tableView.dataArray=[self.otherInfo objectForKey:@"titleArray"];
    }
    
    
    
    
    [_tableView reloadData];
    
}


#pragma mark  tableview网络请求
-(void)request{
    krequestParam
    [dictparam setObject:@"%@" forKey:@"page"];
    [dictparam setObject:@"12" forKey:@"pagesize"];
    //    if (self.classid) {
    //        [dictparam setObject:self.classid forKey:@"classId"];
    //    }
    //
    //    if (dataview) {
    //        [dictparam setObject:dataview.subtimestr forKey:@"dateTime"];
    //    }
    _tableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
    [_tableView showRefresh:YES LoadMore:YES];
    [_tableView refresh];
    [_tableView showRefresh:YES LoadMore:YES];
}
#pragma mark - 按钮事件监听

#pragma mark - 代理事件



#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(RHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numrow = 0;
    if (tableView ==_tableView) {
        numrow =  _tableView.dataArray.count;
    }
    return numrow;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return 0.01;
    }else return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger heightRow;
    if (tableView == _tableView) {
        
        
        // [self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        //        230;
        heightRow =  self.cellH;
    }
    return 35.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_tableView) {
        
        
        
        return [UIView new];
    }else{
        return [UIView new];
        
    }
    
}
#pragma mark  cell处理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==_tableView){
        NSDictionary *dic=_tableView.dataArray[indexPath.row];
        //
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            cell.frameWidth=kScreenWidth;
            //左边lable
            UILabel*lb1=[RHMethods lableX:10 Y:10 W:kScreenWidth Height:14 font:14 superview:cell withColor:nil text:@"支付宝"];
            lb1.tag=1001;
            UIImageView*imagV1=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 20, 20) defaultimage:kLibImage(@"radio08") supView:cell];
            imagV1.frameRX=10;
            imagV1.centerY=lb1.centerY;
            imagV1.tag=1002;
            
            [cell setAddValue:lb1 forKey:@"lb1"];
            [cell setAddValue:imagV1 forKey:@"imagV1"];
          [RHMethods viewWithFrame:CGRectMake(10, lb1.frameYH+10, kScreenWidth-20, 0.5) backgroundcolor:rgb(229,229,229) superView:cell];
            
        }
        UILabel*lb1=[cell getAddValueForKey:@"lb1"];
        UIImageView*imgV1=[cell getAddValueForKey:@"imagV1"];
        lb1.text=[dic getSafeObjWithkey:@"title"];
        
        if ([lb1.text isEqualToString:_currenttitle]) {
            imgV1.hidden=NO;
            _currentdic=dic;
        }else{
            
            imgV1.hidden=YES;
        }
        
        return cell;
        
    }
    return [UITableViewCell new];
}
#pragma mark  选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView ==_tableView) {
        NSMutableDictionary *dic=_tableView.dataArray[indexPath.row];
        _currenttitle=[dic getSafeObjWithkey:@"title"];
        _currentdic=dic;
        [_tableView reloadData];
    }
    
    
}

+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"条目选择" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        
        
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnme=(UIButton*)view;
            
            NSMutableDictionary*dictparam=[[NSMutableDictionary alloc]init];
            [dictparam setObject:@[@"条目1",@"条目2",@"条目3"] forKey:@"titleArray"];
            [dictparam setObject:[btnme currentTitle] forKey:@"currentTitle"];
            [UTILITY.currentViewController pushController:[SelectTitleViewController class ] withInfo:nil withTitle:@"条目选择" withOther:dictparam withAllBlock:^(id data, int status, NSString *msg) {
                if (status==200) {
                    [btnme setTitle:[data getSafeObjWithkey:@"title"] forState:UIControlStateNormal];
                }
                
            }];
            
        }];
        
        
        yAdd=btn1.frameYH+10;
    }
    
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"条目选择(带其他的参数)" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        
        
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnme=(UIButton*)view;
            NSMutableDictionary*dictparam=[[NSMutableDictionary alloc]init];
            [dictparam setObject:@[@{@"title":@"条目1",@"id":@"100"},@{@"title":@"条目2",@"id":@"100"},@{@"title":@"条目3",@"id":@"100"},] forKey:@"titleArray"];
            [dictparam setObject:[btnme currentTitle] forKey:@"currentTitle"];
            [UTILITY.currentViewController pushController:[SelectTitleViewController class] withInfo:nil withTitle:@"条目选择" withOther:dictparam withAllBlock:^(id data, int status, NSString *msg) {
                if (status==200) {
                    [btnme setTitle:[data getSafeObjWithkey:@"title"] forState:UIControlStateNormal];
                }
                
            }];
            
        }];
        
        
        yAdd=btn1.frameYH+10;
    }

}

@end
