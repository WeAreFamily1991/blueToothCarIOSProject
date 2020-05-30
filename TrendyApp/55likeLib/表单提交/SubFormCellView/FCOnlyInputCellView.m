//
//  FCOnlyInputCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCOnlyInputCellView.h"

@implementation FCOnlyInputCellView
-(void)addFCView{
    
    UIView*viewBG=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-30, 49) backgroundcolor:rgb(246, 246, 246) superView:self];
    viewBG.layer.cornerRadius=4;
    UITextField*tfOther=[RHMethods textFieldlWithFrame:CGRectMake(15, 0, viewBG.frameWidth-30, viewBG.frameHeight) font:Font(14) color:rgb(153, 153, 153) placeholder:[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseInput"),[self.data ojsk:@"name"]] text:@""  supView:viewBG];
    self.defaultTextfield=tfOther;
    self.frameHeight=viewBG.frameYH+15;
    self.defaultLineView.frameBY=0;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
