//
//  MyVehicleCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/28. 178a2ea19ada79fb12aee5&uid=6&language=cn
//  Copyright © 2019 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "MyVehicleCellView.h"
@interface MyVehicleCellView()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UIImageView *photoImagv;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *describLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *collectionLable;
@property (weak, nonatomic) IBOutlet UILabel *seeLable;
@end
@implementation MyVehicleCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
//        self.frameHeight=55;
    }
    if (self.isfirstInit) {
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            weakSelf.statusLable.text=[data ojsk:@"status_name"];
            weakSelf.statusLable.hidden=YES;
            weakSelf.statusLable.backgroundColor=rgbHexColor([data ojsk:@"status_color"]);
            [weakSelf.photoImagv imageWithURL:[data ojsk:@"path"]];
            
            weakSelf.photoImagv.contentMode=UIViewContentModeScaleAspectFill;
            weakSelf.nameLable.text=[data ojsk:@"title"];
            weakSelf.describLable.text=[data ojsk:@"plate_number"];
            weakSelf.seeLable.text=[data ojsk:@"commentnum"];
            weakSelf.seeLable.text=[data ojsk:@"hits"];
            
            weakSelf.collectionLable.text=[data ojsk:@"favnum"];
            weakSelf.priceLable.text=[NSString stringWithFormat:@"%@￥%@  %@￥%@",kS(@"CarList", @"Weekdays"),[data ojsk:@"price"],kS(@"CarList", @"Festivals"),[data ojsk:@"price_holiday"]];
            weakSelf.priceLable.textColor=rgb(244,58,58);
            [weakSelf.priceLable setColor:rgb(102,102,102) contenttext:kS(@"CarList", @"Weekdays")];
            [weakSelf.priceLable setColor:rgb(102,102,102) contenttext:kS(@"CarList", @"Festivals")];
        }];
        
    }
    
}
-(void)bendData:(id)data withType:(NSString *)type{
    [super bendData:data withType:type];
    [self upDataMeWithData:data];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect { 178a2ea19ada79fb12aee5&uid=6&language=cn
    // Drawing code
}
*/

@end
