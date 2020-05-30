
#import "UIView+expanded.h"
#import <QuartzCore/QuartzCore.h>
#import "SDDataCache.h"
#import "NSString+expanded.h"
#import "UIImage+expanded.h"
#import "NetEngine.h"

#import "YLGIFImage.h"
#import "objc/runtime.h"


#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageCompat.h"
#import "WsUseweekObj.h"
#import "MYRHTableView.h"

static char btnBlock;

static char tapGsture;

static char setionObjxxx;
#define showProgressIndicator_width 250


@implementation UIView(Addition)
+(instancetype)getViewWithConfigData:(NSMutableDictionary*)cofigData{
    NSString*typeStr=[cofigData ojsk:@"classStr"];
    Class class=0x0;
    {
        class=NSClassFromString(typeStr);
    }
    if(class){
        UIView* cellView=nil;
        if ([cofigData objectForKey:@"frameX"]||[cofigData objectForKey:@"frameY"]||[cofigData objectForKey:@"frameWidth"]||[cofigData objectForKey:@"frameHeight"]) {
            cellView= [[class alloc]initWithFrame:CGRectMake([cofigData ojsk:@"frameX"].floatValue, [cofigData ojsk:@"frameY"].floatValue, [cofigData ojsk:@"frameWidth"].floatValue, [cofigData ojsk:@"frameHeight"].floatValue)];
        }else{
            cellView=[[class alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        
        cellView.data=cofigData;
        [cellView upDataMe];
        return cellView;
    }
    return nil;
}
#pragma mark  - 布局
- (void)setFrameX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setFrameY:(CGFloat)y
{
    CGRect frame = self.frame;
    
    if ([self isKindOfClass:[UILabel class]]&&[self getAddValueForKey:@"lablezhuanhuan"]) {
        y=y-2;
    }
    
    
    frame.origin.y = y;
    
    
    self.frame = frame;
}
- (CGFloat)frameX
{
    return self.frame.origin.x;
}
- (CGFloat)frameY
{
    
    if ([self isKindOfClass:[UILabel class]]&&[self getAddValueForKey:@"lablezhuanhuan"]) {
        return self.frame.origin.y+2;
    }
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setFrameWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setFrameHeight:(CGFloat)frameHeight
{
    CGRect frame = self.frame;
    frame.size.height = frameHeight;
    self.frame = frame;
}
- (CGFloat)frameHeight
{
    
    if ([self isKindOfClass:[UILabel class]]&&[self getAddValueForKey:@"lablezhuanhuan"]) {
        return self.frame.size.height-4;
    }
    
    return self.frame.size.height;
}
- (CGFloat)frameWidth
{
    return self.frame.size.width;
}
- (void)setFrameSize:(CGSize)frameSize
{
    CGRect frame = self.frame;
    frame.size = frameSize;
    self.frame = frame;
}
- (CGSize)frameSize
{
    return self.frame.size;
}
- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    CGRect frame = self.frame;
    frame.origin = frameOrigin;
    self.frame = frame;
}
- (CGPoint)frameOrigin
{
    return self.frame.origin;
}
-(void)setFrameXW:(CGFloat)frameXW{
    
    CGRect frame = self.frame;
    
    frame.origin.x = frameXW-frame.size.width;
    self.frame = frame;
}
-(CGFloat)frameXW{
    
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setFrameYH:(CGFloat)frameYH{
    CGRect frame = self.frame;
    
    
    
    if ([self isKindOfClass:[UILabel class]]&&[self getAddValueForKey:@"lablezhuanhuan"]) {
        frameYH=frameYH+2;
    }
    
    frame.origin.y = frameYH-frame.size.height;
    self.frame = frame;
    
}
-(CGFloat)frameYH{
    
    if ([self isKindOfClass:[UILabel class]]&&[self getAddValueForKey:@"lablezhuanhuan"]) {
        return  self.frame.origin.y+self.frame.size.height-2;
    }
    
    return self.frame.origin.y+self.frame.size.height;
}

-(void)setFrameBY:(CGFloat)frameBY{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.frame=CGRectMake(self.frame.origin.x, view.frameHeight-frameBY-self.frameSize.height, self.frame.size.width, self.frame.size.height);
    
}
-(CGFloat)frameBY{
    UIView *view=self.superview;
    if (view==nil) {
        return 0;
    }
    return view.frameHeight-self.frameSize.height-self.frameOrigin.y;
    
}
-(void)setFrameRX:(CGFloat)frameRX{
    
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.frame=CGRectMake(view.frame.size.width-frameRX-self.frameSize.width, self.frameOrigin.y, self.frame.size.width, self.frame.size.height);
    
    
}
-(CGFloat)frameRX{
    UIView *view=self.superview;
    if (view==nil) {
        return 0;
    }
    
    
    return view.frameWidth-self.frameOrigin.x-self.frameSize.width;
    
}
////////////////------------------------
-(void)beCenter{
    //    if
    
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.centerX=view.frame.size.width/2;
    self.centerY=view.frame.size.height/2;
    
}
-(void)beCX{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.centerX=view.frame.size.width/2;
    
    
}
-(void)beCY{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.centerY=view.frame.size.height/2;
    
}

-(void)beRound{
        self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frameHeight*0.5;
}

#pragma mark   - 事件
/**
 获取控件所在的控制器
 
 @return 控件当前页面的控制器
 */
- (UIViewController*)supViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



-(void)addViewClickBlock:(BtnCallBlock)block{
    
    self.btnCallBlock=block;
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton*btn=(UIButton*)self;
        //        self.
        [btn addTarget:self action:@selector(btnCallBlockClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return;
    }else{
        
        UITapGestureRecognizer *tap=[self btnCleckMeGesture];
        if (tap==nil) {
            tap  = [[UITapGestureRecognizer alloc] init];
            [self setBtnCleckMeGesture:tap];
            // 连续敲击2次,手势才能识别成功
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            // 2.添加手势识别器对象到对应的view
            
            [self addGestureRecognizer:tap];
        }
        //
        self.userInteractionEnabled=YES;
        // 3.添加监听方法(识别到了对应的手势,就会调用监听方法)
        [tap addTarget:self action:@selector(btnCallBlockClick:)];
    }
    
    
    
    
}
-(void)removeViewEvent{
    
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton*btn=(UIButton*)self;
        [btn removeTarget:self action:@selector(btnCallBlockClick:)  forControlEvents:UIControlEventTouchUpInside];
    }else{
        UITapGestureRecognizer *tap=[self btnCleckMeGesture];
        [self removeGestureRecognizer:tap];
        [self setBtnCleckMeGesture:nil];
    }
}
-(void)btnCallBlockClick:(id)btn{
    
    if (self.btnCallBlock) {
        self.btnCallBlock(self);
    }
}
#pragma mark  - 运行时添加属性

-(void)setBtnCleckMeGesture:(UITapGestureRecognizer*)btnCleckMeGesture{
    objc_setAssociatedObject(self, &tapGsture, btnCleckMeGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UITapGestureRecognizer*)btnCleckMeGesture{
    return objc_getAssociatedObject(self, &tapGsture);
}


-(void)setBtnCallBlock:(BtnCallBlock)btnCallBlock{
    objc_setAssociatedObject(self, &btnBlock, btnCallBlock, OBJC_ASSOCIATION_COPY);
}
-(BtnCallBlock)btnCallBlock{
    return objc_getAssociatedObject(self, &btnBlock);
}
-(void)addViewTarget:(id)obj select:(SEL)selctor{
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton*btn=(UIButton*)self;
        [btn addTarget:obj action:selctor forControlEvents:UIControlEventTouchUpInside];
        return;
    }else{
        __weak __typeof(obj) weakobj = obj;
        [self addViewClickBlock:^(UIView *view) {
            [weakobj performSelector:selctor withObject:view];
        }];
    }
}
-(void)viewClickMe{
    if ([self isKindOfClass:[UIButton class]]) {
        
        [(UIButton*)self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }else{
        if (self.btnCallBlock) {
            self.btnCallBlock(self);
        }
    }
}
#pragma mark image/button 设置图片
-(void)imageWithURL:(NSString *)url
{
    return [self imageWithURL:url useProgress:NO useActivity:NO defaultImage:@"load_image"];
}

-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity
{
    [self imageWithURL:url useProgress:useProgress useActivity:useActivity defaultImage:W(self)<60?@"load_image":@"load_image"];
}
-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity defaultImage:(NSString *)strImage
{
    [self imageWithURL:url useProgress:useProgress useActivity:useActivity defaultImage:strImage showGifImage:NO];
}

-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity defaultImage:(NSString *)strImage showGifImage:(BOOL)showGif{
    if ([MYRHTableView isRefreshOnlySize]) {
        return;
    }
    NSString *urlImage =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
    if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imgView = (UIImageView *)self;
        UIView *tempView = nil;
        if (useProgress) {
            CGFloat width = self.frame.size.width *0.8;
            CGFloat fX = (self.frame.size.width - width)/2.0;
            CGFloat fY = self.frame.size.height/2.0 - 10;
            UIProgressView *progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(fX, fY, width, 20)];
            [progressIndicator setProgressViewStyle:UIProgressViewStyleBar];
            //            [progressIndicator setProgressTintColor:[UIColor grayColor]];
            [progressIndicator setProgressTintColor:rgbpublicColor];
            [progressIndicator setTrackTintColor:[UIColor grayColor]];
            tempView = progressIndicator;
            
            [self addSubview:tempView];
            
            progressIndicator.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        }
        else if (useActivity)
        {
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [activityIndicatorView setCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)];
            [activityIndicatorView startAnimating];
            tempView = activityIndicatorView;
            
            activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            
            [self addSubview:tempView];
        }
        __weak UIProgressView *progressIndicator;
        if (useProgress) {
            progressIndicator= (UIProgressView *)tempView;
        }
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:urlImage] placeholderImage:[strImage notEmptyOrNull]?[UIImage imageNamed:strImage]:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            float currentProgress = (float)receivedSize/(expectedSize*1.0);
            if (useProgress) {
                //                DLog(@"进currentProgress:%f",currentProgress);
                dispatch_main_async_safe(^{
                    [progressIndicator setProgress:currentProgress];
                });
            }
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (tempView) {
                [tempView removeFromSuperview];
            }
        }];
    }else if ([self isKindOfClass:[UIButton class]]){
        UIButton *BtnView = (UIButton *)self;
        [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:urlImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        }completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [BtnView setImage:image forState:UIControlStateNormal];
        } ];
    }
    
}

-(void)imageWithCacheUrl:(NSString *)url{
    if ([self isKindOfClass:[UIImageView class]]) {
        NSString *urlImage =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        UIImageView *imgView = (UIImageView *)self;
        NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:urlImage]];
        if (cacheImageKey.length) {
            NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
            if (cacheImagePath.length && [[NSFileManager defaultManager] fileExistsAtPath:cacheImagePath]) {
                imgView.image = [UIImage imageWithContentsOfFile:cacheImagePath];//[NSData dataWithContentsOfFile:cacheImagePath];
            }
        }
        
    }
}
-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress useActivity:(BOOL)useActivity defaultImageData:(UIImage *)aImage{
    
    NSString *urlImage =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
    if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imgView = (UIImageView *)self;
        UIView *tempView = nil;
        if (useProgress) {
            CGFloat width = self.frame.size.width *0.8;
            CGFloat fX = (self.frame.size.width - width)/2.0;
            CGFloat fY = self.frame.size.height/2.0 - 10;
            UIProgressView *progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(fX, fY, width, 20)];
            [progressIndicator setProgressViewStyle:UIProgressViewStyleBar];
            //            [progressIndicator setProgressTintColor:[UIColor grayColor]];
            [progressIndicator setProgressTintColor:rgbpublicColor];
            [progressIndicator setTrackTintColor:[UIColor grayColor]];
            tempView = progressIndicator;
            
            [self addSubview:tempView];
            
            progressIndicator.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        }
        else if (useActivity)
        {
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [activityIndicatorView setCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)];
            [activityIndicatorView startAnimating];
            tempView = activityIndicatorView;
            
            activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            
            [self addSubview:tempView];
        }
        
        __weak UIProgressView *progressIndicator;
        if (useProgress) {
            progressIndicator= (UIProgressView *)tempView;
        }
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:urlImage] placeholderImage:aImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            float currentProgress = (float)receivedSize/(expectedSize*1.0);
            
            if (useProgress) {
                //                DLog(@"进度：currentProgress:%f",currentProgress);
                dispatch_main_async_safe(^{
                    [progressIndicator setProgress:currentProgress];
                });
            }
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (tempView) {
                [tempView removeFromSuperview];
            }
        }];
        
        
    }else if ([self isKindOfClass:[UIButton class]]){
        UIButton *BtnView = (UIButton *)self;
        [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:urlImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        }completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [BtnView setImage:image forState:UIControlStateNormal];
        } ];
    }
}
/// 动画(缩放) 用于点赞等-----选中
-(void)showAnimationSelected{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@0.6,@1.5 ,@0.8, @1.0,@1.2,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}
///动画(缩放) 用于点赞等-----取消
-(void)showAnimationCancelSelected{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@0.8, @1.1,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

///圆角
-(void)viewLayerRoundBorderWidth:(float)width borderColor:(UIColor *)color{
    [self viewLayerRoundBorderWidth:width cornerRadius:H(self)/ 2.0 borderColor:color];
}
///圆角或椭圆
-(void)viewLayerRoundBorderWidth:(float)width cornerRadius:(float)radius borderColor:(UIColor *)color{
    // 必須加上這一行，這樣圓角才會加在圖片的「外側」
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius =radius;
    //边框
    self.layer.borderWidth=width;
    if (color) {
        self.layer.borderColor =[color CGColor];
    }
}

///view 上添加线条
-(void)addLineLayerWhitframe:(CGRect)_frame whitColor:(UIColor *)_color{
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = _frame;
    TopBorder.backgroundColor = _color.CGColor;
    [self.layer addSublayer:TopBorder];
}

-(SectionObj *)sectionObj{
    WsUseweekObj*aaobj= objc_getAssociatedObject(self, &setionObjxxx);
    if (aaobj.sectionObj==nil) {
        UIView*sview=self.superview;
        for (int i=0; i<6; i++) {
            aaobj= objc_getAssociatedObject(sview, &setionObjxxx);
            if (aaobj.sectionObj) {
                return aaobj.sectionObj;
            }
            sview=sview.superview;
        }
    }
    return aaobj.sectionObj;
}

-(void)setSectionObj:(SectionObj *)sectionObj{
    WsUseweekObj*aaobj=objc_getAssociatedObject(self, &setionObjxxx);
    if (aaobj==nil) {
        aaobj=[WsUseweekObj new];
        objc_setAssociatedObject(self, &setionObjxxx, aaobj, OBJC_ASSOCIATION_RETAIN);
    }
    aaobj.sectionObj=sectionObj;
}
-(int)index_row{
    
    WsUseweekObj*aaobj= objc_getAssociatedObject(self, &setionObjxxx);
    if (aaobj.sectionObj==nil) {
        UIView*sview=self.superview;
        for (int i=0; i<6; i++) {
            aaobj= objc_getAssociatedObject(sview, &setionObjxxx);
            if (aaobj.sectionObj) {
                return aaobj.sectionrow;
            }
            sview=sview.superview;
        }
    }
    if (aaobj.sectionObj==nil) {
        return -1;
    }
    return aaobj.sectionrow;
}
-(void)setIndex_row:(int )index_row{
    WsUseweekObj*aaobj=objc_getAssociatedObject(self, &setionObjxxx);
    if (aaobj==nil) {
        aaobj=[WsUseweekObj new];
        objc_setAssociatedObject(self, &setionObjxxx, aaobj, OBJC_ASSOCIATION_RETAIN);
    }
    aaobj.sectionrow=index_row;
}

-(NSIndexPath *)indexPath{
    WsUseweekObj*aaobj= objc_getAssociatedObject(self, &setionObjxxx);
    if (aaobj.sectionObj==nil) {
        UIView*sview=self.superview;
        for (int i=0; i<6; i++) {
            aaobj= objc_getAssociatedObject(sview, &setionObjxxx);
            if (aaobj.sectionObj) {
                return aaobj.indexPath;
            }
            sview=sview.superview;
        }
    }
    if (aaobj.sectionObj==nil) {
        return nil;
    }
    return aaobj.indexPath;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    WsUseweekObj*aaobj=objc_getAssociatedObject(self, &setionObjxxx);
    if (aaobj==nil) {
        aaobj=[WsUseweekObj new];
        objc_setAssociatedObject(self, &setionObjxxx, aaobj, OBJC_ASSOCIATION_RETAIN);
    }
    aaobj.indexPath=indexPath;
}

#pragma mark  添加创建方法
+(instancetype)viewWithFrame:(CGRect) frame backgroundcolor:(UIColor *)color superView:(UIView *)view{
    return   [self viewWithFrame:frame backgroundcolor:color superView:view reuseId:nil];
}
+(instancetype)viewWithFrame:(CGRect) frame backgroundcolor:(UIColor *)color superView:(UIView *)view  reuseId:(NSString*)reuseID{
    if ([view getAddValueForKey:reuseID]) {
        UIView*lineView=[view getAddValueForKey:reuseID];
        lineView.frameX=frame.origin.x;
        lineView.frameY=frame.origin.y;
        if (frame.size.width==0) {
        }else{
            lineView.frameWidth=frame.size.width;
        }
        if (frame.size.height==0) {
        }else{
            lineView.frameHeight=frame.size.height;
        }
        return lineView;
    }else{
        UIView*lineView=[[self alloc]initWithFrame:frame];
        //        lineView.frame=aframe;
        if (color) {
            
            lineView.backgroundColor=color;
        }
        [view addSubview:lineView];
        if (reuseID) {
            [view setAddValue:lineView forKey:reuseID];
        }
        return lineView;
    }
}
@end
