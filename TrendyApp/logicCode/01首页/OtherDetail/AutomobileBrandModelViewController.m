//
//  AutomobileBrandModelViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/14.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AutomobileBrandModelViewController.h"
#import "AutomobileBrandContentView.h"
@interface AutomobileBrandModelViewController ()
@property(nonatomic,strong)AutomobileBrandContentView*viewContent;
@end

@implementation AutomobileBrandModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AutomobileBrandContentView*viewContent=[AutomobileBrandContentView viewWithFrame:CGRectMake(0, kTopHeight, 0, 0) backgroundcolor:nil superView:self.view];
    [viewContent upDataMeWithData:self.userInfo];
    _viewContent=viewContent;
//    [self rightButton:kS(@"chooseAutomobileBrandModel", @"complete") image:nil sel:@selector(completeBtnClick:)];
    __weak __typeof(self) weakSelf = self;
    [viewContent setCallBackBlock:^(id data, int status, NSString *msg) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    // Do any additional setup after loading the view.
}
-(void)completeBtnClick:(UIButton*)btn{
//    if (self.allcallBlock) {
//        self.allcallBlock(_viewContent.data, 200, nil);
//    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.allcallBlock) {
        self.allcallBlock(_viewContent.data, 200, nil);
    }
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
