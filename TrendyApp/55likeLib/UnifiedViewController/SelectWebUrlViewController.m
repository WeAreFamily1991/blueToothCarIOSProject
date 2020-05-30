//
//  SelectWebUrlViewController.m
//  ZhuiKe55like
//
//  Created by junseek on 15-4-13.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//

#import "SelectWebUrlViewController.h"
#import "MyWebView.h"

#import "NSObject+JSONCategories.h"
#import "NSString+JSONCategories.h"
@interface SelectWebUrlViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>{
    MyWebView *WebView;
    NSString *strTempUrl;
    UIBarButtonItem *LeftItem1;
    UIButton *btnBack;
    NSArray *arrayType;
    
    NSString *strTitle;
    NSString *strDescription;
    NSString *strImageUrl;
 
    BOOL boolBack;
    
    BOOL boolRefresh;
}


@end

@implementation SelectWebUrlViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initComponents];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myWebView_nil:) name:@"myWebView_nil" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (boolRefresh) {
        boolRefresh=NO;
        [WebView refreshWeb];
    }
    [WebView.configuration.userContentController addScriptMessageHandler:self name:@"webViewApp"];
    [SVProgressHUD dismiss];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [WebView.configuration.userContentController removeScriptMessageHandlerForName:@"webViewApp"];
//    [SVProgressHUD dismiss];
}

#pragma mark push_NSNotification
-(void)myWebView_nil:(NSNotification *)note{
    [WebView removeFromSuperview];
    WebView=nil;
}


- (void)initComponents{
    strTempUrl=@"";
    if (!kVersion7) {
        [self navbarTitle:@""];
        [self backButton];
    }
    
    btnBack=[RHMethods buttonWithFrame:CGRectMake(44, kTopHeight-44, 50+30,44 ) title:kS(@"generalPage", @"zClose") image:@"" bgimage:@""];
    [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnBack addTarget:self action:@selector(LeftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font=Font(17);
    btnBack.hidden=YES;
    [self.navView addSubview:btnBack];
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.userContentController = [[WKUserContentController alloc] init];
    config.processPool = [[WKProcessPool alloc] init];
    
    
    //    _WebView = [[MyWebView alloc] initWithFrame:CGRectMake(0, kTopHeight,kScreenWidth,kScreenHeight-kTopHeight) configuration:config];
    WebView = [[MyWebView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth,kContentHeight) configuration:config];
    WebView.navigationDelegate=self;
    WebView.UIDelegate=self;
    [self.view addSubview:WebView];
//    WebView.scalesPageToFit=YES;
    WebView.isRefreshNavTitle=YES;
    [WebView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    if ([self.otherInfo isKindOfClass:[NSString class]]) {
        strTempUrl=self.otherInfo;
    }else  if ([self.otherInfo isKindOfClass:[NSDictionary class]]) {
        strTempUrl=[self.otherInfo valueForJSONStrKey:@"url"];
    }
    
    if (strTempUrl.length>4) {
        strTempUrl= [[[strTempUrl lowercaseString] substringToIndex:4] isEqualToString:@"http"]?strTempUrl:[NSString stringWithFormat:@"http://%@",strTempUrl];
    }
    
    [WebView loadMyWeb:strTempUrl];
   
    if ([self.userInfo isEqualToString:@"userProject"] ||
        [self.userInfo isEqualToString:@"userDownload"]) {
        [self rightButton:nil image:@"headfx" sel:@selector(shareBUttonClicked)];
    }
    
}
#pragma mark button
-(void)shareBUttonClicked{
    //分享
}
-(void)backButtonClicked:(id)sender{
//    [SVProgressHUD dismiss];
    if (WebView.canGoBack){
        //返回上一个网页
        [WebView goBack];
    }else{
        if (!boolBack) {
            boolBack=YES;
            [super backButtonClicked:nil];
        }
    }
}
-(void)LeftButtonClicked{
    if (!boolBack) {
        boolBack=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
//分离URL参数
-(NSMutableDictionary *)dicSeparatedUrl:(NSString *)strurl{
    //获取问号的位置，问号后是参数列表
    NSRange range = [strurl rangeOfString:@"?"];
    NSLog(@"参数列表开始的位置：%d", (int)range.location);
    
    //获取参数列表
    NSString *propertys = [strurl substringFromIndex:(int)(range.location+1)];
    NSLog(@"截取的参数列表：%@", propertys);
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    NSLog(@"把每个参数列表进行拆分，返回为数组：n%@", subArray);
    
    //把subArray转换为字典
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
    
    for (int j = 0 ; j < subArray.count; j++)
    {
        if ([subArray[j] notEmptyOrNull]) {
            //在通过=拆分键和值
            NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
            if ([dicArray count]>1) {
                //给字典加入元素
                [tempDic setObject:dicArray[1] forKey:dicArray[0]];
            }else if([dicArray count]){
                [tempDic setObject:@"" forKey:dicArray[0]];
            }
        }
    }
    NSLog(@"打印参数列表生成的字典：n%@", tempDic);
    
    return tempDic;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    __weak __typeof(self) weakSelf = self;
    
    //找到对应js端的方法名,获取messge.body
    if ([message.name isEqualToString:@"webViewApp"]) {
        NSDictionary *dicBody=[message.body JSONValue];
        NSLog(@"%@", message.body);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UTILITY setAddValue:@"1" forKey:@"addOrder"];
            
            if ([[dicBody valueForJSONStrKey:@"type"] isEqualToString:@"order"]) {//
                
                [UTILITY.CustomTabBar_zk selectedTabIndex:@"2"];
            }
            if ([[dicBody valueForJSONStrKey:@"type"] isEqualToString:@"home"]) {//
                [UTILITY.CustomTabBar_zk selectedTabIndex:@"0"];
            }
        });
    }
    
}

#pragma mark -
#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    strTempUrl= [navigationAction.request.URL absoluteString];
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (WebView.canGoBack) {
        self.backButton.frameWidth=44;
        btnBack.hidden=NO;
        
    }else{
        self.backButton.frameWidth=60;
        btnBack.hidden=YES;
    }

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showImage:nil status:@"加载失败,下拉可以刷新界面"];
}

#pragma mark pop
-(void)popRefreshData{
    boolRefresh=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
