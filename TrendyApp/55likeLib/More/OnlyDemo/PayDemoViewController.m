//
//  PayDemoViewController.m
//  55likeLibDemo
//
//  Created by 55like on 2017/12/21.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "PayDemoViewController.h"

@interface PayDemoViewController ()

@end

@implementation PayDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
      __weak __typeof(self) weakSelf = self;
    
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"成功" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            if (weakSelf.allcallBlock) {
                weakSelf.allcallBlock(nil, 200, nil);
            }
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"失败" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            if (self.allcallBlock) {
                self.allcallBlock(nil, 201, nil);
            }
        }];
        yAdd=btn1.frameYH+10;
    }
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
