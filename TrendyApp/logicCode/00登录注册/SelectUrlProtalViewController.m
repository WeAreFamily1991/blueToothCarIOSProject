//
//  SelectWebUrlViewController.m
//  ZhuiKe55like
//
//  Created by junseek on 15-4-13.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//

#import "SelectUrlProtalViewController.h"
#import "MyWebView.h"
#import "MJRefreshNormalHeader.h"

@interface SelectUrlProtalViewController ()<WKNavigationDelegate,WKUIDelegate>{
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

@implementation SelectUrlProtalViewController

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
    [SVProgressHUD dismiss];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    
    
    
    
    WebView = [[MyWebView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth,kContentHeight-50)];
    WebView.scrollView.mj_header=nil;
    WebView.navigationDelegate=self;
    WebView.UIDelegate=self;
    [self.view addSubview:WebView];
    //    WebView.scalesPageToFit=YES;
    WebView.isRefreshNavTitle=YES;
    [WebView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
//    if ([self.otherInfo isKindOfClass:[NSString class]]) {
//        strTempUrl=self.otherInfo;
//    }else  if ([self.otherInfo isKindOfClass:[NSDictionary class]]) {
//        strTempUrl=[self.otherInfo valueForJSONStrKey:@"url"];
//        strTempUrl=@"www.baidu.com";
//    }
//
//    if (strTempUrl.length>4) {
//        strTempUrl= [[[strTempUrl lowercaseString] substringToIndex:4] isEqualToString:@"http"]?strTempUrl:[NSString stringWithFormat:@"http://%@",strTempUrl];
//    }
//
//    [WebView loadMyWeb:strTempUrl];
    
    if ([[self.userInfo ojsk:@"url"] notEmptyOrNull]) {
        
        [WebView loadMyWeb:[self.userInfo ojsk:@"url"]];
    }else{
        
        [WebView loadHTMLString:[self.userInfo ojsk:@"rule"] baseURL:nil];
    }

    
    
    if ([[self.userInfo ojsk:@"btnTitle"] notEmptyOrNull]||[[self.userInfo ojsk:@"myTitle"] notEmptyOrNull]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:self.view];
        viewContent.frameY=WebView.frameYH;
        if ([[self.userInfo ojsk:@"myTitle"] notEmptyOrNull]) {
//            iReadAndAgree kS(@"", @"iReadAndAgree")
           ;
            UILabel*lbContent=[RHMethods lableX:40 Y:0 W:0 Height:viewContent.frameHeight font:14 superview:viewContent withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@%@",kS(@"confirm_booking_info", @"have_read_and_agree"),[self.userInfo ojsk:@"myTitle"]]];
            
            [lbContent setColor:rgb(13,107,154) contenttext:[self.userInfo ojsk:@"myTitle"]];
        }else{
            UILabel*lbContent=[RHMethods lableX:40 Y:0 W:0 Height:viewContent.frameHeight font:14 superview:viewContent withColor:rgb(102, 102, 102) text:[self.userInfo ojsk:@"btnTitle"]];
        }
        
        
        WSSizeButton*btnAgrreBtn=[RHMethods buttonWithframe:CGRectMake(0, 0, kScreenWidth*0.5, viewContent.frameHeight) backgroundColor:nil text:@"" font:0 textColor:nil radius:0 superview:viewContent];
        [btnAgrreBtn setImageStr:@"checkedoff" SelectImageStr:@"checkedon"];
        [btnAgrreBtn setBtnImageViewFrame:CGRectMake(15, 0, 19, 19)];
        [btnAgrreBtn imgbeCY];
        btnAgrreBtn.selected=[[self.userInfo ojsk:@"isSelectPolicy"] isEqualToString:@"1"];
        [btnAgrreBtn addViewTarget:self select:@selector(agrreBtnclick:)];
    }else{
        WebView.frameHeight=kContentHeight;
    }
    

    
}
#pragma mark button
-(void)agrreBtnclick:(UIButton*)btn{
    btn.selected=!btn.selected;
    [self.userInfo setObject:btn.selected?@"1":@"0" forKey:@"isSelectPolicy"];
    self.allcallBlock?self.allcallBlock(self.userInfo,200,nil):nil;
    
    
    if (btn.selected) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}

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
