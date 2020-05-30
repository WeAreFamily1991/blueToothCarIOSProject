//
//  ComprehensiveSortPopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ComprehensiveSortPopView.h"

#import "MYRHTableView.h"
@interface ComprehensiveSortPopView()
{
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)AllcallBlock selectBlock;
@property(nonatomic,strong)WSSizeButton *btnCellOld;
@property (nonatomic, strong) UIWindow *overlayWindow;
@end
@implementation ComprehensiveSortPopView
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
    
    [self setAddUpdataBlock:^(id data, id weakme) {
        weakSelf.btnCellOld=nil;
        [weakSelf.mtableView.defaultSection.noReUseViewArray removeAllObjects];
        NSArray*arraytitle=[data ojk:@"list"];//@[@"综合排序",@"距离最近",@"距离最远",];
        for (int i=0; i<arraytitle.count; i++) {
            WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(0, 0, kScreenWidth, 44) backgroundColor:rgbwhiteColor text:[arraytitle[i] ojsk:@"name"] font:14 textColor:rgb(51, 51, 51) radius:0 superview:nil];
            [btnCell setTitleColor:rgbpublicColor forState:UIControlStateSelected];
            btnCell.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
            btnCell.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0  );
            btnCell.data=arraytitle[i];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, btnCell.frameWidth-15, 1) backgroundcolor:RGBACOLOR(238, 238, 238, 0.5) superView:btnCell];
            viewLine.frameBY=0;
            [weakSelf.mtableView.defaultSection.noReUseViewArray addObject:btnCell];
            [btnCell addViewClickBlock:^(UIView *view) {
                if (weakSelf.btnCellOld) {
                    weakSelf.btnCellOld.selected=NO;
                }
                WSSizeButton*btnCell=(id)view;
                weakSelf.btnCellOld=btnCell;
//                    btnCell.selected=!btnCell.selected;
                weakSelf.btnCellOld.selected=YES;
                NSString *strKey=[NSString stringWithFormat:@"%@_%@",[weakSelf.data ojsk:@"type"],[btnCell.data ojsk:@"obj"]];
                weakSelf.selectBlock?weakSelf.selectBlock(@{strKey:[NSString stringWithFormat:@"%@_%@",strKey,[btnCell.data ojsk:@"value"]]},200,nil):nil;
                [weakSelf hidden];
            }];
        }
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
