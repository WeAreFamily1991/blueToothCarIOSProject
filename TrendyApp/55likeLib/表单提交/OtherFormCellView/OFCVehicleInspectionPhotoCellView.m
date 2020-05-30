//
//  FCTextCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "OFCVehicleInspectionPhotoCellView.h"

@implementation OFCVehicleInspectionPhotoCellView
- (void)addSimplicView{

}
-(void)setValueStr:(NSString *)valueStr{
    [super setValueStr:valueStr];
}

-(void)addFCView{
    //    self.frameHeight=44;
    [self defaultNameLabel];
    [self defaultTextfield];
    [self defaultLineView];
    
    self.defaultTextfield.hidden=YES;
    NSArray*arraytitle=@[@"上传行驶证主页",@"上传行驶证副页",];
    float width=(kScreenWidth-30-10)*0.5;
    float height=width*111.5/167.5;
    for (int i=0; i<arraytitle.count; i++) {
        UIImageView*imgVSelectImageView=[RHMethods imageviewWithFrame:CGRectMake(15+i*(width+10), 55, width, height) defaultimage:@"photo" supView:self];
        imgVSelectImageView.layer.cornerRadius=2.5;
        imgVSelectImageView.layer.borderColor=rgb(234, 234, 234).CGColor;
        imgVSelectImageView.layer.borderWidth=1;
        UIImageView*imgVSmallImage=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 40, 40) defaultimage:@"mfile1" supView:imgVSelectImageView];
        [imgVSmallImage beCX];
        [imgVSmallImage beCY];
        UILabel*lbName=[RHMethods lableX:imgVSelectImageView.frameX Y:imgVSelectImageView.frameYH+14 W:imgVSelectImageView.frameWidth Height:13 font:13 superview:self withColor:rgb(153, 153, 153) text:arraytitle[i]];
        lbName.textAlignment=NSTextAlignmentCenter;
        self.frameHeight=lbName.frameYH+20;
    }
    
//    self.frameHeight=viewBG.frameYH+15;
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
