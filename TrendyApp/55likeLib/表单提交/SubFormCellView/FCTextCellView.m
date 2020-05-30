//
//  FCTextCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCTextCellView.h"

@implementation FCTextCellView
- (void)addSimplicView{
    NSMutableDictionary*data=self.data;
    self.backgroundColor=rgbwhiteColor;
    self.frameHeight=28;
    UILabel*lbName=[RHMethods lableX:10 Y:0 W:0 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@:",[data ojsk:@"name"]] reuseId:@"lbNamelbName"];
    [lbName beCY];
    self.defaultNameLabel=lbName;
    self.frameHeight=45;
    [lbName beCY];
    UILabel*lb1=[RHMethods lableX:lbName.frameXW+10 Y:lbName.frameY W:self.frameWidth-15-10-lbName.frameXW Height:0 font:14 superview:self withColor:rgb(102, 102, 102) text:@"   " reuseId:@"lb1lb1lb1"];
    self.frameHeight=lb1.frameYH+lb1.frameY;
    if (self.frameHeight<45) {
        self.frameHeight=45;
    }
    self.defaultTextfield=(id)lb1;
    
}
-(void)setValueStr:(NSString *)valueStr{
    [super setValueStr:valueStr];
    if ([self.defaultTextfield isKindOfClass:[UILabel class]]) {
        UILabel*lb1=(id)self.defaultTextfield;
        UILabel*lbName= [self getAddValueForKey:@"lbNamelbName"];
       lb1=[RHMethods lableX:lbName.frameXW+10 Y:lbName.frameY W:self.frameWidth-15-10-lbName.frameXW Height:0 font:14 superview:self withColor:rgb(102, 102, 102) text:@"   " reuseId:@"lb1lb1lb1"];
        
        float oldheight= self.frameHeight;
        self.frameHeight=lb1.frameYH+lb1.frameY;
        
        if (self.frameHeight<45) {
            self.frameHeight=45;
        }
        if (oldheight!=self.frameHeight) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self request1];
            
                [[self mysuperTableView] reloadData];
            });
        }
        
    }else if([[self.data ojsk:@"isNoEdite"] isEqualToString:@"1"]){
        
        float oldheight= self.frameHeight;
        self.defaultTextfield.frameHeight=[valueStr HEIGHTwF:self.defaultTextfield.font.pointSize W:self.defaultTextfield.frameWidth]*1.25;
        if (self.defaultTextfield.frameHeight<45) {
            self.defaultTextfield.frameHeight=45;
        }
        self.defaultTextfield.superview.frameHeight=self.defaultTextfield.frameYH+15;
        self.frameHeight=self.defaultTextfield.superview.frameYH+15;
       
        if (oldheight!=self.frameHeight) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[self mysuperTableView] reloadData];
            });
        }
        
    }
}
 
-(void)addFCView{
//    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    
    self.defaultTextfield.hidden=YES;
    UIView*viewBG=[UIView viewWithFrame:CGRectMake(15, 50, kScreenWidth-30, 140) backgroundcolor:rgb(246, 246, 246) superView:self];
    viewBG.layer.cornerRadius=3;
    PLTextView*viewTv=[PLTextView viewWithFrame:CGRectMake(15, 15, viewBG.frameWidth-30, viewBG.frameHeight-30) backgroundcolor:nil superView:viewBG];
    if ([[self getAddValueForKey:@"maxtxtnumber"] isEqualToString:@"0"]) {
        
        viewTv.placeholder=[NSString stringWithFormat:@"%@",self.defaultTextfield.placeholder];
        [viewTv setAddValue:@"100000" forKey:@"maxtxtnumber"];
    }else{
        viewTv.placeholder=[NSString stringWithFormat:@"%@，限制200字以内",self.defaultTextfield.placeholder];
        [viewTv setAddValue:@"200" forKey:@"maxtxtnumber"];
    }
   
    viewTv.font=Font(14);
    self.defaultTextfield=(id)viewTv;
    self.frameHeight=viewBG.frameYH+15;
    self.defaultLineView.frameBY=0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
