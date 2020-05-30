//
//  FCImageSelectCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCImageSelectCellView.h"
#import "ImageSelectEditorView.h"
#import "NSObject+JSONCategories.h"
#import "NSString+JSONCategories.h"
@interface FCImageSelectCellView()
{
    
}

@property(nonatomic,strong)ImageSelectEditorView* imageEditorV;
@end
@implementation FCImageSelectCellView
-(void)addFCView{
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    NSMutableDictionary*data=self.data;
    if (![[data ojsk:@"picturenumber"] notEmptyOrNull]) {
        [data setObject:@"5" forKey:@"picturenumber"];
    }
    
    self.defaultTextfield.hidden=YES;
    self.defaultTextfield.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[data ojsk:@"name"]];
    self.defaultNameLabel.frameWidth=self.frameWidth-30;
    self.defaultNameLabel.text=[NSString stringWithFormat:@"%@（最多可添加%@张照片）",[data ojsk:@"name"],[data ojsk:@"picturenumber"]];
    [self.defaultNameLabel setColor:rgb(151, 151, 151) font:Font(12) contenttext:[NSString stringWithFormat:@"（最多可添加%@张照片）",[data ojsk:@"picturenumber"]]];
    if ([[self.data ojsk:@"tipStr"] notEmptyOrNull]) {
//        self.defaultNameLabel.text=[NSString stringWithFormat:@"%@（%@）",[data ojsk:@"name"],[data ojsk:@"tipStr"]];
//        [self.defaultNameLabel setColor:rgb(151, 151, 151) font:Font(12) contenttext:[NSString stringWithFormat:@"（%@）",[data ojsk:@"tipStr"]]];
        self.defaultNameLabel.text=[NSString stringWithFormat:@"%@（%@）",[data ojsk:@"name"],[data ojsk:@"tipStr"]];
        [self.defaultNameLabel setColor:rgb(151, 151, 151) font:Font(12) contenttext:[NSString stringWithFormat:@"（%@）",[data ojsk:@"tipStr"]]];
    }
    
    
    ImageSelectEditorView* imageEditorV=[[ImageSelectEditorView alloc] initWithFrame:CGRectMake(5,  45, kScreenWidth-10, 100)];
    self.frameHeight=imageEditorV.frameYH+10;
    [self addSubview:imageEditorV];
    _imageEditorV=imageEditorV;
    _imageEditorV.maxNumber=[data ojsk:@"picturenumber"].intValue;
    self.defaultLineView.frameBY=0;
    __weak __typeof(self) weakSelf = self;
    [_imageEditorV setImageUrlArray:[NSMutableArray new] imageChange:^(NSInteger suc) {
        weakSelf.frameHeight=weakSelf.imageEditorV.frameYH+10;
        weakSelf.defaultLineView.frameBY=0;
        
        [[weakSelf mysuperTableView] reloadData];
    }];
}

-(NSMutableArray*)getNoUploadImageViewArray{
    NSMutableArray*array=[NSMutableArray new];
    for (UIImageView*imageView in self.imageEditorV.imageViewArray) {
        if (![[imageView getAddValueForKey:@"dataurl"] notEmptyOrNull]) {
            [array addObject:imageView];
        }
    }
    return array;
}

-(void)setValueStr:(NSString *)valueStr{
//    NSArray*array=[valueStr JSONValue];
    NSArray*array=[valueStr componentsSeparatedByString:@","];
    NSMutableArray*marray=[NSMutableArray new];
    if ([array isKindOfClass:[NSArray class]]) {
        for (int i=0; i<array.count; i++) {
            NSString*urlstr=array[i];
            NSMutableDictionary*mdic=[NSMutableDictionary dictionaryWithDictionary:@{@"url":urlstr,@"id":[NSString stringWithFormat:@"%d",i]}];
            [marray addObject:mdic];
        }
    }
    if ([[self.data ojsk:@"isSimplicity"] isEqualToString:@"1"]) {
        float imageWith=81;
        float x=15;float y=47;
        for (int i=0; i<marray.count; i++) {
            UIImageView*imgVImage=[RHMethods BIGimageviewWithFrame:CGRectMake(x, y, imageWith, imageWith) defaultimage:@"photo" supView:self];
            [imgVImage imageWithURL:[marray[i] ojsk:@"url"]];
            if (imgVImage.frameXW>self.frameWidth-10) {
                x=15;y=imgVImage.frameYH+10;
                imgVImage.frameY=y;
                imgVImage.frameX=x;
            }
            x=imgVImage.frameXW+7;
            if (i==marray.count-1) {
                self.frameHeight=imgVImage.frameYH+15;
            }
        }
    }else{
        [_imageEditorV setImageUrlArray:marray imageChange:_imageEditorV.imageChange];
    }
}
-(NSString *)valueStr{
    NSMutableArray*marray=[NSMutableArray new];
    for (UIImageView*imageView in self.imageEditorV.imageViewArray) {
        if ([[imageView getAddValueForKey:@"dataurl"] notEmptyOrNull]) {
            [marray addObject:[imageView getAddValueForKey:@"dataurl"]];
        }
    }
    if (marray.count) {
//        [self.data setObject:marray.JSONString_l forKey:@"valueStr"];
//        return marray.JSONString_l;
        return [marray componentsJoinedByString:@","];
    }else{
        [self.data removeObjectForKey:@"valueStr"];
    }
//    return @"[]";
    return @"";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
