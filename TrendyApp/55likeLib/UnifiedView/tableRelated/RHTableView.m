

#import "RHTableView.h"
#import "Utility.h"
#import "Foundation.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"

@interface RHTableView(){
    UIView *bgView;
    
    UILabel *labelNull;
    UIImageView *imageNull;
    
    
    
}
@property (nonatomic, strong) UIControl *closeC;
@property (nonatomic, assign) BOOL boolNull;
@property (nonatomic, strong) NSMutableArray *allArrayData;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, weak) NSURLSessionDataTask *networkOperation;


@end

@implementation RHTableView
@synthesize delegate2;
@synthesize curPage,dataCount,urlString = _urlString,dataArray = _dataArray,networkOperation= _networkOperation,progressHUDMask,isNeedLoadMore = _isNeedLoadMore,isNeedRefresh = _isNeedRefresh;//refreshView = _refreshView,loadMoreView = _loadMoreView,delegateInterceptor = _delegateInterceptor,

- (id)initWithFrame:(CGRect)frame
{
    
    return [self initWithFrame:frame style:UITableViewStylePlain];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComponents];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initComponents];
    }
    
    return self;
}


- (void)setDataCount:(NSInteger)t_dataCount
{
    dataCount = t_dataCount;
    if (dataCount < self.defaultPageSize) {
        self.mj_footer.hidden=YES;
        //        _loadMoreView.delegate?[_loadMoreView setHidden:YES]:nil;
    }
    else{
        self.mj_footer.hidden=NO;
    }
    //        _loadMoreView.delegate?[_loadMoreView setHidden:NO]:nil;
}

- (void)dealloc
{
    [self cancelDownload];
    //    _loadMoreView=nil;
    //    _refreshView=nil;
    //[super dealloc];
}

- (void)initComponents
{
    self.dataCallBack=nil;
    self.defaultPageSize=default_PageSize;
    _isShowHUDMask=YES;
    _dataDic=[NSMutableDictionary new];
    _dataArray=[NSMutableArray new];
    progressHUDMask = SVProgressHUDMaskTypeNone;//SVProgressHUDMaskTypeClear
    
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    __weak RHTableView *weak_v=self;
    __weak __typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        if ([weakSelf.delegate2 respondsToSelector:@selector(tableViewWillRefresh:)]) {
            [weakSelf.delegate2 tableViewWillRefresh:weakSelf];
        }
        
        [weak_v refresh];
    }];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [weak_v loadmore];
    }];
    self.mj_header.hidden=YES;
    self.mj_footer.hidden=YES;
}
- (void)setIsNeedRefresh:(BOOL)isNeedRefresh
{
    _isNeedRefresh = isNeedRefresh;
    self.mj_header.hidden=!_isNeedRefresh;
}

- (void)setIsNeedLoadMore:(BOOL)isNeedLoadMore
{
    _isNeedLoadMore = isNeedLoadMore;
    self.mj_footer.hidden=!_isNeedLoadMore;
}
- (void)stopRefresh
{
    //    refreshing = NO;
    [self.mj_header endRefreshing];
    //    if (_refreshView) {
    //        [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    //    }
    
    //endRefresh];
}

- (void)stopLoadmore
{
    
    [self.mj_footer endRefreshing];
    //    if (_loadMoreView) {
    //        [_loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    //    }
    
}

- (void)cancelDownload
{
    //    self.delegate2=nil;
    if (self.networkOperation) {
        [self.networkOperation cancel];
    }
    self.networkOperation=nil;
    [self stopRefresh];
    [self stopLoadmore];
    
    [SVProgressHUD dismiss];
}
- (void)loadData:(NSInteger)page
{
    //      __weak __typeof(self) weakSelf = self;
    curPage = page;
    SVProgressHUDMaskType masktype = self.progressHUDMask;
    if(masktype && _isShowHUDMask){
        if (masktype != SVProgressHUDMaskTypeNone) {
            [SVProgressHUD showWithStatus:@"正在加载..." maskType:masktype];
        }
    }
    
    
    //离线、刷新、加载更多数据加载完成处理。
    void(^block)(NSArray* array, BOOL isCache) = ^(NSArray* array, BOOL isCache){
        
        [self.allArrayData removeAllObjects];
        self.allArrayData=[NSMutableArray arrayWithArray:self.dataArray];
        if (array.count || self.curPage==1) {
            if (masktype != SVProgressHUDMaskTypeNone  && self.isShowHUDMask) {
                [SVProgressHUD dismiss];
            }
            if (self.curPage <= default_StartPage) {
                self.allArrayData = [NSMutableArray arrayWithArray:array];
            }else{
                [self.allArrayData addObjectsFromArray:array];
            }
        }else{
            if (self.curPage > default_StartPage+1&&!isCache) {
                self.curPage --;
            }
            if (self.curPage <= default_StartPage) {
                [self.allArrayData removeAllObjects];
            }
            if(masktype && self.isShowHUDMask){
                if (masktype != SVProgressHUDMaskTypeNone) {
                    if(self.curPage>default_StartPage){
                        [SVProgressHUD showImage:nil status:kS(@"generalPage", @"noMoreData")];
                    }else{
                        [SVProgressHUD showImage:nil status:kS(@"generalPage", @"noDataToDisplay")];
                    }
                    
                }
            }
        }
        if (self.allArrayData.count==0) {
            if (self.boolNull) {
                self.backgroundView=[self tipsView:YES];
            }else{
                
                self.backgroundView=[self tipsView:NO];
                self.closeC.userInteractionEnabled=NO;
            }
            
        }else{
            self.backgroundView=nil;
            self.closeC.userInteractionEnabled=NO;
        }
        
        if (self.allArrayData.count >= self.defaultPageSize) {
            if (self.isNeedLoadMore) {
                self.mj_footer.hidden=NO;
                //                [self showLoadmoreFooter];
            }
        }else{
            self.mj_footer.hidden=YES;
            //            [self hiddenLoadmoreFooter];
        }
        if (self.delegate2 && [self.delegate2 respondsToSelector:@selector(refreshData:)]){
            [self.delegate2 refreshData:self];
        }
        
        //数据加载成功
        if (self.bk_loaded) {
            self.bk_loaded(self.allArrayData,isCache);
        }
        [self stopLoadmore];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:self.allArrayData];
            if (self.dataSource) {
                [self reloadData];
            }
            if ([self.delegate2 respondsToSelector:@selector(refreshDataFinished:)]) {
                [self.delegate2 refreshDataFinished:self];
            }
        });
        
        
        isCache?nil:[self stopRefresh];
    };
    
    if (self.dataCallBack==nil) {
        __weak __typeof(self) weakSelf = self;
        [self setDataCallBack:^(id data, int status, NSString *msg) {
            if (status==200){
                weakSelf.backgroundView=nil;
                weakSelf.boolNull=NO;
                //数据成功
                weakSelf.dataDic=data;
                if (weakSelf.delegate2 && [weakSelf.delegate2 respondsToSelector:@selector(refreshDataWillAppear:)]){
                    [weakSelf.delegate2 refreshDataWillAppear:weakSelf];
                }
                //                    if (delegate2 && [delegate2 respondsToSelector:@selector(refreshData:)]){
                //                        [delegate2 refreshData:self];
                //                    }
                block([weakSelf.dataDic objectForJSONKey:@"list"],NO);
            }else if(status==502){
                weakSelf.boolNull=YES;
                block([NSArray array],NO);
                if (masktype != SVProgressHUDMaskTypeNone && self.isShowHUDMask) {
                    [SVProgressHUD showErrorWithStatus:alertErrorTxt];
                }
                if ([weakSelf.delegate2 respondsToSelector:@selector(refreshDataError:)]) {
                    [weakSelf.delegate2 refreshDataError:weakSelf];
                }
                weakSelf.networkOperation=nil;
            }else{
                weakSelf.boolNull=YES;
                block([NSArray array],NO);
                if (masktype != SVProgressHUDMaskTypeNone && weakSelf.isShowHUDMask) {
                    //                    [SVProgressHUD showImage:nil status:[resData valueForJSONKey:@"info"] ];
                }
                if ([weakSelf.delegate2 respondsToSelector:@selector(refreshDataError:)]) {
                    [weakSelf.delegate2 refreshDataError:weakSelf];
                }
            }
        }];
    }
    if (self.loadDataBlock) {
        NSMutableDictionary*mdic=[NSMutableDictionary new];
        [mdic setObject:[NSString stringWithFormat:@"%ld",(long)self.curPage] forKey:@"current"];
        [mdic setObject:@"20" forKey:@"size"];
        self.loadDataBlock(mdic, self.dataCallBack);
    }else if(self.urlString.length){
        __weak __typeof(self) weakSelf = self;
        if (self.networkOperation) {
            [self.networkOperation cancel];
        }
        self.networkOperation=[NetEngine createGetAction_LJ_two:[NSString stringWithFormat:self.urlString,[NSNumber numberWithInteger:self.curPage]] onCompletion:^(id resData, BOOL isCache) {
            //                DLog(@"resData666:%@",resData);
            if (masktype != SVProgressHUDMaskTypeNone && weakSelf.isShowHUDMask) {
                [SVProgressHUD dismiss];
            }
            
            weakSelf.dataCallBack([resData objectForJSONKey:@"data"], [resData valueForJSONStrKey:@"status"].intValue, [resData valueForJSONKey:@"info"]);
            
            weakSelf.networkOperation=nil;
        } onError:^(NSError *error) {
            if (error.code==-999) {
                // NSURLErrorCancelled =          -999
                //取消请求的反馈不做处理
            }else{
                weakSelf.dataCallBack(nil,502, nil);
            }
        }];
        
    }else{
        block([NSArray array],YES);
    }
    
}
- (void)refresh
{
    //    refreshing = YES;
    [self stopLoadmore];
    [self loadData:default_StartPage];
}

- (void)loadmore
{
    self.curPage ++;
    [self stopRefresh];
    [self loadData:self.curPage];
}

#pragma mark - Extends

- (void)loadUrl:(NSString*)url
{
    [self loadWithRefresh:YES withLoadmore:YES withMask:self.progressHUDMask Url:url withParam:nil data:nil offline:nil loaded:nil];
}
- (void)loadUrl:(NSString*)url withMask:(SVProgressHUDMaskType)mask
{
    self.progressHUDMask = mask;
    [self loadWithRefresh:YES withLoadmore:YES withMask:mask Url:url withParam:nil data:nil offline:nil loaded:nil];
}
- (void)loadBlock:(RHTableDataBlock)data_bk
{
    [self loadWithRefresh:YES withLoadmore:YES withMask:self.progressHUDMask Url:nil withParam:nil data:data_bk offline:nil loaded:nil];
}
- (void)loadBlock:(RHTableDataBlock)data_bk offline:(RHTableDataOfflineBlock)offline_bk withMask:(SVProgressHUDMaskType)mask
{
    self.progressHUDMask = mask;
    [self loadWithRefresh:YES withLoadmore:YES withMask:self.progressHUDMask Url:nil withParam:nil data:data_bk offline:offline_bk loaded:nil];
}
- (void)loadBlock:(RHTableDataBlock)data_bk withMask:(SVProgressHUDMaskType)mask
{
    self.progressHUDMask = mask;
    [self loadWithRefresh:YES withLoadmore:YES withMask:self.progressHUDMask Url:nil withParam:nil data:data_bk offline:nil loaded:nil];
}
- (void)showRefresh:(BOOL)showRefresh LoadMore:(BOOL)showLoadmore
{
    self.isNeedRefresh = showRefresh;
    self.isNeedLoadMore = showLoadmore;
}
/**
 @method
 @abstract 表格数据加载模型
 @discussion 通过url 以及参数 params
 @param url 数据来源  params 参数列表
 */

- (void)loadWithRefresh:(BOOL)showRefresh withLoadmore:(BOOL)showLoadmore withMask:(SVProgressHUDMaskType)mask   Url:(NSString*)url withParam:(NSDictionary*)params data:(RHTableDataBlock)data_bk offline:(RHTableDataOfflineBlock)offline_bk loaded:(RHTableLoadedDataBlock)loaded_bk
{
    [self showRefresh:showRefresh LoadMore:showLoadmore];
    self.progressHUDMask = mask;
    self.urlString = url;
    [self refresh];
}


/**
 
 背景view
 */

- (UIView*)tipsView:(BOOL)refreshBool;
{
    if (!bgView) {
        bgView = [[UIView alloc] initWithFrame:self.bounds];
        self.closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [self.closeC addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeC];
        
        labelNull = [[UILabel alloc] initWithFrame:CGRectMake(10, (self.bounds.size.height-60)/2, W(self)-20,0)];
        labelNull.font = [UIFont systemFontOfSize:15];
        labelNull.textColor = [UIColor lightGrayColor];
        labelNull.backgroundColor = [UIColor clearColor];
        labelNull.textAlignment = NSTextAlignmentCenter;
        labelNull.numberOfLines = 3;
        
        [bgView addSubview:labelNull];
        
        imageNull = [RHMethods imageviewWithFrame:CGRectMake((W(self)-100)/2, Y(labelNull)-70, 100, 70) defaultimage:@"smile" contentMode:UIViewContentModeCenter];
        [bgView addSubview:imageNull];
    }
    
    if (refreshBool) {
        self.closeC.userInteractionEnabled=YES;
        imageNull.hidden=YES;
        labelNull.hidden=NO;
    }else{
        self.closeC.userInteractionEnabled=NO;
        if (self.noDataView) {
            [bgView addSubview:self.noDataView];
            [self.noDataView beCenter];
            self.noDataView.hidden=_isHiddenNull;
            imageNull.hidden=YES;
            labelNull.hidden=YES;
        }else{
            imageNull.hidden=_isHiddenNull;
            labelNull.hidden=_isHiddenNull;
        }
    }
    
//    NSString *strTitle=self.strNullTitle?self.strNullTitle:@"暂无数据";
    NSString *strTitle=self.strNullTitle?self.strNullTitle:kS(@"generalPage", @"noDataToDisplay");
//    labelNull.text = refreshBool?kS(@"generalPage", @"erroData"):strTitle;
    labelNull.text = refreshBool?kS(@"generalPage", @"NetworkErrorConnect"):strTitle;
    labelNull.frameHeight=[labelNull sizeThatFits:CGSizeMake(W(labelNull), MAXFLOAT)].height;
    
    imageNull.frameY=H(self)/2-30-H(imageNull)+_floatOffset;
    if (_floatContentY>0) {
        imageNull.frameY=_floatContentY;
    }
    labelNull.frameY=YH(imageNull);
    
    return bgView;
}

-(void)showNullHint:(BOOL)abool{
    _isHiddenNull=!abool;
    self.backgroundView=[self tipsView:NO];
}
+(void)showMyDemo{
    
    RHTableView * tableview = [[RHTableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    //接口传入;
    tableview.urlString = @"";
    //是否可以下拉刷新和上啦加载
    [tableview showRefresh:YES LoadMore:YES];
    //接口返回的数组数据
    //    tableview.dataArray;
    //接口返回的所有数据
    //    tableview.dataDic;
    //是否隐藏没有数据的提示
    tableview.isHiddenNull = NO;
    //没有数据时候提醒语句
    tableview.strNullTitle = @"没有更多数据";
    //没有数据的时候提示语句偏移位置表中心
    tableview.floatOffset = 20.0;
    //刷新数据时候的提示框样式
    tableview.progressHUDMask = SVProgressHUDMaskTypeNone;
    
    
    //RHtableview的协议方法
    //    tableview.delegate2 = self;
    /**正在刷新*/
    //    -(void)refreshData:(RHTableView *)view;
    /**刷新完成*/
    //    -(void)refreshDataFinished:(RHTableView *)view;
    //    -(void)refreshDataWillAppear:(RHTableView *)view;
    /**刷新失败*/
    //    -(void)refreshDataError:(RHTableView *)view;
    /**将要刷新*/
    //    -(void)tableViewWillRefresh:(RHTableView *)view;
    
    [UTILITY.currentViewController.view addSubview:tableview];
    
}

@end

