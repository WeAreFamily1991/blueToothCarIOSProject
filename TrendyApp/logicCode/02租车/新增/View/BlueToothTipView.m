//
//  BlueToothTipView.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/18.
//  Copyright © 2020 55like. All rights reserved.
//

#import "BlueToothTipView.h"
@interface BlueToothTipView()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIView *popView;
@property(nonatomic,strong) UIView *centerView;
@property(nonatomic,assign) float popViewHeight;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) BigClickBT *nextBtn;
@end

@implementation BlueToothTipView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0,0, kWindowW, kWindowH);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.clipsToBounds = YES;
        self.tag = 100;
        
        self.popView = [[UIView alloc] init];
        self.popView.backgroundColor = WHITECOLOR;
        self.popView.userInteractionEnabled = YES;
        self.popView.layer.cornerRadius = WScale(5);
        self.popView.clipsToBounds = YES;
        [self addSubview:self.popView];
        [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(WScale(290));
            make.height.mas_equalTo(WScale(214));
        }];
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        [self setUI];
    }
    return self;
}
-(void)closeBtnClick
{
    [self dismiss];
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    NSArray *titleArray = @[@"您要开始用车吗",@"蓝牙连接提示",@"蓝牙配对成功"];
    NSArray *contentArray = @[@"",@"连接失败\n校验失败，请重新连接",@"已成功配對i-key免鑰匙開關鎖"];
    NSArray *btnArray = @[@"确认",@"重新连接",@"下一步"];
    self.titleLabel.text = titleArray[index];
    self.contentLabel.text = contentArray[index];
    [self.nextBtn setTitle:btnArray[index] forState:UIControlStateNormal];
}
-(void)nextBtnClick
{
    [self dismiss];
    if (self.Block) {
        self.Block(_index);
    }
}

-(void)setUI
{
    BigClickBT *closeBtn = [[BigClickBT alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"closei2"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WScale(15));
        make.top.mas_equalTo(WScale(15));
    }];
    
    UILabel *titleLabel = [UILabel labelWithText:@"藍牙配對成功" font:[UIFont boldSystemFontOfSize:WScale(22)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentCenter superView:self.popView];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.top.mas_equalTo(WScale(30));
    }];
    self.titleLabel = titleLabel;
    
    
    UILabel *contentLabel = [UILabel labelWithText:@"已成功配對i-key免鑰匙開關鎖" font:kFont(15) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor textAlignment:NSTextAlignmentCenter superView:self.popView];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(25));
    }];
    self.contentLabel = contentLabel;
    
    
    BigClickBT *nextBtn = [[BigClickBT alloc] init];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    nextBtn.titleLabel.font = kFont(16);
    [nextBtn setBackgroundColor:UIColorFromRGB(0x0E70A1)];
    nextBtn.layer.cornerRadius = WScale(5);
    nextBtn.clipsToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.bottom.mas_equalTo(-WScale(40));
        make.width.mas_equalTo(WScale(230));
        make.height.mas_equalTo(WScale(40));
    }];
    self.nextBtn = nextBtn;
    
}

-(void)tapClick
{
    [self dismiss];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view.tag == 100) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}

- (void)dismiss {
    
     [self removeFromSuperview];
}


@end
