//
//  FCSelectCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCSelectCellView.h"
#import "SelectTimeView.h"
#import "SelectItemView.h"

@implementation FCSelectCellView
-(void)addFCView{
    
//    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 8, 13) defaultimage:@"arrowr1" supView:self];
    imgVRow.frameRX=15;
    [imgVRow beCY];
    self.defaultTextfield.frameWidth=self.frameWidth-self.defaultTextfield.frameX-17-15;
    self.defaultTextfield.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[self.data ojsk:@"name"]];
    self.defaultTextfield.userInteractionEnabled=NO;
    [self addViewTarget:self select:@selector(selectBtnClick:)];
}

-(void)selectBtnClick:(UIView*)btn{
    [UTILITY.currentViewController.view endEditing:YES];
    __weak __typeof(self) weakSelf = self;
    //    @"selectsubtype":@"timeselect",
    if ([[self.data ojsk:@"selectsubtype"] isEqualToString:@"timeselect"]||[[self.data ojsk:@"selectsubtype"] isEqualToString:@"dateselect"]||[[self.data ojsk:@"selectsubtype"] isEqualToString:@"yearselect"]) {
        UITextField*currentlb=self.defaultTextfield;
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        NSString*formStr=@"yyyy-MM-dd HH:mm";
        PGDatePickerMode pickerMode=PGDatePickerModeDateHourMinute;
        if ([[self.data ojsk:@"selectsubtype"] isEqualToString:@"dateselect"]) {
            formStr=@"yyyy-MM-dd";
            pickerMode=PGDatePickerModeDate;
        }else if ([[self.data ojsk:@"selectsubtype"] isEqualToString:@"yearselect"]) {
            formStr=@"yyyy";
            pickerMode=PGDatePickerModeYear;
        }
        [dateFormatter setDateFormat:formStr];
        NSDate *dateT=[dateFormatter dateFromString:currentlb.text];
        if (![currentlb.text notEmptyOrNull]) {
            dateT=[NSDate date];
        }
        SelectTimeView *dateView=[SelectTimeView showWithTime:[NSString stringWithFormat:@"%f",[dateT timeIntervalSince1970]] withCallBack:^(id data, int status, NSString *msg) {
            NSString*timestr= [dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970:[data integerValue]]];
            currentlb.text=timestr;
        }];
        {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy";
            //#warning 真机调试下, 必须加上这段
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [fmt dateFromString:@"1900"];
            NSDate *date=[fmt dateFromString:@"1900"];
            dateView.datePicker.minimumDate=date;
//            NSString*datestr=[fmt stringFromDate:date];
        }
        
        dateView.datePicker.datePickerMode = pickerMode;
        if ([[self.data ojsk:@"maximumDate"] isEqualToString:@"forever"]) {
            dateView.datePicker.minimumDate=[NSDate new];
            dateView.datePicker.maximumDate=nil;
        }
        
    }else if ([[self.data ojsk:@"selectsubtype"] isEqualToString:@"selectCate"]){
        //[self.data ojk:@"cateList"]
        SelectItemView *selectView=[SelectItemView showWithDataDic:@{@"list":[self.data ojk:@"cateList"], @"title":self.defaultTextfield.placeholder} WithBlock:^(id data, int status, NSString *msg) {
            if (status==200 && [data count]>0) {
                id dataTemp=[data objectAtIndex:0];
                weakSelf.defaultTextfield.text=[dataTemp ojsk:@"title"];
                weakSelf.defaultTextfield.data=dataTemp;
            }
        }];
    }else{
        [kFormCellService getCofigDicWithDicCode:[self.data ojsk:@"dictCode"] withBlock:^(id data, int status, NSString *msg) {
            if (status==200) {
                
                
//                UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[weakSelf.data ojsk:@"name"]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",kS(@"personalInfo", @"dialog_title_please_select")] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                for (int i=0; i< [[data ojk:@"baseDictItemList"] count]; i++) {
                    NSMutableDictionary*itemDic=[data ojk:@"baseDictItemList"][i];
                    [alertcv addAction:[UIAlertAction actionWithTitle:[itemDic ojsk:@"itemName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        weakSelf.defaultTextfield.text=[itemDic ojsk:@"itemName"];
                        
                        [weakSelf baseViewButtonClick:weakSelf];
                    }]];
                }
                [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"generalPage", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
                [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
                    
                }];
            }
        }];
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
