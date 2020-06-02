//
//  SearchVehicleLocationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderSearchViewController.h"
#import "MYRHTableView.h"
#import "BrandModleSearchDetailViewController.h"

#import "NSObject+JSONCategories.h"
#import "NSString+JSONCategories.h"
#import "OrderSearchResultListViewController.h"
@interface OrderSearchViewController ()<UITextFieldDelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableArray *arrayHot;
@property(nonatomic,strong)UIView *viewBMBG;
@end

@implementation  OrderSearchViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
//    [[self.navView viewWithTag:104] setHidden:YES];
    //    [self navbarTitle:@" "];
    [self addView];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
//    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(40, 3, kScreenWidth-40-15, 30) backgroundcolor:rgb(246, 246, 246) superView:self.navView];
//        [viewSearchContent addViewTarget:self select:@selector(searchBtnClick:)];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:kS(@"main_order", @"hint_search_all") text:@""  supView:viewSearchContent];
        tfSearch.delegate=self;
//        tfSearch.userInteractionEnabled=NO;
        viewSearchContent.frameBY=7;
    }
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    {
        
        NSArray*arraytitle=@[kS(@"main_order", @"search_record"),];
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 55) backgroundcolor:rgbwhiteColor superView:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
            UILabel*lbTitle=[RHMethods lableX:16 Y:0 W:0 Height:55 font:16 superview:viewContent withColor:rgb(102, 102, 102) text:arraytitle[0]];
            WSSizeButton*viewBtn=[WSSizeButton viewWithFrame:CGRectMake(0, 0, 18+30, 18+19+19) backgroundcolor:nil superView:viewContent];
            viewBtn.frameRX=0;
            [viewBtn setImageStr:@"deli" SelectImageStr:nil];
            
            [viewBtn addViewTarget:self select:@selector(deleatBtnClick:)];
            _viewBMBG=[UIView viewWithFrame:CGRectMake(0, 55, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:viewContent];
            [_viewBMBG setAddUpdataBlock:^(id data, id weakme) {
                for (UIView *view in [weakSelf.viewBMBG subviews]) {
                    [view setHidden:YES];
                }
                float sx=15;
                float sy=0;
                for (int i=0; i<weakSelf.arrayHot.count; i++) {
                    NSDictionary *dic=weakSelf.arrayHot[i];
                    WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(sx,sy , 30, 30) backgroundColor:RGBACOLOR(13, 107, 154, 0.1) text:[dic ojsk:@"name"] font:14 textColor:rgb(13, 107, 154) radius:3 superview:weakSelf.viewBMBG reuseId:[NSString stringWithFormat:@"btnCell_%d",i]];
                    btnCell.hidden=NO;
                    btnCell.data=dic;
                    [btnCell setTitle:[dic ojsk:@"name"] forState:UIControlStateNormal];
                    btnCell.frameWidth=[btnCell.currentTitle widthWithFont: 14]+32;
                    if (btnCell.frameXW>viewContent.frameWidth-14) {
                        btnCell.frameX=15;
                        btnCell.frameY=btnCell.frameYH+10;
                    }
                    sx=btnCell.frameXW+10;
                    sy=btnCell.frameY;
                    [btnCell addViewClickBlock:^(UIView *view) {
//                        weakSelf.allcallBlock?weakSelf.allcallBlock(view.data, 200, nil):nil;
//                        [weakSelf backButtonClicked:nil];
                        [weakSelf searchWithStr:[dic ojsk:@"name"]];
                    }];
                }
                weakSelf.viewBMBG.frameHeight=sy+30+20;
                viewContent.frameHeight=YH(weakSelf.viewBMBG);
            }];
            [_viewBMBG upDataMe];
        }
        
    }
    
}
-(void)searchWithStr:(NSString*)searchStr{
    if (![searchStr notEmptyOrNull]) {
        return;
    }
    for (long i=self.arrayHot.count-1; i>=0; i--) {
        if ([searchStr isEqualToString:[self.arrayHot[i] ojsk:@"name"]]) {
            [self.arrayHot removeObjectAtIndex:i];
        }
    }
    
    NSMutableDictionary*mdic=[NSMutableDictionary dictionaryWithDictionary:@{@"name":searchStr}];
    [self.arrayHot insertObject:mdic atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[self.arrayHot JSONString] forKey:@"searchStr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [_viewBMBG upDataMe];
    [_mtableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self pushController:[OrderSearchResultListViewController class] withInfo:searchStr withTitle:kS(@"main_order", @"search_result")];
    });
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    [self searchWithStr:textField.text];
    return YES;
    
}
-(void)deleatBtnClick:(UIButton*)btn{
    UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:kS(@"main_order", @"order_notice_clear_keyword") message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.arrayHot=[NSMutableArray new];
        [[NSUserDefaults standardUserDefaults] setObject:[self.arrayHot JSONString] forKey:@"searchStr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_viewBMBG upDataMe];
        [_mtableView reloadData];
    }]];
    [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"main_order", @"cancel") style:UIAlertActionStyleCancel handler:nil]];
    [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
        
    }];
    

    
    
}
-(void)searchBtnClick:(UIButton*)btn{
//    [self pushController:[BrandModleSearchDetailViewController class] withInfo:nil withTitle:kS(@"KeyHome", @"BrandModel") withOther:nil withAllBlock:self.allcallBlock];
}
#pragma mark - request data from the server
-(void)loadDATA{
    NSString*searchStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"searchStr"];
    if ([searchStr notEmptyOrNull]) {
        self.arrayHot =[[searchStr objectFromJSONString] toBeMutableObj];
        if (self.arrayHot==nil) {
            self.arrayHot=[NSMutableArray new];
        }
        [_viewBMBG upDataMe];
        [_mtableView reloadData];
    }
    if (self.arrayHot==nil) {
        self.arrayHot=[NSMutableArray new];
    }
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
