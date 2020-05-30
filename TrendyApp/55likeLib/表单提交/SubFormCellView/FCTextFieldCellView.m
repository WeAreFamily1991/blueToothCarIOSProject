//
//  FCTextFieldCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCTextFieldCellView.h"
@interface FCTextFieldCellView()<UITextFieldDelegate>
{
    
}
@end
@implementation FCTextFieldCellView
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
    
    lb1.textAlignment=NSTextAlignmentRight;
    if (self.frameHeight<=45) {
        self.frameHeight=45;
        
//        lb1.textAlignment=NSTextAlignmentRight;
    }else{
        
//        lb1.textAlignment=NSTextAlignmentLeft;
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
        
    }
}

 
-(void)addFCView{
//    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    if ([[self.data ojsk:@"keyboardType"] isEqualToString:@"UIKeyboardTypeNumberPad"]) {
        self.defaultTextfield.keyboardType=UIKeyboardTypeNumberPad;
    }else if ([[self.data ojsk:@"keyboardType"] isEqualToString:@"UIKeyboardTypeDecimalPad"]) {
        self.defaultTextfield.keyboardType=UIKeyboardTypeDecimalPad;
    }
    if ([[self.data ojsk:@"name"] isEqualToString:@"联系方式"]||[[self.data ojsk:@"requestkey"] rangeOfString:@"Phone"].length>3 ||[[self.data ojsk:@"requestkey"] rangeOfString:@"phone"].length>3 ) {
        
        self.defaultTextfield.keyboardType=UIKeyboardTypePhonePad;
//        self.defaultTextfield.delegate=self;
    }
    
        
}
-(BOOL)textField:(UITextField *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textView==self.defaultTextfield) {
        if ([[self.data ojsk:@"name"] isEqualToString:@"联系方式"]||[[self.data ojsk:@"requestkey"] rangeOfString:@"Phone"].length>3 ||[[self.data ojsk:@"requestkey"] rangeOfString:@"phone"].length>3 ) {
            if (textView.text.length+string.length>11) {
                [SVProgressHUD showImage:nil status:@"手机号最多为11位！"];
                return NO;
            }
        }
        
    }
    
    return YES;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
