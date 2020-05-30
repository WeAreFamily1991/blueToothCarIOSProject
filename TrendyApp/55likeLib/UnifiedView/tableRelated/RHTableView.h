

#import <UIKit/UIKit.h>
#import <SVProgressHUD.h>
#import "NetEngine.h"

@protocol RHTableViewDelegate;


typedef id (^RHTableDataBlock)(NSInteger page);
typedef id (^RHTableDataOfflineBlock)(NSInteger page);

typedef void (^RHTableLoadedDataBlock)(NSArray *array,BOOL cache);



/**
 请求数据block block 里面要回调
 
 @param pageOrPageSizeData 包含页数和每页数量的字典
 @param dataCallBack 调用完成之后回调（tableview 刷新页面）
 */
typedef void (^RHTableLoadDataBlock)(NSMutableDictionary* pageOrPageSizeData,AllcallBlock dataCallBack);

@interface RHTableView : UITableView


@property(nonatomic, weak) id<RHTableViewDelegate> delegate2;


/**
 数据请求方式（优先处理）
 */
@property(nonatomic,copy)RHTableLoadDataBlock loadDataBlock;
/**
 数据请求回调
 */
@property(nonatomic,copy)AllcallBlock dataCallBack;



/**
 没有数据时候显示的view
 */
@property(nonatomic,strong)UIView*noDataView;


@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *strNullTitle;//没有数据时候提醒语句
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) SVProgressHUDMaskType progressHUDMask;
@property (nonatomic, assign) BOOL isNeedRefresh;
@property (nonatomic, assign) BOOL isNeedLoadMore;
@property (nonatomic, assign) BOOL isSoapDomain;
//// 是否显示提示（默认yes）
@property (nonatomic, assign) BOOL isShowHUDMask;

////没有数据的时候提示语句偏移位置表中心
@property (nonatomic, assign) float floatOffset;

/**
 中心提示（无数据时Y轴，大于0时使用，偏移失效）
 */
@property (nonatomic, assign) float floatContentY;
@property (nonatomic, assign) BOOL isHiddenNull;//是否隐藏没有数据的提示
@property (nonatomic, assign) NSInteger defaultPageSize;//


@property (nonatomic,copy) RHTableLoadedDataBlock bk_loaded;

- (void)refresh;
- (void)loadmore;
- (void)stopRefresh;
- (void)stopLoadmore;
- (void)cancelDownload;

- (void)showRefresh:(BOOL)showRefresh LoadMore:(BOOL)showLoadmore;
///强制设置是否显隐提示
-(void)showNullHint:(BOOL)abool;


- (void)loadUrl:(NSString*)url;
- (void)loadBlock:(RHTableDataBlock)data_bk;
- (void)loadBlock:(RHTableDataBlock)data_bk offline:(RHTableDataOfflineBlock)offline_bk withMask:(SVProgressHUDMaskType)mask;

- (void)loadWithRefresh:(BOOL)showRefresh withLoadmore:(BOOL)showLoadmore withMask:(SVProgressHUDMaskType)mask   Url:(NSString*)url withParam:(NSDictionary*)params data:(RHTableDataBlock)data_bk offline:(RHTableDataOfflineBlock)offline_bk loaded:(RHTableLoadedDataBlock)loaded_bk;

- (void)loadUrl:(NSString*)url withMask:(SVProgressHUDMaskType)mask;
- (void)loadBlock:(RHTableDataBlock)data_bk withMask:(SVProgressHUDMaskType)mask;

@end



@protocol RHTableViewDelegate <NSObject>

@optional  //可选
-(void)refreshData:(RHTableView *)view;
///刷新后
-(void)refreshDataFinished:(RHTableView *)view;
///获取数据后-将要刷新
-(void)refreshDataWillAppear:(RHTableView *)view;
-(void)refreshDataError:(RHTableView *)view;
///将要刷新
-(void)tableViewWillRefresh:(RHTableView *)view;

@end
