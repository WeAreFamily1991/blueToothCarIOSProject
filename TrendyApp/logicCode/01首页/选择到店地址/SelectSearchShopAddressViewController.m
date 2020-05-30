//
//  SelectSearchShopAddressViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/25.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SelectSearchShopAddressViewController.h"

#import "MYRHTableView.h"

@interface SelectSearchShopAddressViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) MYRHTableView*mtableView;
@property(nonatomic,strong)UITextField *txtSearch;

@end

@implementation SelectSearchShopAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf=self;
    
    [[self.navView viewWithTag:104] setHidden:YES];
    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(15, 3, kScreenWidth-30, 30) backgroundcolor:rgb(246, 246, 246) superView:viewTopSearch];
        //        [viewSearchContent addViewTarget:self select:@selector(searchBtnClick)];
        [viewSearchContent addViewClickBlock:^(UIView *view) {
            
        }];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:kS(@"selectStores", @"searchHint") text:@""  supView:viewSearchContent];
        _txtSearch=tfSearch;
        _txtSearch.delegate=self;
        _txtSearch.returnKeyType=UIReturnKeySearch;
        [_txtSearch addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight+H(viewTopSearch), kScreenWidth, kContentHeight-H(viewTopSearch)) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtableView];
    //    [_mtableView showRefresh:YES LoadMore:YES];
    _mtableView.defaultSection.dataArray=self.otherInfo;
    _mtableView.tableHeaderView=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 20) backgroundcolor:nil superView:nil];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        UIView *viewcell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
        
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:kScreenWidth-30 Height:14 font:16 superview:viewcell withColor:rgb(51, 51, 51) text:@"高鐵站送車點店" reuseId:@"lbName"];
        UILabel *lbDescrib=[RHMethods lableX:15 Y:lbName.frameYH+10 W:lbName.frameWidth Height:14 font:14 superview:viewcell withColor:rgb(153, 153, 153) text:@"上海市浦東新區濟州路286" reuseId:@"lbDescrib"];
    
         lbName.numberOfLines=0;
         lbDescrib.numberOfLines=0;
         lbName.text=[Datadic ojsk:@"title"];
         lbDescrib.text=[Datadic ojsk:@"address"];
         [lbName changeLabelHeight];
         lbDescrib.frameY=YH(lbName)+10;
         [lbDescrib changeLabelHeight];
         viewcell.frameHeight=YH(lbDescrib)+15;
         [RHMethods viewWithFrame:CGRectMake(0, H(viewcell)-0.5, kScreenWidth, 0.5) backgroundcolor:rgbLineColor superView:viewcell reuseId:@"viewLine"];
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        weakSelf.allcallBlock?weakSelf.allcallBlock(Datadic, 200, nil):nil;
        //返回两级
        NSInteger countT=self.navigationController.viewControllers.count;
        id controller=self.navigationController.viewControllers[countT-3];
        [self.navigationController popToViewController:controller animated:YES];
    }];
}

#pragma mark search
-(void)loadSearch:(NSString *)strTxt{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *tempResults = [NSMutableArray array];
        NSArray *tArray=self.otherInfo;
        if ([strTxt notEmptyOrNull]) {
            NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
            
            for (int i = 0; i < tArray.count; i++) {
                NSDictionary *dict=tArray[i];
                NSString *storeString = [dict valueForJSONStrKey:@"title"];
                NSRange storeRange = NSMakeRange(0, storeString.length);
                NSRange foundRange = [storeString rangeOfString:strTxt options:searchOptions range:storeRange];
                if (foundRange.length) {
                    [tempResults addObject:dict];
                }else{
                    NSString *storeString = [dict valueForJSONStrKey:@"address"];
                    NSRange storeRange = NSMakeRange(0, storeString.length);
                    NSRange foundRange = [storeString rangeOfString:strTxt options:searchOptions range:storeRange];
                    if (foundRange.length) {
                        [tempResults addObject:dict];
                    }else{
                        NSString *storeString = [dict valueForJSONStrKey:@"mapaddr"];
                        NSRange storeRange = NSMakeRange(0, storeString.length);
                        NSRange foundRange = [storeString rangeOfString:strTxt options:searchOptions range:storeRange];
                        if (foundRange.length) {
                            [tempResults addObject:dict];
                        }else{
                            
                        }
                    }
                }
            }
        }else{
            [tempResults addObjectsFromArray:tArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _mtableView.defaultSection.dataArray=tempResults;
            if (tempResults.count>0) {
                [_mtableView showNullHint:NO];
            }else{
                [_mtableView showNullHint:YES];
            }
            [_mtableView reloadData];
        });
    });
    
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loadSearch:textField.text];
    return YES;
}
#pragma mark - change
-(void)textFieldTextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    [self loadSearch:textField.text];
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
