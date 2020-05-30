//
//  FCTUnitTextfieldCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/12/20.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCTUnitTextfieldCellView.h"
@interface FCTUnitTextfieldCellView()
{
    
}
@property(nonatomic,strong)UITextField*tfBig;

@property(nonatomic,strong)UITextField*tfSmall;

@end
@implementation FCTUnitTextfieldCellView

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
    self.defaultTextfield.hidden=YES;
     UITextField*tfTf=[RHMethods textFieldlWithFrame:CGRectMake(0, 0, 80, self.defaultTextfield.frameHeight) font:Font(14) color:rgb(51, 51, 51) placeholder:@"最高" text:@""  supView:self];
    tfTf.frameRX=self.frameWidth-lbUnit.frameX+7;
    
    _tfBig=tfTf;
    
    UILabel*lbUnit2=[RHMethods RlableRX:self.frameWidth-tfTf.frameX+7 Y:0 W:0 Height:self.frameHeight font:14 superview:self withColor:rgb(51, 51, 51) text:[NSString stringWithFormat:@"%@　～",[data ojsk:@"unit"]]];
    
    UITextField*tfTf2=[RHMethods textFieldlWithFrame:CGRectMake(0, 0, 80, self.defaultTextfield.frameHeight) font:Font(14) color:rgb(51, 51, 51) placeholder:@"最低" text:@""  supView:self];
    tfTf2.frameRX=self.frameWidth-lbUnit2.frameX+7;
    
    tfTf.textAlignment=NSTextAlignmentRight;
    tfTf2.textAlignment=NSTextAlignmentRight;
    tfTf.keyboardType=UIKeyboardTypeDecimalPad;
    tfTf2.keyboardType=UIKeyboardTypeDecimalPad;
    
    if ([[self.data ojsk:@"keyboardType"] isEqualToString:@"UIKeyboardTypeNumberPad"]) {
        tfTf2.keyboardType=UIKeyboardTypeNumberPad;
        tfTf.keyboardType=UIKeyboardTypeNumberPad;
    }
    _tfSmall=tfTf2;
    if ([[self.data ojsk:@"bigPlaceHoleder"] notEmptyOrNull]) {
        _tfBig.placeholder=[self.data ojsk:@"bigPlaceHoleder"];
    }
    if ([[self.data ojsk:@"smallPlaceHoleder"] notEmptyOrNull]) {
        _tfSmall.placeholder=[self.data ojsk:@"smallPlaceHoleder"];
    }
    
    
}
-(NSString *)valueStr{
    if ([[self.data ojsk:@"isMust"] isEqualToString:@"1"]) {
        if (![_tfSmall.text notEmptyOrNull]||![_tfBig.text notEmptyOrNull]) {
            return @"";
        }
    }
    self.defaultTextfield.text=[NSString stringWithFormat:@"%@~%@",_tfSmall.text,_tfBig.text];
    return self.defaultTextfield.text;
}

-(void)setValueStr:(NSString *)valueStr{
   NSArray*array= [valueStr componentsSeparatedByString:@"~"];
    _tfSmall.text=array.firstObject;
    _tfBig.text=array.lastObject;
    self.defaultTextfield.text=valueStr;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
