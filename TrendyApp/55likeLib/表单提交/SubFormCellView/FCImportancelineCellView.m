//
//  FCImportancelineCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "FCImportancelineCellView.h"

@implementation FCImportancelineCellView
-(void)addSimplicView{
    [self addFCView];
}
-(void)addFCView{
    self.backgroundColor=rgb(246, 246, 246);
    self.frameHeight=40;
    [RHMethods imageviewWithFrame:CGRectMake(15, 13, 15, 15) defaultimage:@"headimprotant" supView:self];
    [RHMethods lableX:35 Y:0 W:0 Height:self.frameHeight font:13 superview:self withColor:rgb(251,148,33) text:[self.data ojsk:@"name"]];
    return;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
