


#import "KKNavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>

@interface KKNavigationController ()<UIGestureRecognizerDelegate>
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
    UIPanGestureRecognizer *recognizer;
    
}

@property (nonatomic,retain) UIView *backgroundView;

@property (nonatomic,assign) BOOL isMoving;

@end

@implementation KKNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

-(BOOL)shouldAutorotate{
    
    return [[self topViewController] shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self topViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self topViewController] preferredInterfaceOrientationForPresentation];
}

- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    //
    //    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
    //    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    //    [self.view addSubview:shadowImageView];
    
    //
    //    if (!kVersion7) {
    //
    
    self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
    self.canDragBack = YES;
    
    
    recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    recognizer.delegate=self;
    [recognizer delaysTouchesBegan];
    self.navRecognizer=recognizer;
    [self.view addGestureRecognizer:recognizer];
    
    //    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    //    if (!kVersion7) {
    [self.screenShotsList addObject:[self capture]];
    //    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    [SVProgressHUD dismiss];
    //    if (!kVersion7) {
    [self.screenShotsList removeLastObject];
    if ([self.topViewController respondsToSelector:@selector(destroyAppWebViewController)]) {
        [self.topViewController performSelector:@selector(destroyAppWebViewController)];
    }
    
    //    }
    
    return [super popViewControllerAnimated:animated];
}

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popToRootViewController_video" object:nil];
    [SVProgressHUD dismiss];
    //    if (!kVersion7) {
    [self.screenShotsList removeAllObjects];
    //    }
    for (NSInteger i=self.viewControllers.count-1; i>0; i--) {
        UIViewController*vc=self.viewControllers[i];
        if ([vc respondsToSelector:@selector(destroyAppWebViewController)]) {
            [vc performSelector:@selector(destroyAppWebViewController)];
        }
    }
    return [super popToRootViewControllerAnimated:animated];
}
-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [SVProgressHUD dismiss];
    //    if (!kVersion7) {
    
    NSInteger count=[self.viewControllers count];
    for (NSInteger i=count-1; i>=0; i--) {
        UIViewController *tempC=[self.viewControllers objectAtIndex:i];
        
        if (viewController==tempC) {
            break;
        }
        [self.screenShotsList removeLastObject];
        if ([tempC respondsToSelector:@selector(destroyAppWebViewController)]) {
            [tempC performSelector:@selector(destroyAppWebViewController)];
        }
        
    }
    return [super popToViewController:viewController animated:animated];
}
#pragma mark - Utility Methods -

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, self.view.opaque, 0.0);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)moveViewWithX:(float)x
{
    x = x>kScreenWidth?kScreenWidth:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float alpha = 0.4 - (x/800);
    
    blackMask.alpha = alpha;
    
    CGFloat aa = fabs(startBackViewX)/kkBackViewWidth;
    CGFloat y = x*aa;
    
    CGFloat lastScreenShotViewHeight =kkBackViewHeight;//kVersion7? kkBackViewHeight:kkBackViewHeight-20;//
    
    //TODO: FIX self.edgesForExtendedLayout = UIRectEdgeNone  SHOW BUG
    /**
     *  if u use self.edgesForExtendedLayout = UIRectEdgeNone; pls add
     
     if (!iOS7) {
     lastScreenShotViewHeight = lastScreenShotViewHeight - 20;
     }
     *
     */
    [lastScreenShotView setFrame:CGRectMake(startBackViewX+y,
                                            0,
                                            kkBackViewWidth,
                                            lastScreenShotViewHeight)];
    
}


-(void)destroyAppWebViewController{
    
    
    
}
-(BOOL)isBlurryImg:(CGFloat)tmp
{
    return YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(self.canDragBack){
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x < 20.0 || point.x > self.view.frame.size.width - 20.0) {
            return YES;
        } else {
            return NO;
        }
        
    }else{
        return NO;
        
    }
    
    
}
#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    if (self.backgroundView) { self.backgroundView = nil; }
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame =[UIScreen mainScreen].bounds;// self.view.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        
        startBackViewX = kstartX;
        [lastScreenShotView setFrame:CGRectMake(startBackViewX,
                                                lastScreenShotView.frame.origin.y,
                                                lastScreenShotView.frame.size.height,
                                                lastScreenShotView.frame.size.width)];
        
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:kScreenWidth];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                self.isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            self.isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}


-(void)removeGesture{
    [self.view removeGestureRecognizer:recognizer];
    
}

-(void)addGesture{
    [self.view addGestureRecognizer:recognizer];
    
}

@end



