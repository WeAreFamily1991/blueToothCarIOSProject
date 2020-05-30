//
//  WSimageToolUseList.m
//  55likeLibDemo
//
//  Created by 55like on 2017/12/5.
//  Copyright © 2017年 55like lj. All rights reserved.
//

//
//  WSimageToolUse.m
//  jinYingWu
//
//  Created by 55like on 2017/11/20.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "WSimageToolUseList.h"

#import "Myimage.h"


@implementation WSimageToolUseList
-(void)start{
    //    return;
    //    imageTest
    [self imageWithPath:@"/Users/55like/Desktop/imageTest/testlist"];
}

-(void)imageWithPath:(NSString*)pathStr{
    //    prixstr=@"abc_";
    //    pathStr=@"/Users/55like/Desktop/Payload/image";
    NSMutableArray*marray=[NSMutableArray new];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray*fillContent= [fm contentsOfDirectoryAtPath:pathStr error:nil];
//    NSString*firstPath;
//    NSString*className;
    
    for (NSString*spathStr in fillContent) {
        NSString*realPath=[NSString stringWithFormat:@"%@/%@",pathStr,spathStr];
        
        
        if ([spathStr.pathExtension isEqualToString:@"png"]) {
            
            NSRange range=   [spathStr rangeOfString:@".png"];
//            if (className==nil) {
//                className=[spathStr substringToIndex:range.location];
//                //                firstPath=[NSString stringWithFormat:@"%@/%@",pathStr,spathStr];
//                firstPath=pathStr;
//            }
            //            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
            UIImageView*imageview=  [[UIImageView alloc]initWithImage:[UIImage imageNamed:realPath]];
            
            NSMutableDictionary*mdic=[NSMutableDictionary new];
            
            [mdic setObject:pathStr forKey:@"pathStr"];
            [mdic setObject:[spathStr substringToIndex:range.location] forKey:@"className"];
            [mdic setObject:imageview forKey:@"imageview"];
//            imageview.image
            [marray addObject:mdic];
            
        }
    }
    UIScrollView*showsv=[UTILITY getAddValueForKey:@"mmmimage"];
    [showsv removeFromSuperview];
    
   
       showsv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth-2,kScreenHeight-60 )];
    showsv.layer.borderColor=[UIColor blueColor].CGColor;
    showsv.layer.borderWidth=1;
    
    [UTILITY setAddValue:showsv forKey:@"mmmimage"];
    
    [UTILITY.currentViewController.view  addSubview:showsv];
    
    for (int i=0; i<marray.count; i++){
        NSDictionary*datadic=marray[i];
            NSString*firstPath=[datadic objectForJSONKey:@"pathStr"];
            NSString*className=[datadic objectForJSONKey:@"className"];;
        firstPath=[NSString stringWithFormat:@"%@/code",firstPath];
        
        Myimage*simge=[Myimage MyimageWithImage:(UIImage*)[[datadic objectForKey:@"imageview"] image]] ;
        //        1 如果宽度大于320 的需要进行剪裁 宽度变成320 如果不是就返回自己
        [simge RuhuiHuaWithBata];
        [simge findbind];
        
        simge=[simge getLaggestRect320];
        
        //   2     减掉边缘 四周的边缘全部减掉
        [simge RuhuiHuaWithBata];
        [simge findbind];
        simge=[simge getLaggestRect];
        //   3     获取识别出来的所有长方形
        [simge RuhuiHuaWithBata];
        [simge findbind];
        
        NSMutableArray*imageMarray=  [simge getAllRects];
        
        UIImageView*imagev=[simge bianjianimage];
        [simge restarAll];
        
        NSMutableArray*myimageArray=  [simge getRectHeBing:imageMarray];
        
        myimageArray=  [simge get2RectHeBing:myimageArray];
        imagev.frame=CGRectMake(0, showsv.contentHeight+20, imagev.frame.size.width*9, imagev.frame.size.height*9);
        showsv.contentHeight=imagev.frameYH;
        
        showsv.contentHeight=imagev.frameYH;
        if (showsv.contentWidth<imagev.frameXW) {
            
            showsv.contentWidth=imagev.frameXW;
        }
        [showsv addSubview:imagev];
        imagev.userInteractionEnabled=YES;
        for (Myimage*simgess in myimageArray) {
            UIImageView*imgview=[simgess getimageView];
            [imgview addViewClickBlock:^(UIView *view) {
//                                            [simgess colortongjiSuju];
                [simgess logColorTongji];
            }];
            [imagev addSubview:imgview];
        }
        
        //        [simge writeMeHfileWithClassName:className];
        
        simge.filePath=firstPath;
        
        
//
        [WSimageToolUseList writeFile:[NSString stringWithFormat:@"%@_small.png",className] data: UIImagePNGRepresentation([simge getimageView].image) withPath:firstPath];
        [WSimageToolUseList writeFile:[NSString stringWithFormat:@"%@.h",className] data:[[simge writeMeHfileWithClassName:className] dataUsingEncoding:NSUTF8StringEncoding] withPath:firstPath];
        [WSimageToolUseList writeFile:[NSString stringWithFormat:@"%@.m",className] data:[[simge writeMeMfileWithClassName:className]  dataUsingEncoding:NSUTF8StringEncoding] withPath:firstPath];
        
        
    }
    
}

+(void)writeFile:(NSString*)fileName data:(NSData*)data withPath:(NSString*)pathStr

{
//    [data dataUsingEncoding:NSUTF8StringEncoding]
    NSString* doc_path =pathStr;
    //    doc_path=@"/Users/home/Desktop/mobile/";
    doc_path=pathStr;
    
    //NSLog(@"Documents Directory:%@",doc_path);
    
    //创建文件管理器对象
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString* realFileName = [doc_path stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] createDirectoryAtPath:doc_path withIntermediateDirectories:YES attributes:nil error:nil];
    //    if (![fm fileExistsAtPath:realFileName]){
    if ([fm createFileAtPath:realFileName contents:data attributes:nil]) {
        //        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@写入成功",fileName]];
        
    }else{
        
        //        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@写入失败",fileName]];
        
    }
    
    //    }
}


+(void)showMyDemo{
    [[WSimageToolUseList new]start];
    
}


//-(void)writePNG{
//
//    NSFileManager *fm = [NSFileManager defaultManager];
//
//    NSString* realFileName = [NSString stringWithFormat:@"%@/%@/%@_%@@2x.png",self.superMyImage.filePath,self.superMyImage.myClassNameStr,self.superMyImage.myClassNameStr,self.writeVariableName];
//    //        NSString* realFileName = [NSString stringWithFormat:@"%@/%@@2x.png",self.superMyImage.filePath,self.writeVariableName];
//    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/",self.superMyImage.filePath,self.superMyImage.myClassNameStr] withIntermediateDirectories:YES attributes:nil error:nil];
//    NSData *data;
//    data =UIImagePNGRepresentation([self getimageViewPNG].image);
//    if ([fm createFileAtPath:realFileName contents:data attributes:nil]) {
//        //        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@写入成功",fileName]];
//
//    }else{
//
//        //        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@写入失败",fileName]];
//
//    }
//}

@end

