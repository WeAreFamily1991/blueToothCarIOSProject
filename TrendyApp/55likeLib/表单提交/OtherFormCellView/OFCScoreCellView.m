//
//  FCSelectCellView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/28.
//  Copyright © 2018 55like. All rights reserved.
//

#import "OFCScoreCellView.h"
//#import "SelectDateView.h"
#import "XHStarRateView.h"
@interface OFCScoreCellView()
{
    
}
@property(nonatomic,strong)XHStarRateView*viewStar;
@end
@implementation OFCScoreCellView
-(void)addFCView{
    
    self.frameHeight=35;
    [self defaultNameLabel];
    [self defaultTextfield];
    //    [self defaultLineView];
    //    UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 8, 13) defaultimage:@"arrowr1" supView:self];
    //    imgVRow.frameRX=15;
    //    [imgVRow beCY];
    //    XHStarRateView*viewStar=[XHStarRateView viewWithFrame:CGRectMake(0, 0, 92+15, 15) backgroundcolor:nil superView:self];
    
    //    -(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish
    
    UILabel*lbScore=[RHMethods lableX:0 Y:0 W:50 Height:self.frameHeight font:13 superview:self withColor:rgb(244, 58, 58) text:@"5.0分"];
    //    lbScore.text=@"4.7分";
    XHStarRateView*viewStar=[[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 92+15, 15) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        lbScore.text=[NSString stringWithFormat:@"%.1f%@",currentScore,kS(@"carOwnerMessage", @"branch")];
    }];
    [viewStar setCurrentScore:5.0];
    _viewStar=viewStar;
    [self addSubview:viewStar];
    [viewStar beCY];
    viewStar.frameRX=56;
    lbScore.frameX= viewStar.frameXW+1;
    
    
    
    self.defaultTextfield.frameWidth=self.frameWidth-self.defaultTextfield.frameX-17-15;
    self.defaultTextfield.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[self.data ojsk:@"name"]];
    self.defaultTextfield.userInteractionEnabled=NO;
    self.defaultTextfield.hidden=YES;
    //    [self addViewTarget:self select:@selector(selectBtnClick:)];
}

-(NSString *)valueStr{
    
   return  [NSString stringWithFormat:@"%.1f",self.viewStar.currentScore];
}
-(void)setValueStr:(NSString *)valueStr{
    
    [self.viewStar setCurrentScore:valueStr.floatValue];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
