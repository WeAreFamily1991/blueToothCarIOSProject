//
//  MYViewBase.m
//  jinYingWu
//
//  Created by 55like on 2017/11/4.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "MYViewBase.h"
@interface MYViewBase()


#pragma mark  - 初始化 绑定数据


#pragma mark  - 事件交互

/**
 点击交互事件的对象
 */
@property(nonatomic,weak)id eventTargetObj;
@property(nonatomic,assign)SEL eventAselector;

#pragma mark  - 类方法 创建方法
@end
@implementation MYViewBase

#pragma mark  - 初始化 绑定数据
- (instancetype)init
{
    self = [super init];
    if (self) {
        //        [UTILITY addTAbleview:self];
        _isRefresh=NO;
        _isfirstInit=YES;
        [self initOrReframeView];
        _isfirstInit=NO;
        //        self.layer.borderColor=[[UIColor redColor] CGColor];
        //        self.layer.borderWidth=0.5;
    }
    
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    NSLog(@"xib xib %@",NSStringFromClass([self class]));
    
    
}

- (instancetype)initWithType:(NSString*)type WithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [UTILITY addTAbleview:self];
        _isRefresh=NO;
        _type=type;
        _isfirstInit=YES;
        [self initOrReframeView];
        _isfirstInit=NO;
        //        self.layer.borderColor=[[UIColor redColor] CGColor];
        //        self.layer.borderWidth=0.5;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [UTILITY addTAbleview:self];
        _isRefresh=NO;
        _isfirstInit=YES;
        [self initOrReframeView];
        _isfirstInit=NO;
        //        self.layer.borderColor=[[UIColor redColor] CGColor];
        //        self.layer.borderWidth=0.5;
    }
    return self;
}

-(void)initOrReframeView{
    
}
-(void)addSubview:(UIView *)view{
    [super addSubview:view];
#ifdef DEBUG
    UIView*view1=[self getAddValueForKey:@"addINdexButton"];
    if (view1==nil) {
        __weak __typeof(self) weakSelf = self;
        
        view1=[UIView viewWithFrame:CGRectMake(0, 0, 10, 10) backgroundcolor:RGBACOLOR(0, 0, 1, 0.2) superView:nil reuseId:nil];
        [self setAddValue:view1 forKey:@"addINdexButton"];
        [view1 addViewClickBlock:^(UIView *view) {
            
            NSMutableString*logstr=[NSMutableString new];
            
            if (weakSelf.data) {
                [logstr appendString:@"\n数据："];
                [logstr appendString: [weakSelf.data jsonStrSYS]];
            }
            [ logstr appendFormat:@"\n%@",NSStringFromClass([weakSelf class])];
            if (weakSelf.type) {
                [logstr appendString:@"\n type:"];
                [logstr appendString: weakSelf.type];
            }
            NSLog(@"%@",logstr);
        }];
    }
    [super addSubview:view1];
    [view1 beCenter];
#endif
    
}
-(void)bendData:(id)data withType:(NSString *)type{
    self.data=data;
    _type=type;
}
-(void)refreshData{
    
    _isRefresh=YES;
    [self bendData:self.data withType:_type];
    _isRefresh=NO;
}

#pragma mark  - 事件交互

/**
 对事件的监听，如果有按钮或者需要监听的东西的话就直接执行这个方法
 
 @param view 被点击的view
 */
-(void)baseViewButtonClick:(UIView*)view{
    [self subViewBeClick:view withBaseView:self];
}


-(void)subViewBeClick:(UIView*)subView withBaseView:(MYViewBase*)baseView{
    self.currentEvnetBaseView=baseView;
    self.eventView=subView;
    
    if (_eventTargetObj) {
        [_eventTargetObj performSelector:_eventAselector withObject:self];
    }
    if (self.baseViewEventBlock) {
        self.baseViewEventBlock(self);
    }
    MYViewBase*supBasview= [self superBaseView];
    if (supBasview) {
        [supBasview subViewBeClick:subView withBaseView:baseView];
        supBasview.subEvnetBaseView=self;
    }
}


/**
 添加交互事件
 
 @param obj target 对象
 @param selctor 需要执行的方法
 */
-(void)addBaseViewTarget:(id)obj select:(SEL)selctor{
    self.eventTargetObj=obj;
    self.eventAselector=selctor;
    
    
}
-(MYViewBase*)superBaseView{
    MYViewBase*supBasview=(MYViewBase*)self.superview;
    
    
    for (int i=0; i<7; i++) {
        if ([supBasview isKindOfClass:[MYViewBase class]]) {
            return supBasview;
        }else{
            supBasview=(MYViewBase*)supBasview.superview;
            if (supBasview==nil) {
                return nil;
            }
        }
    }
    return nil;
}



-(void)setEventBtn:(UIView*)eventView{
    [eventView addViewTarget:self select:@selector(baseViewButtonClick:)];
}

#pragma mark  - 类方法 创建方法
+(instancetype)viewWithframe:(CGRect)frame supView:(UIView *)sView reuseId:(NSString*)reuseID{
    if ([sView getAddValueForKey:reuseID]) {
        MYViewBase* bv=[sView getAddValueForKey:reuseID];
        bv.frame=frame;
        [bv initOrReframeView];
        return bv;
        
    }else{
        MYViewBase* bv=[[self alloc]initWithFrame:frame];
        if (reuseID) {
            [sView setAddValue:bv forKey:reuseID];
        }
        [sView addSubview:bv];
        return  bv;
        
    }
    
}
+(instancetype)viewWithframe:(CGRect)frame supView:(UIView *)sView type:(NSString*)type reuseId:(NSString*)reuseID{
    if ([sView getAddValueForKey:reuseID]) {
        MYViewBase* bv=[sView getAddValueForKey:reuseID];
        
        //        if (frame.size.width==0) {
        //
        //        }
        bv.type=type;
        bv.frame=frame;
        //        bv.frameOrigin=frame.origin;
        [bv initOrReframeView];
        //        [sView addSubview:bv];
        return bv;
        
    }else{
        //        MYViewBase* bv=[[self alloc]initWithFrame:frame];
        MYViewBase*bv=[[self alloc]initWithType:type WithFrame:frame];
        //        [self alloc]
        if (reuseID) {
            [sView setAddValue:bv forKey:reuseID];
        }
        [sView addSubview:bv];
        return  bv;
        
    }
    
}

+(instancetype)xibviewWithframe:(CGRect)frame supView:(UIView *)sView reuseId:(NSString*)reuseID{
    
    
    if ([sView getAddValueForKey:reuseID]) {
        MYViewBase* bv=[sView getAddValueForKey:reuseID];
        
        //        if (frame.size.width==0) {
        //
        //        }
        //        bv.type=type;
        bv.frame=frame;
        //        bv.frameOrigin=frame.origin;
        [bv initOrReframeView];
        
        UIView*view1=[bv getAddValueForKey:@"addINdexButton"];
        [view1 beCenter];
        return bv;
        
    }else{
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        MYViewBase *bv = [nibView objectAtIndex:0];
        [bv setFrame:frame];
        if (reuseID) {
            [sView setAddValue:bv forKey:reuseID];
        }
        [sView addSubview:bv];
        
        bv.isfirstInit=YES;
        [bv initOrReframeView];
        bv.isfirstInit=NO;
        
        UIView*view1=[bv getAddValueForKey:@"addINdexButton"];
        [view1 beCenter];
        
        return  bv;
        
    }
}


@end

