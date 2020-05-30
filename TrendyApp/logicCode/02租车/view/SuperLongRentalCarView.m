//
//  SuperLongRentalCarView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SuperLongRentalCarView.h"
#import "WSButtonGroup.h"
@interface SuperLongRentalCarView()
{
    
}
@property(nonatomic,strong)UIView *oldSelectView;

@end
@implementation SuperLongRentalCarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf=self;
        UIScrollView *viewScoroll=[UIScrollView viewWithFrame:self.bounds backgroundcolor:nil superView:self];
        viewScoroll.showsHorizontalScrollIndicator=NO;
        viewScoroll.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        WSButtonGroup *_btnGroupTableview3=[WSButtonGroup new];
//        @[@"經濟型",@"舒適型",@"SUV",@"經濟型",@"舒適型",@"SUV",];
        float cellwidth=120;
        
//        [_btnGroupTableview3 setGroupClickBlock:^(WSButtonGroup *group) {
//            for (UIButton*mybtn in group.buttonArray) {
//                UIView*viewMask=[mybtn getAddValueForKey:@"viewMask"];
//                viewMask.hidden=NO;
//                mybtn.layer.shadowRadius = 0;
//                if (group.currentSelectBtn==mybtn) {
//                    viewMask.hidden=YES;
//                    mybtn.layer.shadowRadius = 8;
//                    weakSelf.changeBlock?weakSelf.changeBlock(mybtn.data, 200, nil):nil;
//                }
//            }
//        }];
        [self setAddUpdataBlock:^(id data, id weakme) {
            for (UIView *view in [viewScoroll subviews]) {
                [view setHidden:YES];
            }
            NSArray *arraytitle=data;
            for (int i=0; i<arraytitle.count; i++) {
                
                WSSizeButton *btnItem=[viewScoroll getAddValueForKey:[NSString stringWithFormat:@"btnItem_%d",i]];
                if (!btnItem) {
                    btnItem=[RHMethods viewWithFrame:CGRectZero backgroundcolor:rgbwhiteColor superView:viewScoroll  reuseId:[NSString stringWithFormat:@"btnItem_%d",i]];
                    UIView *bgV=[RHMethods viewWithFrame:CGRectMake(10, 10, 100, 100) backgroundcolor:rgbwhiteColor superView:btnItem  reuseId:@"bgV"];
                    [weakSelf addShadowToView:bgV withColor:[UIColor blackColor]];
                    
                    UIImageView *imageIcon=[RHMethods imageviewWithFrame:CGRectMake(10, 10, 100, 100) defaultimage:nil supView:btnItem reuseId:@"imageIcon"];
                    imageIcon.layer.cornerRadius=5;

                    UIView *viewMask=[UIView viewWithFrame:CGRectMake(10, 10, 100, 100) backgroundcolor:RGBACOLOR(0, 0, 0, 0.1) superView:btnItem reuseId:@"viewMask"];
                    viewMask.layer.cornerRadius=5;
                    viewMask.userInteractionEnabled=NO;

                    [btnItem addViewTarget:weakSelf select:@selector(clickedButton:)];
                }
                btnItem.hidden=NO;
                btnItem.frame=CGRectMake(10+cellwidth*i, 0, cellwidth, viewScoroll.frameHeight);
                btnItem.data=arraytitle[i];
                viewScoroll.contentWidth=btnItem.frameXW+10;
                UIImageView *imageIcon=[btnItem getAddValueForKey:@"imageIcon"];
                [imageIcon imageWithURL:[arraytitle[i] ojsk:@"wappath"]];
                UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(0, 120, btnItem.frameWidth, 18) font:fontTxtContent color:rgbTxtDeepGray text:@"" textAlignment:NSTextAlignmentCenter supView:btnItem reuseId:@"lblTitle"];;
                lblTitle.text=[arraytitle[i] ojsk:@"title"] ;
                
                if (i==0) {
                    [weakSelf clickedButton:btnItem];
                }
            }
        }];
        

    }
    return self;
}
-(void)clickedButton:(UIView *)view{
    if (_oldSelectView==view) {
        return;
    }
    if (_oldSelectView) {
        UIView *viewMask=[_oldSelectView getAddValueForKey:@"viewMask"];
        viewMask.hidden=NO;
        UIView *viewBG=[_oldSelectView getAddValueForKey:@"bgV"];
        viewBG.layer.shadowRadius = 0;
        UILabel *lblTitle=[_oldSelectView getAddValueForKey:@"lblTitle"];
        lblTitle.textColor=rgbTxtDeepGray;
    }
    _oldSelectView=view;
    UIView *viewMask=[_oldSelectView getAddValueForKey:@"viewMask"];
    viewMask.hidden=YES;
    UIView *viewBG=[_oldSelectView getAddValueForKey:@"bgV"];
    viewBG.layer.shadowRadius = 9;
    UILabel *lblTitle=[_oldSelectView getAddValueForKey:@"lblTitle"];
    lblTitle.textColor=rgbpublicColor;
    self.changeBlock?self.changeBlock(_oldSelectView.data, 200, nil):nil;
}
-(void)didChangeValueWithBlock:(AllcallBlock)ablock{
    _changeBlock=ablock;
}
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.2;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 0;
    //圆角
    theView.layer.cornerRadius=5;
    
    theView.clipsToBounds=NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
