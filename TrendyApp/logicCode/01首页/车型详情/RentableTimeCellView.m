//
//  RentableTimeCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//

#import "RentableTimeCellView.h"
#import "CalendarSmallCellView.h"

@implementation RentableTimeCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf=self;
        NSArray*arraydayTitle=@[kS(@"KeyHome", @"week1"),
                                kS(@"KeyHome", @"week2"),
                                kS(@"KeyHome", @"week3"),
                                kS(@"KeyHome", @"week4"),
                                kS(@"KeyHome", @"week5"),
                                kS(@"KeyHome", @"week6"),
                                kS(@"KeyHome", @"week7"),
                                ];//@[@"日",@"一",@"二",@"三",@"四",@"五",@"六",];
        float mywidth=(kScreenWidth-10)/7;
        float fy=0;
        for (int i=0; i<arraydayTitle.count; i++) {
            UILabel *lbWeakDay=[RHMethods lableX:5+mywidth*i Y:0 W:mywidth Height:14*3 font:14 superview:self withColor:rgbTitleDeepGray text:arraydayTitle[i]];
            lbWeakDay.textAlignment=NSTextAlignmentCenter;
            if (i==arraydayTitle.count-1) {
                fy+=H(lbWeakDay);
            }
        }
        [self setAddUpdataBlock:^(id data, id weakme) {
            NSArray *arrayT=[data ojk:@"calendar"];
            for (int i=0; i<7; i++) {
                CalendarSmallCellView * viewContentCell= [CalendarSmallCellView viewWithFrame:CGRectMake(5+i*mywidth, fy , mywidth, 0) backgroundcolor:nil superView:weakSelf reuseId:[NSString stringWithFormat:@"viewContentCell%d",i]];
                viewContentCell.type=@"服务器数据";
                viewContentCell.userInteractionEnabled=NO;
                if (i==arrayT.count-1) {
                    weakSelf.frameHeight=YH(viewContentCell)+40;
                }
                if (arrayT.count>i) {
                    viewContentCell.serverData=arrayT[i];
                    [viewContentCell upDataMeWithData:arrayT[i]];
                    viewContentCell.hidden=NO;
                }else{
                    viewContentCell.hidden=YES;
                }
            }
        }];
        
        NSArray*arraytitle=@[@{
                                 @"image":@"memtimei1",
                                 //                                     @"title":kS(@"KeyHome", @"selectTip1"),//部分时段可租
                                 @"title":kS(@"carDetails", @"rentPartDay"),//部分时段可租
                                 },
                             @{
                                 @"image":@"datebg",
                                 //                                     @"title":kS(@"KeyHome", @"selectTip2"),//全天可租
                                 @"title":kS(@"carDetails", @"rentAllDay"),//全天可租
                                 },];
        float rx=15;
        
        self.frameHeight=fy+40;
        for (int i=0; i<arraytitle.count; i++) {
            NSDictionary*dic=arraytitle[i];
            UILabel*lbTitle=[RHMethods RlableRX:rx Y:H(self)-40 W:0 Height:13 font:13 superview:self withColor:rgb(153, 153, 153) text:[dic ojsk:@"title"]];
            rx=lbTitle.frameWidth+rx;
            UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 12, 12) defaultimage:[dic ojsk:@"image"] supView:self];
            imgVIcon.frameRX=rx+10;
            imgVIcon.centerY=lbTitle.centerY;
            rx=imgVIcon.frameWidth+imgVIcon.frameRX+10;
            lbTitle.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            imgVIcon.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        }
        
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
