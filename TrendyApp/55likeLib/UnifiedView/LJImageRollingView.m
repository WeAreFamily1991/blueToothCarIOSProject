//
//  LJImageRollingView.m
//  JiuSheng55like
//
//  Created by junseek on 2016/11/8.
//  Copyright © 2016年 55like lj. All rights reserved.
//

#import "LJImageRollingView.h"

@interface LJImageRollingView ()<UIScrollViewDelegate>
{
    BOOL boolStopAnimation;
    UIScrollView *scrollviewBG;
    NSArray * imageNameList;
    UIPageControl *_pageControl;
    
    NSMutableArray *arrayImageViews;
    
    NSInteger currentImageIndex;
    NSInteger imageCount;
}
@property(nonatomic,strong)UILabel*numberLabel;


@end
@implementation LJImageRollingView

-(void)dealloc{
    RemoveNofify
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        arrayImageViews=[NSMutableArray new];
        RegisterNotify(UIApplicationDidEnterBackgroundNotification, @selector(enterBackGroundNotication))
        RegisterNotify(UIApplicationWillEnterForegroundNotification, @selector(enterForegroundNotification))
        
        scrollviewBG = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollviewBG.delegate = self;
        scrollviewBG.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        scrollviewBG.showsHorizontalScrollIndicator = NO;
        scrollviewBG.contentOffset = CGPointMake(self.bounds.size.width, 0);
        scrollviewBG.pagingEnabled = YES;
        [self addSubview:scrollviewBG];
        //        [scrollviewBG setBackgroundColor:[UIColor greenColor]];
        [scrollviewBG setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 20;
        rect.size.height = 10;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
        //        _pageControl.currentPageIndicatorTintColor = rgbpublicColor;
        //        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //        _pageControl.hidden=YES;
        
        [self addSubview:_pageControl];
        boolStopAnimation=NO;
        
    }
    return self;
}

-(void)updataNumberLabel{
    if (_pageControl.hidden==NO) {
        return;
    }
    
    if (_numberLabel==nil) {
        UILabel*lbContent=[RHMethods ClableY:0 W:0 Height:20 font:13 superview:self withColor:rgb(255, 255, 255) text:@"3/5"];
        [lbContent beRound];
        lbContent.backgroundColor=RGBACOLOR(0, 0, 0, 0.5);
        _numberLabel=lbContent;
    }
    _numberLabel.text=[NSString stringWithFormat:@"%ld/%ld",_pageControl.currentPage+1,_pageControl.numberOfPages];
    _numberLabel.frameWidth=[_numberLabel.text widthWithFont:13]+16;
    _numberLabel.frameBY=10;
    _numberLabel.frameRX=15;
}

/*
 images@[@{
 (UIImage *)DefaultImage   //默认图片（有数据时候优先显示）
 (NSString *)url           //大图路径
 (id)data           //其他数据
 }]
 */
-(void)reloadImageView:(NSArray *)images selectIndex:(NSInteger )sIndex{
    if ([images count]==0) {
        return;
    }
    imageNameList=images;
    if (sIndex>=[images count]) {
        sIndex=0;
    }
    for (UIView *viewT in [scrollviewBG subviews]) {
        [viewT removeFromSuperview];
    }
    {
        NSInteger i=[images count]-1;
        NSDictionary *dic=images[i];
        UIImageView *imageT=[RHMethods imageviewWithFrame:CGRectMake(0, 0, W(scrollviewBG), H(scrollviewBG)) defaultimage:@"loadImageBG"];
        [imageT setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [imageT setUserInteractionEnabled:YES];
        imageT.tag=i;
        //        imageT.backgroundColor=[UIColor redColor];
        [scrollviewBG addSubview:imageT];
        if ([dic objectForJSONKey:@"DefaultImage"]) {
            imageT.image=[dic objectForJSONKey:@"DefaultImage"];
        }else{
            [imageT imageWithURL:[dic valueForJSONStrKey:@"url"] useProgress:NO useActivity:NO];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageClicked:)];
        [imageT addGestureRecognizer:tap];
        
        [arrayImageViews addObject:imageT];
    }
    for (int i=0; i<images.count; i++) {
        NSDictionary *dic=images[i];
        UIImageView *imageT=[RHMethods imageviewWithFrame:CGRectMake((i+1)*W(scrollviewBG), 0, W(scrollviewBG), H(scrollviewBG)) defaultimage:@"loadImageBG"];
        [imageT setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [imageT setUserInteractionEnabled:YES];
        imageT.tag=i;
        //        imageT.backgroundColor=[UIColor redColor];
        [scrollviewBG addSubview:imageT];
        if ([dic objectForJSONKey:@"DefaultImage"]) {
            imageT.image=[dic objectForJSONKey:@"DefaultImage"];
        }else{
            [imageT imageWithURL:[dic valueForJSONStrKey:@"url"] useProgress:NO useActivity:NO];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageClicked:)];
        [imageT addGestureRecognizer:tap];
        
        [arrayImageViews addObject:imageT];
    }
    {
        NSInteger i=0;
        NSDictionary *dic=images[i];
        UIImageView *imageT=[RHMethods imageviewWithFrame:CGRectMake(([images count]+1)*W(scrollviewBG), 0, W(scrollviewBG), H(scrollviewBG)) defaultimage:@"loadImageBG"];
        [imageT setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [imageT setUserInteractionEnabled:YES];
        imageT.tag=i;
        //        imageT.backgroundColor=[UIColor redColor];
        [scrollviewBG addSubview:imageT];
        if ([dic objectForJSONKey:@"DefaultImage"]) {
            imageT.image=[dic objectForJSONKey:@"DefaultImage"];
        }else{
            [imageT imageWithURL:[dic valueForJSONStrKey:@"url"] useProgress:NO useActivity:NO];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageClicked:)];
        [imageT addGestureRecognizer:tap];
        
        [arrayImageViews addObject:imageT];
    }
    
    
    [scrollviewBG setContentSize:CGSizeMake((arrayImageViews.count)*W(scrollviewBG), H(scrollviewBG)-1)];
    imageCount= [images count];
    currentImageIndex=sIndex;
    _pageControl.numberOfPages =imageCount;
    [scrollviewBG setContentOffset:CGPointMake((currentImageIndex+1)*W(scrollviewBG), 0)];
    _pageControl.currentPage = currentImageIndex;
    
    [self startAnimation];
    
    [self updataNumberLabel];
}
#pragma mark UIScrollView
//- (void) scrollViewDidScroll: (UIScrollView*) scrollview{
//    CGFloat imageW = scrollviewBG.frame.size.width;
//    CGFloat currentOffsetX = scrollviewBG.contentOffset.x;
//    int currentPage = (int) (currentOffsetX+imageW*0.5)/imageW;
//    _pageControl.currentPage = currentPage;
//}

- (void) scrollViewWillBeginDragging: (UIScrollView*) scrollview{
    //当用户准备拖曳时停止定时器,以后重启需重新启动,不会自动启动
    [self stopAnimation];
}

- (void) scrollViewDidEndDragging: (UIScrollView*) scrollview willDecelerate:(BOOL)decelerate{
    //当用户停止拖曳时,定时器重启,自动轮播开始
    [self startAnimation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self reloadImage];
}

- (void)reloadImage {
    
    CGFloat imageW = scrollviewBG.frame.size.width;
    CGFloat currentOffsetX = scrollviewBG.contentOffset.x;
    //    int currentPage = (int) (currentOffsetX+imageW*0.5)/imageW;
    currentImageIndex=(currentOffsetX-imageW)/imageW;
    //    DLog(@"currentOffsetX:%f",currentOffsetX);
    if (currentOffsetX >= (imageCount +1)*imageW) { //第一个
        currentImageIndex = 0;
        [scrollviewBG setContentOffset:CGPointMake((currentImageIndex+1)*imageW, 0)];
    } else if (currentOffsetX < imageW ) {//最后一个
        currentImageIndex =  imageCount-1;
        [scrollviewBG setContentOffset:CGPointMake((currentImageIndex+1)*imageW, 0)];
    }
    
    _pageControl.currentPage = currentImageIndex;
    [self updataNumberLabel];
}

#pragma autoPlay
- (void)switchFocusImageItems
{
    //    DLog(@"___滚动中___");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = scrollviewBG.contentOffset.x + scrollviewBG.frame.size.width;
    
    [self moveToTargetPosition:targetX];
    if ([imageNameList count]>1) {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:5.0];
    }
    
}
- (void)moveToTargetPosition:(CGFloat)targetX
{
    if (targetX > scrollviewBG.contentSize.width-scrollviewBG.frame.size.width) {
        targetX = 0.0;
    }
    [scrollviewBG setContentOffset:CGPointMake(targetX, 0) animated:targetX==0?NO:YES] ;
    int page= (int)(scrollviewBG.contentOffset.x / scrollviewBG.frame.size.width);
    _pageControl.currentPage = page;
}

#pragma mark notification
-(void)enterBackGroundNotication{
    //后台-停止
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
}
-(void)enterForegroundNotification{
    //前台-开启
    if (!boolStopAnimation) {
        [self startAnimation];
    }
}
#pragma mark cliked
-(void)tapImageClicked:(UITapGestureRecognizer *)tap{
    NSDictionary *dic=[imageNameList objectAtIndex:currentImageIndex];
    if ([self.delegateDiscount respondsToSelector:@selector(selectView:ad:index:)]) {
        [self.delegateDiscount selectView:self ad:[dic objectForJSONKey:@"data"] index:currentImageIndex];
    }
}



-(void)startAnimation{
    boolStopAnimation=NO;
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:5.0];
}
-(void)stopAnimation{
    boolStopAnimation=YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
