
//
//  imageTool.m
//  SpookCam
//
//  Created by home on 15/12/14.
//
//

//派生到我的代码片
#import "Myimage.h"

struct stuff{
    char job[20];
    int age;
    float height;
};
typedef struct stuff stuff;

//#define Mask8(x) ( (x) & 0xFF )
//#define R(x) ( Mask8(x) )
//#define G(x) ( Mask8(x >> 8 ) )
//#define B(x) ( Mask8(x >> 16) )
//#define A(x) ( Mask8(x >> 24) )
//
//#define BATA 63
//
//
//
//#define MR(x) (R(x)/BATA)
//#define MG(x) (G(x)/BATA)
//#define MB(x) (B(x)/BATA)
//#define MA(x) (A(x)/BATA)
//
//#define ConventColor(x) MR(x)*BATA+(MG(x)<<8)*BATA+(MB(x)<<16)*BATA+(MA(x)<<24)*BATA
//降低颜色分辨率


#import "imageTool.h"
@interface imageTool()
{


}


@end
@implementation imageTool

#pragma mark 处理图片
+(UIImageView*)logPixelsOfImage{
    
    
    
    Myimage*simg=[Myimage MyimageWithStr:@"qqq"];
    
//    Myimage*subimg=[Myimage MyimageWithMyimage:simg X:100 Y:100 Width:200 Height:200];
    
    
//    [subimg RuhuiHuaWithBata];
    return [simg getimageView];
    
    
//
//
//    //    / 1.
//
//    UIImage * ghostImage = [UIImage imageNamed:@"zbxq"];
//    CGImageRef inputCGImage = [ghostImage CGImage];
//    NSUInteger width =  CGImageGetWidth(inputCGImage);
//
//    //获取高度
//    NSUInteger height = CGImageGetHeight(inputCGImage);
//
//
//    NSLog(@"宽度：%lu",(unsigned long)width);
//    NSLog(@"高度:%lu",(unsigned long)height);
//
//    // 2.
//    //
//    //因为是rgba 所以是4
//    NSUInteger bytesPerPixel = 4;
//    //没一行的字节
//    NSUInteger bytesPerRow = bytesPerPixel *     width;
//    NSUInteger bitsPerComponent = 8;
//    //指针的数组集合
//    UInt32 * pixels;
//    pixels = (UInt32 *) calloc(height * width,     sizeof(UInt32));
//
//    // 3.
//    CGColorSpaceRef colorSpace =     CGColorSpaceCreateDeviceRGB();
//    CGContextRef context =     CGBitmapContextCreate(pixels, width, height,     bitsPerComponent, bytesPerRow, colorSpace,     kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
//
//    // 4.
//    CGContextDrawImage(context, CGRectMake(0,     0, width, height), inputCGImage);
//
//
//
//    // 1.
//
//
//    NSLog(@"Brightness of image:");
//
//
//
//
//
//    // 2.
//    UInt32 * currentPixel = pixels;
//    for (NSUInteger j = 0; j < height; j++) {
//        for (NSUInteger i = 0; i < width; i++) {
//            // 3.
//            UInt32 color = *currentPixel;
////            printf("%3.0f ",    255- (R(color)+G(color)+B(color))/3.0);
//
////            printf("%lu%lu%lu ",MR(color),MG(color),MB(color));
//
////            *currentPixel=ConventColor(color);
//            // 4.
//            currentPixel++;
//        }
////        printf("\n");
//    }
////    [self lin:pixels height:height width:width];
////    [self colorrect:pixels rect:CGRectMake(100, 100, 100, 100) height:height width:width];
//
////    myimage.currentPixel=pixels;
//
//    for (NSUInteger i=0; i<height; i++) {
//        [self hlin:pixels height:height width:width y:i];
//    }
//    for (NSUInteger i=0; i<width; i++) {
//        [self slin:pixels height:height width:width x:i];
//    }
//
//
//    for (NSUInteger i=0; i<width*height; i++) {
//        if (*(pixels+i)!=0xff000000) {
//            *(pixels+i)=0xffffffff;
//        };
//    }
//
//    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
//    UIImage * processedImage = [UIImage imageWithCGImage:newCGImage];
//    UIImageView*imv=[[UIImageView alloc]initWithImage:processedImage];
//
//    imv.frame=CGRectMake(0, 0, 320, 640);
////    [[UIApplication sharedApplication].keyWindow addSubview:imv];
//
//
//    // 5. Cleanup
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//
////    Myimage*imgviewobj=[Myimage new];
////    imgviewobj.currentPixel=pixels;
////    imgviewobj.width=width;
////    imgviewobj.height=height;
////
//    return imv;
}
#pragma mark  找出图片上的横线
/**************找出图片上的横线****************/
+(void)lin:(UInt32 *)currentPixel height:(NSUInteger) height width:(NSUInteger) width{
    

    NSUInteger x=500;
            for (UInt32 * f=(currentPixel+x); f<(currentPixel+height*width); f=f+width) {
                *f=0xff000000;
            }

    
    for (NSUInteger h=0; h<height; h++) {
        if (*(currentPixel+x+1+h*width)!=*(currentPixel+x+1+(h+1)*width)) {
            
            for (UInt32 * f=(currentPixel+h*width); f<(currentPixel+width+h*width); f++) {
                *f=0xff000000;
            }
            
        }
    
        
        
    }

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
//            isLink=isLink+1;
//            if (isLink==3) {
////                break;
//            }
            
        }
    }

}
#pragma mark  判断图片上的竖线是否是边界线染色
/**************判断图片上的竖线是否是边界线染色****************/

+(void)slin:(UInt32 *)currentPixel height:(NSUInteger) height width:(NSUInteger) width  x:(NSUInteger)x{
    
    int isLink;
    isLink=0;
    for (NSUInteger i=0; i<height; i++) {
        if (*(currentPixel+x+i*width)!=*(currentPixel+x+1+(i)*width)) {
            *(currentPixel+x+i*width)=0xff000000;
            
        }
    }
    
}


#pragma mark  为图片上的矩形块染色
/**************为图片上的矩形块染色****************/
+(void)colorrect:(UInt32 *)currentPixel rect:(CGRect)rect height:(NSUInteger) height width:(NSUInteger) width{
    
    
    for (NSUInteger j = 0; j < rect.size.height; j++) {
        for (NSUInteger i = 0; i < rect.size.width; i++) {

            
            *(currentPixel+(j+(int)(rect.origin.y))*width +i+(int)(rect.origin.x))=0xff000000;

        }
    }
    
}

#pragma mark  获取矩形
-(void)function{
    stuff ff;
    ff.height=123;
    ff.age=12;
    
    {int a=10;
        int *p;//定义了一个整数类型的指针
        p=malloc(sizeof(int)*a);//分配40个字节的内存空间
        *p=5;
        *(p+1)=6; //将分配的内存空间的前两个整数赋值为5和6
        free(p); //使用完之后释放内存空间
    }

    
    
}
@end
