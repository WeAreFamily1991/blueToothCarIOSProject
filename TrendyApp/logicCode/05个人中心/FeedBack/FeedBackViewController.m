//
//  FeedBackViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MYRHTableView.h"
@interface FeedBackViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UITextView*contentTextView;
@property(nonatomic,strong)UITextField*mobileTextfield;
@end

@implementation  FeedBackViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self navbarTitle:kST(@"feedback")];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
 UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 15, kScreenWidth, 219) backgroundcolor:rgb(255, 255, 255) superView:nil];
    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    {
        UIView*viewQuestionsAndOpinionsGreyBackGround=[UIView viewWithFrame:CGRectMake(15, 15, viewContent.frameWidth-30, 135) backgroundcolor:rgb(246, 246, 246) superView:viewContent];
        PLTextView*viewTextQuestionAndOpinions=[PLTextView viewWithFrame:CGRectMake(15, 15, viewQuestionsAndOpinionsGreyBackGround.frameWidth-30, viewQuestionsAndOpinionsGreyBackGround.frameHeight -30) backgroundcolor:nil superView:viewQuestionsAndOpinionsGreyBackGround];
        viewTextQuestionAndOpinions.placeholder=kS(@"feedback", @"feedback_hint_content");
        _contentTextView=viewTextQuestionAndOpinions;
    }
    
    {
        UIView*viewQuestionsAndOpinionsGreyBackGround=[UIView viewWithFrame:CGRectMake(15, 15, viewContent.frameWidth-30, 44) backgroundcolor:rgb(246, 246, 246) superView:viewContent];
        viewQuestionsAndOpinionsGreyBackGround.frameBY=15;
        
//        PLTextView*viewTextQuestionAndOpinions=[PLTextView viewWithFrame:CGRectMake(15, 15, viewQuestionsAndOpinionsGreyBackGround.frameWidth-30, viewQuestionsAndOpinionsGreyBackGround.frameHeight -30) backgroundcolor:nil superView:viewQuestionsAndOpinionsGreyBackGround];
//        viewTextQuestionAndOpinions.placeholder=@"請輸入您的聯繫方式（選填）";
 UITextField*tfText=[RHMethods textFieldlWithFrame:CGRectMake(15, 0, viewQuestionsAndOpinionsGreyBackGround.frameWidth-30, viewQuestionsAndOpinionsGreyBackGround.frameHeight) font:Font(14) color:rgb(51, 51, 51) placeholder:kS(@"feedback", @"feedback_hint_mobile") text:@""  supView:viewQuestionsAndOpinionsGreyBackGround];
        _mobileTextfield=tfText;
    
    }
     WSSizeButton*btnCommit=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"feedback", @"button_submit") font:17 textColor:rgb(255, 255, 255) radius:5 superview:nil];
    [_mtableView.defaultSection.noReUseViewArray addObject:btnCommit];
    [btnCommit addViewTarget:self select:@selector(submit)];
    
}
-(void)submit{
      __weak __typeof(self) weakSelf = self;
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    [mdic setObject:_contentTextView.text forKey:@"content"];
    [mdic setObject:_mobileTextfield.text forKey:@"mobile"];
    
    [kUserCenterService addfeedBackWithParam:mdic withBlock:^(id data, int status, NSString *msg) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }];
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
