//
//  FCSelectCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCSelectIdCellView.h"
#import "SelectDateView.h"

@implementation FCSelectIdCellView
-(void)addFCView{
    
//    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 8, 13) defaultimage:@"right02" supView:self];
    imgVRow.frameRX=15;
    [imgVRow beCY];
    self.defaultTextfield.frameWidth=self.defaultTextfield.frameWidth-17;
    self.defaultTextfield.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[self.data ojsk:@"name"]];
    self.defaultTextfield.userInteractionEnabled=NO;
    [self addViewTarget:self select:@selector(selectBtnClick:)];
}

-(void)selectBtnClick:(UIView*)btn{
    [UTILITY.currentViewController.view endEditing:YES];
    __weak __typeof(self) weakSelf = self;
    
    [kFormCellService getCofigDicWithDicCode:[self.data ojsk:@"dictCode"] withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[weakSelf.data ojsk:@"name"]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];

            for (int i=0; i< [[data ojk:@"baseDictItemList"] count]; i++) {
                NSMutableDictionary*itemDic=[data ojk:@"baseDictItemList"][i];
                [alertcv addAction:[UIAlertAction actionWithTitle:[itemDic ojsk:@"itemName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    weakSelf.defaultTextfield.text=[itemDic ojsk:@"itemName"];
                    [weakSelf.defaultTextfield setAddValue:[itemDic ojsk:@"id"] forKey:@"id"];

                    [weakSelf baseViewButtonClick:weakSelf];
                }]];
            }
            [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"personalInfo", @"dialog_button_cancel") style:UIAlertActionStyleCancel handler:nil]];
            [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{

            }];
        }
    }];
}
-(NSString *)valueStr{
    return [self.defaultTextfield getAddValueForKey:@"id"];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
