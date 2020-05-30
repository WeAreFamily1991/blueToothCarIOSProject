//
//  ChooseAStoreViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AutomobileBrandContentView.h"
#import "MYRHTableView.h"
#import "WSButtonGroup.h"
@interface AutomobileBrandContentView ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    
}
@property(nonatomic,strong)RHTableView*mtableView;
@property(nonatomic,strong)RHTableView*mtableView2;
@property(nonatomic,strong)WSButtonGroup*btnGroup;
@property(nonatomic,strong)NSMutableDictionary*currrentSelectDic;
@end

@implementation  AutomobileBrandContentView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=kScreenHeight-kTopHeight;
    }
    if (self.isfirstInit) {
          __weak __typeof(self) weakSelf = self;
        [weakSelf setAddUpdataBlock:^(id data, id weakme) {
            [weakSelf addView];
//            for (NSMutableDictionary*mdic in data[@"list"]) {
//                
//            }
            for (int i=0; i<[data[@"list"] count]; i++) {
                NSMutableDictionary*mdic=data[@"list"][i];
                for (int j=0; j<[mdic[@"son"] count]; j++) {
                    
                    if ([[mdic[@"son"][j] ojsk:@"selected"] isEqualToString:@"1"]) {
//                        NSIndexPath*index=[NSIndexPath indexPathForRow:j inSection:i];
//                        [weakSelf selectAtIndexPath:index];

                        [weakSelf selectAtSection:i atRow:j];
                        return ;
                    }
                }
            }
            [weakSelf.btnGroup btnClickAtIndex:0];
        }];
    }
    
    
}
#pragma mark  bigen
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self addView];
//}
#pragma mark -   write UI
-(void)addView{
    {
        
        _mtableView =[[RHTableView alloc]initWithFrame:CGRectMake(105, 0, kScreenWidth-105, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableView.delegate=self;
        _mtableView.dataSource=self;
        [self addSubview:_mtableView];
        [_mtableView reloadData];
    }
    {
        _btnGroup=[WSButtonGroup new];
          __weak __typeof(self) weakSelf = self;
        [_btnGroup setGroupChangeBlock:^(WSButtonGroup *group) {
            [weakSelf.currrentSelectDic setObject:@"0" forKey:@"selected"];
            weakSelf.currrentSelectDic=nil;
            [weakSelf.mtableView reloadData];
        }];
        MYRHTableView* _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, 0, 105, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableView2=_mtableView;
        [self addSubview:_mtableView];
        _mtableView.backgroundColor=rgb(235,235,235);
        NSArray*arraytitle=[self.data ojk:@"list"];;
        for (int i=0; i<arraytitle.count; i++) {
            NSDictionary*dic=arraytitle[i];
            WSSizeButton*btnSelect=[RHMethods buttonWithframe:CGRectMake(0, 0, 105, 44) backgroundColor:nil text:[dic ojsk:@"name"] font:14 textColor:rgb(51, 51, 51) radius:0 superview:nil];
            [btnSelect setTitleColor:rgb(13, 107, 154) forState:UIControlStateSelected];
            [btnSelect setBackGroundImageviewColor:RGBACOLOR(14,112,161,0.0)  forState:UIControlStateNormal];
            [btnSelect setBackGroundImageviewColor:RGBACOLOR(255, 255, 255, 1)forState:UIControlStateSelected];
//            [btnSelect setImageStr:nil SelectImageStr:@"complete1"];
            [btnSelect setBtnLableFrame:CGRectMake(15, 0, btnSelect.frameWidth-30, btnSelect.frameHeight)];
            [btnSelect setBtnImageViewFrame:CGRectMake(0, 0, 12, 8)];
            btnSelect.imgframeRX=15;
            [btnSelect imgbeCY];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, btnSelect.frameWidth, 1) backgroundcolor:RGBACOLOR(221, 221, 221, 0.7) superView:btnSelect];
            viewLine.frameBY=0;
            [_mtableView.defaultSection.noReUseViewArray addObject:btnSelect];
            [_btnGroup addButton:btnSelect];
            
        }
        
    }
    
    
}
#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [[self.data ojk:@"list"] count];
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numrow = [[[self.data ojk:@"list"][_btnGroup.currentindex] ojk:@"son"] count];
    return numrow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    NSInteger heightRow=44;
    
    return 44;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
//
//    return 0.001;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_mtableView) {
        UIView*viewCell=[UIView viewWithFrame:CGRectMake(0, 0, _mtableView.frameWidth, 30) backgroundcolor:rgb(246,246,246) superView:nil];
        UILabel*lbTitle=[RHMethods lableX:17 Y:0 W:_mtableView.frameWidth-30 Height:viewCell.frameHeight font:13 superview:viewCell withColor:rgb(102, 102, 102) text:[[self.data ojk:@"list"][_btnGroup.currentindex] ojk:@"name"]];
        return viewCell;
    }else{
        return [UIView new];
        
    }
    
}
#pragma mark  cell处理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==_mtableView){
        //        NSDictionary *dic=_mtableView.dataArray[indexPath.row];
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            //            UILabel*lbName=[RHMethods lableX:15 Y:15 W:kScreenWidth-105-30 Height:14 font:14 superview:cell withColor:rgb(51, 51, 51) text:@"高鐵站送車點店"];
            //            UILabel*lbDescrib=[RHMethods lableX:15 Y:lbName.frameYH+10 W:lbName.frameWidth Height:14 font:14 superview:cell withColor:rgb(153, 153, 153) text:@"上海市浦東新區濟州路286"];
            //
            WSSizeButton*btnSelect=[RHMethods buttonWithframe:CGRectMake(0, 0, tableView.frameWidth, 44) backgroundColor:nil text:@"ddd" font:14 textColor:rgb(51, 51, 51) radius:0 superview:cell];
            btnSelect.userInteractionEnabled=NO;
            [btnSelect setTitleColor:rgb(13, 107, 154) forState:UIControlStateSelected];
            //            [btnSelect setBackGroundImageviewColor:RGBACOLOR(255, 255, 255, 1)  forState:UIControlStateNormal];
            //            [btnSelect setBackGroundImageviewColor:RGBACOLOR(14,112,161,0.1)forState:UIControlStateSelected];
//            [btnSelect setImageStr:nil SelectImageStr:@"complete1"];
            [btnSelect setBtnLableFrame:CGRectMake(15, 0, btnSelect.frameWidth-30, btnSelect.frameHeight)];
            [btnSelect setBtnImageViewFrame:CGRectMake(0, 0, 12, 8)];
            btnSelect.imgframeRX=15;
            [btnSelect imgbeCY];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, btnSelect.frameWidth, 1) backgroundcolor:RGBACOLOR(221, 221, 221, 0.7) superView:btnSelect];
            viewLine.frameBY=0;
            [cell setAddUpdataBlock:^(id data, id weakme) {
                [btnSelect setTitle:[data ojsk:@"name"] forState:UIControlStateNormal];
                btnSelect.selected=[[data ojsk:@"selected"] isEqualToString:@"1"];
            }];
        }
        
        NSMutableDictionary*mdic=[[self.data ojk:@"list"][_btnGroup.currentindex] ojk:@"son"][indexPath.row];
        [cell upDataMeWithData:mdic];
        
        
        return cell;
        //
    }
    return nil;
}
#pragma mark  选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self selectAtIndexPath:indexPath];
//    [self selectAtIndexPath:indexPath];
    [self selectAtSection:-1 atRow:(int)indexPath.row];
}
-(void)selectAtSection:(int)section atRow:(int) row{
    [_currrentSelectDic setObject:@"0" forKey:@"selected"];
    if (section>=0) {
        [_btnGroup btnClickAtIndex:section];
    }
    
    _currrentSelectDic=self.data[@"list"][_btnGroup.currentindex][@"son"][row];
    
    [_currrentSelectDic setObject:@"1" forKey:@"selected"];
    [_mtableView reloadData];
    if (section==-1) {
        if (self.callBackBlock) {
            self.callBackBlock(nil, 200, nil);
        }
    }
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
