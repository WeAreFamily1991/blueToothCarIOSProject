

#import <UIKit/UIKit.h>

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define kkBackViewHeight [UIScreen mainScreen].bounds.size.height
#define kkBackViewWidth [UIScreen mainScreen].bounds.size.width

#define iOS7  ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

// 背景视图起始frame.x
#define kstartX -200;


/**
 可以用手势滑动的Nav 软件内的NavControler 继承
 */
@interface KKNavigationController : UINavigationController
{
    CGFloat startBackViewX;
}

@property(nonatomic,strong) UIPanGestureRecognizer *navRecognizer;
@property (nonatomic,strong) NSMutableArray *screenShotsList;

//@property (nonatomic,strong) UIPanGestureRecognizer *recognizer;
// 默认为特效开启
@property (nonatomic, assign) BOOL canDragBack;



/**
 添加手势
 */
-(void)addGesture;

/**
 移除手势
 */
-(void)removeGesture;

@end


