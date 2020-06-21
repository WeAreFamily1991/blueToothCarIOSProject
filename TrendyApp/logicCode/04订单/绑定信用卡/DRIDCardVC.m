//
//  DRIDCardVC.m
//  TrendyApp
//
//  Created by rockding on 2020/6/10.
//  Copyright © 2020 55like. All rights reserved.
//

#import "DRIDCardVC.h"

@interface DRIDCardVC ()
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
@property (weak, nonatomic) IBOutlet UITextField *monthTF;
@property (weak, nonatomic) IBOutlet UITextField *yearTF;
@property (weak, nonatomic) IBOutlet UITextField *safeTF;
@property (weak, nonatomic) IBOutlet UIButton *contentBTN;
@property (weak, nonatomic) IBOutlet UIButton *useIDCardBtn;
@property (nonatomic,retain)UIView *backView;
@end

@implementation DRIDCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.useIDCardBtn.layer.cornerRadius = 5;
     self.useIDCardBtn.layer.masksToBounds = 5;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)addBackView
{
    self.backView =[[UIView alloc]initWithFrame:self.view.bounds];
    UIView *customView =[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-WScale(315), SCREEN_WIDTH, WScale(315))];
    customView.backgroundColor =WHITECOLOR;
    [self.backView addSubview:customView];
    UIButton *cancelBtn =[UIButton buttonWithImage:@"closei2" target:self action:@selector(cancelBtnClick) showView:self.backView];
    cancelBtn.frame =CGRectMake(SCREEN_WIDTH-WScale(33), WScale(20), WScale(13), WScale(13));
    [customView addSubview:cancelBtn];
    
    UILabel *titleLab =[UILabel labelWithText:@"VISA/Mastercard/JCB/運通卡" font:DR_FONT(15) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:customView];
    titleLab.frame =CGRectMake(0, WScale(60), SCREEN_WIDTH, WScale(15));
    UIImageView *idCardIMG =[[UIImageView alloc]initWithFrame:CGRectMake(WScale(25), WScale(104), (SCREEN_WIDTH-WScale(75))/2, WScale(100))];
    idCardIMG.image =[UIImage imageNamed:@"pic_card_01"];
     [customView addSubview:idCardIMG];
    
    UIImageView *idCardIMG2 =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+WScale(12.5), WScale(104), (SCREEN_WIDTH-WScale(75))/2, WScale(100))];
    idCardIMG2.image =[UIImage imageNamed:@"pic_card_02"];
    [customView addSubview:idCardIMG2];
    
    UILabel *contentLab =[UILabel labelWithText:@"※此處無印刷數字之信用卡無法使用\nVisa, master card, JCB是背面末三碼，美國運通卡是正面右邊四碼" font:DR_FONT(11) textColor:REDCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:customView];
    contentLab.frame =CGRectMake(WScale(25), WScale(260), SCREEN_WIDTH-WScale(50), WScale(32));
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.backView];
    
    //111111
}
-(void)cancelBtnClick
{
    [self.backView removeFromSuperview];
}
- (IBAction)contentBtnClick:(id)sender {
    [self addBackView];
}
- (IBAction)useIDCardBtnClick:(id)sender {
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
