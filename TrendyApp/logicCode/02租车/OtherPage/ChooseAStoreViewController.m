//
//  ChooseAStoreViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ChooseAStoreViewController.h"
#import "MYRHTableView.h"
#import "WSButtonGroup.h"
#import "MoreBlankTableViewHeaderFooterView.h"
#import "SelectSearchShopAddressViewController.h"

@interface ChooseAStoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    float ftempH;
    
}
@property(nonatomic,strong)RHTableView*mtableView;
@property(nonatomic,strong)RHTableView*mtableView2;
@property(nonatomic,strong)WSButtonGroup*btnGroup;
@property(nonatomic,strong)NSMutableArray *arrayAll;
@property(nonatomic,assign)NSInteger indexSectionTop;
@property(nonatomic,assign)BOOL boolSelectLeftButton;
@end

@implementation  ChooseAStoreViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    
    [[self.navView viewWithTag:104] setHidden:YES];
    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(15, 3, kScreenWidth-30, 30) backgroundcolor:rgb(246, 246, 246) superView:viewTopSearch];
//        [viewSearchContent addViewTarget:self select:@selector(searchBtnClick)];
        [viewSearchContent addViewClickBlock:^(UIView *view) {
            NSMutableArray *arrayT=[NSMutableArray new];
            for (id dataT in weakSelf.arrayAll) {
                [arrayT addObjectsFromArray:[dataT ojk:@"shoplist"]];
            }
            [weakSelf pushController:[SelectSearchShopAddressViewController class] withInfo:nil withTitle:weakSelf.title withOther:arrayT withAllBlock:weakSelf.allcallBlock];
        }];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:kS(@"selectStores", @"searchHint") text:@""  supView:viewSearchContent];
        tfSearch.userInteractionEnabled=NO;
       
    }
    {
        _mtableView =[[RHTableView alloc]initWithFrame:CGRectMake(105, kTopHeight+H(viewTopSearch), kScreenWidth-105, kContentHeight-H(viewTopSearch)) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        _mtableView.delegate=self;
        _mtableView.dataSource=self;
        [self.view addSubview:_mtableView];
        [_mtableView registerClass:[MoreBlankTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"MoreBlankTableViewHeaderFooterView"];
        [_mtableView reloadData];
    }
    {
        _btnGroup=[WSButtonGroup new];
        MYRHTableView* mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, Y(_mtableView), 105, H(_mtableView)) style:UITableViewStylePlain];
        mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableView2=mtableView;
        [self.view addSubview:mtableView];
        mtableView.backgroundColor=rgb(235,235,235);
        NSArray*arraytitle=_arrayAll;
        for (int i=0; i<arraytitle.count; i++) {
             WSSizeButton*btnSelect=[RHMethods buttonWithframe:CGRectMake(0, 0, 105, 44) backgroundColor:nil text:[arraytitle[i] ojsk:@"title"] font:16 textColor:rgb(51, 51, 51) radius:0 superview:nil];
            [btnSelect setTitleColor:rgb(13, 107, 154) forState:UIControlStateSelected];
            [btnSelect setBackGroundImageviewColor:RGBACOLOR(0, 0, 0, 0) forState:UIControlStateNormal];
            [btnSelect setBackGroundImageviewColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateSelected];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, btnSelect.frameWidth, 1) backgroundcolor:RGBACOLOR(221, 221, 221, 0.7) superView:btnSelect];
            viewLine.frameBY=0;
            [mtableView.defaultSection.noReUseViewArray addObject:btnSelect];
            [_btnGroup addButton:btnSelect];

        }
        if (arraytitle>0) {
            [_btnGroup btnClickAtIndex:0];
        }
    }
    
    [_btnGroup setGroupChangeBlock:^(WSButtonGroup *group) {
        weakSelf.indexSectionTop=group.currentindex;
        NSDictionary *dicsection=weakSelf.arrayAll[weakSelf.indexSectionTop];
        [weakSelf.mtableView reloadData];
        if ([[dicsection objectForJSONKey:@"shoplist"] count]) {
            weakSelf.boolSelectLeftButton=YES;
            [weakSelf.mtableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:weakSelf.indexSectionTop] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
    }];
    
}
#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrayAll.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dicsection=self.arrayAll[section];
    NSInteger numrow = [[dicsection ojk:@"shoplist"] count];
    return numrow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSInteger heightRow=ftempH;
    return heightRow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_mtableView) {
        MoreBlankTableViewHeaderFooterView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MoreBlankTableViewHeaderFooterView"];
        sectionView.backgroundView.backgroundColor=rgbGray;
        NSDictionary *dicsection=self.arrayAll[section];
        UILabel*lbTitle=[RHMethods lableX:17 Y:0 W:_mtableView.frameWidth-30 Height:30 font:13 superview:sectionView withColor:rgb(102, 102, 102) text:@"" reuseId:@"lbTitle"];
        lbTitle.text=[NSString stringWithFormat:@"%@(%ld)",[dicsection ojsk:@"title"],[[dicsection ojk:@"shoplist"] count]];
        return sectionView;
    }else{
        return [UIView new];
    }
    
}
#pragma mark  cell处理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==_mtableView){
        NSDictionary *dicsection=self.arrayAll[indexPath.section];
        NSDictionary *dicrow=[dicsection ojk:@"shoplist"][indexPath.row];
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            UILabel*lbName=[RHMethods lableX:15 Y:15 W:kScreenWidth-105-30 Height:14 font:16 superview:cell withColor:rgb(51, 51, 51) text:@"高鐵站送車點店" reuseId:@"lbName"];
            [RHMethods lableX:15 Y:lbName.frameYH+10 W:lbName.frameWidth Height:14 font:14 superview:cell withColor:rgb(153, 153, 153) text:@"上海市浦東新區濟州路286" reuseId:@"lbDescrib"];
        }
        UILabel *lbName=[cell getAddValueForKey:@"lbName"];
        UILabel *lbDescrib=[cell getAddValueForKey:@"lbDescrib"];
        lbName.numberOfLines=0;
        lbDescrib.numberOfLines=0;
        lbName.text=[dicrow ojsk:@"title"];
        lbDescrib.text=[dicrow ojsk:@"address"];
        [lbName changeLabelHeight];
        lbDescrib.frameY=YH(lbName)+10;
        [lbDescrib changeLabelHeight];
        ftempH=YH(lbDescrib)+15;
        return cell;
    }
    return nil;
}
#pragma mark  选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dicsection=self.arrayAll[indexPath.section];
    NSMutableDictionary *dicrow=[dicsection ojk:@"shoplist"][indexPath.row];
    [dicrow setObject:[dicsection ojsk:@"id"] forKey:@"address_id"];
    self.allcallBlock?self.allcallBlock(dicrow, 200, nil):nil;
    [super backButtonClicked:nil];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _boolSelectLeftButton=NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _mtableView && !_boolSelectLeftButton) {
        NSArray <UITableViewCell *> *cellArray = [_mtableView  visibleCells];
        //cell的section的最小值
        long cellSectionMINCount = LONG_MAX;
        for (int i = 0; i < cellArray.count; i++) {
            UITableViewCell *cell = cellArray[i];
            long cellSection = [_mtableView indexPathForCell:cell].section;
            if (cellSection < cellSectionMINCount) {
                cellSectionMINCount = cellSection;
            }
        }
        if (_indexSectionTop!=cellSectionMINCount) {
            _indexSectionTop = cellSectionMINCount;
            DLog(@"当前悬停的组头是:%ld",_indexSectionTop);
            [_btnGroup btnClickAtIndex:(int)_indexSectionTop];
        }
    }
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"city"];
    [NetEngine createPostAction:@"welcome/getshoplist" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.arrayAll=[dicData ojk:@"list"];
            [self addView];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClicked:nil];
            });
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showImage:nil status:alertErrorTxt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClicked:nil];
        });
    }];
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
