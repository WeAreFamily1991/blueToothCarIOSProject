//
//  MyWebView.h
//  ZhuiKe55like
//
//  Created by junseek on 15-4-13.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//
/*
 使用后必须在dealloc手动释放，否则容易造成空指针
 
 -(void)dealloc{
 WebView.scrollView.delegate=nil;
 WebView.navigationDelegate=nil;
 [WebView removeFromSuperview];
 WebView=nil;
 }
 */
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MyWebView : WKWebView
    
/**
 是否隐藏加载进度条（默认显示）
 */
@property(nonatomic,assign)BOOL isHiddenProgress;
    
/**
 是否刷新导航栏标题
 */
@property(nonatomic,assign)BOOL isRefreshNavTitle;
-(void)refreshWeb;
-(void)loadMyWeb:(NSString *)url;
/**
 加载URL地址（用于本地文件）
 
 @param url URL 地址
 */
-(void)loadMyWebFileURL:(NSURL *)url;
@end

