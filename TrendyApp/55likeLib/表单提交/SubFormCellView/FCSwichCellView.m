//
//  FCSwichCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/14.
//  Copyright © 2019 55like. All rights reserved.
//

#import "FCSwichCellView.h"
@interface FCSwichCellView()
{
    
}
@property(nonatomic,strong) UISwitch *switchButton2 ;
@end
@implementation FCSwichCellView
-(void)addFCView{
    
    //    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
//    UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 8, 13) defaultimage:@"arrowr1" supView:self];
//    imgVRow.frameRX=15;
//    [imgVRow beCY];
    self.defaultTextfield.frameWidth=self.frameWidth-self.defaultTextfield.frameX-17-15;
    self.defaultTextfield.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[self.data ojsk:@"name"]];
    self.defaultTextfield.userInteractionEnabled=NO;
    self.defaultTextfield.hidden=YES;
//    [self addViewTarget:self select:@selector(selectBtnClick:)];

    UISwitch *switchButton2 = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 51, 30)];
    _switchButton2=switchButton2;
    //            [switchButton2 setOnTintColor:rgbpublicColor];
    [switchButton2 setTag:101];
    switchButton2.onTintColor=rgb(14,112,161);
    [switchButton2 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:switchButton2];
    [switchButton2 beCY];
    switchButton2.frameRX=15;
    
}
-(void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
}
-(void)setValueStr:(NSString *)valueStr{
    _switchButton2.on=[valueStr isEqualToString:@"1"]?YES:NO;
    
}
-(NSString *)valueStr{
    return _switchButton2.on?@"1":@"0";
}


//-(void)selectBtnClick:(UIView*)btn{
//    [UTILITY.currentViewController.view endEditing:YES];
//
//}
@end
