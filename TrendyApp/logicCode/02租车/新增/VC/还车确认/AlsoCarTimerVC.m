//
//  AlsoCarTimerVC.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/20.
//  Copyright © 2020 55like. All rights reserved.
//

#import "AlsoCarTimerVC.h"
#import "AlsoEndVC.h"
@interface AlsoCarTimerVC ()

@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UILabel *timeLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *lastTime;

@end

@implementation AlsoCarTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarTitle:@"還車倒計時"];
    [self backButton];
    self.view.backgroundColor = WHITECOLOR;
    
    [self infoView];
    [self timeLabel];
    [self setUI];
    
    _lastTime = @"600";
    [self startTimer];
}

#pragma mark ***** 倒计时
- (void)startTimer
{
     _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
}
- (void)refreshLessTime
{
    NSUInteger time;
    time = [_lastTime intValue];
    if (time == 0) {
       self.timeLabel.text = [self lessSecondToDay:0];
    }
    else
    {
       self.timeLabel.text = [self lessSecondToDay:--time];
        _lastTime = [NSString stringWithFormat:@"%lu",(unsigned long)time];
    }
}
- (NSString *)lessSecondToDay:(NSUInteger)seconds
{
    NSUInteger hour = (NSUInteger)(seconds)/3600;
    NSUInteger min  = (NSUInteger)(seconds%(3600))/60;
    NSUInteger second = (NSUInteger)(seconds%60);
//    NSString *time = [NSString stringWithFormat:@"%lu:%lu:%lu",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    NSString *minStr = min <10?([NSString stringWithFormat:@"0%lu",(unsigned long)min]):([NSString stringWithFormat:@"%lu",(unsigned long)min]);
    NSString *secondStr = second <10?([NSString stringWithFormat:@"0%lu",(unsigned long)second]):([NSString stringWithFormat:@"%lu",(unsigned long)second]);
    
    NSString *time = [NSString stringWithFormat:@"%@:%@",minStr,secondStr];
    return time;
}

#pragma mark ************* 按钮的点击事件
///电话
-(void)phoneBtnClick:(UIButton *)button
{
    NSString *phone = [NSString stringWithFormat:@"tel://%@",button.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

///开
-(void)openBtnClick
{
    
}

///关
-(void)closeBtnClick
{
    
}

///立即还车
-(void)nextBtnClick
{
    AlsoEndVC *endVC = [[AlsoEndVC alloc] init];
    [self.navigationController pushViewController:endVC animated:YES];
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

///倒计时
-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"" font:[UIFont boldSystemFontOfSize:WScale(20)] textColor:UIColorFromRGB(0x0E70A1) backGroundColor:ClearColor textAlignment:NSTextAlignmentCenter superView:self.view];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.infoView.mas_bottom).mas_equalTo(WScale(20));
        }];
    }
    return _timeLabel;
}

-(void)setUI
{
    ///提示
    UILabel *tipLabel = [UILabel labelWithText:@"如果您遺漏物品在車里，可以在10分鐘內開鎖車門一次 ，如果10分鐘後需要開啟，請致電客服：" font:kFont(14) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_equalTo(WScale(30));
        make.centerX.mas_equalTo(self.view);
    }];
    
    ///客服
    UIButton *phoneBtn =  [UIButton buttonWithTitle:@"047-712-8816" font:kFont(14) titleColor:ThemeColor backGroundColor:CLEARCOLOR buttonTag:0 target:self action:@selector(phoneBtnClick:) showView:self.view];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(tipLabel.mas_bottom).mas_equalTo(WScale(6));
    }];
    

    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [openBtn setImage:[UIImage imageNamed:@"btn_open"] forState:UIControlStateNormal];
    [openBtn setImage:[UIImage imageNamed:@"btn_open"] forState:UIControlStateHighlighted];
    [openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
    [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(72));
        make.top.mas_equalTo(phoneBtn.mas_bottom).mas_equalTo(WScale(39));
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_ash"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_ash"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-72));
        make.top.mas_equalTo(phoneBtn.mas_bottom).mas_equalTo(WScale(39));
    }];
    
    ///立即還車
    UIButton *nextBtn =  [UIButton buttonWithTitle:@"立即還車" font:kFont(16) titleColor:WHITECOLOR backGroundColor:UIColorFromRGB(0x0E70A1) buttonTag:0 target:self action:@selector(nextBtnClick) showView:self.view];
    nextBtn.layer.cornerRadius = WScale(5);
    nextBtn.clipsToBounds = YES;
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(WScale(40));
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(15));
    }];
    
    NSString *tip = @"1.如果您已經確認不需要再次開門，那麼請點擊立即還車即可；\n2.如果您需要開車門後，請在倒數計時範圍內關閉車門，否則還車不成功將會產生罰款";
    UILabel *tipLabel2 = [UILabel labelWithText:tip font:[UIFont boldSystemFontOfSize:WScale(12)] textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(nextBtn.mas_top).mas_equalTo(WScale(-15));
    }];
                         
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.lineSpacing = 5;//设置行间距离
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tip];
    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, tip.length)];
    tipLabel2.attributedText = attrString;
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
