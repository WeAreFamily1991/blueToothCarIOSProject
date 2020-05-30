//
//  OFCSelectItemButtonCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/14.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OFCSelectItemButtonCellView.h"
@interface OFCSelectItemButtonCellView()
{
    
}
@property(nonatomic,strong)UIView*viewBG;
@end
@implementation OFCSelectItemButtonCellView
//- (void)addSimplicView{
//    NSMutableDictionary*data=self.data;
//    self.backgroundColor=rgbwhiteColor;
//    self.frameHeight=28;
//    UILabel*lbName=[RHMethods lableX:10 Y:0 W:0 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@:",[data ojsk:@"name"]] reuseId:@"lbNamelbName"];
//    [lbName beCY];
//    self.defaultNameLabel=lbName;
//    self.frameHeight=45;
//    [lbName beCY];
//    UILabel*lb1=[RHMethods lableX:lbName.frameXW+10 Y:lbName.frameY W:self.frameWidth-15-10-lbName.frameXW Height:0 font:14 superview:self withColor:rgb(102, 102, 102) text:@"   " reuseId:@"lb1lb1lb1"];
//    self.frameHeight=lb1.frameYH+lb1.frameY;
//    if (self.frameHeight<45) {
//        self.frameHeight=45;
//    }
//    self.defaultTextfield=(id)lb1;
//
//}
-(void)setValueStr:(NSString *)valueStr{
//    [super setValueStr:valueStr];
    [self.viewBG upDataMeWithData:valueStr];

}
- (NSString *)valueStr{
    
    UIView*viewContetn= [self getAddValueForKey:@"viewContetnCustom"];
    if (viewContetn) {
         UITextField*viewTf=[viewContetn getAddValueForKey:@"viewTf"];
        [self.data setObject:viewTf.text forKey:@"content"];
    }
    return (id)self.viewBG.data;
}

-(void)addFCView{
    //    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    self.defaultTextfield.hidden=YES;
    UIView*viewBG=[UIView viewWithFrame:CGRectMake(0, 55, kScreenWidth, 140) backgroundcolor:nil superView:self];
    viewBG.layer.cornerRadius=3;
    _viewBG=viewBG;
    __weak __typeof(self) weakSelf = self;
    [viewBG setAddUpdataBlock:^(id data, id weakme) {
        UIView*viewBG=weakme;
        float width=(weakSelf.frameWidth-30-20)/3.0;
        NSArray*itmeArray=data;
        for (UIView*btnItemView in weakSelf.subviews) {
            if (btnItemView.tag==2019) {
                btnItemView.hidden=YES;
            }
        }
        
        for (int i= 0; i<itmeArray.count; i++) {
            WSSizeButton*btnItem= [weakSelf getAddValueForKey:[NSString stringWithFormat:@"btnItem%d",i]];
            if (btnItem==nil) {
                btnItem=[RHMethods buttonWithframe:CGRectMake(15+i%3*(width+10), 0 + i/3*(44), width, 34) backgroundColor:nil text:@"提交" font:13 textColor:rgb(102, 102, 102) radius:3 superview:viewBG reuseId:[NSString stringWithFormat:@"btnItem%d",i]];
                btnItem.layer.borderColor=rgb(204, 204, 204).CGColor;
                btnItem.layer.borderWidth=1;
                [btnItem setTitleColor:rgb(255, 255, 255) forState:UIControlStateSelected];
                [btnItem addViewTarget:weakSelf select:@selector(btnItemClick:)];
                [btnItem setBackGroundImageviewColor:rgb(255, 255, 255) forState:UIControlStateNormal];
                [btnItem setBackGroundImageviewColor:rgb(25, 84, 140) forState:UIControlStateSelected];
                [btnItem setAddUpdataBlock:^(id data, id weakme) {
                    WSSizeButton*btnItem=weakme;
                    [btnItem setTitle:[data ojk:@"title"] forState:UIControlStateNormal];
                    btnItem.selected=[[data ojsk:@"status"] isEqualToString:@"1"];
                    btnItem.layer.borderWidth=btnItem.selected?0:1;
                }];
            }
            btnItem.hidden=NO;
            btnItem.tag=2019;
            [btnItem upDataMeWithData:itmeArray[i]];
            if (i==itmeArray.count-1) {
                viewBG.frameHeight=btnItem.frameYH;
            }
            
            
            if ([[itmeArray[i] ojsk:@"status"] isEqualToString:@"1"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [btnItem.data setObject:@"0" forKey:@"status"];
                    [weakSelf btnItemClick:btnItem];
                });
            }
        }
        weakSelf.frameHeight=viewBG.frameYH+15;
        weakSelf.defaultLineView.frameBY=0;
//        dispatch_after(dispatch_time(0, 0.1*NSEC_PER_SEC),dispatch_get_main_queue() , ^{
//
//            [[weakSelf mysuperTableView] reloadData];
//        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [[weakSelf mysuperTableView] reloadData];
        });
    }];
//    self.frameHeight=viewBG.frameYH+15;
//    self.defaultLineView.frameBY=0;
}

-(void)btnItemClick:(UIButton*)btn{
    
    if ([[self.data ojsk:@"ismulti"] isEqualToString:@"1"]) {
        
        [btn.data setObject:[[btn.data ojsk:@"status"] isEqualToString:@"1"]?@"0":@"1" forKey:@"status"];
        [btn upDataMe];
        
    }else{
        for (WSSizeButton*btnItemView in self.viewBG.subviews) {
            if (btnItemView.tag==2019&&btnItemView!=btn) {
                [btnItemView.data setObject:@"0" forKey:@"status"];
                if (btnItemView.selected) {
                    [btnItemView upDataMe];
                }
            }
        }
        [btn.data setObject:[[btn.data ojsk:@"status"] isEqualToString:@"1"]?@"0":@"1" forKey:@"status"];
        [btn upDataMe];
    }
      __weak __typeof(self) weakSelf = self;
    if (btn.selected&&[[btn.data ojsk:@"iscustom"] isEqualToString:@"1"]) {
        UIView*viewContetn= [self getAddValueForKey:@"viewContetnCustom"];
        if (viewContetn==nil) {
            viewContetn=[UIView viewWithFrame:CGRectMake(15, self.viewBG.frameYH, self.frameWidth-30, 44) backgroundcolor:rgb(246, 246, 246) superView:self reuseId:@"viewContetnCustom"];
            viewContetn.layer.cornerRadius=5;
             UITextField*viewTf=[RHMethods textFieldlWithFrame:CGRectMake(15, 0, viewContetn.frameWidth-30, viewContetn.frameHeight) font:Font(14) color:rgb(15, 15, 15) placeholder:@"" text:@""  supView:viewContetn reuseId:@"viewTf"];
            viewTf.text=[self.data ojsk:@"content"];
        }
        UITextField*viewTf=[viewContetn getAddValueForKey:@"viewTf"];
        viewTf.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseInput"),[btn.data ojsk:@"name"]];
        viewContetn.hidden=NO;
        viewContetn.frameY=self.viewBG.frameYH+15;
//        [viewContetn setAddValue:btn.data forKey:@""];
        viewContetn.data=btn.data;
        self.frameHeight=viewContetn.frameYH+15;
        self.defaultLineView.frameBY=0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [[weakSelf mysuperTableView] reloadData];
        });
    }else if(self.frameHeight>self.viewBG.frameYH+15+5){
        UIView*viewContetn= [self getAddValueForKey:@"viewContetnCustom"];
        viewContetn.hidden=YES;
        self.frameHeight=_viewBG.frameYH+15;
        self.defaultLineView.frameBY=0;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[weakSelf mysuperTableView] reloadData];
        });
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
