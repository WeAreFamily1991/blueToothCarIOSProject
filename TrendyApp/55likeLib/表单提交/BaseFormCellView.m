//
//  BaseFormCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "BaseFormCellView.h"
#import "FCLineCellView.h"
#import "FCImportancelineCellView.h"
#import "FCTextFieldCellView.h"
#import "FCOnlyInputCellView.h"
#import "FCSelectCellView.h"
#import "FCImageSelectCellView.h"
#import "FCUnittextfieldCellView.h"
#import "FCTextCellView.h"
@interface BaseFormCellView()<UITextFieldDelegate>
{
    UITextField * _defaultTextfield;
}
@end
@implementation BaseFormCellView

-(void)setDefaultTextfield:(UITextField *)defaultTextfield{
    _defaultTextfield=defaultTextfield;
    if ([_defaultTextfield isKindOfClass:[UITextField class]]) {
        if ([[self.data ojsk:@"checkRule"] notEmptyOrNull]) {
            _defaultTextfield.delegate=self;
        }
    }
}

-(UITextField *)myTextfield{
    return _defaultTextfield;
}

-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
          __weak __typeof(self) weakSelf = self;
//          __weak __typeof(_defaultTextfield) weak_defaultTextfield = _defaultTextfield;
        [self setAddUpdataBlock:^(id data, id weakme) {
            weakSelf.backgroundColor=rgbwhiteColor;
            if ([[data ojsk:@"isSimplicity"] isEqualToString:@"1"]) {
                [weakSelf addSimplicView];
            }else{
                [weakSelf addFCView];
            }
            if ([[data ojsk:@"placeholder"]notEmptyOrNull]&& [[weakSelf real_defaultTextfield] respondsToSelector:@selector(setPlaceholder:)]) {
                [weakSelf real_defaultTextfield].placeholder=[data ojsk:@"placeholder"];
            }
            NSString*str=[data ojk:@"valueStr"];
            if (str||([str isKindOfClass:[NSString class]]&&[str notEmpty])) {
                [weakSelf setValueStr:str];
            }
        }];
    }
}
-(UILabel *)defaultNameLabel{
    if (_defaultNameLabel==nil) {
        UILabel*lbName=[RHMethods lableX:15 Y:0 W:0 Height:self.frameHeight font:16 superview:self withColor:rgb(51, 51, 51) text:[NSString stringWithFormat:@"%@*",[self.data ojsk:@"name"]]];
        _defaultNameLabel=lbName;
//        if ([[self.data ojsk:@"isMust"] isEqualToString:@"1"]) {
//            [lbName setColor:rgb(255, 81, 0) contenttext:@"*"];
//        }else{
            lbName.text=[self.data ojsk:@"name"];
//        }
    }
    return _defaultNameLabel;
}


-(UITextField *)real_defaultTextfield{

    return _defaultTextfield;
}
-(UITextField *)defaultTextfield{
    if (_defaultTextfield==nil) {
        UITextField*tfText=[RHMethods textFieldlWithFrame:CGRectMake(_defaultNameLabel.frameXW+15, 0, self.frameWidth-30-_defaultNameLabel.frameXW, self.frameHeight) font:Font(14) color:rgb(51, 51, 51) placeholder:[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseInput"),[self.data ojsk:@"name"]] text:@""  supView:self];
        tfText.textAlignment=NSTextAlignmentRight;
        
        [self setDefaultTextfield:tfText];
    }
    return _defaultTextfield;
}
-(UIView *)defaultLineView{
    if (_defaultLineView==nil) {
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
        _defaultLineView=viewLine;
    }
    return _defaultLineView;
}



-(NSMutableDictionary *)getDataAndValueStrDic{
    NSString*valueStr=[self valueStr];
    if (valueStr) {
        if ([valueStr isKindOfClass:[NSString class]]) {
            if ([valueStr notEmptyOrNull]) {
                [self.data setObject:valueStr forKey:@"valueStr"];
            }else{
//                [self.data removeObjectForKey:@"valueStr"];
                
                [self.data setObject:@"" forKey:@"valueStr"];
            }
        }else{
            [self.data setObject:valueStr forKey:@"valueStr"];
        }
    }
    if ([_defaultTextfield respondsToSelector:@selector(placeholder)]&&_defaultTextfield.placeholder) {
        [self.data setObject:_defaultTextfield.placeholder forKey:@"placeholder"];
    }
    return self.data;
}



- (NSMutableArray *)getNoUploadImageViewArray{return nil;}

-(void)setValueStr:(NSString *)valueStr{if([valueStr isKindOfClass:[NSString class]]) _defaultTextfield.text=valueStr;}
-(NSString *)valueStr{return  _defaultTextfield.text;}
-(void)addSimplicView{
    NSMutableDictionary*data=self.data;
    self.backgroundColor=rgbwhiteColor;
    self.frameHeight=28;
    UILabel*lbName=[RHMethods lableX:10 Y:0 W:0 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:[NSString stringWithFormat:@"%@:",[data ojsk:@"name"]]];
    [lbName beCY];
    _defaultNameLabel=lbName;
    UILabel*lbTf=[RHMethods lableX:lbName.frameXW+10 Y:lbName.frameY W:self.frameWidth-lbName.frameXW-10-15 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:@"      "];
    lbTf.textAlignment=NSTextAlignmentRight;
    _defaultTextfield=(id)lbTf;
}
-(void)addFCView{}


-(UITableView*)mysuperTableView{
    UITableView*tableview=(id)self.superview;
    for (int i=0; i<10; i++) {
        if ([tableview isKindOfClass:[UITableView class]]) {
            return tableview;
        }else{
            tableview=(id)tableview.superview;
        }
    }
    return nil ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


    
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    if (![textField.text notEmptyOrNull]) {
//        return YES;
//    }
//    
//    krequestParam
//    [dictparam setValue:textField.text forKey:@"content"];
//    [dictparam setValue:[self.data ojsk:@"checkRule"] forKey:@"type"];
//    [NetEngine createHttpAction:@"member/checkRule" withCache:NO withParams:dictparam withMask:SVProgressHUDMaskTypeNone onCompletion:^(id resData, BOOL isCache) {
//        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
//            //                NSDictionary *dicData=[resData objectForJSONKey:@"data"];
//        }else{
////            [textField becomeFirstResponder];
//            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
//        }
//    } onError:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:alertErrorTxt];
//    }];
//    return YES;
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField endEditing:YES];
//    return YES;
//}

@end
