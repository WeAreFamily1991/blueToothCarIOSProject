//
//  UsageViewController.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/20.
//  Copyright © 2020 55like. All rights reserved.
//

#import "UsageViewController.h"

@interface UsageViewController ()

@property(nonatomic,strong)UIView *infoView;
@end

@implementation UsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navbarTitle:@"使用情況"];
    [self backButton];
    self.view.backgroundColor = WHITECOLOR;
    
    [self infoView];
    [self setUI];
}
#pragma mark ************* 按钮的点击事件
///开
-(void)openBtnClick
{
    
}

///关
-(void)closeBtnClick
{
    
}

///还车
-(void)nextBtnClick
{
    
}

#pragma mark ************* UI
///车辆信息
-(UIView *)infoView
{
    if (!_infoView) {
        _infoView = [[UIView alloc] init];
        [self.view addSubview:_infoView];
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(SafeAreaTopHeight);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(WScale(105));
        }];
        
        //图片
        UIImageView *carImg = [[UIImageView alloc] init];
        carImg.backgroundColor = [UIColor lightGrayColor];
        [self.infoView addSubview:carImg];
        [carImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(18));
            make.width.mas_equalTo(WScale(94));
            make.height.mas_equalTo(WScale(70));
        }];
        
        //名称
        UILabel *titleLabel = [UILabel labelWithText:@"HONDA VE ZEL(Silver)" font:[UIFont boldSystemFontOfSize:WScale(15)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.infoView];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(carImg.mas_right).mas_equalTo(WScale(15));
            make.top.mas_equalTo(carImg.mas_top);
        }];
        
        ///设备
        UILabel *setLabel = [UILabel labelWithText:@"轎車 | 自排 | 5人座" font:kFont(12) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.infoView];
        [setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(10));
        }];
        
        //关键字
        UILabel *keyLabel = [UILabel labelWithText:@"TRENDY" font:kFont(10) textColor:UIColorFromRGB(0xF43A3A) backGroundColor:rgb(251, 236, 235) textAlignment:NSTextAlignmentCenter superView:self.infoView];
        keyLabel.layer.cornerRadius = 2;
        keyLabel.clipsToBounds = YES;
        [keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
            make.bottom.mas_equalTo(carImg.mas_bottom);
            make.width.mas_equalTo(WScale(45));
            make.height.mas_equalTo(WScale(17));
        }];
        
        ///线
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(105)-1,kWindowW, 1)];
        lineLabel.backgroundColor = SeparatorCOLOR;
        [self.infoView addSubview:lineLabel];
    }
    return _infoView;
}

-(void)setUI
{
    ///左边时间
    UILabel *leftDateLabel = [UILabel labelWithText:@"04.23" font:[UIFont boldSystemFontOfSize:WScale(16)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [leftDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(self.infoView.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    UILabel *leftTimeLabel = [UILabel labelWithText:@"Thu 09:00" font:kFont(13) textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(leftDateLabel.mas_bottom).mas_equalTo(WScale(10));
    }];
    
    
    ///右边时间
    UILabel *rightDateLabel = [UILabel labelWithText:@"04.24" font:[UIFont boldSystemFontOfSize:WScale(16)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [rightDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-15));
        make.top.mas_equalTo(self.infoView.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    UILabel *rightTimeLabel = [UILabel labelWithText:@"Thu 09:00" font:kFont(13) textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-15));
        make.top.mas_equalTo(leftDateLabel.mas_bottom).mas_equalTo(WScale(10));
    }];
    
    ///中间
    UILabel *centerTimeLabel = [UILabel labelWithText:@"2日" font:kFont(13) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [centerTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.infoView.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc] init];
    arrowImg.image = [UIImage imageNamed:@"timei"];
    [self.view addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(centerTimeLabel.mas_bottom).mas_equalTo(WScale(4));
    }];
    
    
    ///里程数
    UILabel *mileageLabel = [UILabel labelWithText:@"里程數：100km" font:kFont(14) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [mileageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(leftTimeLabel.mas_bottom).mas_equalTo(WScale(30));
    }];
    
    UILabel *pointLabel = [[UILabel alloc] init];
    pointLabel.backgroundColor = UIColorFromRGB(0x009944);
    pointLabel.layer.cornerRadius = WScale(7);
    pointLabel.clipsToBounds = YES;
    [self.view addSubview:pointLabel];
    [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-15));
        make.centerY.mas_equalTo(mileageLabel);
        make.width.height.mas_equalTo(WScale(14));
    }];
    
    UIImageView *bluetoothImg = [[UIImageView alloc] init];
    bluetoothImg.image = [UIImage imageNamed:@"ic_bluetooth_light"];
    [self.view addSubview:bluetoothImg];
    [bluetoothImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(pointLabel.mas_left).mas_equalTo(WScale(-15));
        make.centerY.mas_equalTo(mileageLabel);
    }];
    
    
    ///使用中
    UILabel *useLabel = [UILabel labelWithText:@"使用中" font:kFont(14) textColor:ThemeColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(mileageLabel.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [openBtn setImage:[UIImage imageNamed:@"btn_open_ash"] forState:UIControlStateNormal];
    [openBtn setImage:[UIImage imageNamed:@"btn_open_ash"] forState:UIControlStateHighlighted];
    [openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
    [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(72));
        make.top.mas_equalTo(useLabel.mas_bottom).mas_equalTo(WScale(40));
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-72));
        make.top.mas_equalTo(useLabel.mas_bottom).mas_equalTo(WScale(40));
    }];
    
    ///立即還車
    UIButton *nextBtn =  [UIButton buttonWithTitle:@"還車" font:kFont(16) titleColor:WHITECOLOR backGroundColor:UIColorFromRGB(0x0E70A1) buttonTag:0 target:self action:@selector(nextBtnClick) showView:self.view];
    nextBtn.layer.cornerRadius = WScale(5);
    nextBtn.clipsToBounds = YES;
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(WScale(40));
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(15));
    }];
    
    
    ///蓝牙未使用
    /*
    pointLabel.backgroundColor = UIColorFromRGB(0xF43A3A);
    bluetoothImg.image = [UIImage imageNamed:@"ic_bluetooth_ash"];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_ash"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_ash"] forState:UIControlStateHighlighted];
    */
    
    
    ///使用情况 -- 未使用
    /*
    pointLabel.hidden = YES;
    bluetoothImg.hidden = YES;
    openBtn.hidden = YES;
    closeBtn.hidden = YES;
    useLabel.text = @"未使用";
    useLabel.textColor = UIColorFromRGB(0x666666);
     */
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
