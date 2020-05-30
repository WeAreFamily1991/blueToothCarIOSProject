//
//  ViewController.m
//  55likeLibDemo
//
//  Created by junseek on 2017/5/2.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "DEMOHOMEViewController.h"
#import "ImageSelectEditorView.h"
#import "RHTableView.h"
#import "ExampleViewController.h"

@interface DEMOHOMEViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    
}
@property(nonatomic,strong)RHTableView*mtableView;

@end

@implementation DEMOHOMEViewController
#pragma mark  开始
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.userInfo==nil) {
        [self navbarTitle:@"DEMO"];
    }
    
    [self addView];
    [self loadDATA];
    
    
    
    
}
#pragma mark -  写UI
-(void)addView{
    _mtableView =[[RHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    
    _mtableView.delegate = self;
    _mtableView.dataSource = self;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    
}


#pragma mark  tableview网络请求
-(void)loadDATA{
    
    if (self.userInfo) {
        NSString *addressPath = [[NSBundle mainBundle] pathForResource:self.userInfo ofType:@"plist"];
        NSMutableDictionary*mdic=[[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
        NSMutableArray*maarray=[NSMutableArray arrayWithArray:[mdic objectForKey:@"dataArray"]];
        _mtableView.dataArray=maarray;
        [_mtableView reloadData];
        
    }else{
        
        
        NSArray*array=@[
                        @{@"name":@"样式实例",
                          @"describe":@"图片选择，弹窗，进度条，时间选择，...",
                          @"filePath":@"DesignDepartment",
                          },
                        @{@"name":@"选择类实例",
                          @"describe":@"地址选择，时间选择，图片选择，条目选择，弹窗选择...类似表单提交",
                          @"filePath":@"SelectTypeDemo",
                          },
                        ];
        
        _mtableView.dataArray=[NSMutableArray arrayWithArray:array];
        [_mtableView reloadData];
    }

//    SelectTypeDemo
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    //    self.provinces = [dict objectForKey:@"address"];        //取出address数组
    
    
}
#pragma mark - 按钮事件监听


#pragma mark - 代理事件



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
            UIImageView*imgVrow=[RHMethods imageviewWithFrame:CGRectMake(kScreenWidth-6.5-10, 0, 6.5, 12.5) defaultimage:kLibImage(@"myrightarrow") supView:cell];
//            [imgVrow beCY];
            imgVrow.centerY=30;
            
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
        
        if (self.userInfo) {
            classNamelb.text=[dic objectForJSONKey:@"classname"];
        }else{
            classNamelb.text=[dic objectForJSONKey:@"describe"];
        }
        return cell;
        
    }
    return [UITableViewCell new];
}
#pragma mark  选中cell
-(void)tableView:(RHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic=tableView.dataArray[indexPath.row];
    NSLog(@"%@",[dic objectForJSONKey:@"classname"]);
    
    if (self.userInfo) {
        
        [self pushController:[ExampleViewController class] withInfo:dic withTitle:[dic objectForJSONKey:@"name"]];
    }else{
        [self pushController:[DEMOHOMEViewController class] withInfo:[dic objectForJSONKey:@"filePath"] withTitle:[dic objectForJSONKey:@"name"] withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            
        }];
    }
    
    
    
}
@end

