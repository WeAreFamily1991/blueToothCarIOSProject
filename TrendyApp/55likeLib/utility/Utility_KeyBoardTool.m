//
//  Utility_KeyBoardTool.m
//  55likeLibDemo
//
//  Created by 55like on 2018/7/11.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "Utility_KeyBoardTool.h"

static Utility_KeyBoardTool *_utility_KeyBoardTool=nil;
static dispatch_once_t utility_KeyBoardTool;
@interface Utility_KeyBoardTool()
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isGetSuperview;
@end

@implementation Utility_KeyBoardTool
+(instancetype)shareInstence{
    dispatch_once(&utility_KeyBoardTool, ^ {
        _utility_KeyBoardTool = [[Utility_KeyBoardTool alloc] init];
        _utility_KeyBoardTool.isOpen=YES;
        //注册键盘显示通知监听
        [[NSNotificationCenter defaultCenter] addObserver:_utility_KeyBoardTool selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:_utility_KeyBoardTool selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        //注册键盘收起通知监听
        [[NSNotificationCenter defaultCenter] addObserver:_utility_KeyBoardTool selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    });
    return _utility_KeyBoardTool;
}
/**
 开启 键盘处理
 */
-(void)start{
    _isOpen=YES;
}


/**
 关闭 键盘处理
 */
-(void)stop{
    _isOpen=NO;
    
}


    
-(void)handleKeyboardDidShow:(NSNotification *)notification{
    if(_isGetSuperview){
        _isGetSuperview=NO;
    }else{
        [self handleKeyboardWillShow:notification];
        
    }
    _isGetSuperview=NO;
}
    /**
     键盘显示 通知处理
     
     @param notification 键盘显示通知
     */
-(void)handleKeyboardWillShow:(NSNotification *)notification{

    //      return;
    if (_isOpen==NO) {
        return;
    }
    
    if ([UTILITY.currentViewController respondsToSelector:@selector(handleKeyboardDidShow:)]) {
        return;
    }
    [UTILITY.currentViewController.view addViewClickBlock:^(UIView *view) {
        [view endEditing:YES];
    }];
    
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    //键盘滑动高度
    CGFloat distanceToMove = kbSize.height;
    NSLog(@"---->动态键盘高度:%f",distanceToMove);
#pragma mark zxh UI布局 根据键盘布局
    
    
    //获取 当前响应者的 scrollView 需要滑动改变高度的_UIWebViewScrollView
    UIScrollView*scrollView=[self getCurrentScrollView];
    if(scrollView){
        _isGetSuperview=YES;
    }else{
        _isGetSuperview=NO;
    }
    if (scrollView==nil||[NSStringFromClass([scrollView class]) isEqualToString:@"WKScrollView"]||[NSStringFromClass([scrollView class]) isEqualToString:@"_UIWebViewScrollView"]) {
        return;
    }
    [UTILITY.currentViewController.view addViewClickBlock:^(UIView *view) {
        [view endEditing:YES];
    }];
    // keyBoadrdscrollViewH 初始状态下 键盘的高度 为了保存现场
    if (![scrollView getAddValueForKey:@"keyBoadrdscrollViewH"]) {
        [scrollView setAddValue:[NSString stringWithFormat:@"%f",scrollView.frameHeight] forKey:@"keyBoadrdscrollViewH"];
        
        
    }
    //    当前keyWindow
    UIWindow*keywindow=[[UIApplication sharedApplication] keyWindow];
    
    // keyBoadrdscrollViewH 初始状态下 键盘的高度 为了保存现场
    float scrollViewH=[[scrollView getAddValueForKey:@"keyBoadrdscrollViewH"] floatValue];
    //scrollView 相对于主窗口的frame
    CGRect rect=[scrollView convertRect:scrollView.bounds toView:keywindow];
    
    //
    float targetframeHeight=scrollViewH-distanceToMove+(keywindow.frameHeight-(scrollViewH +rect.origin.y));
    
    if (targetframeHeight<[[scrollView getAddValueForKey:@"keyBoadrdscrollViewH"] floatValue]) {
        scrollView.frameHeight=targetframeHeight;
        NSLog(@"%f",targetframeHeight);
        //        scrollView.backgroundColor=[UIColor blueColor];
    }
    [Utility_KeyBoardTool TFscrollview:scrollView];
    
}


/**
 键盘隐藏 通知处理
 
 @param notification 键盘隐藏通知
 */
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (_isOpen==NO) {
        return;
    }
    if ([UTILITY.currentViewController respondsToSelector:@selector(handleKeyboardWillHide:)]) {
        return;
    }
    [UTILITY.currentViewController.view removeViewEvent];
    
    UIScrollView*scrollView=[self getCurrentScrollView];
    if (scrollView==nil) {
        return;
    }
    if (![[scrollView getAddValueForKey:@"keyBoadrdscrollViewH"] notEmptyOrNull]) {
        return ;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        //键盘收起后恢复现场 将scrollview 的高度恢复 到初始高度
        scrollView.frameHeight=[[scrollView getAddValueForKey:@"keyBoadrdscrollViewH"] floatValue];
        NSLog(@"%f",[[scrollView getAddValueForKey:@"keyBoadrdscrollViewH"] floatValue]);
        
    }];
}//
-(void)dealloc{
    // 销毁时候移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


/**
 获取 当前响应者的 需要滑动改变高度的 scrollView
 
 @return 当前响应者的scrollView
 */
-(UIScrollView*)getCurrentScrollView{
    //第一响应值 可能是textfield 或者textView
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIView   *firstRespondtf = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(firstResponder)];
    //    当前响应者的scrollView
    UIScrollView*sv;
    if (![firstRespondtf respondsToSelector:@selector(superview)]) {
        return nil;
    }
    UIView*spview=firstRespondtf.superview;
    for (int i=0; i<20; i++) {
        
        if (i==19) {
            break;
        }
        if ([spview isKindOfClass:[UIScrollView class]]) {
            sv=(UIScrollView*)spview;
            break;
        }
        spview=spview.superview;
        if (spview==nil) {
            break;
        }
        
    }
    //检查一下scrollview 的父控件层级里面是否有tableView
    UIView*tableView=[self getSuperViewWithSubView:sv WithClass:[UITableView class]];
    
    if (tableView) {
        return (UIScrollView*)tableView;
    }
    UIViewController*vc=[sv supViewController];
    if ([vc isKindOfClass:[BaseViewController class]]||vc==nil) {
        return sv;
    }
    
    
    return nil;
}

/**
 获取 指定类型的父控件
 
 @param subview 子控件
 @param supClass 父控件类型
 @return 指定类型的父控件 对象
 */
-(id)getSuperViewWithSubView:(UIView*)subview WithClass:(Class) supClass{
    
    UIView*spview=subview.superview;
    
    for (int i=0; i<20; i++) {
        if (i==19) {
            return nil;
        }
        if ([spview isKindOfClass:supClass]) {
            break;
        }
        if ([spview isKindOfClass:[UIWindow class]]) {
            return nil;
        }
        spview=spview.superview;
        if (spview==nil) {
            return  nil;
        }
        
    }
    return spview;
    
}

/**
 键盘弹起时候自动将scrollview 并 滑动到适当的位置
 
 @param scrollview 传入的父控件scrollview
 */
+(void)TFscrollview:(UIScrollView*)scrollview{
    
    //第一响应值 可能是textfield 或者textView
    UIView   *firstRespondtf = [scrollview performSelector:@selector(firstResponder)];
    // scrollview滑动位置
    CGFloat frameY;
    frameY=firstRespondtf.frameY;
    UIView*spview=firstRespondtf.superview;;
    for (int i=0; i<20; i++) {
        
        if (i==19) {
            return;
        }
        
        
        if ([spview isKindOfClass:[UIWindow class]]) {
            return;
        }
        if ([spview isEqual:scrollview]) {
            break;
        }else{
            
            if ([spview isKindOfClass:[UIScrollView class]]) {
                frameY=frameY+spview.frameY;
                
                UIScrollView*scroview=(UIScrollView*)spview;
                
                frameY=frameY-scroview.contentOffset.y;
                
            }else{
                frameY=frameY+spview.frameY;
            }
            
            
            
            spview=spview.superview;
            
        }
    }
    
    /*##################计算位置#####################*/
    
    if (firstRespondtf) {
        
        CGFloat h=frameY+30+50-scrollview.frameHeight;
        
        if ([scrollview isKindOfClass:[UITableView class]]) {
            h=frameY+30+50-scrollview.frameHeight;
        }
        h=h>0?h:0;
        scrollview.contentOffset=CGPointMake(scrollview.contentOffset.x,h);
    }
    
}


@end
