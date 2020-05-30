//
//  CantGoBackViewController.m
//  Zhongdu
//
//  Created by 55like on 2018/4/3.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "CantGoBackViewController.h"

@interface CantGoBackViewController ()

@end

@implementation CantGoBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonClicked:(id)sender{
  
    if ([self cantGoBack]) {
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:@"确认返回" message:@"返回后所填内容将清空" preferredStyle:UIAlertControllerStyleAlert];
        [alertcv addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [super backButtonClicked:sender];
        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
    }else{
        [super backButtonClicked:sender];
    }
}
-(BOOL)cantGoBack{
    return NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    KKNavigationController*nv=(KKNavigationController*)self.navigationController;
    [nv removeGesture];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    KKNavigationController*nv=(KKNavigationController*)self.navigationController;
    [nv addGesture];
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
