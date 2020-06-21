//
//  TakeCarConfirmVC.m
//  TrendyApp
//
//  Created by 解辉 on 2020/6/19.
//  Copyright © 2020 55like. All rights reserved.
//

#import "TakeCarConfirmVC.h"
#import <CoreServices/UTCoreTypes.h>
#import "TakeCarUnlockVC.h"
#import "FPublicCircleCollectionViewCell.h"

#define PublicCircleCollectionViewCell @"FPublicCircleCollectionViewCell"

@interface TakeCarConfirmVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _selectTag; ///<0:沒有明顯刮痕   1:有明顯刮痕
}
@property(nonatomic,weak) UIButton *noBtn;
@property(nonatomic,weak) UIButton *haveBtn;
@property(nonatomic,weak) UIButton *photoBtn;
@property(nonatomic,weak) UILabel *titleLabel2;

@property(nonatomic,strong) UICollectionView  *collectionView;
@property(nonatomic,strong) NSMutableArray  *picListArr;

@end

@implementation TakeCarConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navbarTitle:@"取車確認"];
    [self backButton];
    [self setUI];
    self.view.backgroundColor = WHITECOLOR;
    self.picListArr = [[NSMutableArray alloc] init];
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

///下一步
-(void)nextBtnClick
{
    if (_selectTag == 1 && self.picListArr.count == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请拍照上传"];
        return;
    }
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
    ///检查车辆
    UILabel *titleLabel = [UILabel labelWithText:@"检查车辆" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(WScale(20)+SafeAreaTopHeight);
    }];
    
    ///没有明顯刮痕
    UIButton *noBtn = [UIButton buttonWithTitle:@" 沒有明顯刮痕" font:kFont(14) titleColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(BtnClick:) showView:self.view];
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
    UIButton *haveBtn = [UIButton buttonWithTitle:@" 有明顯刮痕" font:kFont(14) titleColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor buttonTag:1 target:self action:@selector(BtnClick:) showView:self.view];
    [haveBtn setImage:[UIImage imageNamed:@"radio_def"] forState:UIControlStateNormal];
    [haveBtn setImage:[UIImage imageNamed:@"radio_pre"] forState:UIControlStateSelected];
    [haveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noBtn.mas_right).mas_equalTo(WScale(35));
        make.centerY.mas_equalTo(noBtn);
    }];
    self.haveBtn = haveBtn;
    
    
    ///拍照上传
    UILabel *titleLabel2 = [UILabel labelWithText:@"拍照上传" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor textAlignment:NSTextAlignmentLeft superView:self.view];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(noBtn.mas_bottom).mas_equalTo(WScale(30));
    }];
    self.titleLabel2 = titleLabel2;
    
    
    CGFloat picWidth = (kWindowW-WScale(30)-2*7)/3.0;
    NSInteger count = MIN(self.picListArr.count+1, 9);
    NSInteger row = count%3==0?count/3:(count/3+1);
    CGFloat height = picWidth*row+(row-1)*7;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel2.mas_bottom).mas_equalTo(WScale(20));
        make.left.mas_equalTo(WScale(15));
        make.width.mas_equalTo(kWindowW-WScale(30));
        make.height.mas_equalTo(height);
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
