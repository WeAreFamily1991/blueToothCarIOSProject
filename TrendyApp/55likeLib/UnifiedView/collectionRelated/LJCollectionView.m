
#import "LJCollectionView.h"
#import "Utility.h"
#import "Foundation.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
@interface LJCollectionView(){

    UILabel *labelNull;
    UIImageView *imageNull;
    
}
@property (nonatomic, strong)UIControl *closeC;
@property (nonatomic, assign)BOOL boolNull;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) NSDictionary *postParams;

@property (nonatomic, strong) NSURLSessionDataTask *networkOperation;
//@property (nonatomic, assign) SVProgressHUDMaskType progressHUDMask;

@property (nonatomic,copy)LJCollectionDataBlock  bk_data;
@property (nonatomic,copy) LJCollectionDataOfflineBlock bk_offline;

@end
@implementation LJCollectionView



@synthesize delegateCollectionView;
@synthesize curPage,dataCount,urlString = _urlString,dataArray = _dataArray,networkOperation= _networkOperation,progressHUDMask,isNeedLoadMore = _isNeedLoadMore,isNeedRefresh = _isNeedRefresh;

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
    }
    else
        self.mj_footer.hidden=NO;
}

- (void)dealloc
{
    self.bk_data = nil;
    [self cancelDownload];
    //[super dealloc];
}

- (void)initComponents
{
    self.alwaysBounceVertical = YES;
    progressHUDMask = SVProgressHUDMaskTypeNone;//SVProgressHUDMaskTypeClear;
    self.defaultPageSize=default_PageSize;
    __weak LJCollectionView *weak_v=self;
    //    MJRefreshNormalHeader *headerR=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [weak_v refresh];
    //    }];
    //    headerR.lastUpdatedTimeLabel.font=fontTxtContent;
    //    headerR.lastUpdatedTimeLabel.textColor=[UIColor lightGrayColor];
    //    self.mj_header = headerR;
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([weak_v.delegateCollectionView respondsToSelector:@selector(collectionViewWillRefresh:)]) {
            [weak_v.delegateCollectionView collectionViewWillRefresh:weak_v];
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
    [self.mj_header endRefreshing];
}

- (void)stopLoadmore
{
    [self.mj_footer endRefreshing];
}

- (void)cancelDownload
{
    self.bk_data = nil;
    if (self.networkOperation) {
        [self.networkOperation cancel];
    }
    [SVProgressHUD dismiss];
}
- (void)loadData:(NSInteger)page
{
    self.curPage = page;
    SVProgressHUDMaskType masktype = self.progressHUDMask;
    if(masktype){
        if (masktype != SVProgressHUDMaskTypeNil) {
            [SVProgressHUD showWithStatus:@"正在加载..." maskType:masktype];
        }
    }
    
    
    //离线、刷新、加载更多数据加载完成处理。
    void(^block)(NSArray* array, BOOL isCache) = ^(NSArray* array, BOOL isCache){
        DLog(@"\n__________\n%@:\n%@\n__________\n",isCache?@"Cache":@"Sever",array)
        if (array.count || self.curPage==1) {
            if (masktype != SVProgressHUDMaskTypeNil) {
                [SVProgressHUD dismiss];
            }
            if (self.curPage <= default_StartPage) {
                self.dataArray = [NSMutableArray arrayWithArray:array];
            }else{
                [self.dataArray addObjectsFromArray:array];
            }
        }else{
            if (self.curPage > default_StartPage+1&&!isCache) {
                self.curPage --;
            }
            if (self.curPage <= default_StartPage) {
                [self.dataArray removeAllObjects];
            }
            if(masktype){
                if (masktype != SVProgressHUDMaskTypeNil) {
                    if(self.curPage>default_StartPage){
                        [SVProgressHUD showImage:nil status:@"亲！没有更多数据了"];
                    }else{
                        [SVProgressHUD showImage:nil status:@"暂无数据"];
                    }
                    
                }
            }
        }
        
        self.bgView.hidden=YES;
        if (self.dataArray.count==0) {
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
        
        if (self.dataArray.count >= self.defaultPageSize) {
            if (self.isNeedLoadMore) {
                self.mj_footer.hidden=NO;
            }
        }else{
            self.mj_footer.hidden=YES;
        }
        //数据加载成功
        if (self.bk_loaded) {
            self.bk_loaded(self.dataArray,isCache);
        }
        [self reloadData];
        if ([self.delegateCollectionView respondsToSelector:@selector(refreshDataFinished:)]) {
            [self.delegateCollectionView refreshDataFinished:self];
        }
        [self stopLoadmore];
        isCache?nil:[self stopRefresh];
    };
//    if ([[Utility Share] offline]&&self.bk_offline) {
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // 耗时的操作
//            NSArray *array =self.bk_offline(self.curPage);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                block(array,NO);
//            });
//        });
//
//        return;
//    }
//
//    //数据加载器：离线、同步（例如：hessian）、异步（NKNetwork）、test
//    if (self.bk_data) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // 耗时的操作
//            NSArray *array = [[Utility Share] offline]?(self.bk_offline?self.bk_offline(self.curPage):nil):self.bk_data(self.curPage);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                block(array,NO);
//            });
//        });
//    }else
    if(self.urlString.length){
        /*  self.networkOperation = [NetEngine createSoapAction:[NSString stringWithFormat:self.urlString,[NSNumber numberWithInteger:self.curPage]] onCompletion:^(id resData, BOOL isCache) {
         DLog(@"resData666:%@",resData);
         if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
         //数据成功
         self.dataDic=[NSMutableDictionary dictionaryWithDictionary:[resData objectForJSONKey:@"data"]];
         if (delegateCollectionView && [delegateCollectionView respondsToSelector:@selector(refreshData:)]){
         [delegateCollectionView refreshData:self];
         }
         block([[resData objectForJSONKey:@"data"] objectForJSONKey:@"list"],isCache);
         }else{
         block([NSArray array],isCache);
         [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"msg"] ];
         }
         } onError:^(NSError *error) {
         
         } useCache:YES useMask:progressHUDMask];
         
         
         self.networkOperation = [NetEngine createHttpAction:[NSString stringWithFormat:self.urlString,[NSNumber numberWithInteger:self.curPage]]
         withCache:YES
         withParams:self.postParams
         withMask:self.progressHUDMask
         onCompletion:^(id resData, BOOL isCache){
         DLog(@"Operation____resData:%@",resData );
         if (resData && [resData count] > 0) {
         block(resData ,isCache);
         }else{
         // block([NSArray array],isCache);
         }
         }
         onError:^(NSError *error) {
         if (self.curPage > default_StartPage+1) {
         self.curPage --;
         }
         [self stopRefresh];
         [self stopLoadmore];
         }];
         */
       
            self.networkOperation=[NetEngine createGetAction_LJ_two:[NSString stringWithFormat:self.urlString,[NSNumber numberWithInteger:self.curPage]] onCompletion:^(id resData, BOOL isCache) {
//                DLog(@"resData666:%@",resData);
                self.backgroundView=nil;
                
                if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
                    
                    self.boolNull=NO;
                    //数据成功
                    self.dataDic=[NSMutableDictionary dictionaryWithDictionary:[resData objectForJSONKey:@"data"]];
                    if (self.delegateCollectionView && [self.delegateCollectionView respondsToSelector:@selector(refreshData:)]){
                        [self.delegateCollectionView refreshData:self];
                    }
                    block([[resData objectForJSONKey:@"data"] objectForJSONKey:@"list"],isCache);
                }else{
                    self.boolNull=YES;
                    block([NSArray array],isCache);
                    if (masktype != SVProgressHUDMaskTypeNil) {
                        
                        [SVProgressHUD showImage:nil status:[[resData valueForJSONKey:@"msg"] notEmptyOrNull]?[resData valueForJSONKey:@"msg"]:alertErrorTxt];
                        // [SVProgressHUD showErrorWithStatus:[[resData valueForJSONKey:@"msg"] notEmptyOrNull]?[resData valueForJSONKey:@"msg"]:alertErrorTxt];
                    }
                }
            } onError:^(NSError *error) {
                self.boolNull=YES;
                block([NSArray array],NO);
                
                if (masktype != SVProgressHUDMaskTypeNil) {
                    [SVProgressHUD showErrorWithStatus:alertErrorTxt];
                }
            }];
        
        
        
        
        
    }
    else{
        //JUST for test
        block([NSArray array],YES);
    }
    
}
- (void)refresh
{
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
- (void)loadBlock:(LJCollectionDataBlock)data_bk
{
    [self loadWithRefresh:YES withLoadmore:YES withMask:self.progressHUDMask Url:nil withParam:nil data:data_bk offline:nil loaded:nil];
}
- (void)loadBlock:(LJCollectionDataBlock)data_bk offline:(LJCollectionDataOfflineBlock)offline_bk withMask:(SVProgressHUDMaskType)mask
{
    self.progressHUDMask = mask;
    [self loadWithRefresh:YES withLoadmore:YES withMask:self.progressHUDMask Url:nil withParam:nil data:data_bk offline:offline_bk loaded:nil];
}
- (void)loadBlock:(LJCollectionDataBlock)data_bk withMask:(SVProgressHUDMaskType)mask
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

- (void)loadWithRefresh:(BOOL)showRefresh withLoadmore:(BOOL)showLoadmore withMask:(SVProgressHUDMaskType)mask Url:(NSString *)url withParam:(NSDictionary *)params data:(LJCollectionDataBlock)data_bk offline:(LJCollectionDataOfflineBlock)offline_bk loaded:(LJCollectionLoadedDataBlock)loaded_bk
{
    [self showRefresh:showRefresh LoadMore:showLoadmore];
    self.progressHUDMask = mask;
    self.urlString = url;
    self.postParams = params;
    self.bk_data = data_bk;
    self.bk_offline = offline_bk;
    self.bk_loaded = loaded_bk;
    [self refresh];
}


/**
 
 背景view
 */

- (UIView*)tipsView:(BOOL)refreshBool;
{
    if (!self.bgView) {
        self.bgView = [[UIView alloc] initWithFrame:self.bounds];
        self.closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [self.closeC addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeC];
        
        
        labelNull = [[UILabel alloc] initWithFrame:CGRectMake(10, (self.bounds.size.height-20)/2, W(self)-20,20)];
        labelNull.font = [UIFont systemFontOfSize:15];
        labelNull.textColor = [UIColor lightGrayColor];
        labelNull.backgroundColor = [UIColor clearColor];
        labelNull.textAlignment = NSTextAlignmentCenter;
        labelNull.numberOfLines = 0;
        [self.bgView addSubview:labelNull];
        
        imageNull = [RHMethods imageviewWithFrame:CGRectMake((W(self)-100)/2, Y(labelNull)-70, 100, 70) defaultimage:@"smile" contentMode:UIViewContentModeCenter];
        [self.bgView addSubview:imageNull];
        
      

    }
    if (refreshBool) {
        self.closeC.userInteractionEnabled=YES;
        imageNull.hidden=YES;
        labelNull.hidden=NO;
    }else{
        self.closeC.userInteractionEnabled=NO;
        imageNull.hidden=_isHiddenNull;
        labelNull.hidden=_isHiddenNull;
    }
    
    self.bgView.hidden=NO;
    
    NSString *strTitle=self.strNullTitle?self.strNullTitle:@"暂无数据";
    labelNull.text = refreshBool?@"数据获取失败，请点击屏幕重新获取数据\n(请检查网络环境是否正常)":strTitle;
    labelNull.frameHeight=[labelNull sizeThatFits:CGSizeMake(W(labelNull), MAXFLOAT)].height;
    
    imageNull.frameY=H(self)/2-30-H(imageNull)+_floatOffset;
    labelNull.frameY=YH(imageNull);
    
    
    
    
    return self.bgView;
}


-(void)showNullHint:(BOOL)abool{
    _isHiddenNull=!abool;
    self.backgroundView=[self tipsView:NO];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
