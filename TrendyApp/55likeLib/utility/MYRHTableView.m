//
//  MYRHTableView.m
//  jinYingWu
//
//  Created by 55like on 2017/11/8.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "MYRHTableView.h"

#import "MessageInterceptor.h"


@interface MYRHTabledelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MessageInterceptor *delegateInterceptor;
@end
@implementation MYRHTabledelegate

#pragma mark - UITextView Delegate Methods

#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(MYRHTableView *)tableView{
    
    
    return tableView.sectionArray.count;
    
}

-(NSInteger)tableView:(MYRHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    SectionObj*obj=tableView.sectionArray[section];
    if (obj.noReUseViewArray.count) {
        return obj.noReUseViewArray.count;
    }
    
    return obj.dataArray.count;
}

-(CGFloat)tableView:(MYRHTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    SectionObj*obj=tableView.sectionArray[section];
    if (obj.selctionHeaderView) {
        return obj.selctionHeaderView.frameHeight;
    }
    
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(MYRHTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionObj*obj=tableView.sectionArray[indexPath.section];
    if (obj.cellHeight) {
        return obj.cellHeight;
    }
    if (obj.noReUseViewArray.count) {
        
        UIView*view=obj.noReUseViewArray[indexPath.row];
        return view.frameYH;
    }
    if (obj.sectionreUseViewBlock) {
        
        [MYRHTableView SetIsRefreshOnlySize:YES];
        UIView*view= obj.sectionreUseViewBlock(tableView, obj.dataArray[indexPath.row],indexPath.row);
        [MYRHTableView SetIsRefreshOnlySize:NO];
        if (view.superview==tableView) {
            view.hidden=YES;
        }
        
        return view.frameYH;
    }
    if (obj.sectionreUseViewBlock_indexP) {
        [MYRHTableView SetIsRefreshOnlySize:YES];
        UIView*view= obj.sectionreUseViewBlock_indexP(tableView, obj.dataArray[indexPath.row],indexPath);
        [MYRHTableView SetIsRefreshOnlySize:NO];
        if (view.superview==tableView) {
            view.hidden=YES;
        }
        return view.frameYH;
    }
    return 100;
}
-(CGFloat)tableView:(MYRHTableView *)tableView heightForFooterInSection:(NSInteger)section    {
    SectionObj*obj=tableView.sectionArray[section];
    if (obj.selctionFooterView) {
        return obj.selctionFooterView.frameHeight;
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(MYRHTableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionObj*obj=tableView.sectionArray[section];
    if (obj.selctionHeaderView) {
        return obj.selctionHeaderView;
    }
    return nil;
    
    
}
-(UIView *)tableView:(MYRHTableView *)tableView viewForFooterInSection:(NSInteger)section{
    SectionObj*obj=tableView.sectionArray[section];
    if (obj.selctionFooterView) {
        return obj.selctionFooterView;
    }
    return nil;
    
    
}

#pragma mark  cell处理
- (UITableViewCell *)tableView:(MYRHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.frameWidth=tableView.frameWidth;
        cell.backgroundColor=[UIColor clearColor];
    }
//    [UTILITY addTAbleview:cell];
    for (UIView*viewx  in cell.subviews) {
        if (viewx.tag==10993) {
            viewx.hidden=YES;
            //            [viewx removeFromSuperview];
        }
    }
    
    SectionObj*obj=tableView.sectionArray[indexPath.section];
    obj.mytableview=tableView;
    cell.sectionObj=obj;
    cell.index_row=(int)indexPath.row;
    cell.indexPath=indexPath;
    if (obj.noReUseViewArray.count) {
        UIView*view=obj.noReUseViewArray[indexPath.row];
        [cell addSubview:view];
        view.tag=10993;
        view.hidden=NO;
        return cell;
    }
    
    if (obj.sectionreUseViewBlock) {
        UIView*reuseView=  obj.sectionreUseViewBlock(cell, obj.dataArray[indexPath.row],indexPath.row);
        reuseView.tag=10993;
        if (cell!=reuseView.superview) {
            [cell addSubview:reuseView];
        }
        reuseView.hidden=NO;
    }
    
    if (obj.sectionreUseViewBlock_indexP) {
        UIView*reuseView=  obj.sectionreUseViewBlock_indexP(cell, obj.dataArray[indexPath.row],indexPath);
        reuseView.tag=10993;
        if (cell!=reuseView.superview) {
            [cell addSubview:reuseView];
        }
        reuseView.hidden=NO;
    }
    return cell;
    
}
#pragma mark  选中cell
-(void)tableView:(MYRHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    SectionObj*obj=tableView.sectionArray[indexPath.section];
    if (obj.sectionIndexClickBlock) {
        
        NSDictionary *dic=obj.dataArray[indexPath.row];
        obj.sectionIndexClickBlock( dic,indexPath.row);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_delegateInterceptor !=nil && [_delegateInterceptor.receiver respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegateInterceptor.receiver scrollViewDidScroll:scrollView];
    }
    
}


@end


@implementation SectionObj
- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellHeight=0;
    }
    return self;
}
-(NSMutableArray *)noReUseViewArray{
    if (_noReUseViewArray==nil) {
        _noReUseViewArray=[NSMutableArray new];
    }
    return _noReUseViewArray;
    
}


#pragma mark  自定义的创建方法 类方法

+(SectionObj*)SectionWithTableView:(MYRHTableView*)tableView DataArray:(NSArray*)dataArray WithReUseViewBlock_index:(SectionReUseViewBlock_indexP)block{
    SectionObj*sectionObj=[SectionObj new];
    sectionObj.dataArray=dataArray;
    sectionObj.sectionreUseViewBlock_indexP = block;
    [tableView.sectionArray addObject:sectionObj];
    return sectionObj;
}
+(SectionObj*)SectionWithTableView:(MYRHTableView*)tableView DataArray:(NSArray*)dataArray WithReUseViewBlock:(SectionReUseViewBlock)block{
    SectionObj*sectionObj=[SectionObj new];
    sectionObj.dataArray=dataArray;
    sectionObj.sectionreUseViewBlock = block;
    [tableView.sectionArray addObject:sectionObj];
    return sectionObj;
}
+(SectionObj*)SectionWithTableView:(MYRHTableView*)tableView DataArray:(NSArray*)dataArray WithReUseViewBlock:(SectionReUseViewBlock)block WithsectionIndexClickBlock:(SectionIndexClickBlock)sectionblock{
    SectionObj*sectionObj=[SectionObj new];
    sectionObj.dataArray=dataArray;
    sectionObj.sectionreUseViewBlock = block;
    sectionObj.sectionIndexClickBlock = sectionblock;
    [tableView.sectionArray addObject:sectionObj];
    return sectionObj;
}

@end


@interface MYRHTableView()

@property(nonatomic,strong)MYRHTabledelegate *wsDelegate;
@property(nonatomic,strong)MYRHTabledelegate *wsDataSource;
@end
@implementation MYRHTableView
//是否只是刷新大小 由于图片刷新耗时太多如果计算cell高度绑定数据耗时太多不适合设置图片
static BOOL _isRefreshOnlySize=NO;

+(BOOL)isRefreshOnlySize{
    return _isRefreshOnlySize;
}
+(void)SetIsRefreshOnlySize:(BOOL)isRefreshOnlySize{
    _isRefreshOnlySize=isRefreshOnlySize;
}

-(SectionObj *)defaultSection{
    if (_defaultSection==nil) {
        if (self.sectionArray.count) {
            _defaultSection=self.sectionArray.firstObject;
        }else{
            SectionObj *obj=[SectionObj  new];
            _defaultSection=obj;
            [self.sectionArray addObject:obj];
        }
        _defaultSection.dataArray=self.dataArray;
    }
    return _defaultSection;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self= [super initWithFrame:frame style:style];
    if (self) {
        //        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellUITableViewCellUITableViewCell"];
        self.delegate=nil;
        self.dataSource=nil;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.delegate = self.wsDelegate;
        self.dataSource = self.wsDataSource;
        self.backgroundColor=[UIColor clearColor];
        //        self.separatorStyle = style;
    }
    return self;
}
-(NSMutableArray *)sectionArray{
    if (_sectionArray==nil) {
        _sectionArray=[NSMutableArray new];
    }
    return _sectionArray;
    
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (_wsDelegate==nil) {
        _wsDelegate=[MYRHTabledelegate new];
        _wsDelegate.delegateInterceptor = [[MessageInterceptor alloc] init];
        _wsDelegate.delegateInterceptor.middleMan = _wsDelegate;
        _wsDelegate.delegateInterceptor.receiver = delegate;
        
        
        super.delegate = (id)_wsDelegate.delegateInterceptor;
        
    }
    
    _wsDelegate.delegateInterceptor.receiver=delegate;
    if (_wsDelegate.delegateInterceptor.receiver==_wsDelegate) {
        _wsDelegate.delegateInterceptor.receiver=nil;
    }
}
-(void)setDataSource:(id<UITableViewDataSource>)dataSource{
    
    if (_wsDataSource==nil) {
        _wsDataSource=[MYRHTabledelegate new];
        _wsDataSource.delegateInterceptor = [[MessageInterceptor alloc] init];
        _wsDataSource.delegateInterceptor.middleMan = _wsDataSource;
        _wsDataSource.delegateInterceptor.receiver = dataSource;
        
        super.dataSource = (id)_wsDataSource.delegateInterceptor;
    }
    _wsDataSource.delegateInterceptor.receiver=dataSource;
    if (_wsDataSource.delegateInterceptor.receiver==_wsDataSource) {
        _wsDataSource.delegateInterceptor.receiver=nil;
    }
}

+(NSMutableArray*)fArrayWithCont:(NSInteger)number{
    NSMutableArray*marray=[NSMutableArray new];
    for (int i=0; i<number; i++) {
        NSMutableDictionary*mdic=[NSMutableDictionary new];
        [marray addObject:mdic];
    }
    
    //    [MYRHTableView fArrayWithCont:number];
    return marray;
}

@end

