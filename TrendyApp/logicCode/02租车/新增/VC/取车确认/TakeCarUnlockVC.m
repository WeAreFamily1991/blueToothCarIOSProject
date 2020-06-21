//
//  TakeCarUnlockVC.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/19.
//  Copyright © 2020 55like. All rights reserved.
//

#import "TakeCarUnlockVC.h"
#import "TakeCarGetKeyVC.h"
@interface TakeCarUnlockVC ()

@end

@implementation TakeCarUnlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navbarTitle:@"取車確認"];
    [self backButton];
    [self setUI];
    self.view.backgroundColor = WHITECOLOR;
}
#pragma mark ************* 按钮的点击事件
///解锁
-(void)unlockBtnClick
{
    
}

///下一步
-(void)nextBtnClick
{
    TakeCarGetKeyVC *keyVC = [[TakeCarGetKeyVC alloc] init];
    [self.navigationController pushViewController:keyVC animated:YES];
}

///电话
-(void)phoneBtnClick:(UIButton *)button
{
    NSString *phone = [NSString stringWithFormat:@"tel://%@",button.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

#pragma mark ************* UI
-(void)setUI
{
    ///解锁
    UIButton *unlockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [unlockBtn setImage:[UIImage imageNamed:@"btn_open_large"] forState:UIControlStateNormal];
    [unlockBtn setImage:[UIImage imageNamed:@"btn_open_large"] forState:UIControlStateHighlighted];
    [unlockBtn addTarget:self action:@selector(unlockBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unlockBtn];
    [unlockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WScale(15));
        make.top.mas_equalTo(SafeAreaTopHeight+WScale(85));
    }];
    
    UILabel *titleLabel = [UILabel labelWithText:@"解鎖車門" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WScale(15));
        make.top.mas_equalTo(unlockBtn.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    ///下一步
    UIButton *nextBtn =  [UIButton buttonWithTitle:@"下一步" font:kFont(16) titleColor:WHITECOLOR backGroundColor:UIColorFromRGB(0x0E70A1) buttonTag:0 target:self action:@selector(nextBtnClick) showView:self.view];
    nextBtn.layer.cornerRadius = WScale(5);
    nextBtn.clipsToBounds = YES;
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(WScale(40));
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(15));
    }];
    
    ///客服
    UIButton *phoneBtn =  [UIButton buttonWithTitle:@"047-712-8816" font:kFont(12) titleColor:ThemeColor backGroundColor:CLEARCOLOR buttonTag:0 target:self action:@selector(phoneBtnClick:) showView:self.view];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(WScale(15));
        make.bottom.mas_equalTo(nextBtn.mas_top).mas_equalTo(WScale(-15));
    }];
    
    ///提示
    UILabel *tipLabel = [UILabel labelWithText:@"在使用過程中出現任何問題請聯繫客服" font:kFont(12) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.bottom.mas_equalTo(phoneBtn.mas_top);
    }];
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
