
//
//  zbigimage.m
//  GangFuBao
//
//  Created by 55like on 15/11/26.
//  Copyright © 2015年 55like. All rights reserved.
//

#import "WSBeBigImageView.h"
#import "XHImageUrlViewer.h"
//#import "MJPhotoBrowser.h"
//#import "MJPhoto.h"
@interface WSBeBigImageView()
{
    
}

@end
@implementation WSBeBigImageView
-(instancetype)initWithImage:(UIImage *)image{
    self=[super initWithImage:image];
    if (self) {
        [self addview];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self addview];
    }
    return self;
}

-(void)addview{
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigphoto)]];
    
    
    
}

-(void)bigphoto{
    
    
    //
    //
    //
    //
    
    NSMutableArray*marray=[NSMutableArray new];
    
    
    for (UIView*view in self.superview.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [marray addObject:view];
        }
    }
    
    
    
    
#pragma mark  zxh 排序
    //对数组进行排序
    
    NSArray *result = [marray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        //        NSLog(@"%@~%@",[obj1 price],[obj2 price]); //3~4 2~1 3~1 3~2
        //
        //        [obj1 integerValue];
        //        NSInteger xx1=[NSInteger in];
        
        if ([(UIView*)obj1 frameX]==[(UIView*)obj2 frameX]) {
            
            
            //            NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending}
            if ([(UIView*)obj1 frameY]==[(UIView*)obj2 frameY]) {
                return NSOrderedSame;
            }else if([(UIView*)obj1 frameY]>[(UIView*)obj2 frameY]){
                return NSOrderedDescending;
                
            }else if([(UIView*)obj1 frameY]<[(UIView*)obj2 frameY]){
                
                return NSOrderedAscending;
            }
            
            return NSOrderedSame;
            
            //            return [[NSString stringWithFormat:@"%.0f",[(UIView*)obj1 y]] compare:[NSString stringWithFormat:@"%f",[(UIView*)obj2 y]]];
        }else{
            
            //            NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending}
            if ([(UIView*)obj1 frameX]==[(UIView*)obj2 frameX]) {
                return NSOrderedSame;
            }else if([(UIView*)obj1 frameX]>[(UIView*)obj2 frameX]){
                return NSOrderedDescending;
                
            }else if([(UIView*)obj1 frameX]<[(UIView*)obj2 frameX]){
                
                return NSOrderedAscending;
            }
            
            return NSOrderedSame;
        }
        
        
        
    }];
    
    XHImageUrlViewer*xhView=[UTILITY.currentViewController getAddValueForKey:@"dddddddXHImageUrlViewer"];
    if (!xhView) {
        xhView=[[XHImageUrlViewer alloc] init];
//        [UTILITY.currentViewController setAddValue:xhView forKey:@"dddddddXHImageUrlViewer"];
    }
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (WSBeBigImageView *imgv in result) {
        NSMutableDictionary *dt=[[NSMutableDictionary alloc] init];
        
        [dt setValue:imgv.image forKey:@"DefaultImage"];
        if (imgv.url) {
            [dt setValue:imgv.url forKey:@"url"];
        }
        if (imgv.cacheUrl) {
            [dt setValue:imgv.cacheUrl forKey:@"cacheUrl"];
        }
        
        [array addObject:dt];
    }
    [xhView showWithImageDatas:array selectedIndex:[result indexOfObject:self]];
    
}


#pragma mark  展示代码
-(void)showme:(UIViewController*)vc{
    for (int i=0; i<4; i++) {
        
        
        
        WSBeBigImageView*imagview=[[WSBeBigImageView alloc]initWithFrame:CGRectMake(10,50+i*100, 100, 100)];
        
        imagview.image=[UIImage imageNamed:@"logo"];
        
        
        [vc.view addSubview:imagview];
    }
    
}




@end

