//
//  XHImageViewer.m
//  XHImageViewer
//
//  Created by
//  Copyright (c) All rights reserved.
//

#import "XHImageViewer.h"
#import "XHViewState.h"
#import "XHZoomingImageView.h"

@interface XHImageViewer ()<UIScrollViewDelegate,UIAlertViewDelegate>{
    
    
    
    UIPanGestureRecognizer *pan;
}
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, strong) UILabel *lblNum_index;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *ViewNavGB;
@property (nonatomic, strong) NSArray *imgViews;

@end

@implementation XHImageViewer

- (id)init {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self _setup];
    }
    return self;
}
-(void)setHiddenDeleteButton:(BOOL)hiddenDeleteButton{
    if (_hiddenDeleteButton!=hiddenDeleteButton) {
        _hiddenDeleteButton=hiddenDeleteButton;
        
        if (self.btnDelete) {
            self.btnDelete.hidden=_hiddenDeleteButton;
        }
    }
    
}
-(void)setHiddenNumIndex:(BOOL)hiddenNumIndex{
    if (_hiddenNumIndex!=hiddenNumIndex) {
        _hiddenNumIndex=hiddenNumIndex;
        if (self.lblNum_index) {
            self.lblNum_index.hidden=_hiddenNumIndex;
        }
    }
}
- (void)_setup {
    self.hiddenDeleteButton=YES;//默认不显示
    self.hiddenNumIndex=NO;///默认显示
    
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    self.backgroundScale = 0.95;
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    pan.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
    self.selectIndexArray=[[NSMutableArray alloc]init];
    
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)setImageViewsFromArray:(NSArray*)views {
    NSMutableArray *imgViews = [NSMutableArray array];
    for(id obj in views){
        if([obj isKindOfClass:[UIImageView class]]){
            [imgViews addObject:obj];
            
            UIImageView *view = obj;
            
            XHViewState *state = [XHViewState viewStateForView:view];
            [state setStateWithView:view];
            
            view.userInteractionEnabled = NO;
        }
    }
    self.imgViews = [imgViews copy];
}

- (void)showWithImageViews:(NSArray*)views selectedView:(UIImageView*)selectedView {
    [self setImageViewsFromArray:views];
    
    if(self.imgViews.count > 0){
        if(![selectedView isKindOfClass:[UIImageView class]] || ![self.imgViews containsObject:selectedView]){
            selectedView = self.imgViews[0];
        }
        [self showWithSelectedView:selectedView];
    }
}
#pragma mark button
-(void)selectImageView{
    NSString *strIndex=[NSString stringWithFormat:@"%ld",(long)_selectIndex];
    if ([self.selectIndexArray containsObject:strIndex]) {
        [self.selectIndexArray removeObject:strIndex];
    }else{
        [self.selectIndexArray addObject:strIndex];
    }
    self.btnDelete.selected=[self.selectIndexArray containsObject:strIndex];
    
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.scrollView) {
        
        CGFloat pageWidth = scrollView.frame.size.width;
        _selectIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        [self setNumValue:[NSString stringWithFormat:@"%ld/%lu",_selectIndex+1,(unsigned long)[self.imgViews count]]];
        //        self.lblNum_index.text=[NSString stringWithFormat:@"%ld/%lu",selectIndex+1,(unsigned long)[self.imgViews count]];
        
        NSString *strIndex=[NSString stringWithFormat:@"%ld",(long)_selectIndex];
        self.btnDelete.selected=[self.selectIndexArray containsObject:strIndex];
        
        
        
    }
}
#pragma mark- Properties

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[backgroundColor colorWithAlphaComponent:0]];
}

- (NSInteger)pageIndex {
    return (self.scrollView.contentOffset.x / self.scrollView.frame.size.width + 0.5);
}

#pragma mark- View management

- (UIImageView *)currentView {
    return [self.imgViews objectAtIndex:self.pageIndex];
}

- (void)showWithSelectedView:(UIImageView*)selectedView {
    for(UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    [self.selectIndexArray removeAllObjects];
    for (int i=0; i<[self.imgViews count]; i++) {
        [self.selectIndexArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    const NSInteger currentPage = [self.imgViews indexOfObject:selectedView];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    if (!kVersion7) {
        window.frame=[UIScreen mainScreen].applicationFrame;
    }
    if(self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator   = NO;
        self.scrollView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:1];
        self.scrollView.alpha = 0;
        [self.scrollView setDelegate:self];
        [self addSubview:self.scrollView];
    }
    
    if (!self.btnDelete) {
        self.btnDelete=[RHMethods buttonWithFrame:CGRectMake(kScreenWidth-50,kVersion7?20:0, 50, 44) title:@"" image:@"ImageBrowser" bgimage:@""];
        [self.btnDelete addTarget:self action:@selector(selectImageView) forControlEvents:UIControlEventTouchUpInside];
        [self.btnDelete setImage:[UIImage imageNamed:@"ImageBrowserChecked"] forState:UIControlStateSelected];
        [self addSubview:self.btnDelete];
    }
    self.btnDelete.selected=YES;
    self.btnDelete.hidden=self.hiddenDeleteButton;
    //    pan.enabled=NO;//当可以编辑的时候禁止拖动
    
    if (!self.lblNum_index) {
        self.lblNum_index=[RHMethods labelWithFrame:CGRectMake(20, YH(self.scrollView)-(kVersion7?40:60), W(self.scrollView)-40, 40) font:fontTitle color:[UIColor whiteColor] text:@"" textAlignment:NSTextAlignmentRight];
        [self addSubview:self.lblNum_index];
    }
    self.lblNum_index.hidden=_hiddenNumIndex;
    _selectIndex=[self.imgViews indexOfObject:selectedView];
    //    self.lblNum_index.text=[NSString stringWithFormat:@"%ld/%lu",(long)selectIndex+1,(unsigned long)[self.imgViews count]];
    [self setNumValue:[NSString stringWithFormat:@"%ld/%lu",(long)_selectIndex+1,(unsigned long)[self.imgViews count]]];
    
    //    if (!_ViewNavGB) {
    //        _ViewNavGB=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    //        [_ViewNavGB setBackgroundColor:RGBACOLOR(255, 255, 255, 0.5)];
    //    }
    //    [self addSubview:_ViewNavGB];
    
    [window addSubview:self];
    
    const CGFloat fullW = window.frame.size.width;
    const CGFloat fullH = window.frame.size.height;
    
    selectedView.frame = [window convertRect:selectedView.frame fromView:selectedView.superview];
    if (!kVersion7) {
        selectedView.frame = CGRectMake(X(selectedView), Y(selectedView)-20, W(selectedView), H(selectedView));
    }
    [window addSubview:selectedView];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         //     _ViewNavGB.alpha=1;
                         self.lblNum_index.alpha=1;
                         self.btnDelete.alpha=1;
                         self.scrollView.alpha = 1;
                         window.rootViewController.view.transform = CGAffineTransformMakeScale(self.backgroundScale, self.backgroundScale);
                         
                         selectedView.transform = CGAffineTransformIdentity;
                         
                         CGSize size = (selectedView.image) ? selectedView.image.size : selectedView.frame.size;
                         CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
                         CGFloat W = ratio * size.width;
                         CGFloat H = ratio * size.height;
                         selectedView.frame = CGRectMake((fullW-W)/2, (fullH-H)/2, W, H);
                     }
                     completion:^(BOOL finished) {
                         self.scrollView.contentSize = CGSizeMake(self.imgViews.count * fullW, 0);
                         self.scrollView.contentOffset = CGPointMake(currentPage * fullW, 0);
                         
                         UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScrollView:)];
                         [self.scrollView addGestureRecognizer:gesture];
                         
                         
                         
                         
                         for(UIImageView *view in self.imgViews){
                             view.transform = CGAffineTransformIdentity;
                             
                             CGSize size = (view.image) ? view.image.size : view.frame.size;
                             CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
                             CGFloat W = ratio * size.width;
                             CGFloat H = ratio * size.height;
                             view.frame = CGRectMake((fullW-W)/2, (fullH-H)/2, W, H);
                             
                             XHZoomingImageView *tmp = [[XHZoomingImageView alloc] initWithFrame:CGRectMake([self.imgViews indexOfObject:view] * fullW, 0, fullW, fullH)];
                             tmp.imageView = (YLImageView*)view;
                             
                             
                             UITapGestureRecognizer *tapTwo=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topTwo:)];
                             [tapTwo setNumberOfTapsRequired:2];
                             [tmp addGestureRecognizer:tapTwo];
                             
                             [gesture requireGestureRecognizerToFail:tapTwo];
                             
                             [self.scrollView addSubview:tmp];
                         }
                     }
     ];
}

-(void)setNumValue:(NSString *)strTitle{
    //    self.lblNum_index.text=strTitle;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    
    //    NSDictionary *dict=@{NSFontAttributeName : DR_BoldFONT(16),
    //                         NSParagraphStyleAttributeName : paragraph,
    //                         NSForegroundColorAttributeName : [UIColor whiteColor],
    //                         NSStrokeWidthAttributeName : @-3,
    //                         NSStrokeColorAttributeName : RGBACOLOR(50, 50, 50, 0.8)};
    
    NSShadow *shadow=[[NSShadow alloc] init];
    shadow.shadowBlurRadius=5;//模糊度
    shadow.shadowColor=[UIColor blackColor];
    shadow.shadowOffset=CGSizeMake(1, 3);
    NSDictionary *dict=@{NSFontAttributeName : DR_BoldFONT(16),
                         NSParagraphStyleAttributeName : paragraph,
                         NSForegroundColorAttributeName : [UIColor whiteColor],
                         NSShadowAttributeName : shadow,
                         NSVerticalGlyphFormAttributeName : @(0)};
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strTitle attributes:dict];
    self.lblNum_index.attributedText=attributedString;
    
    
}
- (void)prepareToDismiss {
    UIImageView *currentView = [self currentView];
    
    if([self.delegate respondsToSelector:@selector(imageViewer:willDismissWithSelectedView:)]) {
        [self.delegate imageViewer:self willDismissWithSelectedView:currentView];
    }
    
    for(UIImageView *view in self.imgViews) {
        if(view != currentView ) {//&& self.hiddenDeleteButton
            XHViewState *state = [XHViewState viewStateForView:view];
            view.transform = CGAffineTransformIdentity;
            view.frame = state.frame;
            view.transform = state.transform;
            [state.superview addSubview:view];
        }
    }
}

- (void)dismissWithAnimate {
    UIImageView *currentView = [self currentView];
    NSInteger index=[self.imgViews indexOfObject:currentView];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect rct = currentView.frame;
    currentView.transform = CGAffineTransformIdentity;
    currentView.frame = [window convertRect:rct fromView:currentView.superview];
    [window addSubview:currentView];
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         //  _ViewNavGB.alpha=0;
                         self.btnDelete.alpha=0;
                         self.lblNum_index.alpha=0;
                         self.scrollView.alpha = 0;
                         window.rootViewController.view.transform =  CGAffineTransformIdentity;
                         if (self.hiddenDeleteButton || [self.selectIndexArray containsObject:[NSString stringWithFormat:@"%ld",index]]) {
                             XHViewState *state = [XHViewState viewStateForView:currentView];
                             currentView.frame = [window convertRect:state.frame fromView:state.superview];
                             currentView.transform = state.transform;
                         }else{
                             currentView.alpha=0.0;
                             currentView.transform = CGAffineTransformScale(currentView.transform, 2.0,2.0);
                         }
                         
                     }
                     completion:^(BOOL finished) {
                         
                         if (self.hiddenDeleteButton|| [self.selectIndexArray containsObject:[NSString stringWithFormat:@"%ld",index]]) {
                             XHViewState *state = [XHViewState viewStateForView:currentView];
                             currentView.transform = CGAffineTransformIdentity;
                             currentView.frame = state.frame;
                             currentView.transform = state.transform;
                             [state.superview addSubview:currentView];
                         }else{
                             [currentView removeFromSuperview];
                         }
                         for(UIView *view in self.imgViews){
                             XHViewState *_state = [XHViewState viewStateForView:view];
                             view.userInteractionEnabled = _state.userInteratctionEnabled;
                         }
                         
                         if (!self.hiddenDeleteButton) {
                             if([self.delegate respondsToSelector:@selector(imageViewer:deleteImageView:withArray:)]) {
                                 NSMutableArray *arrayT=[[NSMutableArray alloc]init];
                                 for (NSString *strIndex in self.selectIndexArray) {
                                     [arrayT addObject:[self.imgViews objectAtIndex:[strIndex integerValue]]];
                                 }
                                 
                                 [self.delegate imageViewer:self deleteImageView:arrayT withArray:self.selectIndexArray];
                             }
                         }
                         if([self.delegate respondsToSelector:@selector(imageViewer:endDismissWithSelectedView:)]) {
                             [self.delegate imageViewer:self endDismissWithSelectedView:currentView];
                         }
                         
                         
                         if (!kVersion7) {
                             window.frame=[UIScreen mainScreen].bounds;
                         }
                         [self removeFromSuperview];
                     }
     ];
}

#pragma mark- Gesture events

- (void)tappedScrollView:(UITapGestureRecognizer*)sender
{
    [self prepareToDismiss];
    [self dismissWithAnimate];
}

- (void)didPan:(UIPanGestureRecognizer*)sender
{
    //当可以编辑的时候不执行拖动效果
    if (self.hiddenDeleteButton) {
        
        
        static UIImageView *currentView = nil;
        
        if(sender.state == UIGestureRecognizerStateBegan){
            currentView = [self currentView];
            
            UIView *targetView = currentView.superview;
            while(![targetView isKindOfClass:[XHZoomingImageView class]]){
                targetView = targetView.superview;
            }
            
            if(((XHZoomingImageView *)targetView).isViewing){
                currentView = nil;
            }
            else{
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                currentView.frame = [window convertRect:currentView.frame fromView:currentView.superview];
                [window addSubview:currentView];
                
                [self prepareToDismiss];
            }
        }
        
        if(currentView){
            if(sender.state == UIGestureRecognizerStateEnded){
                if(self.scrollView.alpha>0.5){
                    [self showWithSelectedView:currentView];
                }
                else{
                    [self dismissWithAnimate];
                }
                currentView = nil;
            }
            else{
                CGPoint p = [sender translationInView:self];
                
                CGAffineTransform transform = CGAffineTransformMakeTranslation(0, p.y);
                transform = CGAffineTransformScale(transform, 1 - fabs(p.y)/1000, 1 - fabs(p.y)/1000);
                currentView.transform = transform;
                
                CGFloat r = 1-fabs(p.y)/200;
                self.scrollView.alpha = MAX(0, MIN(1, r));
                //  _ViewNavGB.alpha= MAX(0, MIN(1, r));
                self.lblNum_index.alpha= MAX(0, MIN(1, r));
                self.btnDelete.alpha= MAX(0, MIN(1, r));
            }
        }
    }
}

-(void)topTwo:(UITapGestureRecognizer *)tap{
    XHZoomingImageView *viewT=(XHZoomingImageView *)tap.view;
    
    CGFloat zs = viewT.scrollView.zoomScale;
    zs = (zs == 1.0) ? 2.0 : 1.0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    viewT.scrollView.zoomScale = zs;
    [UIView commitAnimations];
}
@end
