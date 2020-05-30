//
//  SearchVehicleLocationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "BrandModelSearchViewController.h"
#import "MYRHTableView.h"
#import "BrandModleSearchDetailViewController.h"
@interface BrandModelSearchViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableArray *arrayHot;
@property(nonatomic,strong)UIView *viewBMBG;
@end

@implementation  BrandModelSearchViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.navView viewWithTag:104] setHidden:YES];
    //    [self navbarTitle:@" "];
    [self addView];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(15, 3, kScreenWidth-30, 30) backgroundcolor:rgb(246, 246, 246) superView:viewTopSearch];
        [viewSearchContent addViewTarget:self select:@selector(searchBtnClick:)];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
        UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:kS(@"KeyHome", @"InputBrandModel") text:@""  supView:viewSearchContent];
        tfSearch.userInteractionEnabled=NO;
    }
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTopSearch.frameYH, kScreenWidth, kScreenHeight-viewTopSearch.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    {
        
        NSArray*arraytitle=@[kS(@"KeyHome", @"PopularSearch"),];
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 55) backgroundcolor:rgbwhiteColor superView:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
            UILabel*lbTitle=[RHMethods lableX:16 Y:0 W:0 Height:55 font:16 superview:viewContent withColor:rgb(102, 102, 102) text:arraytitle[0]];
            _viewBMBG=[UIView viewWithFrame:CGRectMake(0, 55, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:viewContent];
            [_viewBMBG setAddUpdataBlock:^(id data, id weakme) {
                for (UIView *view in [weakSelf.viewBMBG subviews]) {
                    [view setHidden:YES];
                }
                float sx=15;
                float sy=0;
                for (int i=0; i<weakSelf.arrayHot.count; i++) {
                    NSDictionary *dic=weakSelf.arrayHot[i];
                    WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(sx,sy , 30, 30) backgroundColor:RGBACOLOR(13, 107, 154, 0.1) text:[dic ojsk:@"title"] font:14 textColor:rgb(13, 107, 154) radius:3 superview:weakSelf.viewBMBG reuseId:[NSString stringWithFormat:@"btnCell_%d",i]];
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
                        weakSelf.allcallBlock?weakSelf.allcallBlock(view.data, 200, nil):nil;
                        [weakSelf backButtonClicked:nil];
                    }];
                }
                weakSelf.viewBMBG.frameHeight=sy+30+20;
                viewContent.frameHeight=YH(weakSelf.viewBMBG);
            }];
            [_viewBMBG upDataMe];
        }
        
    }
    
}
-(void)searchBtnClick:(UIButton*)btn{
    [self pushController:[BrandModleSearchDetailViewController class] withInfo:nil withTitle:kS(@"KeyHome", @"BrandModel") withOther:nil withAllBlock:self.allcallBlock];
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [NetEngine createGetAction_LJ:[NSString stringWithFormat:@"welcome/searchcar%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.arrayHot=[dicData ojk:@"list"];
            [_viewBMBG upDataMe];
            [_mtableView reloadData];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
        }
    }];
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
