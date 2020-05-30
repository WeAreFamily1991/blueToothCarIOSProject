

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetEngine.h"
//#import "SectionObj.h"
@class SectionObj;
typedef void (^BtnCallBlock)(UIView* view);
@interface UIView(Addition)

+(instancetype)getViewWithConfigData:(NSMutableDictionary*)cofigData;


@property (nonatomic, assign) CGFloat frameX;
@property (nonatomic, assign) CGFloat frameY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) CGSize frameSize;
@property (nonatomic, assign) CGPoint frameOrigin;

/**
 view 最右边的x坐标
 */
@property(nonatomic,assign)CGFloat frameXW;

/**
 view 最下边的Y坐标
 */
@property(nonatomic,assign)CGFloat frameYH;
/**
 view 最右边距离父控件右边框的距离
 */
@property(nonatomic,assign)CGFloat frameRX;
/**
 view 最下边距离父控件底部的距离
 */
@property(nonatomic,assign)CGFloat frameBY;
/**
 控件左右上下居中
 */
-(void)beCenter;
/**
 控件横向居中
 */
-(void)beCX;

/**
 控件竖向居中
 */
-(void)beCY;

/**
 控件变圆
 */
-(void)beRound;

#pragma mark  - 运行时添加属性
/**
 获取控件所在的控制器
 
 @return 控件当前页面的控制器
 */
- (UIViewController*)supViewController;







/**
 点击事件回调block
 */
@property(nonatomic,copy)BtnCallBlock btnCallBlock;


/**
 添加点击会回掉时间，所有的view 注意循环引用
 
 @param block 点击之后回调
 */
-(void)addViewClickBlock:(BtnCallBlock)block;


/**
 添加点击事件
 
 @param obj target 对象
 @param selctor 需要执行的方法
 */
-(void)addViewTarget:(id)obj select:(SEL)selctor;


/**
 移除点击事件
 */
-(void)removeViewEvent;
/**
 直接执行点击事件
 */
-(void)viewClickMe;



//for UIImageView & UIButton.backgroudImage
-(void)imageWithURL:(NSString *)url;
-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity;
-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity defaultImage:(NSString *)strImage;
-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity defaultImage:(NSString *)strImage showGifImage:(BOOL)showGif;
-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity defaultImageData:(UIImage *)aImage;

////慎用   （从本地缓存中获取图片，不会从网络获取）
-(void)imageWithCacheUrl:(NSString *)url;

//-(void)imageWithRefreshURL:(NSString *)url;



#pragma mark  - 动画
/// 动画(缩放) 用于点赞等-----选中
-(void)showAnimationSelected;
///动画(缩放) 用于点赞等-----取消
-(void)showAnimationCancelSelected;


#pragma mark  - 圆角或椭圆
///圆角
-(void)viewLayerRoundBorderWidth:(float)width borderColor:(UIColor *)color;
///圆角或椭圆
-(void)viewLayerRoundBorderWidth:(float)width cornerRadius:(float)radius borderColor:(UIColor *)color;


///view 上添加线条
-(void)addLineLayerWhitframe:(CGRect)_frame whitColor:(UIColor *)_color;


/**
 当前控件所在的SectionObj
 */
@property(nonatomic,weak)SectionObj*sectionObj;


/**
 当前控件所在的SectionObj 的地址 多少行 index row 如果没有的话会返回 -1；
 */
@property(nonatomic,assign)int index_row;

/**
 当前控件所在的indexPath；
 */
@property(nonatomic,assign)NSIndexPath * indexPath;


#pragma mark  添加创建方法
+(instancetype)viewWithFrame:(CGRect) frame backgroundcolor:(UIColor *)color superView:(UIView *)view;
+(instancetype)viewWithFrame:(CGRect) frame backgroundcolor:(UIColor *)color superView:(UIView *)view  reuseId:(NSString*)reuseID;
@end
