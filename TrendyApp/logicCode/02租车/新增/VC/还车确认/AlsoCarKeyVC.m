//
//  AlsoCarKeyVC.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/20.
//  Copyright © 2020 55like. All rights reserved.
//

#import "AlsoCarKeyVC.h"
#import "AlsoCarCloseDoorVC.h"
@interface AlsoCarKeyVC ()

@end

@implementation AlsoCarKeyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navbarTitle:@"還車確認"];
    [self backButton];
    [self setUI];
    self.view.backgroundColor = WHITECOLOR;
}
#pragma mark ************* 按钮的点击事件
///
-(void)keyBtnClick
{
    
}

///下一步
-(void)nextBtnClick
{
    AlsoCarCloseDoorVC *closeVC = [[AlsoCarCloseDoorVC alloc] init];
    [self.navigationController pushViewController:closeVC animated:YES];
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
    UILabel *titleLabel = [UILabel labelWithText:@"請歸還i button" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WScale(15));
        make.top.mas_equalTo(WScale(45)+SafeAreaTopHeight);
    }];
    
    ///
    UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [keyBtn setImage:[UIImage imageNamed:@"pic_ibutton"] forState:UIControlStateNormal];
    [keyBtn setImage:[UIImage imageNamed:@"pic_ibutton"] forState:UIControlStateHighlighted];
    [keyBtn addTarget:self action:@selector(keyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyBtn];
    [keyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WScale(15));
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(35));
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
    UILabel *tipLabel = [UILabel labelWithText:@"在使用過程中出現任何問題請聯繫客服" font:[UIFont boldSystemFontOfSize:WScale(12)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
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
