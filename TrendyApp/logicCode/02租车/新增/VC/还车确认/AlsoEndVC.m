//
//  AlsoEndVC.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/20.
//  Copyright © 2020 55like. All rights reserved.
//

#import "AlsoEndVC.h"

@interface AlsoEndVC ()

@end

@implementation AlsoEndVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self backButton];
    self.view.backgroundColor = WHITECOLOR;
    [self setUI];
}
#pragma mark **** 返回首页
-(void)homeBtnClick
{
    [UTILITY.CustomTabBar_zk selectedTabIndex:@"0"];
}

///电话
-(void)phoneBtnClick:(UIButton *)button
{
    NSString *phone = [NSString stringWithFormat:@"tel://%@",@"047-712-8816"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

#pragma mark ************* UI
-(void)setUI
{
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"pic_trendy"];
    [self.view addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight+WScale(50));
    }];
    
    UILabel *titleLabel = [UILabel labelWithText:@"非常感謝您的使用" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentCenter superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(iconImg.mas_bottom).mas_equalTo(WScale(30));
    }];
    
    ///返回首頁
    UIButton *homeBtn =  [UIButton buttonWithTitle:@"返回首頁" font:kFont(16) titleColor:WHITECOLOR backGroundColor:UIColorFromRGB(0x0E70A1) buttonTag:0 target:self action:@selector(homeBtnClick) showView:self.view];
    homeBtn.layer.cornerRadius = WScale(5);
    homeBtn.clipsToBounds = YES;
    [homeBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.width.mas_equalTo(WScale(200));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(WScale(40));
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(24));
    }];
    
    
    UIButton *phoneBtn =  [UIButton buttonWithTitle:@"Trendy24客服中心\n 047-712-8816" font:kFont(12) titleColor:UIColorFromRGB(0x999999) backGroundColor:CLEARCOLOR buttonTag:0 target:self action:@selector(phoneBtnClick:) showView:self.view];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(homeBtn.mas_bottom).mas_equalTo(WScale(15));
    }];
    
//    NSString *tip = @"Trendy24客服中心\n047-712-8816";
//    UILabel *tipLabel = [UILabel labelWithText:tip font:[UIFont boldSystemFontOfSize:WScale(12)] textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor textAlignment:NSTextAlignmentCenter superView:self.view];
//    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(homeBtn.mas_bottom).mas_equalTo(WScale(15));
//    }];
//    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
//    muStyle.lineSpacing = 5;//设置行间距离
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tip];
//    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, tip.length)];
//    tipLabel.attributedText = attrString;
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//    [tipLabel addGestureRecognizer:tap];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
