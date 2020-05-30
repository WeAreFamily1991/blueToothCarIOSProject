//
//  WSimageToolUse.m
//  jinYingWu
//
//  Created by 55like on 2017/11/20.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "WSimageToolUse.h"

#import "Myimage.h"


@implementation WSimageToolUse
-(void)start{
//    return;
//    imageTest
    [self imageWithPath:@"/Users/55like/Desktop/imageTest/testone"];
}

-(void)imageWithPath:(NSString*)pathStr{
    //    prixstr=@"abc_";
    //    pathStr=@"/Users/55like/Desktop/Payload/image";
    NSMutableArray*marray=[NSMutableArray new];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray*fillContent= [fm contentsOfDirectoryAtPath:pathStr error:nil];
    NSString*firstPath;
    NSString*className;
    
    for (NSString*spathStr in fillContent) {
        NSString*realPath=[NSString stringWithFormat:@"%@/%@",pathStr,spathStr];
        
       
        if ([spathStr.pathExtension isEqualToString:@"png"]) {
            
            if (className==nil) {
             NSRange range=   [spathStr rangeOfString:@".png"];
                className=[spathStr substringToIndex:range.location];
//                firstPath=[NSString stringWithFormat:@"%@/%@",pathStr,spathStr];
                firstPath=pathStr;
            }
//            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
           UIImageView*imageview=  [[UIImageView alloc]initWithImage:[UIImage imageNamed:realPath]];
            
//            imageview.image=[UIImage imageNamed:realPath];
            [marray addObject:imageview];
            
        }
    }
    UIScrollView*showsv=[UTILITY.currentViewController getAddValueForKey:@"mmmimage"];
    [UTILITY.currentViewController setAddValue:@"1" forKey:@"debug"];
    //    [showsv removeFromSuperview];
    
    
    if (showsv==nil) {
        showsv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth-2,kScreenHeight-60 )];
        showsv.layer.borderColor=[UIColor blueColor].CGColor;
        showsv.layer.borderWidth=1;
        [UTILITY.currentViewController setAddValue:showsv forKey:@"mmmimage"];
        [UTILITY.currentViewController.view  addSubview:showsv];
    }
    
    
    {
        
        
        Myimage*simge=[Myimage MyimageWithImage:(UIImage*)[marray.firstObject image]] ;
//        1 如果宽度大于320 的需要进行剪裁 宽度变成320 如果不是就返回自己
        
        [simge insertMeToScrollView];
        [simge RuhuiHuaWithBata];
        [simge findbind];
        [simge insertMeToScrollView];
        simge=[simge getLaggestRect320];
        
        [simge insertMeToScrollView];
 //   2     减掉边缘 四周的边缘全部减掉
        [simge RuhuiHuaWithBata];
        [simge findbind];
        
        [simge insertMeToScrollView];
        simge=[simge getLaggestRect];
//   3     获取识别出来的所有长方形
        [simge RuhuiHuaWithBata];
        [simge findbind];
        
        [simge insertMeToScrollView];
        NSMutableArray*imageMarray=  [simge getAllRects];
        
        UIImageView*imagev=[simge bianjianimage];
        [simge restarAll];
        
        NSMutableArray*myimageArray=  [simge getRectHeBing:imageMarray];
      
       myimageArray=  [simge get2RectHeBing:myimageArray];
        imagev.frame=CGRectMake(0, showsv.contentHeight+10, imagev.frame.size.width*1, imagev.frame.size.height*1);
        showsv.contentHeight=imagev.frameYH;
//        showsv.contentWidth=imagev.frameXW;
        [showsv addSubview:imagev];
        imagev.userInteractionEnabled=YES;
        for (Myimage*simgess in myimageArray) {
            UIImageView*imgview=[simgess getimageView];
                        [imgview addViewClickBlock:^(UIView *view) {
//                            [simgess colortongjiSuju];
                            [simgess logColorTongji];
                        }];
            [imagev addSubview:imgview];
        }
        
//        [simge writeMeHfileWithClassName:className];
        
          simge.filePath=firstPath;
        [WSimageToolUse writeFile:[NSString stringWithFormat:@"%@.h",className] data:[simge writeMeHfileWithClassName:className] withPath:firstPath];
        [WSimageToolUse writeFile:[NSString stringWithFormat:@"%@.m",className] data:[simge writeMeMfileWithClassName:className] withPath:firstPath];
        
      
    }
    
}

+(void)writeFile:(NSString*)fileName data:(NSString*)data withPath:(NSString*)pathStr

{
    NSString* doc_path =pathStr;
    //    doc_path=@"/Users/home/Desktop/mobile/";
    doc_path=pathStr;
    
    //NSLog(@"Documents Directory:%@",doc_path);
    
    //创建文件管理器对象
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
   NSString* realFileName = [doc_path stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] createDirectoryAtPath:doc_path withIntermediateDirectories:YES attributes:nil error:nil];
    //    if (![fm fileExistsAtPath:realFileName]){
    if ([fm createFileAtPath:realFileName contents:[data dataUsingEncoding:NSUTF8StringEncoding] attributes:nil]) {
        //        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@写入成功",fileName]];
        
    }else{
        
        //        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@写入失败",fileName]];
        
    }
    
    //    }
}


+(void)showMyDemo{
    [[WSimageToolUse new]start];
    
}
@end
