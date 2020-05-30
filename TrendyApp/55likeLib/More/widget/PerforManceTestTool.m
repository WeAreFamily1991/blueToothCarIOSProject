//
//  PerforManceTestTool.m
//  55likeLibDemo
//
//  Created by 55like on 2017/10/30.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "PerforManceTestTool.h"

@implementation PerforManceTestTool
+(float)testPerforManceWithName:(NSString*)name WithTimes:(NSInteger)times With:(AllcallBlock)block{
    if (times==0) {
        times=1000000;
    }
    
    NSDate*date=[NSDate new];
    for (int i=0; i<times; i++) {
        block(nil,i,nil);
    }
    
    NSDate*date2=[NSDate new];
    //    ;
    NSLog(@"%@ %f",name,date2.timeIntervalSince1970-date.timeIntervalSince1970);
    return date2.timeIntervalSince1970-date.timeIntervalSince1970;
    
}
+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    UIScrollView*scro_sview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight+60, kScreenWidth, kScreenHeight-kTopHeight-60)];
    [s_view addSubview:scro_sview];
    
    float yAdd=kTopHeight;
    
    UILabel*lb1=[RHMethods lableX:100 Y:100 W:100 Height:20 font:12 superview:s_view withColor:rgbRedColor text:@"测试测试测试"];
    lb1.layer.borderColor=rgbRedColor.CGColor;
    
    UIImageView*myimge=[[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 20)];
    [s_view addSubview:myimge];
    myimge.image=[UIImage imageNamed:@"listimg"];
    lb1.alpha=0.3;
    myimge.alpha=0.3;
    lb1.numberOfLines=0;
    UIColor* redcolor=rgbRedColor;
    UITextField*tfx;
    {
        UILabel*lb1=[RHMethods lableX:10 Y:yAdd+10 W:0 Height:40 font:15 superview:s_view withColor:nil text:@"重复次数"];
        UITextField*tf1=[RHMethods textFieldlWithFrame:CGRectMake(lb1.frameXW+10, lb1.frameY, 200, 40) font:Font(15) color:rgbRedColor placeholder:@"重复次数" text:@"1000"];
        [s_view addSubview:tf1];
        tfx=tf1;
        
        yAdd=lb1.frameYH+10;
    }
    yAdd=0;
    {
        NSString*title=@"什么也不做";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置text";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                
                lb1.text=@"测试测试测试测试测试测试测试测试测试测试测试测试";
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置frame";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                
                lb1.frameWidth=150;
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置addview";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                
                [lb1.superview addSubview:lb1];

            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置判断addview";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                if (lb1.superview!=UTILITY.currentViewController.view) {
                    
                    [UTILITY.currentViewController.view addSubview:lb1];
                }
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    
    {
        NSString*title=@"设置textColor" ;
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
              lb1.textColor=   RGBCOLOR(233,71,9);
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置Clore  不新建";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                 lb1.textColor=redcolor;
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置Layer";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                lb1.layer.borderWidth=1;
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    
    NSString*textStr=@"textStr";
    {
        NSString*title=@"判断字符串直接" ;
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                if (![textStr isEqualToString:@"textStr"]) {
                    
                }
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"判断字符串间接";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                if (![textStr isEqualToString:[NSString stringWithFormat:@"%@",@"textStr"]]) {
                    
                    //                    myimge.image=[UIImage imageNamed:@"listimg"];
                }
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    int panduanNumber=10000;
    {
        NSString*title=@"int判断";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                if (panduanNumber==10000) {
                    
                    //                    myimge.image=[UIImage imageNamed:@"listimg"];
                }
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    float panduanfloat=10000.000;
    {
        NSString*title=@"float判断";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                if (panduanfloat==10000.000) {
                    
                    //                    myimge.image=[UIImage imageNamed:@"listimg"];
                }
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"对象判断";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                if (title==nil) {
                    
                    //                    myimge.image=[UIImage imageNamed:@"listimg"];
                }
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    {
        NSString*title=@"设置imageurl";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                    [myimge imageWithURL:@"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=3359324599,3638334535&fm=85&s=58038918AA8ABE052507C09C0300F0A0"];
                    
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }

    {
        NSString*title=@"setObj判断";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                [btnxx setAddValue:title forKey:@"mytitle"];
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    {
        NSString*title=@"lbble 自适应";
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd, kScreenWidth-20, 20) backgroundColor:rgbBlue text:title font:15 textColor:[UIColor whiteColor] radius:4 superview:scro_sview];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            UIButton*btnxx=(UIButton*)view;
            float needtime=   [PerforManceTestTool testPerforManceWithName:title WithTimes:tfx.text.integerValue With:^(id data, int status, NSString *msg) {
                [mdic setValue:@"did" forKey:[NSString stringWithFormat:@"东方卡大富科技个%d",status]];
//                [btnxx setAddValue:title forKey:@"mytitle"];
                
//                 CGSize size =  [lb1 sizeThatFits:CGSizeMake(10, 1000)];
//                lb1.frameSize=CGSizeMake(10, 1000);
                
//                lb1.frameHeight=[lb1.text getHeightByWidth:100 font:lb1.font];
//                CGSize size = [lb1.text sizeWithFont:[UIFont boldSystemFontOfSize:17.0f] constrainedToSize:CGSizeMake(100, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//                CGSize size=[lb1.text labelAutoCalculateRectWith:lb1.text FontSize:lb1.font.pointSize MaxSize:CGSizeMake(100, MAXFLOAT)];
//                lb1.frameHeight=size.height;
//                [lb1.text sizew]dd
//                [lb1.text sizeWithConstrainedToSize:CGSizeMake(100, MAXFLOAT) fromFont:lb1.font lineBreakMode:NSLineBreakByClipping];
            }];
            [btnxx setTitle:[NSString stringWithFormat:@"%@ %f",title,needtime] forState:UIControlStateNormal];
            
        }];
        yAdd=btn1.frameYH+10;
        scro_sview.contentHeight=yAdd;
    }

    
}
@end
