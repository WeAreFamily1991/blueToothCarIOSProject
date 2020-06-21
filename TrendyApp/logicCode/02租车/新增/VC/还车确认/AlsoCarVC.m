//
//  AlsoCarVC.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/20.
//  Copyright © 2020 55like. All rights reserved.
//

#import "AlsoCarVC.h"
#import <CoreServices/UTCoreTypes.h>
#import "FPublicCircleCollectionViewCell.h"
#import "NIMGrowingTextView.h"
#import "AlsoCarKeyVC.h"

#define PublicCircleCollectionViewCell @"FPublicCircleCollectionViewCell"

@interface AlsoCarVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UIGestureRecognizerDelegate,NIMGrowingTextViewDelegate>
{
    NSInteger _selectTag; ///<0:沒有明顯刮痕   1:有明顯刮痕
    BOOL _isRefuel; ///<是否加油
}

@property(nonatomic,weak) UIButton *noBtn;
@property(nonatomic,weak) UIButton *haveBtn;
@property(nonatomic,weak) UIButton *photoBtn;
@property(nonatomic,weak) UILabel *titleLabel2;
@property(nonatomic,weak) UILabel *titleLabel3;
@property (nonatomic,weak) NIMGrowingTextView *inputTextView;

@property(nonatomic,strong) UICollectionView  *collectionView;
@property(nonatomic,strong) NSMutableArray  *picListArr;

@property (nonatomic,weak) UILabel *chargeLabel;///<加油量
@property (nonatomic,weak) UILabel *lineLabel;
@property (nonatomic,weak) UILabel *shengLabel;
@property (nonatomic,weak) UITextField *shengTF;

@property (nonatomic,weak) UILabel *tipLabel2;
@property (nonatomic,weak) UILabel *tipLabel3;

@end

@implementation AlsoCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navbarTitle:@"還車確認"];
    [self backButton];
    [self setUI];
    self.view.backgroundColor = WHITECOLOR;
}

#pragma mark ************* 按钮的点击事件
///0:沒有明顯刮痕  1:有明顯刮痕
-(void)BtnClick:(UIButton *)button
{
    if (button.tag == 0) {
        self.noBtn.selected = YES;
        self.haveBtn.selected = NO;
    }
    else
    {
        self.noBtn.selected = NO;
        self.haveBtn.selected = YES;
    }
    _selectTag = button.tag;
}

///拍照
-(void)photoBtnClick
{
    [self takePhoto];
}

-(void)switchBtnClick:(UISwitch *)switchBtn
{
    _isRefuel = switchBtn.on;
    if (switchBtn.on) {
        [self.tipLabel3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel2.mas_bottom).mas_equalTo(WScale(100));
        }];
        self.chargeLabel.hidden = NO;
        self.shengLabel.hidden = NO;
        self.shengTF.hidden = NO;
        self.lineLabel.hidden = NO;
    }
    else
    {
        [self.tipLabel3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel2.mas_bottom).mas_equalTo(WScale(30));
        }];
        self.chargeLabel.hidden = YES;
        self.shengLabel.hidden = YES;
        self.shengTF.hidden = YES;
        self.lineLabel.hidden = YES;
    }
}

///下一步
-(void)nextBtnClick
{
    if (_selectTag == 1 && self.picListArr.count == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请拍照上传"];
        return;
    }
    AlsoCarKeyVC *keyVC = [[AlsoCarKeyVC alloc] init];
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
    UIScrollView *bgScrollView = [[UIScrollView alloc] init];
    bgScrollView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    bgScrollView.userInteractionEnabled = YES;
    [self.view addSubview:bgScrollView];
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kWindowW);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    tap.delegate = self;
    [bgScrollView addGestureRecognizer:tap];
    
    ///检查车辆
    UILabel *titleLabel = [UILabel labelWithText:@"检查车辆" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(WScale(20));
    }];
    
    ///没有明顯刮痕
    UIButton *noBtn = [UIButton buttonWithTitle:@" 沒有明顯刮痕" font:kFont(14) titleColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(BtnClick:) showView:bgScrollView];
    [noBtn setImage:[UIImage imageNamed:@"radio_def"] forState:UIControlStateNormal];
    [noBtn setImage:[UIImage imageNamed:@"radio_pre"] forState:UIControlStateSelected];
    [noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(20));
    }];
    self.noBtn = noBtn;
        
    noBtn.selected = YES;
    _selectTag = 100;
    
    ///有明顯刮痕
    UIButton *haveBtn = [UIButton buttonWithTitle:@" 有明顯刮痕" font:kFont(14) titleColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor buttonTag:1 target:self action:@selector(BtnClick:) showView:bgScrollView];
    [haveBtn setImage:[UIImage imageNamed:@"radio_def"] forState:UIControlStateNormal];
    [haveBtn setImage:[UIImage imageNamed:@"radio_pre"] forState:UIControlStateSelected];
    [haveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noBtn.mas_right).mas_equalTo(WScale(35));
        make.centerY.mas_equalTo(noBtn);
    }];
    self.haveBtn = haveBtn;
    
    ///聯絡事項
    UILabel *titleLabel2 = [UILabel labelWithText:@"聯絡事項" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(noBtn.mas_bottom).mas_equalTo(WScale(30));
    }];
    
    UILabel *tipLabel = [UILabel labelWithText:@"若您於使用中打翻飲料或於行駛中注意到車輛的狀況，\n請填寫。" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(titleLabel2.mas_bottom).mas_equalTo(WScale(15));
    }];
    
    NSString *tipContent = @"請簡要填寫遇到的車輛狀況...";
    NSMutableAttributedString*mulAttriStr =  [[NSMutableAttributedString alloc]initWithString:tipContent];
    [mulAttriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xB4B4B4), NSFontAttributeName:kFont(13)} range:NSMakeRange(0,tipContent.length)];
    NIMGrowingTextView *inputTextView = [[NIMGrowingTextView alloc] init];
    inputTextView.layer.cornerRadius = 3;
    inputTextView.placeholderAttributedText = mulAttriStr;
    inputTextView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    inputTextView.font = kFont(15);
    inputTextView.maxNumberOfLines = 7;
    inputTextView.minNumberOfLines = 5;
    inputTextView.textColor = [UIColor blackColor];
    inputTextView.textViewDelegate = self;
    [bgScrollView addSubview:inputTextView];
    [inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgScrollView);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(tipLabel.mas_bottom).mas_equalTo(WScale(20));
        make.height.mas_equalTo(WScale(100));
    }];
    self.inputTextView = inputTextView;
        
    
    ///拍照上传
    UILabel *titleLabel3 = [UILabel labelWithText:@"拍照上传" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(inputTextView.mas_bottom).mas_equalTo(WScale(30));
    }];
    self.titleLabel3 = titleLabel3;
        
    CGFloat picWidth = (kWindowW-WScale(30)-2*7)/3.0;
    NSInteger count = MIN(self.picListArr.count+1, 9);
    NSInteger row = count%3==0?count/3:(count/3+1);
    CGFloat height = picWidth*row+(row-1)*7;
    [bgScrollView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel3.mas_bottom).mas_equalTo(WScale(20));
        make.left.mas_equalTo(WScale(15));
        make.width.mas_equalTo(kWindowW-WScale(30));
        make.height.mas_equalTo(height);
    }];
    
    
    ///加油
    UILabel *titleLabel4 = [UILabel labelWithText:@"加油" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_equalTo(WScale(30));
    }];
    
    UILabel *tipLabel2 = [UILabel labelWithText:@"還車前已加油" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(titleLabel4.mas_bottom).mas_equalTo(WScale(15));
    }];
    self.tipLabel2 = tipLabel2;

    
    UISwitch *switchBtn = [[UISwitch alloc] init];
    switchBtn.onTintColor = ThemeColor;
    [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(WScale(-15));
        make.centerY.mas_equalTo(tipLabel2);
    }];
    
    ///加油量
    UILabel *chargeLabel = [UILabel labelWithText:@"加油量" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    chargeLabel.hidden = YES;
    [chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(switchBtn.mas_bottom).mas_equalTo(WScale(30));
    }];
    self.chargeLabel = chargeLabel;
    
    UILabel *shengLabel = [UILabel labelWithText:@"L" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor textAlignment:NSTextAlignmentRight superView:bgScrollView];
    shengLabel.hidden = YES;
    [shengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(WScale(-15));
        make.centerY.mas_equalTo(chargeLabel);
    }];
    self.shengLabel = shengLabel;
    
    UITextField *shengTF = [[UITextField alloc] init];
    shengTF.placeholder = @"请输入";
    shengTF.hidden = YES;
    shengTF.textAlignment = NSTextAlignmentRight;
    shengTF.keyboardType = UIKeyboardTypeDecimalPad;
    shengTF.font = kFont(14);
    [bgScrollView addSubview:shengTF];
    [shengTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(shengLabel.mas_left).mas_equalTo(-WScale(10));
        make.centerY.mas_equalTo(shengLabel);
        make.width.mas_equalTo(kWindowW/3);
    }];
    self.shengTF = shengTF;
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorFromRGB(0xcccccc);
    lineLabel.hidden = YES;
    [bgScrollView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgScrollView);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(chargeLabel.mas_bottom).mas_equalTo(WScale(15));
    }];
    self.lineLabel = lineLabel;
    
    NSString *tip3 = @"1.確保您的車停放在規定位置；\n2.確保車內鑰匙放置原處；\n3.確保車門已經關鎖。";
    UILabel *tipLabel3 = [UILabel labelWithText:tip3 font:[UIFont boldSystemFontOfSize:WScale(12)] textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [tipLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(tipLabel2.mas_bottom).mas_equalTo(WScale(30));
    }];
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.lineSpacing = 5;//设置行间距离
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tip3];
    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, tip3.length)];
    tipLabel3.attributedText = attrString;
    self.tipLabel3 = tipLabel3;
    
    UILabel *tipLabel4 = [UILabel labelWithText:@"為感謝您協助加油，系統將贈送您10積分。" font:kFont(12) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:bgScrollView];
    [tipLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(tipLabel3.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    ///下一步
    UIButton *nextBtn =  [UIButton buttonWithTitle:@"下一步" font:kFont(16) titleColor:WHITECOLOR backGroundColor:UIColorFromRGB(0x0E70A1) buttonTag:0 target:self action:@selector(nextBtnClick) showView:bgScrollView];
    nextBtn.layer.cornerRadius = WScale(5);
    nextBtn.clipsToBounds = YES;
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(bgScrollView);
        make.height.mas_equalTo(WScale(40));
        make.top.mas_equalTo(tipLabel4.mas_bottom).mas_equalTo(WScale(15));
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(50));
    }];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WhiteColor;
        [_collectionView registerClass:[FPublicCircleCollectionViewCell class] forCellWithReuseIdentifier:PublicCircleCollectionViewCell];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        
    }
    return _collectionView;
}

#pragma mark ********************** 代理
#pragma mark - collection 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.picListArr.count>0) {
        if (indexPath.row<self.picListArr.count)
        {
            //跳转到图片预览页面
            [self previewVideoOrPic:indexPath.row];
        }
        else
        {
            [self takePhoto];
        }
    }
    else
    {
        [self takePhoto];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FPublicCircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PublicCircleCollectionViewCell forIndexPath:indexPath];
    if (self.picListArr.count>0)
    {
        if (indexPath.row < self.picListArr.count)
        {
            cell.cellImgView.image = self.picListArr[indexPath.row];
        }
        else
        {
            cell.cellImgView.image = [UIImage imageNamed:@"addpic"];
        }
    }
    else
    {
        cell.cellImgView.image = [UIImage imageNamed:@"addpic"];
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.picListArr.count>0 && [self.picListArr[0] isKindOfClass:[NSURL class]]) {
        return 1;
    }
    return MIN(self.picListArr.count+1, 6);
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picWidth = (kWindowW-WScale(60)-2*7)/3.0;
    CGFloat height = picWidth;
    if (self.picListArr.count>0 && [self.picListArr[0] isKindOfClass:[NSURL class]]) {
        height = WScale(180);
    }
    return CGSizeMake(picWidth, height);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 7;
}

#pragma mark ******* 拍照
-(void)takePhoto
{
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
     imagePickerVc.sourceType =UIImagePickerControllerSourceTypeCamera;
     imagePickerVc.mediaTypes =@[(NSString *)kUTTypeImage];
     imagePickerVc.delegate = self;

     imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
     imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
     UIBarButtonItem *BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
     [BarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
     imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
     [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.picListArr addObject:image];
    
    CGFloat picWidth = (kWindowW-WScale(60)-2*7)/3.0;
    NSInteger count = MIN(self.picListArr.count+1, 9);
    NSInteger row = count%3==0?count/3:(count/3+1);
    CGFloat height = picWidth*row+(row-1)*7;
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel2.mas_bottom).mas_equalTo(WScale(35));
        make.left.mas_equalTo(WScale(15));
        make.width.mas_equalTo(kWindowW-WScale(30));
        make.height.mas_equalTo(height);
    }];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 预览图片|视频
- (void)previewVideoOrPic:(NSInteger)index
{

}

#pragma mark - NIMGrowingTextView代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[touch.view class] isKindOfClass:[UIScrollView class]]) {
        return YES;
    }
    return NO;
}
- (void)hiddenKeyboard
{
    [self.inputTextView resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputTextView resignFirstResponder];
}
- (void)willChangeHeight:(CGFloat)height
{
//    self.inputTextView.height = height;
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
