//
//  MyWebView.m
//  ZhuiKe55like
//
//  Created by junseek on 15-4-13.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//

#import "MyWebView.h"
#import "MessageInterceptor.h"
#import "WebImagesViewController.h"
#import "MJRefreshNormalHeader.h"

@interface MyWebView ()<WKNavigationDelegate,UIScrollViewDelegate,WKUIDelegate>{
    
    BOOL boolFileUrl;
    NSString *strTempUrl;
    
    
    
    //    NSTimer *timeProgress;
    MessageInterceptor *_delegateInterceptor;
    MessageInterceptor *_UIdelegateInterceptor;
}

@property (nonatomic, strong) UIProgressView *progressIndicator;
@property (nonatomic, strong) NSMutableArray *arrayImages;
@property (nonatomic, strong) NSURL *strUrl;

@end


@implementation MyWebView



-(instancetype)init{
    return [self initWithFrame:[[UIScreen mainScreen] bounds]];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponents];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    self=[super initWithFrame:frame configuration:configuration];
    if (self) {
        [self initComponents];
    }
    return self;
}

-(void)setNavigationDelegate:(id<WKNavigationDelegate>)navigationDelegate{
    if(_delegateInterceptor) {
        super.navigationDelegate = nil;
        _delegateInterceptor.receiver = navigationDelegate;
        super.navigationDelegate = (id)_delegateInterceptor;
    } else {
        super.navigationDelegate = navigationDelegate;
    }
}
-(void)setUIDelegate:(id<WKUIDelegate>)UIDelegate{
    if(_UIdelegateInterceptor) {
        super.UIDelegate = nil;
        _UIdelegateInterceptor.receiver = UIDelegate;
        super.UIDelegate = (id)_UIdelegateInterceptor;
    } else {
        super.UIDelegate = UIDelegate;
    }
}
- (void)initComponents
{
    if (_arrayImages) {
        return;
    }
    _arrayImages=[NSMutableArray new];
    self.backgroundColor=[UIColor whiteColor];
    _delegateInterceptor = [[MessageInterceptor alloc] init];
    _delegateInterceptor.middleMan = self;
    _delegateInterceptor.receiver = self.navigationDelegate;
    
    _UIdelegateInterceptor = [[MessageInterceptor alloc] init];
    _UIdelegateInterceptor.middleMan = self;
    _UIdelegateInterceptor.receiver = self.UIDelegate;
    if (!_progressIndicator) {
        _progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, W(self), 1)];
        [_progressIndicator setProgressViewStyle:UIProgressViewStyleBar];
        [_progressIndicator setProgressTintColor:rgbpublicColor];
        [_progressIndicator setTrackTintColor:[UIColor clearColor]];
        _progressIndicator.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        [self addSubview:_progressIndicator];
        _progressIndicator.hidden=YES;
        //        timeProgress=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(function:) userInfo:nil repeats:YES];
        
    }
    
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    __weak typeof(self) weakSelf=self;
    //    修改全局UserAgent值（这里是在原有基础上拼接自定义的字符串）
    [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *userAgent = result;
        if ([userAgent rangeOfString:@"is55likeAPP"].location==NSNotFound) {
            NSString *newUserAgent = [userAgent stringByAppendingString:@"is55likeAPP"];
            //        NSString *newUserAgent = @"1";
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
            [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //        在网上找到的没有下面这句话，结果只是更改了本地的UserAgent，没修改网页的，导致一直有问题，好低级的错误，这个函数是9.0之后才出现的，在这之前，把这段代码放在WKWebView的alloc之前才会有效
            if (@available(iOS 9.0, *)){
                [weakSelf setCustomUserAgent:newUserAgent];
            }
            //            if (([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)) {
            //
            //            }
        }
        
    }];
    __weak MyWebView *weakWeb=self;
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
        [weakWeb refreshWeb];
    }];
    
    
    
    //    [refreshHeaderView refreshLastUpdatedDate];
}
//设置cookie
- (void)setCookie{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"userid" forKey:NSHTTPCookieName];
    [cookieProperties setObject:[[Utility Share] userId] forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"zkapi.junseek.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
    
    
    [cookieProperties setObject:@"usertoken" forKey:NSHTTPCookieName];
    [cookieProperties setObject:[[Utility Share] userToken] forKey:NSHTTPCookieValue];
    
    NSHTTPCookie *cookieuser2 = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser2];
    
}
//清除cookie
- (void)deleteCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSURL *urlT=[NSURL URLWithString: strTempUrl];
    if (urlT) {
        NSArray *cookieAry = [cookieJar cookiesForURL: urlT];
        for (cookie in cookieAry) {
            [cookieJar deleteCookie: cookie];
        }
    }
    
}
-(void)loadMyWeb:(NSString *)url{
    boolFileUrl=NO;
    strTempUrl=url;
    NSString *encodedString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"\n%@\n%@",encodedString,url);
    //    NSLog(@"原url:%@", url);
    //    NSString *encodedString = (NSString *)
    //    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    //                                                              (CFStringRef)url,
    //                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
    //                                                              NULL,
    //                                                              kCFStringEncodingUTF8));
    //
    //    NSLog(@"转码url:%@",  encodedString);
    self.strUrl=[NSURL URLWithString:encodedString];
    //    if ([strTempUrl notEmptyOrNull]) {
    //        [self deleteCookie];
    //    }
    //    [self setCookie];
    
    [self refreshWeb];
}

/**
 加载URL地址（用于本地文件）
 
 @param url URL 地址
 */
-(void)loadMyWebFileURL:(NSURL *)url{
    boolFileUrl=YES;
    self.strUrl=url;
    //    [self setCookie];
    [self refreshWeb];
}
-(void)refreshWeb{
    DLog("refreshWeb:%@",[_strUrl absoluteString])
    //    //清除UIWebView的缓存
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    //    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    //
    //
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    
    //        NSString *encodedString=[self.strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (@available(iOS 9.0, *)) {
        if (boolFileUrl) {
            NSURL *fileURL = self.strUrl;
            
            [self loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        } else {
            NSURLRequest *request = [NSURLRequest requestWithURL:self.strUrl];
            [self loadRequest:request];
        }
    }else {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.strUrl];
        [self loadRequest:request];
    }
    
    
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        });
    //    });
    
}
#pragma mark controller
- (BaseViewController *)viewBaseController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[BaseViewController class]]) {
            return (BaseViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    //读取wkwebview中的cookie 方法1
    for (NSHTTPCookie *cookie in cookies) {
        //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        DLog(@"wkwebview中的cookie:%@", cookie);
        
    }
    //读取wkwebview中的cookie 方法2 读取Set-Cookie字段
    NSString *cookieString = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
    DLog(@"wkwebview中的cookie2:%@", cookieString);
    
    //看看存入到了NSHTTPCookieStorage了没有
    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieJar2.cookies) {
        DLog(@"NSHTTPCookieStorage中的cookie3:%@", cookie);
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *requestString = [[navigationAction.request URL] absoluteString];
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        NSInteger index_img=0;
        NSMutableArray *array=[[NSMutableArray alloc] init];
        for (int i=0 ; i<[_arrayImages count];i++) {
            NSString *strImg =[_arrayImages objectAtIndex:i];
            if ([strImg isEqualToString:imageUrl]) {
                index_img=i;
            }
            NSMutableDictionary *dt=[[NSMutableDictionary alloc] init];
            [dt setValue:strImg forKey:@"url"];
            [array addObject:dt];
        }
        [[self viewBaseController] pushController:[WebImagesViewController class]
                                         withInfo:@"myWebView"
                                        withTitle:@"查看"
                                        withOther:@{@"lookImages":array,
                                                    @"lookSelectIndex":[NSString stringWithFormat:@"%ld",(long)index_img]}];
        
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    UIApplication *app = [UIApplication sharedApplication];
    if ([scheme isEqualToString:@"tel"] ||
        [scheme isEqualToString:@"Tel"]||
        [scheme isEqualToString:@"sms"]||
        [scheme isEqualToString:@"mailto"]) {
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        
    }
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        //        [webView loadRequest:navigationAction.request];
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    if (_delegateInterceptor !=nil && [_delegateInterceptor.receiver respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [_delegateInterceptor.receiver webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    // 判断服务器采用的验证方法
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 如果没有错误的情况下 创建一个凭证，并使用证书
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        }else {
            // 验证失败，取消本次验证
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    }else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [[self supViewController] presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [[self supViewController] presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [[self supViewController] presentViewController:alertController animated:YES completion:nil];
}
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    [webView reload];
}
#endif
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [_arrayImages removeAllObjects];
    if(_isHiddenProgress){
        _progressIndicator.hidden=YES;
    }else{
        _progressIndicator.hidden=NO;
        _progressIndicator.progress=0.0;
    }
    
    //    [_progressIndicator setProgress:0.9 animated:YES];;
    
    if (_delegateInterceptor !=nil &&[_delegateInterceptor.receiver respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [_delegateInterceptor.receiver webView:webView didStartProvisionalNavigation:navigation];
    }
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //    //调整字号
    //    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
    //    [webView stringByEvaluatingJavaScriptFromString:str];
    
    //js方法遍历图片添加点击事件 返回图片点击个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var image_url=\"\";\
    var index_click=0;\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    if(objs[i].getAttribute(\"data-src\")){\
    if(image_url){\
    image_url=image_url+\"__zkwap__\"+objs[i].getAttribute(\"data-src\");\
    }else{\
    image_url=objs[i].getAttribute(\"data-src\");\
    };\
    index_click++;\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.getAttribute(\"data-src\");;\
    };\
    };\
    };\
    return image_url;\
    };getImages();";
    
    __weak typeof(self) weakSelf=self;
    //
    /// jsStr为要执行的js代码，字符串形式
    [webView evaluateJavaScript:jsGetImages completionHandler:^(id _Nullable resurlt, NSError * _Nullable error) {
        // 执行结果回调
        DLog(@"执行结果回调:%@",resurlt);
        [weakSelf.arrayImages removeAllObjects];
        if ([resurlt notEmptyOrNull]) {
            [weakSelf.arrayImages addObjectsFromArray:[resurlt componentsSeparatedByString:@"__zkwap__"]];
        }
        
    }];
    
    
    
    [self endRefresh];
    self.strUrl =webView.URL;
    DLog(@"self.strUrl:%@",[_strUrl absoluteString]);
    
    if (_delegateInterceptor !=nil && [_delegateInterceptor.receiver respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [_delegateInterceptor.receiver webView:webView didFinishNavigation:navigation];
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    _progressIndicator.hidden=YES;
    _progressIndicator.progress=0.0;
    
    [self endRefresh];
    if (_delegateInterceptor !=nil && [_delegateInterceptor.receiver respondsToSelector:@selector(webView:didFailProvisionalNavigation:)]) {
        [_delegateInterceptor.receiver webView:webView didFailProvisionalNavigation:navigation];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    if (refreshHeaderView) {
////        [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
////    }
//
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
////    if (refreshHeaderView) {
////        [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
////    }
//
//
//}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

-(void)dealloc{
    super.navigationDelegate = nil;
    self.scrollView.delegate=nil;
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
    [self removeObserver:self forKeyPath:@"title"];
    
    _UIdelegateInterceptor.receiver=nil;
    _UIdelegateInterceptor=nil;
    _delegateInterceptor.receiver=nil;
    _delegateInterceptor=nil;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        __weak typeof(self) weakSelf=self;
        [_progressIndicator setProgress:self.estimatedProgress animated:YES];
        if (object == self) {
            if(_isHiddenProgress){
                return;
            }
            if(self.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [weakSelf.progressIndicator setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    weakSelf.progressIndicator.hidden=YES;
                    [weakSelf.progressIndicator setProgress:0.0f animated:NO];
                }];
            }else{
                [_progressIndicator setAlpha:1.0f];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self) {
            DLog(@"_title:%@",self.title);
            if (_isRefreshNavTitle) {
                [[self viewBaseController] navbarTitle:self.title];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - 结束下拉刷新和上拉加载
- (void)endRefresh{
    //当请求数据成功或失败后，如果你导入的MJRefresh库是最新的库，就用下面的方法结束下拉刷新和上拉加载事件
    [self.scrollView.mj_header endRefreshing];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

