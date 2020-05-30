//
//  ComprehensiveSortPopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SortByPricePopView.h"

#import "MYRHTableView.h"
@interface SortByPricePopView()
{
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)AllcallBlock selectBlock;
@property(nonatomic,strong)WSSizeButton *btnCellOld;
@property(nonatomic,strong)UIView*viewContent;
@property(nonatomic,strong)UIView*viewContent2;
@property (nonatomic, strong) UIWindow *overlayWindow;
@end
@implementation SortByPricePopView
@synthesize overlayWindow;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        self.backgroundColor=[UIColor clearColor];
        UIControl *closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [closeC addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeC];
        _contentViewBG=[UIView viewWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100) backgroundcolor:RGBACOLOR(0, 0, 0, 0.3) superView:self];
        [self addView];
    }
    return self;
}
- (void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:_contentViewBG.bounds style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [_contentViewBG addSubview:_mtableView];
    __weak __typeof(self) weakSelf = self;
    [_mtableView addViewClickBlock:^(UIView *view) {
        [weakSelf hidden];
    }];
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [viewContent addViewClickBlock:^(UIView *view) {
            
        }];
        _viewContent=viewContent;
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        [_viewContent setAddUpdataBlock:^(id data, id weakme) {
            for (UIView *view in [weakSelf.viewContent subviews]) {
                view.hidden=YES;
            }
            weakSelf.btnCellOld=nil;
            float fx=15;
            float fy=15;
            NSArray*arraytitle=[weakSelf.data ojk:@"list"];
            for (int i=0; i<arraytitle.count; i++) {
                id dataT=arraytitle[i];
                WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(fx, fy, 50, 30) backgroundColor:nil text:@"" font:12 textColor:rgb(102, 102, 102) radius:2 superview:viewContent reuseId:[NSString stringWithFormat:@"btnItem%d",i]];
                [btnItem setBackGroundImageviewColor:RGBACOLOR(153, 153, 153,0.11) forState:UIControlStateNormal];
                [btnItem setBackGroundImageviewColor:RGBACOLOR(14,112,161,0.11) forState:UIControlStateSelected];
                [btnItem setTitleColor:rgbpublicColor forState:UIControlStateSelected];
                btnItem.hidden=NO;
                btnItem.data=dataT;
                [btnItem setTitle:[dataT ojsk:@"name"] forState:UIControlStateNormal];
                float width=[btnItem.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 30)].width+20;
                if (width>kScreenWidth-30) {
                    width=kScreenWidth-30;
                }
                btnItem.frameWidth=width;
                if (XW(btnItem)>kScreenWidth-15) {
                    fx=15;
                    fy+=H(btnItem)+10;
                    btnItem.frameX=fx;
                    btnItem.frameY=fy;
                }
                fx+=W(btnItem)+10;
                if (i==arraytitle.count-1) {
                    viewContent.frameHeight=btnItem.frameYH+10;
                }
                [btnItem addViewClickBlock:^(UIView *view) {
                    WSSizeButton *btnItem=(WSSizeButton *)view;
                    if (weakSelf.btnCellOld) {
                        weakSelf.btnCellOld.selected=NO;
                    }
                    weakSelf.btnCellOld=btnItem;
                    weakSelf.btnCellOld.selected=YES;
                }];
            }
            
        }];
        
        
    }
    
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [viewContent addViewClickBlock:^(UIView *view) {
            
        }];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        _viewContent2=viewContent;
        [_viewContent2 setAddUpdataBlock:^(id data, id weakme) {
            for (UIView *view  in [viewContent subviews]) {
                [view removeFromSuperview];
            }
            if (![weakSelf.data ojk:@"more"] || [[weakSelf.data ojk:@"more"] count]==0) {
                viewContent.frameHeight=0;
                return ;
            }
            NSDictionary *dic=[[weakSelf.data ojk:@"more"] objectAtIndex:0];
            UILabel*lbTitle=[RHMethods lableX:15 Y:10 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:[dic ojsk:@"name"]];
            
            NSArray*arraytitle=[dic ojk:@"list"];//@[@"最低價格",@"最高價格",];
            for (int i=0; i<arraytitle.count; i++) {
                NSDictionary *dataT=[arraytitle objectAtIndex:i];
                UITextField*tfTextInput=[RHMethods textFieldlWithFrame:CGRectMake(15, lbTitle.frameYH+15, (kScreenWidth-45)*0.5, 36) font:Font(12) color:rgb(51, 51, 51) placeholder:[dataT ojsk:@"name"] text:@""  supView:viewContent reuseId:[dataT ojsk:@"obj"]];
                tfTextInput.layer.borderColor=rgb(238, 238, 238).CGColor;
                tfTextInput.layer.borderWidth=1;
                tfTextInput.layer.cornerRadius=3;
                tfTextInput.keyboardType=UIKeyboardTypeNumberPad;
                tfTextInput.textAlignment=NSTextAlignmentCenter;
                if (i==1) {
                    tfTextInput.frameRX=15;
                }
            }
        }];
        
    }
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [viewContent addViewClickBlock:^(UIView *view) {
            
        }];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        NSArray*arrayBtntitle=@[kS(@"generalPage", @"clear"),kS(@"generalPage", @"OK")];//@[@"清空",@"確認",];
        for (int i=0; i<arrayBtntitle.count; i++) {
            WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(15, 15, (kScreenWidth-45)*0.5, 40) backgroundColor:rgb(244,244,244) text:arrayBtntitle[i] font:16 textColor:rgb(51, 51, 51) radius:3 superview:viewContent];
            if (i==1) {
                btnItem.frameRX=15;
                [btnItem setBackgroundColor:rgb(13, 112, 161)];
                [btnItem setTitleColor:rgb(255, 255, 255) forState:UIControlStateNormal];
                viewContent.frameHeight=btnItem.frameYH+15;
                [btnItem addViewClickBlock:^(UIView *view) {
                    NSMutableDictionary *dicTemp=[NSMutableDictionary new];
                    UITextField *txt1=[weakSelf.viewContent2 getAddValueForKey:@"min_price"];
                    UITextField *txt2=[weakSelf.viewContent2 getAddValueForKey:@"max_price"];
                    NSString *str1=txt1.text;
                    NSString *str2=txt2.text;
                    if ([str1 notEmptyOrNull] && [str2 notEmptyOrNull]) {
                        if ([str1 integerValue]>[str2 integerValue]) {
                            [SVProgressHUD showImage:nil status:kS(@"homeCarQueryResult", @"searchMoneyTip")];
                            return ;
                        }
                    }
                    [dicTemp setValue:str1 forKey:@"min_price"];
                    [dicTemp setValue:str2 forKey:@"max_price"];
                    if (weakSelf.btnCellOld) {
                        NSString *strKey=[NSString stringWithFormat:@"%@_%@",[weakSelf.data ojsk:@"type"],[weakSelf.btnCellOld.data ojsk:@"obj"]];
                        [dicTemp setValue:[NSString stringWithFormat:@"%@_%@",strKey,[weakSelf.btnCellOld.data ojsk:@"value"]] forKey:strKey];
                    }
                    weakSelf.selectBlock?weakSelf.selectBlock(dicTemp,200,nil):nil;
                    [weakSelf hidden];
                    
                }];
            }else{
                [btnItem addViewClickBlock:^(UIView *view) {
                    [weakSelf endEditing:YES];
                    //清空
                    if (weakSelf.btnCellOld) {
                        weakSelf.btnCellOld.selected=NO;
                    }
                    UITextField *txt1=[weakSelf.viewContent2 getAddValueForKey:@"min_price"];
                    UITextField *txt2=[weakSelf.viewContent2 getAddValueForKey:@"max_price"];
                    txt1.text=@"";
                    txt2.text=@"";
                    weakSelf.btnCellOld=nil;
                }];
            }
        }
    }
    
    [self setAddUpdataBlock:^(id data, id weakme) {
        [weakSelf.viewContent upDataMe];
        [weakSelf.viewContent2 upDataMe];
        [weakSelf.mtableView reloadData];
    }];
    
    
}
-(void)showPopViewBlock:(AllcallBlock)aBlock{
    self.hidden=NO;
    self.selectBlock = aBlock;
    [self.overlayWindow addSubview:self];
    self.alpha = 1.0f;
}
- (void)hidden
{
   __weak typeof(self) weakSelf=self;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        weakSelf.selectBlock?weakSelf.selectBlock(nil,0,nil):nil;
        [self.overlayWindow removeFromSuperview];
        self.overlayWindow = nil;
    }];
}

#pragma mark - Getters
- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = YES;
        overlayWindow.windowLevel = UIWindowLevelStatusBar-1;
    }
    overlayWindow.hidden=NO;
    return overlayWindow;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
