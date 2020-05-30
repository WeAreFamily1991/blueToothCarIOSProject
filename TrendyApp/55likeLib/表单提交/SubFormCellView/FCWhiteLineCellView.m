//
//  FCWhiteLineCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved.
//

#import "FCWhiteLineCellView.h"
@implementation FCWhiteLineCellView
-(void)addSimplicView{
    [self addFCView];
}
-(void)addFCView{
    self.backgroundColor=rgb(255, 255, 255);
    self.frameHeight=10;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
