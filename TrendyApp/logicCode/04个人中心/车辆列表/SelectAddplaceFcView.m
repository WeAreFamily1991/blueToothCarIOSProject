//
//  FCSelectCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "SelectAddplaceFcView.h"
#import "SelectDateView.h"
//#import "AutomobileBrandModelViewController.h"
#import "CityListSelectViewController.h"
@interface SelectAddplaceFcView()
{
    
}
@property(nonatomic,strong)NSMutableDictionary*carModeldata;
@end
@implementation SelectAddplaceFcView
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
-(void)loadMyDataWithBlock:(AllcallBlock)block{
    if (_carModeldata) {
        block(_carModeldata,200,nil);
        return;
    }
    __weak __typeof(self) weakSelf = self;
//    [kCarCenterService welcome_cityList:@{} withBlock:^(id data, int status, NSString *msg) {
//        if (weakSelf.carModeldata) {
//            block(weakSelf.carModeldata,200,nil);
//            return;
//        }
//        weakSelf.carModeldata=data;
//        block(weakSelf.carModeldata,200,nil);
//    }];
    [kCarCenterService welcome_getcity:@{} withBlock:^(id data, int status, NSString *msg) {
        if (weakSelf.carModeldata) {
            block(weakSelf.carModeldata,200,nil);
            return;
        }
        weakSelf.carModeldata=data;
        block(weakSelf.carModeldata,200,nil);
    }];
}

-(NSString *)valueStr{
    for (NSDictionary*dic in _carModeldata[@"list"]) {
        for (NSDictionary*sdic in dic[@"addresses"]) {
            if ([[sdic ojsk:@"selected"] isEqualToString:@"1"]) {
                NSMutableDictionary*mdic=[NSMutableDictionary new];
                [mdic setObject:[dic ojsk:@"id"] forKey:@"city"];
                [mdic setObject:[sdic ojsk:@"id"] forKey:@"area"];
                [mdic setObject:[sdic ojsk:@"lng"] forKey:@"lng"];
                [mdic setObject:[sdic ojsk:@"lat"] forKey:@"lat"];
                [mdic setObject:[NSString stringWithFormat:@"%@%@",[sdic ojsk:@"cityname"],[sdic ojsk:@"address"]] forKey:@"mapaddr"];
//                [mdic setObject:[sdic ojsk:@"id"] forKey:@"area"];
                return (id)mdic;
            }
        }
    }
    
    return nil;
}
-(void)setValueStr:(NSString *)valueStr{
    NSMutableDictionary*mdic=(id)valueStr;
    __weak __typeof(self) weakSelf = self;
    [self loadMyDataWithBlock:^(id data, int status, NSString *msg) {
        for (NSMutableDictionary*dic in weakSelf.carModeldata[@"list"]) {
            for (NSMutableDictionary*sdic in dic[@"addresses"]) {
                if ([[sdic ojsk:@"id"] isEqualToString:[mdic ojsk:@"area"]]) {
                    [dic setObject:@"1" forKey:@"selected"];
                    [sdic setObject:@"1" forKey:@"selected"];
                    [weakSelf updataTextfeildInfo];
                    return ;
                }
            }
        }
    }];
    
    
    
}

-(void)selectBtnClick:(UIView*)btn{
    [UTILITY.currentViewController.view endEditing:YES];
    __weak __typeof(self) weakSelf = self;
    [self loadMyDataWithBlock:^(id data, int status, NSString *msg) {
        [UTILITY.currentViewController pushController:[CityListSelectViewController class] withInfo:weakSelf.carModeldata withTitle:kST(@"SelectionOfUrbanAreas") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            weakSelf.carModeldata=data;
            [weakSelf updataTextfeildInfo];
        }];
    }];
}
-(void)updataTextfeildInfo{
    self.defaultTextfield.text=@"";
    for (NSDictionary*dic in _carModeldata[@"list"]) {
        for (NSDictionary*sdic in dic[@"addresses"]) {
            if ([[sdic ojsk:@"selected"] isEqualToString:@"1"]) {
                self.defaultTextfield.text=[NSString stringWithFormat:@"%@ %@",[dic ojsk:@"name"],[sdic ojsk:@"address"]];
                break;
            }
        }
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
