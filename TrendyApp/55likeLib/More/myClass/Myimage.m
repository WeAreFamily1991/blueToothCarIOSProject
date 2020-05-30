//
//  Myimage.m
//  SpookCam
//
//  Created by 55like on 17/04/2017.
//
//
#import "SubRectOnly.h"

#import "NSMutableArray+expanded.h"
#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )

#define BATA 1



#define MR(x) (R(x)/BATA)
#define MG(x) (G(x)/BATA)
#define MB(x) (B(x)/BATA)
#define MA(x) (A(x)/BATA)


/**
 降噪 所有的东西都除以 bata

 */
#define ConventColor(x) MR(x)*BATA+(MG(x)<<8)*BATA+(MB(x)<<16)*BATA+(MA(x)<<24)*BATA
#import "Myimage.h"

@interface TongjiObj:NSObject
@property(nonatomic,assign)UInt32 color;

@property(nonatomic,assign)UInt32 number;
@property(nonatomic,assign)float bilv1;
@property(nonatomic,assign)float bilvWithOutwhite;

@end
@implementation TongjiObj



//- (void)bubbleDescendingOrderSortWithArray:(NSMutableArray *)descendingArr
//{
//    for (int i = 0; i < descendingArr.count; i++) {
//        for (int j = 0; j < descendingArr.count - 1 - i; j++) {
//            if ([descendingArr[j] intValue] < [descendingArr[j + 1] intValue]) {
//                int tmp = [descendingArr[j] intValue];
//                descendingArr[j] = descendingArr[j + 1];
//                descendingArr[j + 1] = [NSNumber numberWithInt:tmp];
//            }
//        }
//    }
//    NSLog(@"冒泡降序排序后结果：%@", descendingArr);
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _color=0;
        _number=0;
        _bilv1=0.0;
        _bilvWithOutwhite=0.0;
    }
    return self;
}
@end


@interface TextShiBieObj:NSObject
@property(nonatomic,strong)SubRectOnly*rectObj;
@property(nonatomic,strong)NSMutableArray*imgObjArray;

@end

@implementation TextShiBieObj
-(SubRectOnly *)rectObj{
    if (_rectObj==nil) {
        _rectObj=[SubRectOnly new];
    }
    for (int i=0; i<_imgObjArray.count; i++) {
        Myimage*obj=_imgObjArray[i];
        if (i==0) {
            _rectObj.x=obj.x;
            _rectObj.y=obj.y;
            _rectObj.width=obj.width;
            _rectObj.height=obj.height;
        }
        
        if (_rectObj.x>obj.x) {
            _rectObj.width=_rectObj.width+_rectObj.x-obj.x;
            _rectObj.x=obj.x;
        }
        if (_rectObj.y>obj.y) {
            _rectObj.height=_rectObj.height+_rectObj.y-obj.y;
            _rectObj.y=obj.y;
        }
        if (_rectObj.x+_rectObj.width<obj.x+obj.width) {
            _rectObj.width=obj.x+obj.width-_rectObj.x;
        }
        if (_rectObj.y+_rectObj.height<obj.y+obj.height) {
            _rectObj.height=obj.y+obj.height-_rectObj.y;
        }
        
        
        
    }
  
    
    
    return _rectObj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rectObj=[SubRectOnly new];
        _imgObjArray=[NSMutableArray new];
    }
    return self;
}
@end

@interface Myimage()

@property(nonatomic,strong)NSMutableArray*colortongjiSuju;
@end
@implementation Myimage

-(NSMutableArray*)paixuArray:(NSMutableArray*)descendingArr WithBlock:(NSComparator)blok{
    //    blok(nil,nil);
    
    for (int i=0; i<descendingArr.count; i++) {
        for (int j = 0; j < descendingArr.count - 1 - 0; j++) {
            
            id tmp = descendingArr[j];
            if( blok(descendingArr[j],descendingArr[j+ 1])==1){
                descendingArr[j] = descendingArr[j + 1];
                descendingArr[j + 1] = tmp;
            }
            if( blok(descendingArr[j],descendingArr[j+ 1])==-1){
                
            }
            if( blok(descendingArr[j],descendingArr[j+ 1])==0){
                
                for (int k=j; k<descendingArr.count - 1 - 0; k++) {
                    if( blok(tmp,descendingArr[k+ 1])==1){
                        
//                        descendingArr[j] = descendingArr[k + 1];
//                        descendingArr[k + 1] = tmp;
                        //对比出来的对象、
                        id foreOBj=descendingArr[j];
                        id lasttemp=descendingArr[k + 1];
                         descendingArr[j] = lasttemp;
                        
                        //                        进行对比的对象
                        id currenttemp=foreOBj;
                        for (int l=j; l<=k; l++) {
                            id tmepid= descendingArr[l+1];
                            descendingArr[l+1]=currenttemp;
                            currenttemp=tmepid;
                            
                        }
//                        descendingArr[j] = lasttemp;
//
                        
                        break;
                    }
                    
                }
            }
            
            
        }
    }

//    for (int i=0; i<descendingArr.count; i++) {
//        Myimage*obj=descendingArr[i];
//              NSLog(@"冒泡降序排序后结果%2d：x:%3lu y:%3lu w:%3lu h:%3lu",i, (unsigned long)obj.x,obj.y,obj.width,obj.height);
//    }
//    for (int i=0; i<descendingArr.count; i++) {
//        Myimage*obj=descendingArr[i];
//        for (int j=0; j<descendingArr.count; j++) {
//            Myimage*obj2=descendingArr[j];
//            if (obj==obj2&&i!=j) {
//                NSLog(@"错误");
//            }
//
//        }
//    }
    
//    for (Myimage*obj in descendingArr) {
//        NSLog(@"冒泡降序排序后结果：x:%lu y:%lu w:%lu h:%lu", (unsigned long)obj.x,obj.y,obj.width,obj.height);
//    }
    return descendingArr;
//    NSLog(@"冒泡降序排序后结果：%@", descendingArr);
}

+(Myimage*)getWith:(Myimage*)superMyimge with:(SubRectOnly*) subrect{
    
  return   [self MyimageWithMyimage:superMyimge X:subrect.x Y:subrect.y Width:subrect.width Height:subrect.height];
    
}


+(Myimage*)MyimageWithMyimage:(Myimage*)superMyimge X:(NSInteger)X  Y:(NSInteger)Y  Width:(NSInteger)width Height:(NSUInteger) height {
        Myimage*mi=[[Myimage alloc]init ];
    NSUInteger bytesPerPixel = 4;
    //没一行的字节
    NSUInteger bytesPerRow = bytesPerPixel *     width;
    NSUInteger bitsPerComponent = 8;
    //指针的数组集合
    UInt32 * pixels;
    pixels = (UInt32 *) calloc(height *width,     sizeof(UInt32));
    
    // 3.
    mi.colorSpaceIndex =     CGColorSpaceCreateDeviceRGB();
   mi.contextindex =     CGBitmapContextCreate(pixels, width, height,     bitsPerComponent, bytesPerRow, mi.colorSpaceIndex,     kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    
    
    UInt32 * currentPixel = pixels;
    
    UInt32*mycurrentPixel=superMyimge.startPixelIndex;
    for (NSUInteger sy = 0; sy < height; sy++) {
        for (NSUInteger sx = 0; sx < width; sx++) {
            
            currentPixel=pixels+sy*width+0+sx;
            
            mycurrentPixel=superMyimge.startPixelIndex+(sy+Y)*superMyimge.width+X+sx;
            
            
            *currentPixel=*mycurrentPixel;
            currentPixel++;
        }
        //        printf("\n");
    }
    
    
    mi.superMyImage=superMyimge;
    mi.x=X;
    mi.y=Y;

    mi.width=width;
    mi.height=height;
    mi.startPixelIndex=pixels;
    mi.originalImage=[mi getimageView].image;
    
    
    return mi;


}


+(Myimage*)MyimageWithImage:(UIImage*)imagexx{
    
    Myimage*mi=[[Myimage alloc]init ];
    mi.originalImage=imagexx;
    
    [mi restarAll];
    
    return mi;

    
}

+(Myimage*)MyimageWithStr:(NSString*)imagestr{

  return  [self MyimageWithImage:[UIImage imageNamed:imagestr]];
   
    


}
-(void)insertMeToScrollView{
    UIScrollView*showsv=[UTILITY.currentViewController getAddValueForKey:@"mmmimage"];
    //    [showsv removeFromSuperview];
    
    
    if (showsv==nil) {
        showsv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth-2,kScreenHeight-60 )];
        showsv.layer.borderColor=[UIColor blueColor].CGColor;
        showsv.layer.borderWidth=1;
        [UTILITY.currentViewController setAddValue:showsv forKey:@"mmmimage"];
        [UTILITY.currentViewController.view  addSubview:showsv];
    }
    if ([[UTILITY.currentViewController getAddValueForKey:@"debug"] isEqualToString:@"1"]) {
         UIImageView*imagev=[self getimageView];
        imagev.frameX=0;
        imagev.frameY=showsv.contentHeight+10;
        [showsv addSubview:imagev];
        showsv.contentHeight=imagev.frameYH;
        if (showsv.contentWidth<imagev.frameXW+10) {
            showsv.contentWidth=imagev.frameXW+10;
        }
    }
    
   
}
#pragma mark  - 位置计算转换
-(float)fx{
    return self.x*1.0;
}
-(float)fy{
    return self.y*1.0;
}
-(float)fwidth{
    return self.width*1.0;
}
-(float)fheight{
    return self.height*1.0;
}
-(float)fXW{
    return self.x*1.0+self.width*1.0;
}
-(float)fRX{
    if (self.superMyImage) {
        return self.superMyImage.width*1.0-self.x*1.0-self.width*1.0;
    }
    return 0.0;
}
-(float)fYH{
    float fyh=self.y*1.0+self.height*1.0;
    return fyh;
}
-(float)fBY{
    if (self.superMyImage) {
        return self.superMyImage.height*1.0-self.y*1.0-self.height*1.0;
    }
    return 0.0;
}
-(float)fCX{
    return self.x*1.0+self.width*0.5;
}
-(float)fCY{
    return self.y*1.0+self.height*0.5;
}
#pragma mark  -

-(void)restarAll{
//    [self clearmarray];
//    UIImage * ghostImage = self.originalImage;
    CGImageRef inputCGImage = [self.originalImage CGImage];
    NSUInteger width =  CGImageGetWidth(inputCGImage);
    
    //获取高度
    NSUInteger height = CGImageGetHeight(inputCGImage);
    
    // 2.
    //
    //因为是rgba 所以是4
    NSUInteger bytesPerPixel = 4;
    //没一行的字节
    NSUInteger bytesPerRow = bytesPerPixel *     width;
    NSUInteger bitsPerComponent = 8;
    //指针的数组集合
    UInt32 * pixels;
    pixels = (UInt32 *) calloc(height * width,     sizeof(UInt32));
    
    // 3.
    self.colorSpaceIndex =     CGColorSpaceCreateDeviceRGB();
    self.contextindex =     CGBitmapContextCreate(pixels, width, height,     bitsPerComponent, bytesPerRow,  self.colorSpaceIndex,     kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    
    // 4.
    CGContextDrawImage( self.contextindex, CGRectMake(0,     0, width, height), inputCGImage);
    
    
    self.width=width;
    self.height=height;
    
    self.startPixelIndex=pixels;
}

/**
 整理清空内存
 */
-(void)clearmarray{
    
    
    CGColorSpaceRelease((self.colorSpaceIndex));
    CGContextRelease((self.contextindex));


}

-(void)jianzaoRuhuiHuaWithBata{
    // 2.
    
    //    UInt32*currentPixel=self.startPixelIndex;
    [self logMe];
    
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            
//            *[self GetPixelWithX:sx Y:sy]=ConventColor(*[self GetPixelWithX:sx Y:sy]);
            *[self GetPixelWithX:sx Y:sy]=[self beilvzhuanhuan:*[self GetPixelWithX:sx Y:sy]];
            
            
        }
        //        printf("\n");
    }
    
    
}

/**
 倍率转换

 @param color <#color description#>
 @return <#return value description#>
 */
-(UInt32)beilvzhuanhuan:(UInt32) color{
    UInt32 beginColor=color;
    UInt32 r=R(beginColor);
    UInt32 g=G(beginColor);
    UInt32 b=B(beginColor);
    UInt32 a=A(beginColor);
    
    r=r/BATA*BATA;
    g=g/BATA*BATA;
    b=b/BATA*BATA;
    a=a/BATA*BATA;
    UInt32 endColor=r+(g<<8)+(b<<16)+(a<<24);
    return endColor;
    
    //    return R(x)/BATA*BATA+(G(x)/BATA*BATA<<8)+(B(x)/BATA*BATA<<16)+(A(x)/BATA*BATA<<24);
    
    //    return    MR(x)*BATA+(MG(x)<<8)*BATA+(MB(x)<<16)*BATA+(MA(x)<<24)*BATA;
    //    return  ConventColor(color);
}

/**
 消除大于255的点 转换为255

 @param color 初始的点
 @return 结束的点
 */
-(UInt32)xiaochuzhuanhuan:(UInt32) color{
    UInt32 beginColor=color;
    UInt32 r=R(beginColor);
    UInt32 g=G(beginColor);
    UInt32 b=B(beginColor);
    UInt32 a=A(beginColor);
    
//    r=r/BATA*BATA;
    r=r>250?255:r;
    g=g>250?255:g;
    b=b>250?255:b;
    a=a>250?255:a;
//    g=g/BATA*BATA;
//    b=b/BATA*BATA;
//    a=a/BATA*BATA;
    UInt32 endColor=r+(g<<8)+(b<<16)+(a<<24);
    return endColor;
    
    //    return R(x)/BATA*BATA+(G(x)/BATA*BATA<<8)+(B(x)/BATA*BATA<<16)+(A(x)/BATA*BATA<<24);
    
    //    return    MR(x)*BATA+(MG(x)<<8)*BATA+(MB(x)<<16)*BATA+(MA(x)<<24)*BATA;
    //    return  ConventColor(color);
}


/**
 不再降噪处理
 */
-(void)RuhuiHuaWithBata{
    // 2.
    
//    UInt32*currentPixel=self.startPixelIndex;
    [self logMe];
    
//    return;
    
    
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            *[self GetPixelWithX:sx Y:sy]=[self xiaochuzhuanhuan:*[self GetPixelWithX:sx Y:sy]];
            //        *[self GetPixelWithX:sx Y:sy]=ConventColor(*[self GetPixelWithX:sx Y:sy]);
//            *[self GetPixelWithX:sx Y:sy]=[self beilvzhuanhuan:*[self GetPixelWithX:sx Y:sy]];
            
        }
        //        printf("\n");
    }
//    [self logMe];
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        for (NSUInteger sx = 0; sx < self.width; sx++) {
     
            
//        *[self GetPixelWithX:sx Y:sy]=ConventColor(*[self GetPixelWithX:sx Y:sy]);
            *[self GetPixelWithX:sx Y:sy]=[self beilvzhuanhuan:*[self GetPixelWithX:sx Y:sy]];

        }
        //        printf("\n");
    }
    
    
}
//根据坐标找到点
-(UInt32*)GetPixelWithX:(NSInteger)X Y:(NSInteger)Y{

return  self.startPixelIndex+Y*self.width+0+X;

}

/**
 给定一个x 判断这个这一行是不是全部是边界

 @param X x
 */
-(BOOL)thisxIsshulinWithX:(NSInteger)X{
    int x=0;
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        
        if (*[self GetPixelWithX:X Y:sy]==0xff000000) {
//            return NO;
            x++;
        }
    }
    if (x/self.fheight>0.95||self.fheight-x<=3) {
        
        return YES;
    }
    return NO;
}

-(BOOL)isScreenWidth{
    if (self.fwidth>=634&&self.fwidth<=642) {
        return YES;
    }
    
    return NO;
}
/**
 寻找单独的方块
 
 @return 单独的方块 从外到里 进行边界查找
 */
-(Myimage*)getLaggestRect320{
//    NSInteger x=0;
//    NSInteger y=0;
//    NSInteger xw=0;
//    NSInteger yh=0;
    
    //找出x；
    {
        NSMutableArray*marray=[NSMutableArray new];
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            if ([self thisxIsshulinWithX:sx]) {
                [marray addObject: [NSNumber numberWithUnsignedInteger:sx]];
            }
            
        }
        if (marray.count>1) {
            for (int i=0; i<marray.count-1; i++) {
                NSNumber*number1=marray[i];
                NSNumber*number2=marray[i+1];
//                if (number2.longValue-number1.longValue==640||number2.longValue-number1.longValue==641) {
                    if (number2.longValue-number1.longValue>=634&&number2.longValue-number1.longValue<=642) {
                    
                    [self restarAll];
                    
                    return [Myimage MyimageWithMyimage:self X:number1.longValue+1 Y:0 Width:number2.longValue-number1.longValue-1 Height:self.height];
//                    if (number2.longValue-number1.longValue==641) {
//                        return [Myimage MyimageWithMyimage:self X:number1.longValue+1 Y:0 Width:640 Height:self.height];
//                    }else{
//                        return [Myimage MyimageWithMyimage:self X:number1.longValue+1 Y:0 Width:640-1 Height:self.height];
//                    }
                    
                    
                    
                    
                }
                
            }
        }
        
        
        
    }

    //    NSLog(@"%ld %ld %ld %ld",(long)x,(long)y,(long)xw,(long)yh);
    
    
    [self restarAll];
    return self;
}



/**
 寻找单独的方块

 @return 单独的方块 从外到里 进行边界查找
 */
-(Myimage*)getLaggestRect{
    NSInteger x=0;
    NSInteger y=0;
    NSInteger xw=0;
    NSInteger yh=0;
    
    //找出x；
    {
    
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            
            for (NSUInteger sy = 0; sy < self.height; sy++) {
                
                
                if (*[self GetPixelWithX:sx Y:sy]==0xff000000) {
                    x=sx;
                    break;
                }
            }
            if (x!=0) {
                break;
            }
        }
    }
    
    //找出xw；
    {
        
        for (NSInteger sx = self.width-1; sx >=0; sx--) {
            
            
            for (NSInteger sy = 0; sy < self.height; sy++) {
                
                
                if (*[self GetPixelWithX:sx Y:sy]==0xff000000) {
                    xw=sx;
                    break;
                }
            }
            if (xw!=0) {
                break;
            }
        }
    }
    //找出y；
    {
        
        
        for (NSUInteger sy = 0; sy < self.height; sy++) {
            
            for (NSUInteger sx = 0; sx < self.width; sx++) {
                
                if (*[self GetPixelWithX:sx Y:sy]==0xff000000) {
                    y=sy;
                    break;
                }
               
            } if (y!=0) {
                break;
            }
        }
    }
    //找出yh；
    {
        
        
        for (NSInteger sy = self.height-1; sy >=0; sy--) {
            
            for (NSInteger sx = 0; sx < self.width; sx++) {
                
                if (*[self GetPixelWithX:sx Y:sy]==0xff000000) {
                    yh=sy;
                    break;
                }
                
            }if (yh!=0) {
                break;
            }
        }
    }
//    NSLog(@"%ld %ld %ld %ld",(long)x,(long)y,(long)xw,(long)yh);
    
    if (self.isScreenWidth) {
//        x=0
        [self restarAll];
        return [Myimage MyimageWithMyimage:self X:0 Y:y-1 Width:self.fwidth Height:yh+3-(y-1)];
    }
    
//    (number2.longValue-number1.longValue>=634&&number2.longValue-number1.longValue<=642)
    
    
     [self restarAll];
    return [Myimage MyimageWithMyimage:self X:x-1 Y:y-1 Width:xw+3-(x-1) Height:yh+3-(y-1)];
//    return [Myimage MyimageWithMyimage:self X:x-1 Y:y-1 Width:xw+1-(x-1) Height:yh+1-(y-1)];
}


-(void)logMe{
//    return;
//    for (NSUInteger sy = 0; sy < self.height; sy++) {
//
//        for (NSUInteger sx = 0; sx < self.width; sx++) {
//
//            UInt32 color=*[self GetPixelWithX:sx Y:sy];
////            printf("%lu%lu%lu.",MR(color),MG(color),MB(color));
//
////            printf("%3.0f ",    255- (R(color)+G(color)+B(color))/3.0);
//            printf("%3.0f",    R(color)*1.0);
//            printf("%3.0f",    G(color)*1.0);
//            printf("%3.0fa",    B(color)*1.0);
////            printf("%3.0fa",    A(color)*1.0);
////            printf("%d",color);
//
//
//        }
//        printf("\n");
//
//    }
//
//    printf("\n\n\n\n\n");
}

/**
 找出所有的矩形

 @return 矩形边框
 */
-(NSMutableArray*)getAllRects{
    
    [self logMe];
// 将所有横向既没有 纵向也没有边界的点染色 0xff555555 为没有的点  0xff000000为非边界点
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            if ([self hlinHaviewborder:sy]==0||[self vlinHaviewborder:sx]==0) {
                *[self GetPixelWithX:sx Y:sy]=0xff555555;
            }
            
            
            
        }
    }
    
    [self insertMeToScrollView];
//    找到所有的方块没有边界点的 也染色 这样所有的方块就没有空的了
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            if ([self blackPointx:sx pointY:sy]) {
                 *[self GetPixelWithX:sx Y:sy]=0xff555555;
            }
            
            
            
        }
    }
    
    [self insertMeToScrollView];
    //   对小矩形进行再次缩小
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            if ([self hengxiang555555BlackPointx:sx pointY:sy]||[self shuxiangxiang555555BlackPointx:sx pointY:sy]) {
                *[self GetPixelWithX:sx Y:sy]=0xff555555;
            }
        }
    }
    
    [self insertMeToScrollView];
    //   对小矩形进行再次缩小
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            if ([self hengxiang555555BlackPointx:sx pointY:sy]||[self shuxiangxiang555555BlackPointx:sx pointY:sy]) {
                *[self GetPixelWithX:sx Y:sy]=0xff555555;
            }
        }
    }
    
    [self insertMeToScrollView];
    
//    return nil;
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
        
            if (*[self GetPixelWithX:sx Y:sy]!=0xff555555) {
                continue;
            }
//            
            NSInteger nopointnmuber=0;
            
            
            if (sx>0) {
                if (*[self GetPixelWithX:sx-1 Y:sy]!=0xff555555&&*[self GetPixelWithX:sx-1 Y:sy]!=0xffff0000) {
                    nopointnmuber++;
                }
                if (sy>0) {
                    if (*[self GetPixelWithX:sx-1 Y:sy-1]!=0xff555555&&*[self GetPixelWithX:sx-1 Y:sy-1]!=0xffff0000) {
                        nopointnmuber++;
                    }
                }
                
                if (sy<self.height-1-1) {
                    if (*[self GetPixelWithX:sx-1 Y:sy+1]!=0xff555555&&*[self GetPixelWithX:sx-1 Y:sy+1]!=0xffff0000) {
                        nopointnmuber++;
                    }
                }
                
            }
            if (sx<self.width-1-1) {
                if (*[self GetPixelWithX:sx+1 Y:sy]!=0xff555555&&*[self GetPixelWithX:sx+1 Y:sy]!=0xffff0000) {
                    nopointnmuber++;
                }
                
                if (sy>0) {
                    if (*[self GetPixelWithX:sx+1 Y:sy-1]!=0xff555555&&*[self GetPixelWithX:sx+1 Y:sy-1]!=0xffff0000) {
                        nopointnmuber++;
                    }
                }
                
                if (sy<self.height-1-1) {
                    if (*[self GetPixelWithX:sx+1 Y:sy+1]!=0xff555555&&*[self GetPixelWithX:sx+1 Y:sy+1]!=0xffff0000) {
                        nopointnmuber++;
                    }
                }
            }
            if (sy>0) {
                if (*[self GetPixelWithX:sx Y:sy-1]!=0xff555555&&*[self GetPixelWithX:sx Y:sy-1]!=0xffff0000) {
                    nopointnmuber++;
                }
            }
//            if (sy<self.height-1-1) {
                if (sy<self.height-1-1) {
                if (*[self GetPixelWithX:sx Y:sy+1]!=0xff555555&&*[self GetPixelWithX:sx Y:sy+1]!=0xffff0000) {
                    nopointnmuber++;
                }
            }
            
            
            
            if (nopointnmuber>0) {
                *[self GetPixelWithX:sx Y:sy]=0xffff0000;
            }
            
            
        }
    }

    [self insertMeToScrollView];
    
    
    NSMutableArray*rectArraysub=[NSMutableArray new];
    
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
//            UInt32 color=*[self GetPixelWithX:sx Y:sy];
//        printf("%lu%lu%lu.",MR(color),MG(color),MB(color));
//           printf("%lu%lu%lu.",MR(color),MG(color),MB(color));
        
        }
//     printf("\n");
    
    }
    
    
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            
            if (*[self GetPixelWithX:sx Y:sy]==0xffff0000) {
                
                BOOL isHave=NO;
                
                for (SubRectOnly*modle in rectArraysub) {
                    if ([modle HavePointX:sx Y:sy]) {
                        isHave=YES;
                    }
                    
                }
                
                
                if (isHave==NO) {
                    
                    [rectArraysub addObject:  [self findSubRectWithX:sx Y:sy]];
                }
                
                
                
                
            }
        
        
        }
    }
    
    _bianjianimage=[self getimageView];
    [self insertMeToScrollView];
    [self restarAll];
    //    Myiimage 对象的数组
    NSMutableArray*myimageObjArray=[NSMutableArray new];
    for (int i=0; i<rectArraysub.count; i++) {
        Myimage*imagesub=[Myimage getWith:self with:rectArraysub[i]];
        [myimageObjArray addObject:imagesub];
        //        [imagesub RuhuiHuaWithBata];
        [imagesub colortongjiSuju];
    }
    
    self.allRectsArray=myimageObjArray;
    return myimageObjArray;
    //    NSMutableArray*retunArray=[NSMutableArray new];
//  for (SubRectOnly*modle in rectArraysub) {
//      [retunArray addObject:[Myimage getWith:self with:modle]];
//    }
//
//
//
//    return retunArray;

}

#pragma mark  第一次文字合并相关代码

/**
 上边最近的 布局
 
 @return 右边最近的 布局
 */
-(Myimage*)hebing1DownObj{
    
    NSInteger   index =[self.superMyImage.allRectsArray indexOfObject:self];
    for (NSInteger i=index; i<self.superMyImage.allRectsArray.count; i++) {
        Myimage*obj=self.superMyImage.allRectsArray[i];
        if (obj!=self) {
            
            if (obj.x>(self.x+self.width)) {
                
            }else if (self.x>(obj.x+obj.width)) {
                
            }else{
                
                if (self.fYH<=obj.fy) {
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}
/**
 下边最近的 布局
 
 @return 下边最近的 布局
 */
-(Myimage*)hebing1UPObj{
    
    NSInteger   index =[self.superMyImage.allRectsArray indexOfObject:self];
    for (NSInteger i=index; i>=0; i--) {
        Myimage*obj=self.superMyImage.allRectsArray[i];
        if (obj!=self) {
            
            if (obj.x>self.x+self.width) {
                
            }else if (self.x>obj.x+obj.width) {
                
            }else{
                if (obj.fYH<=self.fy) {
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}
/**
 右边最近的 布局
 
 @return 右边最近的 布局
 */
-(Myimage*)hebing1RightObj{
    
    NSInteger   index =[self.superMyImage.allRectsArray indexOfObject:self];
    for (NSInteger i=index; i<self.superMyImage.allRectsArray.count; i++) {
        Myimage*obj=self.superMyImage.allRectsArray[i];
        if (obj!=self) {
            
            if (obj.y>self.y+self.height) {
                
            }else if (self.y>obj.y+obj.height) {
                
            }else{
                if (self.fXW<=obj.fx) {
                    
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}

/**
 左边最近的 布局
 
 @return 左边最近的 布局
 */
-(Myimage*)hebing1LeftObj{
    
    NSInteger   index =[self.superMyImage.allRectsArray indexOfObject:self];
    for (NSInteger i=index; i>=0; i--) {
        Myimage*obj=self.superMyImage.allRectsArray[i];
        if (obj!=self) {
            
            if (obj.y>self.y+self.height) {
                
            }else if (self.y>obj.y+obj.height) {
                
            }else{
                if (obj.fXW<=self.x) {
                    
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}


/**
 myimage 对象

 @param subArray 传入的SubRectOnly 的对象数组
 @return  SubRectOnly 对象 数组
 */
-(NSMutableArray*)getRectHeBing:(NSMutableArray*)subArray{
    

    
    //    消除没有面积的
    if (subArray.count) {
        for (NSInteger i=subArray.count-1; i>=0; i--) {
            SubRectOnly*imagesub=subArray[i];
            if (imagesub.width==0||imagesub.height==0) {
                [subArray removeObject:imagesub];
            }
        }
    }
    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //        SubRectOnly*objx1=obj1;
        //        SubRectOnly*objx2=obj2;
        //        int resutx=0;
        //
        //
        ////        float x =objx1.x+0.0;
        //        float y=objx1.y+0.0;
        //        float height =objx1.height+0.0;
        ////        float width =objx1.width+0.0;
        //
        ////        float x2 =objx2.x+0.0;
        //        float y2=objx2.y+0.0;
        //        float height2 =objx2.height+0.0;
        ////        float width2 =objx2.width+0.0;
        //        if (y-(y2+height2)>3) {
        //             resutx=-1;
        //        }
        //        if (y2-(y+height)>3) {
        //            return 1;
        //        }
        //
        ////        if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5>20) {
        ////            resutx=-1;
        ////        }else  if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5<-20) {
        ////            resutx=1;
        ////        }
        //        return resutx;
        
        SubRectOnly*objx1=obj1;
        SubRectOnly*objx2=obj2;
        int resutx=0;
        if (objx1.y+1>(objx2.y+objx2.height)) {
            resutx= 1;
        }
        if (objx2.y+1>(objx1.y+objx1.height)) {
            resutx= -1;
        }
        return resutx;
    }];
//    //    从上到下排序
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        //        SubRectOnly*objx1=obj1;
//        //        SubRectOnly*objx2=obj2;
//        //        int resutx=0;
//        //
//        //
//        ////        float x =objx1.x+0.0;
//        //        float y=objx1.y+0.0;
//        //        float height =objx1.height+0.0;
//        ////        float width =objx1.width+0.0;
//        //
//        ////        float x2 =objx2.x+0.0;
//        //        float y2=objx2.y+0.0;
//        //        float height2 =objx2.height+0.0;
//        ////        float width2 =objx2.width+0.0;
//        //        if (y-(y2+height2)>3) {
//        //             resutx=-1;
//        //        }
//        //        if (y2-(y+height)>3) {
//        //            return 1;
//        //        }
//        //
//        ////        if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5>20) {
//        ////            resutx=-1;
//        ////        }else  if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5<-20) {
//        ////            resutx=1;
//        ////        }
//        //        return resutx;
//
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if (objx1.y+1>(objx2.y+objx2.height)) {
//            resutx= 1;
//        }
//        if (objx2.y+1>(objx1.y+objx1.height)) {
//            resutx= -1;
//        }
//        return resutx;
//
//    }];
    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        //        SubRectOnly*objx1=obj1;
        //        SubRectOnly*objx2=obj2;
        //        int resutx=0;
        //        if ([objx1 x]>[objx2 x]) {
        //             resutx=1;
        //        }else{
        //           resutx=-1;
        //        }
        //        return resutx;
        
        SubRectOnly*objx1=obj1;
        SubRectOnly*objx2=obj2;
        int resutx=0;
        if ([objx1 x]+1>[objx2 x]+[objx2  width]) {
            resutx=1;
        }else if ([objx2 x]+1>[objx1 x]+[objx1  width]) {
            resutx=-1;
        }
        return resutx;
    }];
////    从左到右排列
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
////        SubRectOnly*objx1=obj1;
////        SubRectOnly*objx2=obj2;
////        int resutx=0;
////        if ([objx1 x]>[objx2 x]) {
////             resutx=1;
////        }else{
////           resutx=-1;
////        }
////        return resutx;
//
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if ([objx1 x]+1>[objx2 x]+[objx2  width]) {
//            resutx=1;
//        }else if ([objx2 x]+1>[objx1 x]+[objx1  width]) {
//            resutx=-1;
//        }
//        return resutx;
//
//    }];
   

    
    
    self.allRectsArray=subArray;
////    Myiimage 对象的数组
    NSMutableArray*myimageObjArray=subArray;
//    for (int i=0; i<subArray.count; i++) {
//        Myimage*imagesub=[Myimage getWith:self with:subArray[i]];
//        [myimageObjArray addObject:imagesub];
////        [imagesub RuhuiHuaWithBata];
//        [imagesub colortongjiSuju];
//    }
    
    //    Myiimage  最终的 对象的数组
    NSMutableArray*lastmyimageObjArray=[NSMutableArray new];
    //    Myiimage  初始的textview 对象的数组
    NSMutableArray*textmyimageObjArray=[NSMutableArray new];
    for (int i=0; i<myimageObjArray.count; i++) {
        Myimage*obj=myimageObjArray[i];
        
        [obj logColorTongji];
        Myimage*objshangyige;
        if (i>0) {
            objshangyige=myimageObjArray[i-1];
        }
        if ([obj isTextViewWithShangyig:objshangyige]) {
            [textmyimageObjArray addObject:obj];
        }else{
            [lastmyimageObjArray addObject:obj];
        }
    }
    
//    存放 TextShiBieObj 合并后的数组
    NSMutableArray*textBigRectArray=[NSMutableArray new];
    
    for (int i=0; i<textmyimageObjArray.count; i++) {
         Myimage*obj=textmyimageObjArray[i];
        BOOL isHaveAdd=NO;
        for (TextShiBieObj*shibieObj in textBigRectArray) {
            
            for (NSInteger j=shibieObj.imgObjArray.count-1; j>=0; j--) {
            
                Myimage*objxx=shibieObj.imgObjArray[j];
                if ([obj isHaveSameBigWith:objxx]) {
                    [shibieObj.imgObjArray addObject:obj];
                    isHaveAdd=YES;
                }
            }
        }
        if (isHaveAdd==NO) {
            TextShiBieObj*shibeiObj=[TextShiBieObj new];
            [shibeiObj.imgObjArray addObject:obj];
            [textBigRectArray addObject:shibeiObj];
        }
        
        
    }
    for (int i=0; i<textBigRectArray.count; i++) {
        TextShiBieObj*shibieObj=textBigRectArray[i];
        
        Myimage*myimageobj=[Myimage getWith:self with:shibieObj.rectObj];
        myimageobj.imageType=@"第一次文字合并";
        myimageobj.sub1TextArray=shibieObj.imgObjArray;
        [lastmyimageObjArray addObject:myimageobj];
    }
    
    self.subImage1TypeArray=lastmyimageObjArray;
    
    return lastmyimageObjArray;
}

/**
 判断两个Myimage 是否是相邻的text
 
 @param otherObj <#otherObj description#>
 @return <#return value description#>
 */
-(BOOL)isHaveSameBigWith:(Myimage*)otherObj{
    float x =self.x+0.0;
    float y=self.y+0.0;
    
    if (x-20>otherObj.x+otherObj.width) {
        return NO;
    }
    if (x+self.width+20<otherObj.x) {
        return NO;
    }
//    if (x-20>otherObj.x+otherObj.width) {
//        return NO;
//    }
    
    if (y-2>otherObj.y+otherObj.height) {
        return NO;
    }
    if (y+self.height+2<otherObj.y) {
        return NO;
    }
    
    
    return YES;
}

#pragma mark  第二次文字合并相关代码

/**
 上边最近的 布局
 
 @return 右边最近的 布局
 */
-(Myimage*)hebing2DownObj{
    
    NSInteger   index =[self.superMyImage.subImage1TypeArray indexOfObject:self];
    for (NSInteger i=index; i<self.superMyImage.subImage1TypeArray.count; i++) {
        Myimage*obj=self.superMyImage.subImage1TypeArray[i];
        if (obj!=self) {
            
            if (obj.x>(self.x+self.width)) {
                
            }else if (self.x>(obj.x+obj.width)) {
                
            }else{
                
                if (self.fYH<=obj.fy) {
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}
/**
 下边最近的 布局
 
 @return 下边最近的 布局
 */
-(Myimage*)hebing2UPObj{
    
    NSInteger   index =[self.superMyImage.subImage1TypeArray indexOfObject:self];
    for (NSInteger i=index; i>=0; i--) {
        Myimage*obj=self.superMyImage.subImage1TypeArray[i];
        if (obj!=self) {
            
            if (obj.x>self.x+self.width) {
                
            }else if (self.x>obj.x+obj.width) {
                
            }else{
                if (obj.fYH<=self.fy) {
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}
/**
 右边最近的 布局
 
 @return 右边最近的 布局
 */
-(Myimage*)hebing2RightObj{
    
    NSInteger   index =[self.superMyImage.subImage1TypeArray indexOfObject:self];
    for (NSInteger i=index; i<self.superMyImage.subImage1TypeArray.count; i++) {
        Myimage*obj=self.superMyImage.subImage1TypeArray[i];
        if (obj!=self) {
            
            if (obj.y>self.y+self.height) {
                
            }else if (self.y>obj.y+obj.height) {
                
            }else{
                if (self.fXW<=obj.fx) {
                    
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}

/**
 左边最近的 布局
 
 @return 左边最近的 布局
 */
-(Myimage*)hebing2LeftObj{
    
    NSInteger   index =[self.superMyImage.subImage1TypeArray indexOfObject:self];
    for (NSInteger i=index; i>=0; i--) {
        Myimage*obj=self.superMyImage.subImage1TypeArray[i];
        if (obj!=self) {
            
            if (obj.y>self.y+self.height) {
                
            }else if (self.y>obj.y+obj.height) {
                
            }else{
                if (obj.fXW<=self.x) {
                    
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}

/**
 myimage 对象数组 第二次合并 多行合并
 
 @param subArray 传入的 Myimage 的对象数组
 @return  Myimage 对象 数组
 */
-(NSMutableArray*)get2RectHeBing:(NSMutableArray*)subArray{
    
    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Myimage*objx1=obj1;
        Myimage*objx2=obj2;
        int resutx=0;
        if ([objx1 x]>[objx2 x]) {
            resutx=1;
        }else{
            resutx=-1;
        }
        return resutx;
    }];
    
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        Myimage*objx1=obj1;
//        Myimage*objx2=obj2;
//        int resutx=0;
//        if ([objx1 x]>[objx2 x]) {
//            resutx=1;
//        }else{
//            resutx=-1;
//        }
//        return resutx;
//
//    }];
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Myimage*objx1=obj1;
        Myimage*objx2=obj2;
        int resutx=0;
        if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5>20) {
            resutx=1;
        }else  if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5<-20) {
            resutx=-1;
        }
        return resutx;
    }];
    
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        Myimage*objx1=obj1;
//        Myimage*objx2=obj2;
//        int resutx=0;
//        if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5>20) {
//            resutx=-1;
//        }else  if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5<-20) {
//            resutx=1;
//        }
//        return resutx;
//
//    }];
    
    
    
    self.subImage1TypeArray=subArray;
    //    Myiimage 对象的数组
    NSMutableArray*myimageObjArray=subArray;
    
    //    Myiimage  最终的 对象的数组
    NSMutableArray*lastmyimageObjArray=[NSMutableArray new];
    //    Myiimage  初始的textview 对象的数组
    NSMutableArray*textmyimageObjArray=[NSMutableArray new];
    for (int i=0; i<myimageObjArray.count; i++) {
        Myimage*obj=myimageObjArray[i];
        if ([obj.imageType isEqualToString:@"第一次文字合并"]) {
            [textmyimageObjArray addObject:obj];
        }else{
            [lastmyimageObjArray addObject:obj];
        }
    }
    
    //    存放 TextShiBieObj 合并后的数组
    NSMutableArray*textBigRectArray=[NSMutableArray new];
    
    for (int i=0; i<textmyimageObjArray.count; i++) {
        Myimage*obj=textmyimageObjArray[i];
        BOOL isHaveAdd=NO;
        for (TextShiBieObj*shibieObj in textBigRectArray) {
            
            for (NSInteger j=shibieObj.imgObjArray.count-1; j>=0; j--) {
                
                Myimage*objxx=shibieObj.imgObjArray[j];
                if ([obj isHaveSame2BigWith:objxx withOtherArray:lastmyimageObjArray]) {
                    [shibieObj.imgObjArray addObject:obj];
                    isHaveAdd=YES;
                }
            }
        }
        if (isHaveAdd==NO) {
            TextShiBieObj*shibeiObj=[TextShiBieObj new];
            [shibeiObj.imgObjArray addObject:obj];
            [textBigRectArray addObject:shibeiObj];
        }
        
        
    }
    for (int i=0; i<textBigRectArray.count; i++) {
        TextShiBieObj*shibieObj=textBigRectArray[i];
        
        Myimage*myimageobj=[Myimage getWith:self with:shibieObj.rectObj];
        myimageobj.imageType=@"第二次文字合并";
        myimageobj.sub2TextArray=shibieObj.imgObjArray;
        
        [lastmyimageObjArray addObject:myimageobj];
    }
    
//处理有些 ， 逗号 没有识别为文字 移除，但是有第二次文字合并的位置完全重叠
    for (long i=lastmyimageObjArray.count-1; i>=0; i--) {
        Myimage*objxx=lastmyimageObjArray[i];
        if ([objxx.imageType isEqualToString:@"第二次文字合并"]) {
            
        }else{
//            是否有重复的
            BOOL isChongfu=NO;
            for (long i=lastmyimageObjArray.count-1; i>=0; i--) {
                Myimage*objxx222=lastmyimageObjArray[i];
                if ([objxx222.imageType isEqualToString:@"第二次文字合并"]) {
                    if (objxx.fx>=objxx222.fx&&objxx.fy>=objxx222.fy&&objxx.fBY>=objxx222.fBY&&objxx.fRX>=objxx222.fRX) {
                        isChongfu=YES;
                    }
                    
                }
            }
            if (isChongfu==YES) {
                [lastmyimageObjArray removeObject:objxx];
            }
        }
    }
    
    
    
    self.subImage2TypeArray=lastmyimageObjArray;
    
    return lastmyimageObjArray;
}




/**
 判断两个字体对象是不是一个 双行的或者多行的

 @param otherObj 另一个对象
 @param otherallArray 周围其他的对象
 @return 返回值
 */
-(BOOL)isHaveSame2BigWith:(Myimage*)otherObj withOtherArray:(NSMutableArray*)otherallArray{
//    float x =self.x+0.0;
//    float y=self.y+0.0;
//    float height =self.height+0.0;
//    float width =self.width+0.0;
//
//    float x2 =otherObj.x+0.0;
//    float y2=otherObj.y+0.0;
//    float height2 =otherObj.height+0.0;
//    float width2 =otherObj.width+0.0;
    
    
    if (otherObj.textColor!=self.textColor) {
        return NO;
    }
    if (self.fheight-otherObj.fheight>5||otherObj.fheight-self.fheight>5) {
        return NO;
    }
    //    self 在上面
    if (otherObj.fy-self.fy>3) {
        //        如果行间距大于字体高度
        if (otherObj.fy-self.fYH>self.fheight*0.9) {
            return NO;
        }
        //        如果行间距为过小 
        if (otherObj.fy-self.fYH<1) {
            return NO;
        }
        //        第一行比第二行的首行缩进的过多 3 个字节
        if (self.fx-otherObj.fx>self.fheight*3) {
            return NO;
        }
        Myimage *upObj=self;
        
        Myimage *downObj=otherObj;
        
        if ([upObj hebing2LeftObj]) {
            Myimage*rightObj=[upObj hebing2LeftObj];
            if (![rightObj isTextView]) {
//                if (upObj.fx-rightObj.fXW<upObj.height) {
                    if (downObj.fx-rightObj.fx>-6) {
                        return NO;
                    }
                
//                }
            }
        }
//        if ([self writeRightObj]) {
//            <#statements#>
//        }
        
    }
    //    otherObj 在上面
    if (self.fy-otherObj.fy>3) {
        //        入过行间距大于字体高度
        if (self.fy-otherObj.fYH>self.fheight*0.9) {
            return NO;
        }
        //        如果行间距为过小
        if (self.fy-otherObj.fYH<1) {
            return NO;
        }
        //        第一行比第二行的首行缩进的过多 3 个字节
        if (otherObj.fx-self.fx>self.fheight*3) {
            return NO;
        }
        
        Myimage *upObj=otherObj;
        
        Myimage *downObj=self;
        
        if ([upObj hebing2LeftObj]) {
            Myimage*rightObj=[upObj hebing2LeftObj];
            if (![rightObj isTextView]) {
//                if (upObj.fx-rightObj.fXW<upObj.height) {
                    if (downObj.fx-rightObj.fx>-6) {
                        return NO;
//                    }
                    
                }
            }
        }
        
    }
    
    if (self.fheight-otherObj.fheight>2||otherObj.fheight-self.fheight>2) {
        return NO;
    }
    if (self.fx-otherObj.fXW>2*self.fheight||otherObj.fx-self.fXW>2*self.fheight) {
        return NO;
    }
    
    
//    if (x-20>otherObj.x+otherObj.width) {
//        return NO;
//    }
//    if (x+self.width+20<otherObj.x) {
//        return NO;
//    }
//    if (y-2>otherObj.y+otherObj.height) {
//        return NO;
//    }
//    if (y+self.height+2<otherObj.y) {
//        return NO;
//    }
    
    
    return YES;
}

//-(BOOL)isHaveSameBigRectOnlyWith:(SubRectOnly*)otherObj{
//    if (self.x-14>otherObj.x+otherObj.width) {
//        return NO;
//    }
//    if (self.x+self.width+14<otherObj.x) {
//        return NO;
//    }
//    if (self.y-14>otherObj.y+otherObj.height) {
//        return NO;
//    }
//    if (self.y+self.height+14<otherObj.y) {
//        return NO;
//    }
//
//
//    return YES;
//}


-(UInt32)textColor{
    TongjiObj*obj=self.colortongjiSuju.firstObject;
    if (obj.color==0xffffffff&&self.colortongjiSuju.count>1) {
        obj=self.colortongjiSuju[1];
    }
    return obj.color;
   
}

#pragma mark  - 创建代码
-(void)writeCreatMeSelf{
//    NSMutableArray*subArray=self.subImage2TypeArray;
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if ([objx1 x]>[objx2 x]) {
//            resutx=1;
//        }else{
//            resutx=-1;
//        }
//        return resutx;
//
//    }];
//
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5>20) {
//            resutx=-1;
//        }else  if (objx1.y+objx1.height*0.5-objx2.y+objx2.height*0.5<-20) {
//            resutx=1;
//        }
//        return resutx;
//
//    }];
    
}


-(NSString*)writeMeHfileWithClassName:(NSString*)className{
    
    _myClassNameStr=className;
    NSString*hfileStr=[NSString stringWithFormat:@"#import \"MYGenerateView.h\"\n\
\n\
@interface %@ : MYGenerateView\n\
\n\
@end",className];
    return hfileStr;
    
    
}


-(NSString*)writeMeMfileWithClassName:(NSString*)className{
    
    _myClassNameStr=className;
    NSMutableArray*subArray=self.subImage2TypeArray;
    
//    //先从左到右排序
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if ([objx1 x]>[objx2 x]) {
//            return 1;
//        }else if ([objx2 x]>[objx1 x]) {
//            return -1;
//        }
//        return resutx;
//
//    }];
    
    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SubRectOnly*objx1=obj1;
        SubRectOnly*objx2=obj2;
        int resutx=0;
        if ((objx1.y+objx1.height*0.5)>(objx2.y+objx2.height)) {
            return 1;
        }else if ((objx2.y+objx2.height*0.5)>(objx1.y+objx1.height)) {
            return -1;
        }else{
            //            if (objx1.y>objx2.y&&obj) {
            //                <#statements#>
            //            }
        }
        return resutx;
        
        
    }];
    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SubRectOnly*objx1=obj1;
        SubRectOnly*objx2=obj2;
        int resutx=0;
        if ([objx1 x]>[objx2 x]) {
            return 1;
        }else if ([objx2 x]>[objx1 x]) {
            return -1;
        }
        return resutx;
    }];
    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SubRectOnly*objx1=obj1;
        SubRectOnly*objx2=obj2;
        int resutx=0;
        if (([objx1 x]+1.0)>([objx2 x]+0.0+[objx2  width])+0.0) {
            return 1;
        }else if (([objx2 x]+1.0)>([objx1 x]+[objx1  width])+0.0) {
            return -1;
        }
        return resutx;
        
    }];
//    //先从左到右排序
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if (([objx1 x]+1.0)>([objx2 x]+0.0+[objx2  width])+0.0) {
//            return 1;
//        }else if (([objx2 x]+1.0)>([objx1 x]+[objx1  width])+0.0) {
//            return -1;
//        }
//        return resutx;
//
//    }];
    

    
    subArray=[self paixuArray:subArray WithBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SubRectOnly*objx1=obj1;
        SubRectOnly*objx2=obj2;
        int resutx=0;
        if ((objx1.y+1)>(objx2.y+objx2.height)) {
            return 1;
        }else if ((objx2.y+1)>(objx1.y+objx1.height)) {
            return -1;
        }else{
//            if (objx1.y>objx2.y&&obj) {
//                <#statements#>
//            }
        }
        return resutx;

        
    }];
    
//    //从上到下排序
//    subArray = [subArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        SubRectOnly*objx1=obj1;
//        SubRectOnly*objx2=obj2;
//        int resutx=0;
//        if ((objx1.y+1)>(objx2.y+objx2.height)) {
//            return 1;
//        }
//        if ((objx2.y+1)>(objx1.y+objx1.height)) {
//            return -1;
//        }
//        return resutx;
//
//    }];
    self.subImage2TypeArray=[NSMutableArray arrayWithArray:subArray];
//    属性 字符串
    NSMutableString*mpropertyStr=[NSMutableString new];
//    创建字符串
    NSMutableString*mcreateStr=[NSMutableString new];
//    绑定字符串
    NSMutableString*mbendStr=[NSMutableString new];
    
    
    for (int i=0; i<subArray.count; i++) {
        Myimage* imgateObj=subArray[i];
//        [imgateObj writeCreatCode];
        [mcreateStr appendFormat:@"%@", [imgateObj writeCreatCode]];
        [mpropertyStr appendFormat:@"@property(nonatomic,weak)%@*%@;\n",imgateObj.writeCreatTypeStr,imgateObj.writeVariableName];
        
        if ([imgateObj.writeCreatTypeStr isEqualToString:@"UILabel"]) {
            [mbendStr appendFormat:@"_%@.text=[data ojsk:@\"\"];\n",imgateObj.writeVariableName];
        }
        if ([imgateObj.writeCreatTypeStr isEqualToString:@"UIImageView"]) {
            if (imgateObj.width>50&&imgateObj.height>50) {
                [mbendStr appendFormat:@" [_%@ imageWithURL:[data ojsk:@\"path\"]];\n",imgateObj.writeVariableName];
            }
        }
        
        
    }
    
    
//    @property(nonatomic,weak)UIView*view;
    
    
    NSString*importStr=[NSString stringWithFormat:@"\n#import \"%@.h\"\n",className];
    NSString*interfaceStr=[NSString stringWithFormat:@"@interface %@()\n\
{\n\
\n\
}\n\
%@\n\
@end\n",className,mpropertyStr];
    NSString*lastewidhtStr=[NSString stringWithFormat:@"%.0f",self.width*0.5];
    
    float lastwidthjian=(640.0-self.fwidth)*0.5;
    if (lastwidthjian>=-1.5&&lastwidthjian<=-1.5) {
        lastwidthjian=0;
    }
    
    if (lastwidthjian<100) {
        lastewidhtStr=[NSString stringWithFormat:@"kScreenWidth-%.0f",lastwidthjian];
    }
    if(self.width*0.5<320*0.5){
        lastewidhtStr=[NSString stringWithFormat:@"%.0f*kScreenWidth/640.0",self.width*0.5];
        ;
    }
    
    NSString*initOrReframentViewStr=[NSString stringWithFormat:@"\n-(void)initOrReframeView{\n\
if (self.frameWidth==0) {\n\
self.frameWidth=%@;\n\
}\n\
if (self.frameHeight==0) {\n\
self.frameHeight=%.0f;\n\
}\
if (self.isfirstInit) {\n\
self.backgroundColor=rgbwhiteColor;\n\
%@\n\
}\n\
\n\
}\n",lastewidhtStr,(self.height+0.0)*0.5,mcreateStr];
    
    NSString*bendDataStr=[NSString stringWithFormat:@"\n\
-(void)bendData:(id)data withType:(NSString *)type{\n\
[super bendData:data withType:type];\n\
%@}\n\
\n",mbendStr];
    
    
    NSString*mfileStr=[NSString stringWithFormat:@"%@%@@implementation %@ %@%@\n@end",importStr,interfaceStr,className,initOrReframentViewStr,bendDataStr];
    return mfileStr;
    
    
    
    
    
//#import "MyselfView.h"
//
//    @implementation MyselfView
//    -(void)initOrReframeView{
//        if (self.frameWidth==0) {
//            self.frameWidth=kScreenWidth;
//        }
//        if (self.frameHeight==0) {
//            self.frameHeight=55;
//        }
//        if (self.isfirstInit) {
//
//        }
//
//    }
//    -(void)bendData:(id)data withType:(NSString *)type{
//        [super bendData:data withType:type];
//    }
//
//    @end
//
//
//    return nil;
}
/**
 是否是文字 创建代码的时候使用
 @return 判断结果
 */

-(BOOL)isLastTextView{
     if ([self.imageType isEqualToString:@"第二次文字合并"]) {
         
         if (self.sub2TextArray.count==1&&[[[self.sub2TextArray firstObject] sub1TextArray] count]==1) {
             if (self.width<40) {
                 return NO;
                 
             }
             if (self.width<40&&(self.height/(self.width)>4)) {
                 return NO;
                 
             }
         }
   
         return YES;
     }
    return NO;
}

/**
 子控件书写自己

 */
-(NSString*)writeCreatCode{
 NSInteger   index =[self.superMyImage.subImage2TypeArray indexOfObject:self]+1;
    
    
    
    
    NSMutableString*titleStr=[NSMutableString new];
    
    if ([self isLastTextView]) {
        self.writeCreatTypeStr=@"UILabel";
        self.writeVariableName=[NSString stringWithFormat:@"mylable%ld",(long)index];
        
//        UILabel*lbx=[RHMethods RlableRX:10 Y:0 W:0 Height:0 font:0 superview:self withColor:nil text:@"21541212"];
        if (self.writeRX) {
              [titleStr appendFormat:@"%@*%@=[RHMethods RlableRX:%@ Y:%@ W:%@ Height:%@ font:%@ superview:self withColor:%@ text:@\"%@\"];\n",self.writeCreatTypeStr,self.writeVariableName,self.writeRX,self.writeY,self.writeWidth,self.writeHight,self.writeTextfont,self.writeTextColor,self.writeTextStr];
        }else if([self isCenterX]){
//            UILabel*lb1=[RHMethods ClableY:0 W:0 Height:0 font:0 superview:self withColor:0 text:@"名称"];
           [titleStr appendFormat:@"%@*%@=[RHMethods ClableY:%@ W:%@ Height:%@ font:%@ superview:self withColor:%@ text:@\"%@\"];\n",self.writeCreatTypeStr,self.writeVariableName,self.writeY,self.writeWidth,self.writeHight,self.writeTextfont,self.writeTextColor,self.writeTextStr];
        }else{
            [titleStr appendFormat:@"%@*%@=[RHMethods lableX:%@ Y:%@ W:%@ Height:%@ font:%@ superview:self withColor:%@ text:@\"%@\"];\n",self.writeCreatTypeStr,self.writeVariableName,self.writeX,self.writeY,self.writeWidth,self.writeHight,self.writeTextfont,self.writeTextColor,self.writeTextStr];
        }
      
//        UILabel*lb1=[RHMethods lableX:0 Y:0 W:0 Height:10 font:10 superview:self withColor:nil text:@"名称名称名称名称"];
        
         [titleStr appendFormat:@"_%@=%@;\n",self.writeVariableName,self.writeVariableName];
        
    }else{
        if ([self isImageView]||(self.width<40&&self.height<40)) {
//            创建 uiimageView
            self.writeCreatTypeStr=@"UIImageView";
            
          
            
            self.writeVariableName=[NSString stringWithFormat:@"myImage%ld",(long)index];
            
            
            NSString*pngimageStr=@"photo";
            
            if ((self.width<40&&self.height<40)) {
                [self writePNG];
                pngimageStr=self.writeVariableName;
                pngimageStr = [NSString stringWithFormat:@"%@_%@",self.superMyImage.myClassNameStr,self.writeVariableName];
            }
            
            [titleStr appendFormat:@"%@*%@=[UIImageView generateViewWithFrame:CGRectMake(%@, %@, %@, %@) defaultimage:@\"%@\" supView:self];//%@\n",self.writeCreatTypeStr, self.writeVariableName,self.writeX,self.writeY,self.writeWidth,self.writeHight,pngimageStr,[self writeViewColor]];
            
          
//            居右的东西
            if (self.writeRX) {
                [titleStr appendFormat:@"%@.frameRX=%@;\n",self.writeVariableName,self.writeRX];
            }else if([self isCenterX]){
                [titleStr appendFormat:@"[%@ beCX];\n",self.writeVariableName];
            }
            
            [titleStr appendFormat:@"_%@=%@;\n",self.writeVariableName,self.writeVariableName];
        }else{
            
            self.writeCreatTypeStr=@"UIView";
            self.writeVariableName=[NSString stringWithFormat:@"myView%ld",(long)index];
            [titleStr appendFormat:@"%@*%@=[UIView viewWithFrame:CGRectMake(%@, %@, %@, %@) backgroundcolor:rgb(240, 240, 240) superView:self];//%@\n",self.writeCreatTypeStr, self.writeVariableName,self.writeX,self.writeY,self.writeWidth,self.writeHight,[self writeViewColor]];
            //            居右的东西
            if (self.writeRX) {
                [titleStr appendFormat:@"%@.frameRX=%@;\n",self.writeVariableName,self.writeRX];
            }else if([self isCenterX]){
                [titleStr appendFormat:@"[%@ beCX];\n",self.writeVariableName];
            }
            
            
            [titleStr appendFormat:@"_%@=%@;\n",self.writeVariableName,self.writeVariableName];
        }
        
        
    }
    
    
    return titleStr;
}

-(void)writePNG{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString* realFileName = [NSString stringWithFormat:@"%@/%@/%@_%@@2x.png",self.superMyImage.filePath,self.superMyImage.myClassNameStr,self.superMyImage.myClassNameStr,self.writeVariableName];
//        NSString* realFileName = [NSString stringWithFormat:@"%@/%@@2x.png",self.superMyImage.filePath,self.writeVariableName];
     [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/",self.superMyImage.filePath,self.superMyImage.myClassNameStr] withIntermediateDirectories:YES attributes:nil error:nil];
    NSData *data;
    data =UIImagePNGRepresentation([self getimageViewPNG].image);
    if ([fm createFileAtPath:realFileName contents:data attributes:nil]) {
        //        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@写入成功",fileName]];
        
    }else{
        
        //        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@写入失败",fileName]];
        
    }
}


/**
 上边最近的 布局
 
 @return 右边最近的 布局
 */
-(Myimage*)writeDownObj{
    
    NSInteger   index =[self.superMyImage.subImage2TypeArray indexOfObject:self];
    for (NSInteger i=index; i<self.superMyImage.subImage2TypeArray.count; i++) {
        Myimage*obj=self.superMyImage.subImage2TypeArray[i];
        if (obj!=self) {
            
            if (obj.x>(self.x+self.width)) {
                
            }else if (self.x>(obj.x+obj.width)) {
                
            }else{
                
                if (self.fYH<=obj.fy) {
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}

/**
 下边最近的 布局
 
 @return 下边最近的 布局
 */
-(Myimage*)writeUPObj{
    
    NSInteger   index =[self.superMyImage.subImage2TypeArray indexOfObject:self];
    for (NSInteger i=index; i>=0; i--) {
        Myimage*obj=self.superMyImage.subImage2TypeArray[i];
        if (obj!=self) {
            
            if (obj.x>self.x+self.width) {
                
            }else if (self.x>obj.x+obj.width) {
                
            }else{
                if (obj.fYH<=self.fy) {
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}
/**
 右边最近的 布局
 
 @return 右边最近的 布局
 */
-(Myimage*)writeRightObj{
    
    NSInteger   index =[self.superMyImage.subImage2TypeArray indexOfObject:self];
    for (NSInteger i=index; i<self.superMyImage.subImage2TypeArray.count; i++) {
        Myimage*obj=self.superMyImage.subImage2TypeArray[i];
        if (obj!=self) {
            
            if (obj.y>self.y+self.height) {
                
            }else if (self.y>obj.y+obj.height) {
                
            }else{
                if (self.fXW<=obj.fx) {
                    
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}

/**
 左边最近的 布局
 
 @return 左边最近的 布局
 */
-(Myimage*)writeLeftObj{
    
    NSInteger   index =[self.superMyImage.subImage2TypeArray indexOfObject:self];
    for (NSInteger i=index; i>=0; i--) {
        Myimage*obj=self.superMyImage.subImage2TypeArray[i];
        if (obj!=self) {
            
            if (obj.y>self.y+self.height) {
                
            }else if (self.y>obj.y+obj.height) {
                
            }else{
                if (obj.fXW<=self.x) {
                    
                    return obj;
                }
            }
            
        }
    }
    
    return nil;
}

-(NSString *)writeWidth{
    if ([self isLastTextView]) {
        if (self.writeRX) {
            return [NSString stringWithFormat:@"%.0f",self.width*0.5+30];
        }else if([self isCenterX]){
            return [NSString stringWithFormat:@"%.0f",self.width*0.5+30];
        } else{
            Myimage*rightobj=  [self writeRightObj];
            
            Myimage*leftobj=  [self writeLeftObj];
            if (!rightobj) {
//                return [NSString stringWithFormat:@"self.frameWidth-%.0f",self.x*0.5];
                if (leftobj) {
                    
                    return [NSString stringWithFormat:@"self.frameWidth-(%@)",self.writeX];
                }else{
                    
                    if (self.superMyImage.isScreenWidth) {
                         return [NSString stringWithFormat:@"self.frameWidth-%.0f-10",self.x*0.5];
                    }else{
                        
                        return [NSString stringWithFormat:@"self.frameWidth-%.0f",self.x*0.5];
                    }
                    
                }
                
            }else{
                
                if (rightobj.writeRX) {
                   
                    if (leftobj) {
                        
                        return [NSString stringWithFormat:@"self.frameWidth-(%@)-%.0f",self.writeX,(10+ (rightobj.superMyImage.width-rightobj.x))*0.5];
//                         return [NSString stringWithFormat:@"self.frameWidth-%.0f",(10+self.x+ (rightobj.superMyImage.width-rightobj.x))*0.5];
                    }else{
                         return [NSString stringWithFormat:@"self.frameWidth-%.0f",(10+self.x+ (rightobj.superMyImage.width-rightobj.x))*0.5];
                    }
                   
                }
                
            }
        }
         return [NSString stringWithFormat:@"%.0f",self.width*0.5];
//        return nil;
//        图片
    }else   if ([self isImageView]) {
        return [NSString stringWithFormat:@"%.0f",self.width*0.5];
//        下面的是view
    }else  if(self.width>self.superMyImage.width/2){
        Myimage*rightobj=  [self writeRightObj];
        if (!rightobj) {
            return [NSString stringWithFormat:@"self.frameWidth-%.0f",self.x*0.5];
        }else{
            
            
            
        }
    }
     return [NSString stringWithFormat:@"%.0f",self.width*0.5];
}
-(NSString *)writeHight{
    if ([self isLastTextView]) {
//        return nil;
        if ([self writeTextLineNmuber]>1) {
            return @"0";
        }
        
        return [NSString stringWithFormat:@"%.0f",self.height*0.5];
    }else{
        return [NSString stringWithFormat:@"%.0f",self.height*0.5];
    }
}
-(NSString *)writeX{
    if (self.x==0) {
        return @"0";
    }
    Myimage*leftobj=  [self writeLeftObj];
    if (leftobj &&self.writeRX==nil) {
         return [NSString stringWithFormat:@"%@.frameXW+%.0f",leftobj.writeVariableName,(self.x-leftobj.x-leftobj.width)*0.5];
    }
    return [NSString stringWithFormat:@"%.0f",self.x*0.5];
}
-(NSString *)writeY{
    if (self.y==0) {
        return @"0";
    }
    float pianchaY=0;
    
    if ([self.writeCreatTypeStr isEqualToString:@"UIView"]&& self.superMyImage.fheight-self.fYH<4&&self.height<4) {
        pianchaY=self.superMyImage.fheight-self.fYH;
    }
//    mylable2.frameYH+10
    Myimage*upobj=  [self writeUPObj];
    if (upobj) {
        return [NSString stringWithFormat:@"%@.frameYH+%.0f",upobj.writeVariableName,(self.fy-upobj.fYH+pianchaY)*0.5];
    }
    return [NSString stringWithFormat:@"%.0f",(self.y+pianchaY)*0.5];
}
-(NSString *)writeTextColor{
    if (![self isLastTextView]) {
        return nil;
    }
 Myimage*imgev=   self.sub2TextArray.firstObject;
    UInt32 color= [imgev textColor];
 
    NSString*colorstr=[NSString stringWithFormat:@"rgb(%3.0f, %3.0f, %3.0f)",R(color)*1.0,G(color)*1.0,B(color)*1.0];
    return colorstr;
}

-(NSString *)writeViewColor{
//    if (![self isLastTextView]) {
//        return nil;
//    }
//    Myimage*imgev=   self.sub2TextArray.firstObject;
    UInt32 color= [self textColor];
    
    NSString*colorstr=[NSString stringWithFormat:@"rgb(%3.0f, %3.0f, %3.0f)",R(color)*1.0,G(color)*1.0,B(color)*1.0];
    return colorstr;
}
-(NSString *)writeTextfont{
    if (![self isLastTextView]) {
        return nil;
    }
    Myimage*imgev=   self.sub2TextArray.firstObject;
    return [NSString stringWithFormat:@"%.0f",imgev.height*0.5];
}

-(NSString *)writeTextStr{
    NSInteger numberline=[self writeTextLineNmuber];
    NSString*mutableStr=@"";
    for (int i=0; i<100; i++) {
        NSString*currentStr=[NSString stringWithFormat:@"%@文",mutableStr];
        if ([currentStr widthWithFont:self.writeTextfont.floatValue]>[NSString stringWithFormat:@"%.0f",self.width*0.5].floatValue) {
            break;
        }else{
            mutableStr=currentStr;
        }
    }
    NSString*lastStr=@"";
    
    for (int i=0; i<numberline; i++) {
        if (i==numberline-1) {
            lastStr=[NSString stringWithFormat:@"%@%@",lastStr,mutableStr];
        }else{
            lastStr=[NSString stringWithFormat:@"%@%@\\n",lastStr,mutableStr];
        }
    
    }
    
    
    return lastStr;
    
}

//有多少行文字
-(NSInteger)writeTextLineNmuber{
    if (![self isLastTextView]) {
        return 0;
    }
    if( self.sub2TextArray.count==1){
        return 1;
    }
    NSMutableArray *tongjiNumber=[NSMutableArray new];
    
    for (int i=0; i<self.sub2TextArray.count; i++) {
        Myimage*objxx=self.sub2TextArray[i];
        //是不是在同一行
        BOOL isHaveSameline=NO;
        for (Myimage*objpre in tongjiNumber) {
            if (objpre.y>objxx.y+objxx.height||objxx.y>objpre.y+objpre.height) {
                 isHaveSameline=NO;
            }else{
                isHaveSameline=YES;
            }
        }
        if (isHaveSameline==NO) {
            [tongjiNumber addObject:objxx];
        }
    }
    
    return tongjiNumber.count;
}

//@property(nonatomic,copy)NSString*writeTextColor;
//
//
//@property(nonatomic,copy)NSString*writeTextfont;
-(BOOL)isCenterX{
    if (self.x<30) {
        return NO;
    }
    if (self.superMyImage.width-self.x-self.width<30) {
        return NO;
    }
    
    if ((self.superMyImage.width-self.x-self.width)-self.x>10 ){
        return NO;
    }
    
    if (self.x-(self.superMyImage.width-self.x-self.width)>10 ){
        return NO;
    }
    
    return YES;
}

-(NSString *)writeRX{
    if (self.x<30) {
        return nil;
    }
//    if (self.) {
//        <#statements#>
//    }
    
//    rx 偏差
    float rxpiancha=0;
    if (self.superMyImage.isScreenWidth) {
//        rxpiancha=20;
    }
    
    //    rx 超过10 的时候返回 10 同时 x 大于 父空间的一半
    if (self.fRX-rxpiancha>15&&self.fCX<self.superMyImage.width*0.5) {
        return nil;
    }
    if (self.fx<=self.fRX ){
        return nil;
    }
    Myimage*leftObj=[self writeLeftObj];
    if (leftObj&&self.fx-leftObj.fXW<28) {
        if (leftObj.writeRX==nil) {
            return nil;
        }
    }
//    Myimage*rightObj=[self writeRightObj];
//    if (rightObj) {
//
//        if (rightObj.writeRX==nil) {
//            return nil;
//        }
//    }
   
    
    return [NSString stringWithFormat:@"%.0f",(self.superMyImage.width-self.x-self.width)*0.5];
}
/**
 颜色统计数组
发现可能出现 高度或者宽度为0 的对象
 @return <#return value description#>
 */
-(NSMutableArray *)colortongjiSuju{
    if (_colortongjiSuju==nil) {
        NSMutableArray*colortonjiArray=[NSMutableArray new];
        
        for (NSUInteger sy = 0; sy < self.height; sy++) {
            
            for (NSUInteger sx = 0; sx < self.width; sx++) {
                
                if (colortonjiArray.count>100) {
                    continue;
                }
                UInt32 color=*[self GetPixelWithX:sx Y:sy];
                
                BOOL isHave=NO;
                
                for (int i=0; i<colortonjiArray.count; i++) {
                    TongjiObj*tjobj=colortonjiArray[i];
                    if (tjobj.color==color) {
                        tjobj.number=tjobj.number+1;
                        isHave=YES;
                        break;
                    }
                }
                if (isHave==NO) {
                    TongjiObj*tjobj=[TongjiObj new];
                    tjobj.color=color;
                    tjobj.number=1;
                    [colortonjiArray addObject:tjobj];
                }
                
                
            }
        }
        
        NSArray *result = [colortonjiArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            int resutx=0;
            if ([obj1 number]>[obj2 number]) {
                resutx=-1;
            }else{
                resutx=1;
            }
            return resutx;
            
        }];
        colortonjiArray=[NSMutableArray arrayWithArray:result];
        _colortongjiSuju=colortonjiArray;
        
        TongjiObj*baiseObj=nil;
        
        for (TongjiObj*tjobj in colortonjiArray) {
            if (tjobj.color==0xffffffff) {
             baiseObj= tjobj;
            }
            
        }
        float allPoint=self.width*self.height*1.0;
        float allPointWithOutwhite=allPoint;
        if (baiseObj) {
              allPointWithOutwhite=allPoint-baiseObj.number;
        }
//        rgbwhiteColor;
        
        for (TongjiObj*tjobj in colortonjiArray) {
            if (allPoint!=0.0) {
                tjobj.bilv1=tjobj.number/allPoint;
            }
            if (allPointWithOutwhite!=0.0) {
                
                tjobj.bilvWithOutwhite=tjobj.number/allPointWithOutwhite;
            }
        }
        
        
        
        
        [self logColorTongji];
      
    }
    
  
    return _colortongjiSuju;
    
}

/**
 颜色数据统计
 */
-(void)logColorTongji{
    
    for (TongjiObj*tjobj in self.colortongjiSuju) {
        UInt32 color=tjobj.color;
        printf("%3.0f",R(color)*1.0);
        printf("%3.0f",G(color)*1.0);
        printf("%3.0fa",B(color)*1.0);
        printf("比率：%.3f，比率（白色外）：%.3fa",tjobj.bilv1,tjobj.bilvWithOutwhite);
        printf("%d\n",tjobj.number);
    }
    printf("\n共%lu, x=%lu,y=%lu,%lu*%lu",(unsigned long)_colortongjiSuju.count,(unsigned long)self.x,(unsigned long)self.y,(unsigned long)self.width,(unsigned long)self.height);
    printf("\n\n\n\n\n\n\n");
}


-(BOOL)isImageView{
    if (self.colortongjiSuju.count>100) {
        return YES;
    }
    if (self.colortongjiSuju.count>80) {
        return YES;
    }
    if (self.colortongjiSuju.count>35) {
        
            TongjiObj*obj=self.colortongjiSuju[0];
            if (obj.color==0xffffffff) {
                obj=self.colortongjiSuju[1];
            }
            if (obj.bilvWithOutwhite<1.5) {
                return YES;
            }
        
        return YES;
    }
    
    return NO;
    
}

-(BOOL)isTextViewWithShangyig:(Myimage*)otherObj{
    if ([self isTextView]) {
        return YES;
    }else{
        
        if ([self isTextViewWithShangyig2:[self hebing1LeftObj]]||
            [self isTextViewWithShangyig2:[self hebing1RightObj]]||
            [self isTextViewWithShangyig2:[self hebing1UPObj]]||
            [self isTextViewWithShangyig2:[self hebing1RightObj]]) {
            return YES;
        }
        
//
//        if (otherObj==nil) {
//            return NO;
//        }
//        if (![otherObj isTextView]) {
//            return NO;
//        }
////        Myimage*leftObj;
////        if (leftObj) {
////            if (leftObj) {
////                <#statements#>
////            }
////        }
//
////        float x =self.x+0.0;
////        float y=self.y+0.0;
////
////
////
//        if (self.fx-8>otherObj.fXW) {
//            return NO;
//        }
//        if (self.fXW+8<otherObj.fx) {
//            return NO;
//        }
//        if (self.fy-8>otherObj.fYH) {
//            return NO;
//        }
//        if (self.fYH+8<otherObj.fy) {
//            return NO;
//        }
        
        
        return NO;
        
    }
    return NO;
}
-(BOOL)isTextViewWithShangyig2:(Myimage*)otherObj{
    
    if (otherObj==nil) {
        return NO;
    }
    if (![otherObj isTextView]) {
        return NO;
    }
    //        Myimage*leftObj;
    //        if (leftObj) {
    //            if (leftObj) {
    //                <#statements#>
    //            }
    //        }
    
    //        float x =self.x+0.0;
    //        float y=self.y+0.0;
    //
    //
    //
    if (self.fx-6>otherObj.fXW) {
        return NO;
    }
    if (self.fXW+6<otherObj.fx) {
        return NO;
    }
    if (self.fy-6>otherObj.fYH) {
        return NO;
    }
    if (self.fYH+6<otherObj.fy) {
        return NO;
    }
    return YES;
}


-(BOOL)isTextView{
    
//    @"第一次文字合并"  @"第二次文字合并"
    if (self.imageType) {
        if ([self.imageType isEqualToString:@"第一次文字合并"]||[self isLastTextView]) {
            return YES;
        }
    }
//    如果只有17中颜色肯定等是文字
    if (self.colortongjiSuju.count==17) {
        return YES;
    }
//    暂时如果颜色在8到20 中可以基本肯定是文字了
    if (self.colortongjiSuju.count>8&&self.colortongjiSuju.count<20) {
        return YES;
    }
    if (self.colortongjiSuju.count<=8&&self.colortongjiSuju.count>3) {
        TongjiObj*obj=self.colortongjiSuju[0];
        if (obj.color==0xffffffff) {
            obj=self.colortongjiSuju[1];
        }
        if (obj.bilvWithOutwhite>0.3) {
            return YES;
        }
        
    }
    //     横线的数据
    
//    255255255a比率：0.778，比率（白色外）：3.500a56
//    102102102a比率：0.167，比率（白色外）：0.750a12
//    223223223a比率：0.056，比率（白色外）：0.250a4
//
//    共3, x=54,y=10,8*9
    
//    255255255a比率：0.778，比率（白色外）：3.500a49
//    102102102a比率：0.190，比率（白色外）：0.857a12
//    188188188a比率：0.032，比率（白色外）：0.143a2
//
//    共3, x=89,y=10,7*9
    if (self.colortongjiSuju.count==3&&self.colortongjiSuju.count<20) {
        if (self.width*1.0/self.height*1.0>0.75&&self.width*1.0/self.height*1.0<1.2) {
            return YES;
        }
    }
    
    return NO;
}

-(SubRectOnly*)findSubRectWithX:(NSInteger)X Y:(NSInteger)Y{
    
    NSInteger sx=X;
    NSInteger sy=Y;
    
    NSInteger direct=0;//0 左 ，1 下，2 右边， 3 上
    

    SubRectOnly*subact=[SubRectOnly new];
    
    subact.x=X;
    subact.y=Y;
    
    
    do {
        if (direct==0) {
            sx=sx+1;
            if (*[self GetPixelWithX:sx Y:sy]==0xffff0000) {
                continue;
            }else{
                sx=sx-1;
                direct=1;
                subact.width=sx-subact.x;
                
                continue;
                
            }
            
        }
        if (direct==1) {
            sy=sy+1;
            if (*[self GetPixelWithX:sx Y:sy]==0xffff0000) {
                continue;
            }else{
                sy=sy-1;
                direct=2;
                subact.height=sy-subact.y;
                
                continue;
                
            }
            
        }
        if (direct==2) {
            sx=sx-1;
            if (*[self GetPixelWithX:sx Y:sy]==0xffff0000) {
                continue;
            }else{
                sx=sx+1;
                direct=3;
//                subact.width=sx-subact.x;
                
                continue;
                
            }
            
        }
        
        if (direct==3) {
            sy=sy-1;
            if (*[self GetPixelWithX:sx Y:sy]==0xffff0000) {
                continue;
            }else{
                sy=sy+1;
                
//                subact.height=sx-subact.x;
                
//                continue;
                break;
                
            }
            
        }
        
        
        
    } while (sx!=X||sy!=Y);
    
    
    return subact;
    
}


/**
  只对白点进行判断

 @param x <#x description#>
 @param y <#y description#>
 @return <#return value description#>
 */
-(BOOL)hengxiang555555BlackPointx:(NSInteger)x pointY:(NSInteger)y{
    //    如果不是白色的 肯定就不是了
    if (*[self GetPixelWithX:x Y:y]!=0xffffffff) {
        return NO;
    }
    //    向左边遍历
    for (long sx=x; sx>=0; sx--) {
        if (*[self GetPixelWithX:sx Y:y]==0xff000000) {
            return NO;
        }
        //        如果遇到边界点位55的 就不做处理了
        if (*[self GetPixelWithX:sx Y:y]==0xff555555) {
            break;
        }
    }
    //    向右边遍历
    for (long sx=x; sx<self.width; sx++) {
        if (*[self GetPixelWithX:sx Y:y]==0xff000000) {
            return NO;
        }
        if (*[self GetPixelWithX:sx Y:y]==0xff555555) {
            break;
        }
    }
    return YES;
}


/**
 只对白点进行判断

 @param x <#x description#>
 @param y <#y description#>
 @return <#return value description#>
 */
-(BOOL)shuxiangxiang555555BlackPointx:(NSInteger)x pointY:(NSInteger)y{
    //    如果不是白色的 肯定就不是了
    if (*[self GetPixelWithX:x Y:y]!=0xffffffff) {
        return NO;
    }
    //    向上遍历
    for (long sy=y; sy>=0; sy--) {
        if (*[self GetPixelWithX:x Y:sy]==0xff000000) {
            return NO;
        }
        if (*[self GetPixelWithX:x Y:sy]==0xff555555) {
            break;
        }
    }
    // 向下遍历
    for (long sy=y; sy<self.height; sy++) {
        if (*[self GetPixelWithX:x Y:sy]==0xff000000) {
            return NO;
        }
        if (*[self GetPixelWithX:x Y:sy]==0xff555555) {
            break;
        }
    }
    return YES;
}

/**
 找出所有的白色的点单是不是 方块但是没有边框

 @param x x
 @param y y
 @return 判断值
 */
-(BOOL)blackPointx:(NSInteger)x pointY:(NSInteger)y{
//    如果不是白色的 肯定就不是了
    if (*[self GetPixelWithX:x Y:y]!=0xffffffff) {
        return NO;
    }
//    向左边遍历
    for (long sx=x; sx>=0; sx--) {
        if (*[self GetPixelWithX:sx Y:y]==0xff000000) {
            return NO;
        }
//        如果遇到边界点位55的 就不做处理了
        if (*[self GetPixelWithX:sx Y:y]==0xff555555) {
            break;
        }
    }
//    向右边遍历
    for (long sx=x; sx<self.width; sx++) {
        if (*[self GetPixelWithX:sx Y:y]==0xff000000) {
            return NO;
        }
        if (*[self GetPixelWithX:sx Y:y]==0xff555555) {
            break;
        }
    }
//    向上遍历
    for (long sy=y; sy>=0; sy--) {
        if (*[self GetPixelWithX:x Y:sy]==0xff000000) {
            return NO;
        }
        if (*[self GetPixelWithX:x Y:sy]==0xff555555) {
            break;
        }
    }
    // 向下遍历
    for (long sy=y; sy<self.height; sy++) {
        if (*[self GetPixelWithX:x Y:sy]==0xff000000) {
            return NO;
        }
        if (*[self GetPixelWithX:x Y:sy]==0xff555555) {
            break;
        }
    }
    

    
    return YES;
}

/**
 横向所有的边界点

 @param y 输入的y位置
 @return 该y值所有的横向边界点数
 */
-(NSInteger)hlinHaviewborder:(NSInteger)y{
    NSInteger number=0;
    
    for (NSInteger sx = 0; sx < self.width; sx++) {
        
        if (*[self GetPixelWithX:sx Y:y]==0xff000000) {
            
            number++;
            return number;
        }
        
    }
    
    
    return number;
    
    
}
-(NSInteger)vlinHaviewborder:(NSInteger)x{
    NSInteger number=0;
    
    for (NSInteger sy = 0; sy < self.height; sy++) {
        
        if (*[self GetPixelWithX:x Y:sy]==0xff000000) {
            number++;
            
            return number;
        }
        
    }
    
    
    return number;
    
    
}




#pragma mark  横向竖向的边界变成黑色
/**************找出图片上的边界线****************/
-(void)findbind2{
    
    
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            
            if (sy<self.height-1) {
                if (*[self GetPixelWithX:sx Y:sy]!=*[self GetPixelWithX:sx Y:sy+1]) {
                    *[self GetPixelWithX:sx Y:sy]=0xff000000;
                }
            }
            
            
            if (sx<self.width-1) {
                if (*[self GetPixelWithX:sx Y:sy]!=*[self GetPixelWithX:sx+1 Y:sy]) {
                    *[self GetPixelWithX:sx Y:sy]=0xff000000;
                }
            }
            
            if (*[self GetPixelWithX:sx Y:sy]!=0xff000000) {
                *[self GetPixelWithX:sx Y:sy]=0xffffffff;
            }
            
        }
    }
    
    
    
    
}
-(void)findbind{
//    [self RuhuiHuaWithBata];
     UInt32 whiteColor=[self beilvzhuanhuan:0xffffffff];
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            if (sy<self.height-1) {
                
                
                if ([self bianjiePanduan:*[self GetPixelWithX:sx Y:sy] colortow:*[self GetPixelWithX:sx Y:sy+1]]) {
//                    if (*[self GetPixelWithX:sx Y:sy]!=*[self GetPixelWithX:sx Y:sy+1]) {
                    
                   
                    if (*[self GetPixelWithX:sx Y:sy]==whiteColor) {
                        *[self GetPixelWithX:sx Y:sy+1]=0xff000000;
                    }else{
                        *[self GetPixelWithX:sx Y:sy]=0xff000000;
                    }
                    
                }
               
            }
         
            
            if (sx<self.width-1) {
                if ([self bianjiePanduan:*[self GetPixelWithX:sx Y:sy] colortow:*[self GetPixelWithX:sx+1 Y:sy]]) {
//                    if (*[self GetPixelWithX:sx Y:sy]!=*[self GetPixelWithX:sx+1 Y:sy]) {
//                    *[self GetPixelWithX:sx Y:sy]=0xff000000;
                    if (*[self GetPixelWithX:sx Y:sy]==whiteColor) {
                        *[self GetPixelWithX:sx+1 Y:sy]=0xff000000;
                    }else{
                        *[self GetPixelWithX:sx Y:sy]=0xff000000;
                    }
                    
                }
            
            }
            
            if (sy==self.height-1||sy==0) {
                *[self GetPixelWithX:sx Y:sy]=0xffffffff;
            }
            if (sx==self.width-1||sx==0) {
                *[self GetPixelWithX:sx Y:sy]=0xffffffff;
            }
            
            if (*[self GetPixelWithX:sx Y:sy]!=0xff000000) {
                *[self GetPixelWithX:sx Y:sy]=0xffffffff;
            }
            
        }
    }
    
    
    
    
}
-(BOOL)bianjiePanduan:(UInt32)color1 colortow:(UInt32)color2{
    UInt32 r=R(color1);
    UInt32 g=G(color1);
    UInt32 b=B(color1);
    UInt32 a=A(color1);
    
    UInt32 r2=R(color2);
    UInt32 g2=G(color2);
    UInt32 b2=B(color2);
    UInt32 a2=A(color2);
    if (r-r2>10||r2-r>10) {
        return YES;
    }

    if (g-g2>10||g2-g>10) {
        return YES;
    }

    if (b-b2>10||b2-b>10) {
        return YES;
    }

    if (a-a2>10||a2-a>10) {
        return YES;
    }

    
    return NO;
}

#pragma mark  判断图片上的横线是否是边界线染色
/**************判断图片上的横线是否是边界线染色****************/

+(void)hlin:(UInt32 *)currentPixel height:(NSUInteger) height width:(NSUInteger) width  y:(NSUInteger)y{
    
    int isLink;
    isLink=0;
    for (NSUInteger i=0; i<width; i++) {
        if (*(currentPixel+i+1+y*width)!=*(currentPixel+i+1+(y+1)*width)) {
            *(currentPixel+i+1+y*width)=0xff000000;
            
        }else{

            
        }
    }
    
}

-(UIImageView*)getimageView{
    
    
    
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(self.contextindex);
    UIImage * processedImage = [UIImage imageWithCGImage:newCGImage];
    UIImageView*imv=[[UIImageView alloc]initWithImage:processedImage];
    
    imv.frame=CGRectMake(self.x/1, self.y/1, self.width/1, self.height/1);
    
    
    
    return imv;
    
}
-(UIImageView*)getimageViewPNG{
    
    
    
    for (NSUInteger sy = 0; sy < self.height; sy++) {
        for (NSUInteger sx = 0; sx < self.width; sx++) {
            if (*[self GetPixelWithX:sx Y:sy]==0xffffffff) {
                *[self GetPixelWithX:sx Y:sy]=0x00000000;
            }
            if (R(*[self GetPixelWithX:sx Y:sy])>250&&G(*[self GetPixelWithX:sx Y:sy])>250&&B(*[self GetPixelWithX:sx Y:sy])>250) {
                  *[self GetPixelWithX:sx Y:sy]=0x00000000;
            }
        }
    }
    
    
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(self.contextindex);
    UIImage * processedImage = [UIImage imageWithCGImage:newCGImage];
    UIImageView*imv=[[UIImageView alloc]initWithImage:processedImage];
    
    imv.frame=CGRectMake(self.x/2, self.y/2, self.width/2, self.height/2);
    
    [self restarAll];
    
    return imv;
    
}

@end
