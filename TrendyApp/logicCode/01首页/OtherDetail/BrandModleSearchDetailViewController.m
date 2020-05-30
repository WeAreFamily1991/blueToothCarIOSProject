//
//  SearchVehicleLocationDetailViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "BrandModleSearchDetailViewController.h"
#import "MYRHTableView.h"
@interface BrandModleSearchDetailViewController ()<UITextFieldDelegate>
{
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UITextField *txtSearch;
@end

@implementation  BrandModleSearchDetailViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.navView viewWithTag:104] setHidden:YES];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(15, 3, kScreenWidth-15-15, 30) backgroundcolor:rgb(246, 246, 246) superView:viewTopSearch];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:kS(@"KeyHome", @"InputBrandModel")  text:@""  supView:viewSearchContent];
        tfSearch.returnKeyType=UIReturnKeySearch;
        tfSearch.delegate=self;
        [tfSearch addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        
        _txtSearch=tfSearch;
    }
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTopSearch.frameYH, kScreenWidth, kScreenHeight-viewTopSearch.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.defaultSection.dataArray=kfAry(15);
    _mtableView.tableHeaderView=[RHMethods viewWithFrame:CGRectMake(0, 0, kScreenWidth, 10) backgroundcolor:rgbGray superView:nil];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        UIView*viewcell=[reuseView getAddValueForKey:@"viewcell"];
        if (viewcell==nil) {
            viewcell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
            UILabel*lbAddress=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:14 superview:viewcell withColor:rgb(51, 51, 51) text:@"奔馳 C級"];
            [lbAddress beCY];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:viewcell];
            viewLine.frameBY=0;
            viewcell.backgroundColor=rgb(255, 255, 255);
            [viewcell setAddUpdataBlock:^(id data, id weakme) {
                lbAddress.text=[data ojsk:@"name"];
//                rgb(14, 112, 161)
                [lbAddress setColor:rgb(14, 112, 161) contenttext:weakSelf.txtSearch.text];
            }];
        }        
        [viewcell upDataMeWithData:Datadic];
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        weakSelf.allcallBlock?weakSelf.allcallBlock(Datadic, 200, nil):nil;
//        [weakSelf backButtonClicked:nil];
        //返回两级
        NSInteger countT=self.navigationController.viewControllers.count;
        id controller=self.navigationController.viewControllers[countT-3];
        [self.navigationController popToViewController:controller animated:YES];
    }];
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    [dictparam setValue:_txtSearch.text forKey:@"keywords"];
    _mtableView.urlString=[NSString stringWithFormat:@"welcome/searchcar%@",dictparam.wgetParamStr];
    [_mtableView refresh];
}
#pragma mark - event listener function


#pragma mark - delegate function

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self request];
    return YES;
}
#pragma mark - change
-(void)textFieldTextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    [self request];
}

@end
