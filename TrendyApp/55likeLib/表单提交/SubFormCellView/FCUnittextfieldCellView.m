//
//  FCUnittextfieldCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCUnittextfieldCellView.h"

@implementation FCUnittextfieldCellView

-(void)addSimplicView{
    NSMutableDictionary*data=self.data;
    self.backgroundColor=rgbwhiteColor;
    self.frameHeight=28;
    UILabel*lbName=[RHMethods lableX:10 Y:0 W:0 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@:",[data ojsk:@"name"]]];
    [lbName beCY];
    self.defaultNameLabel=lbName;
    UILabel*lbTf=[RHMethods lableX:lbName.frameXW+10 Y:lbName.frameY W:self.frameWidth-lbName.frameXW-10-15 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:@"      "];
    lbTf.textAlignment=NSTextAlignmentRight;
    self.defaultTextfield=(id)lbTf;
    UILabel*lbUnit=[RHMethods RlableRX:15 Y:0 W:0 Height:self.frameHeight font:14 superview:self withColor:rgb(51, 51, 51) text:[data ojsk:@"unit"]];
    lbTf.frameWidth=lbTf.frameWidth-lbUnit.frameWidth-10;
}

-(void)addFCView{
//    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    NSMutableDictionary*data=self.data;
    UILabel*lbUnit=[RHMethods RlableRX:15 Y:0 W:0 Height:self.frameHeight font:14 superview:self withColor:rgb(51, 51, 51) text:[data ojsk:@"unit"]];
//    lbUnit.backgroundColor=rgbRedColor;
    self.defaultTextfield.frameWidth=self.frameWidth-self.defaultTextfield.frameX-10-lbUnit.frameWidth-15;
    self.defaultTextfield.keyboardType=UIKeyboardTypeDecimalPad;
    if ([[self.data ojsk:@"keyboardType"] isEqualToString:@"UIKeyboardTypeNumberPad"]) {
        self.defaultTextfield.keyboardType=UIKeyboardTypeNumberPad;
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
