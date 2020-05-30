//
//  FCSelectCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "SelectPlacePointCellView.h"
#import "SelectDateView.h"
//#import "AutomobileBrandModelViewController.h"
//#import "CityListSelectViewController.h"
#import "MapSelectPointViewController.h"
@interface SelectPlacePointCellView()
{
    
}
@property(nonatomic,strong)NSMutableDictionary*carModeldata;
@end
@implementation SelectPlacePointCellView
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
-(NSString *)valueStr{
    return self.carModeldata;
    
//    return nil;
}
-(void)setValueStr:(NSString *)valueStr{
    NSMutableDictionary*mdic=(id)valueStr;
    __weak __typeof(self) weakSelf = self;
    weakSelf.carModeldata=mdic;
    [self updataTextfeildInfo];
}

-(void)selectBtnClick:(UIView*)btn{
    [UTILITY.currentViewController.view endEditing:YES];
    __weak __typeof(self) weakSelf = self;
    //    [self loadMyDataWithBlock:^(id data, int status, NSString *msg) {
    [UTILITY.currentViewController pushController:[MapSelectPointViewController class] withInfo:self.carModeldata withTitle:kS(@"mapFindCar", @"mapAddress") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
        weakSelf.carModeldata=data;
        [weakSelf updataTextfeildInfo];
        if (weakSelf.changeBlock) {
            weakSelf.changeBlock(weakSelf.defaultTextfield.text, 200, nil);
        }
    }];
    //    }];
}
-(void)updataTextfeildInfo{
    self.defaultTextfield.text=@"";
    self.defaultTextfield.text=[self.carModeldata ojsk:@"mapaddr"];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
