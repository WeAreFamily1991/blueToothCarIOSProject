//
//  NavRightSelectTypeDemo.m
//  55likeLibDemo
//
//  Created by junseek on 2017/9/27.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "NavRightSelectTypeDemo.h"
#import "SelectRightTypeView.h"

@implementation NavRightSelectTypeDemo

+(void)showMyDemo{
    BaseViewController *baseV=UTILITY.currentViewController;
    UIButton *btnRightNav=[RHMethods buttonWithFrame:CGRectMake(kScreenWidth-80, 20, 80, 44) title:@"选择" image:nil bgimage:nil supView:baseV.navView];
    [btnRightNav setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnRightNav setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    
    SelectRightTypeView *selctTypeView=[[SelectRightTypeView alloc] init];
    selctTypeView.dicType=@{@"list":@[@{@"title":@"测试类型1"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"},@{@"title":@"类型仓"},@{@"title":@"类型3"}]};
    selctTypeView.contentConter=YES;
    [btnRightNav addViewClickBlock:^(UIView *view) {
        [selctTypeView showRightTypeBlock:^(NSDictionary *dicSelect) {
            [SVProgressHUD showImage:nil status:[dicSelect valueForJSONStrKey:@"title"]];
        }];
    }];
    
    
    


}
@end
