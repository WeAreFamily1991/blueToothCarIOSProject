
#import "CustomTabBar.h"
#import "YUBaseTabBar.h"
/////////////lj

@interface CustomTabBar ()<UITabBarControllerDelegate>{
}

@end
@implementation CustomTabBar

@synthesize currentSelectedIndex;

@synthesize buttons,lbls;




static CustomTabBar *_instance=nil;

+ (id)Share
{
    @synchronized(self) {
        if (_instance==nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [[Utility Share] setCustomTabBar_zk:self];
    self.delegate=self;
    
    YUBaseTabBar *baseTabBar = [[YUBaseTabBar alloc] init];
    [self setValue:baseTabBar forKey:@"tabBar"];
    [self customTabBar];
    
    
}


- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:NO];
//    [self.selectedViewController endAppearanceTransition];

    //slideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomfocus"]];
    static bool isfirst=true;/////////lijiang
    //  bool isfirst=true;
    if (isfirst) {
        isfirst=false;
        [self customTabBar];
    }
    for (UITabBarItem *item in self.tabBar.items) {
        item.title=@"  ";
        item.enabled=NO;
    }
    self.tabBar.tintColor=[UIColor clearColor];
    [super viewDidAppear:NO];
}

- (void)hideRealTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden = YES;
            break;
        }
    }
}


//- (void)hideExistingTabBar
//{
//	for(UIView *view in self.view.subviews)
//	{
//		if([view isKindOfClass:[UITabBar class]])
//		{
//			view.hidden = YES;
//			break;
//		}
//	}
//}

-(NSArray *)cusViewControllers{
    return self.viewControllers;
}
- (void)customTabBar{
    
    UITabBar *tabBar = self.tabBar;
  
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
   
    for(UIView *view in self.tabBar.subviews){
        [view removeFromSuperview];
    }
    self.tabBar.barStyle=UIBarStyleBlack;//去除黑线

    
    double _height = kIphoneXBottom+49;//self.tabBar.frame.size.height;
    
    
    UIView *tabBarBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];//[UIScreen mainScreen].bounds.size.height-49
    tabBarBackGroundView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:tabBarBackGroundView];
    [self.tabBar bringSubviewToFront:tabBarBackGroundView];
    
    
    tabBarBackGroundView.tag=10000;
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, W(tabBarBackGroundView), 0.5)];
    lineV.backgroundColor=rgbLineColor;//RGBACOLOR(150, 150, 150, 0.5);
    [tabBarBackGroundView addSubview:lineV];
    
    
    
    //        UIImageView *imgView = [[UIImageView alloc] initWithImage: [[UIImage imageNamed:@"foot_tit"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];//[image stretchableImageWithLeftCapWidth:_w topCapHeight:_h]
    //        imgView.frame = tabBarBackGroundView.bounds;
    //        [tabBarBackGroundView addSubview:imgView];
    //	slideBg.frame = CGRectMake(-30, self.tabBar.frame.origin.y, slideBg.image.size.width, slideBg.image.size.height);
    //[imgView release];
    
    NSArray *tarray=[[NSArray alloc]initWithObjects:kS(@"main", @"home"),kS(@"main", @"rentCar"),kS(@"main", @""),kS(@"main", @"order"),kS(@"main", @"mine"),nil];
    
    
    //创建按钮
    NSInteger viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
    self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
    self.lbls = [NSMutableArray arrayWithCapacity:viewCount];
    double _width = kScreenWidth / viewCount;
    
    DLog(@"_yyyy:%f,_height:%f",self.tabBar.frame.origin.y,_height);
    
    for (int i = 0; i < viewCount; i++) {
        //        UIViewController *tempController=[self.viewControllers objectAtIndex:i];
        //        tempController.hidesBottomBarWhenPushed=YES;
        //hidesBottomBarWhenPushed
        
       
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i!=2) {
          btn.frame = CGRectMake(i*_width,0, _width, 49);
        }else
        {
          btn.frame = CGRectMake(SCREEN_WIDTH/2-WScale(50),WScale(-40), WScale(100), WScale(100));
        }
        
        // btn.frame=CGRectMake(i*_width,self.tabBar.frame.origin.y+3, 53, 44);
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
               
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fmenuion%d",i+1]] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fmenui%d",i+1]] forState:UIControlStateNormal];
                
        // [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%d%d",i+1,i+1]] forState:UIControlStateHighlighted];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        [self.buttons addObject:btn];
        [tabBarBackGroundView  addSubview:btn];
//        
        UILabel *lblt=[RHMethods labelWithFrame:CGRectMake(X(btn), 34, W(btn), 15) font:Font(10) color:rgbTxtGray text:[tarray objectAtIndex:i]];
        [lblt setTextAlignment:NSTextAlignmentCenter];
        [self.lbls addObject:lblt];
        if (i==2) {
            lblt.text =@"";
        }
        [tabBarBackGroundView addSubview:lblt];
    }
    [self selectedTab:[self.buttons objectAtIndex:self.currentSelectedIndex]];
//    NSInteger viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
//    double _width = kScreenWidth / viewCount;
    
    UIView *vt1=[tabBar viewWithTag:201];
    if (!vt1) {
        for (int i=0; i<viewCount; i++) {
            //            UIView *vit=[[UIView alloc]initWithFrame:CGRectMake(_width*i + (_width/2.0) +10, 5, 6, 6)];
            //            vit.tag=200+i;
            //            [[Utility Share] viewLayerRound:vit borderWidth:3 borderColor:[UIColor redColor]];
            UIImageView *imagV=[RHMethods imageviewWithFrame:CGRectMake(_width*i + (_width/2.0) + 12, 5, 7, 7) defaultimage:@"dian01TG"];
            imagV.tag=200+i;
            imagV.hidden=YES;
            [tabBar addSubview:imagV];
        }
    }
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UINavigationController *nav=(UINavigationController *)viewController;
    [nav popToRootViewControllerAnimated:NO];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    UINavigationController *nav=(UINavigationController *)viewController;
//    DLog(@"________%ld",(long)nav.navigationBar.tag);
//    if (nav.navigationBar.tag==3&&![kUtility_Login isLogIn]) {
//
//
//        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
//
//        }];
//        return NO;
//        //        [[Utility Share] isLogin:^(NSInteger NoLogin) {
//        //            if (NoLogin==1) {
//        //                [[[Utility Share] CustomTabBar_zk] setSelectedIndex:3];
//        //            }
//        //        }];
//        //
//        //        //[[Utility Share] showLoginAlert:YES];
//        //        return NO;
//    }else{
        //
        return YES;
//    }
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    DLog(@"________%@",item.title);
}
- (void)selectedTab:(UIButton *)button{
    [SVProgressHUD dismiss];
      __weak __typeof(self) weakSelf = self;
//    if ((button.tag==2 || button.tag==3)&&![kUtility_Login isLogIn]) {
//        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
//            [weakSelf selectedTabTemp:button];
//        }];
//
//        //        SendNotify(@"sendTelClicked", nil)
//    }else{
//        [self selectedTabTemp:button];
//    }
    if ((button.tag==2)&&![kUtility_Login isLogIn]) {
        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
            [weakSelf selectedTabTemp:button];
        }];
        
        //        SendNotify(@"sendTelClicked", nil)
    }else{
        [self selectedTabTemp:button];
    }
    
}
-(void)selectedTabTemp:(UIButton *)button{    
    for (UITabBarItem *item in self.tabBar.items) {
        item.title=@"  ";
        item.enabled=NO;
    }

    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fmenuion%ld",button.tag+1]] forState:UIControlStateNormal];

    UILabel *lblttt=(UILabel *)[self.lbls objectAtIndex:button.tag];
    [lblttt setTextColor:rgbpublicColor];
    
    // [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_bg_s%d",button.tag+1]] forState:UIControlStateNormal];
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(13, 0, 0,0)];
    // [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%d%d",button.tag+1,button.tag+1]] forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor colorWithRed:2/255.0 green:92/255. blue:170/255. alpha:1] forState:UIControlStateNormal];
    
    if (self.currentSelectedIndex != button.tag)
    {
        UIButton *preBtn=[self.buttons objectAtIndex:self.currentSelectedIndex];
        // [preBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%d",self.currentSelectedIndex+1]] forState:UIControlStateNormal];
       
        [preBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fmenui%d",self.currentSelectedIndex+1]] forState:UIControlStateNormal];
            
        
        
        UILabel *lblttt=(UILabel *)[self.lbls objectAtIndex:self.currentSelectedIndex];
        [lblttt setTextColor:rgbTxtGray];
                
//        [preBtn setImageEdgeInsets:UIEdgeInsetsMake(13, 0, 0,0)];
        //        [preBtn setTitleColor:[UIColor colorWithRed:49/255.0 green:20/255. blue:4/255. alpha:1] forState:UIControlStateNormal];
        //      DLog(@"button.tag:%d",button.tag);
        //        if (button.tag!=2) {
        //            [[self.viewControllers objectAtIndex:button.tag] popToRootViewControllerAnimated:NO];
        //        }
        //取消不要默认记忆效果
        [[self.viewControllers objectAtIndex:button.tag] popToRootViewControllerAnimated:NO];
        
        
    }else{
        //返回初始化页面
        [[self.viewControllers objectAtIndex:button.tag] popToRootViewControllerAnimated:NO];
        
    }
    
    
    
    self.currentSelectedIndex = (int)button.tag;
    self.selectedIndex = self.currentSelectedIndex;
}

- (void)selectedTabIndex:(NSString *)indexStr;
{
//    if (!kVersion7) {
        [self selectedTab:[self.buttons objectAtIndex:[indexStr integerValue]]];
//    }else{
//        
//        [[[Utility Share] CustomTabBar_zk] setSelectedIndex:[indexStr integerValue]];
//      
//    }
}
-(void)updateCustomTabBarControllers{
//    KKNavigationController *kkn=(KKNavigationController *)[self.viewControllers lastObject];
//    
//    NSMutableArray *vs=[[NSMutableArray alloc] initWithObjects:[self.viewControllers objectAtIndex:0],[self.viewControllers objectAtIndex:1],[self.viewControllers objectAtIndex:2], nil];
//    if (![[[Utility Share] userTraintask] isEqualToString:@"0"]) {
//        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        //根据 场景 标示符 ，创建目前视图对象
//        KKNavigationController *kkPx=[story instantiateViewControllerWithIdentifier:@"trainingKKNav"];
//        //        KKNavigationController *kkPx=[[KKNavigationController alloc] initWithRootViewController:<#(nonnull UIViewController *)#>];
//        [vs addObject:kkPx];
//    }
//    [vs addObject:kkn];
//    
//    if (self.viewControllers.count!=[vs count]) {       
//        
//        [self setViewControllers:vs];
//        [self customTabBar];
//    }
    
    
}

//是否支持屏幕旋转
-(BOOL)shouldAutorotate
{
    NSInteger indext=[[[Utility Share] CustomTabBar_zk]selectedIndex];
    indext=indext>4?0:indext;
    UINavigationController *curNav = [[[[Utility Share] CustomTabBar_zk] viewControllers] objectAtIndex:indext];
    
    return curNav.topViewController.shouldAutorotate;
}

// 支持的旋转方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    NSInteger indext=[[[Utility Share] CustomTabBar_zk]selectedIndex];
    indext=indext>4?0:indext;
    UINavigationController *curNav = [[[[Utility Share] CustomTabBar_zk] viewControllers] objectAtIndex:indext];
    
    
    return curNav.topViewController.supportedInterfaceOrientations;//UIInterfaceOrientationMaskAllButUpsideDown;
}

//- (void)slideTabBg:(UIButton *)btn{
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.20];
//	[UIView setAnimationDelegate:self];
//	slideBg.frame = CGRectMake(btn.frame.origin.x - 30, btn.frame.origin.y, slideBg.image.size.width, slideBg.image.size.height);
//	[UIView commitAnimations];
//}



@end
