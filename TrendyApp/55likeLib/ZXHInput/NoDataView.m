//
//  NoDataView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/12/4.
//  Copyright © 2018 55like. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView
+(UIView*)NoDataViewWithImageStr:(NSString*)imageStr withTitleStr:(NSString*)titleStr ContentStr:(NSString*)contentStr{
    UIView*meView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
//    nokehu
    UIImageView*imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr]];
    [meView addSubview:imageView];
    [imageView beCX];
    UILabel*lbTitle=[RHMethods ClableY:0 W:0 Height:17 font:17 superview:meView withColor:rgb(51, 51, 51) text:titleStr];
    UILabel*lbContent=[RHMethods ClableY:0 W:0 Height:12 font:12 superview:meView withColor:rgb(193,193,193) text:contentStr];

    float y=0.0;

    if ([lbContent.text notEmptyOrNull]) {
        y=(meView.frameHeight-(imageView.frameHeight+15+lbTitle.frameHeight+10+lbContent.frameHeight))*0.5;
    }else{
        y=(meView.frameHeight-(imageView.frameHeight+15+lbTitle.frameHeight))*0.5;
    }
    imageView.frameY=y;
    lbTitle.frameY=imageView.frameYH+15;
    lbContent.frameY=lbTitle.frameYH+10;
    
    return meView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
