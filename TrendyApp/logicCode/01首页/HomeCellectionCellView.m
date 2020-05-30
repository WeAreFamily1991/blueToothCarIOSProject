//
//  HomeCellectionCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "HomeCellectionCellView.h"
#import "VehicleDetailsViewController.h"
@interface HomeCellectionCellView()
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UILabel *bandlable;
@property (weak, nonatomic) IBOutlet UILabel *carNumber;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@end
@implementation HomeCellectionCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [weakSelf.headerImage imageWithURL:[data ojsk:@"path"]];
            weakSelf.carName.text=[data ojsk:@"title"];
            weakSelf.bandlable.text=[data ojsk:@"type_str"];
            float fw=[weakSelf.bandlable sizeThatFits:CGSizeMake(MAXFLOAT, H(weakSelf.bandlable))].width;
            weakSelf.bandlable.frameWidth=fw+4;
            weakSelf.carNumber.frameX=XW(weakSelf.bandlable)+5;
            weakSelf.carNumber.frameWidth=W(weakSelf)-weakSelf.carNumber.frameX;
            weakSelf.carNumber.text=[data ojsk:@"plate_number"];
            weakSelf.priceLable.text=[NSString stringWithFormat:@"￥%@/%@",[data ojsk:@"price"],kS(@"main_order", @"day")];
            
            if ([[data ojsk:@"type"] isEqualToString:@"1"]) {
                weakSelf.bandlable.textColor=rgb(13,112,161);
                weakSelf.bandlable.backgroundColor=RGBACOLOR(13,112,161, 0.1);
            }else{
                weakSelf.bandlable.textColor=rgb(244,58,58);
                weakSelf.bandlable.backgroundColor=RGBACOLOR(244,58,58, 0.1);
            }
        }];
        [self addViewClickBlock:^(UIView *view) {
           [UTILITY.currentViewController pushController:[VehicleDetailsViewController class] withInfo:[weakSelf.data ojsk:@"id"] withTitle:[weakSelf.data ojsk:@"title"]];
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
