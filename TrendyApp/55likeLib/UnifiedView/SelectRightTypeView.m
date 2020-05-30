//
//  SelectRightTypeView.m
//  ZhuiKe55like
//
//  Created by junseek on 15/11/11.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//

#import "SelectRightTypeView.h"

@interface SelectRightTypeView ()<UITableViewDataSource,UITableViewDelegate>{
    //
    
    UITableView *tableViewT;
    UIImageView *imageBG;
    
    NSArray *arrayType;
    
}

@property (nonatomic, strong) UIView *view_userContact;
@property (nonatomic, strong) UIWindow *overlayWindow;

@property(strong,nonatomic)UITextField *selecttextField;

@end

@implementation SelectRightTypeView
@synthesize overlayWindow;


-(instancetype)init{
    self=[super init];
    if (self) {
        [self loadDataView];
    }
    return self;
}

-(void)loadDataView{
    self.backgroundColor=[UIColor clearColor];//RGBACOLOR(0, 0, 0, 0.4);
    self.frame=[UIScreen mainScreen].bounds;
    
    UIControl *closeC=[[UIControl alloc]initWithFrame:self.bounds];
    [closeC addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeC];
    
    self.view_userContact=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-128, kTopHeight, 120, 1)];
    [self addSubview:self.view_userContact];
    self.view_userContact.backgroundColor=[UIColor clearColor];
    self.view_userContact.clipsToBounds=YES;
    self.view_userContact.layer.anchorPoint=CGPointMake(0.9, 0);
    
    imageBG=[RHMethods imageviewWithFrame:self.view_userContact.bounds defaultimage:@"headTcBg_20151111" stretchW:20 stretchH:20];
    [imageBG setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view_userContact addSubview:imageBG];
    
   
    //table
    tableViewT=[[UITableView alloc]initWithFrame:CGRectMake(0, 9, W(self.view_userContact), H(self.view_userContact)-12) style:UITableViewStylePlain];
//    [tableViewT setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    tableViewT.delegate=self;
    tableViewT.dataSource = self;
    tableViewT.backgroundColor=[UIColor clearColor];
    [tableViewT setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view_userContact addSubview:tableViewT];
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrayType.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic=[arrayType objectAtIndex:indexPath.row];
     NSString *identifier= dic.description.md5;//@"tableMessageCell";
   
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:[UIColor clearColor]];
      
        if (self.contentConter) {
            UIButton *btn=[RHMethods buttonWithFrame:CGRectMake(0, 0, W(tableView), 40) title:[NSString stringWithFormat:@" %@",[dic valueForJSONStrKey:@"title"]] image:[dic valueForJSONStrKey:@"image"] bgimage:@""];
            btn.userInteractionEnabled=NO;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell addSubview:btn];
        }else{
            float fw=0.0;
            if ([[dic valueForJSONStrKey:@"image"] notEmptyOrNull]) {
                [cell addSubview:[RHMethods imageviewWithFrame:CGRectMake(0, 0, 44, 40) defaultimage:[dic valueForJSONStrKey:@"image"] contentMode:UIViewContentModeCenter]];
                fw=44;
            }
            
            UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(fw, 10, W(tableViewT)-fw, 20) font:fontTitle  color:[UIColor whiteColor] text:[dic valueForJSONStrKey:@"title"] textAlignment:[[dic valueForJSONStrKey:@"image"] notEmptyOrNull]?NSTextAlignmentLeft:NSTextAlignmentCenter];
            [lblTitle setHighlightedTextColor:RGBCOLOR(255, 255, 255)];
            [cell addSubview:lblTitle];
            

        }
        
        
        UIView *viewLine=[RHMethods lineViewWithFrame:CGRectMake(10, 39.5, W(self.view_userContact)-15, 0.5) supView:cell];
        viewLine.backgroundColor=RGBACOLOR(255, 255, 255, 0.3);
        viewLine.tag=110;
        
    }
    
    UIView *viewImg=[cell viewWithTag:110];
    if (indexPath.row==arrayType.count-1) {
        viewImg.hidden=YES;
    }else{
        viewImg.hidden=NO;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(selectRightTypeView:object:index:)]) {
        NSDictionary *dic=[arrayType objectAtIndex:indexPath.row];
        [self.delegate selectRightTypeView:self object:dic index:indexPath];
    }
    self.rightType?self.rightType([arrayType objectAtIndex:indexPath.row]):nil;
    self.hidden = YES;
    [overlayWindow removeFromSuperview];
    overlayWindow = nil;
//    [self hidden];
}
#pragma mark but
-(void)closeButtonClicked{
    [self hidden];
}

- (void)showRightTypeBlock:(SelectRightTypeViewBlock)aTypeBlock{
    self.rightType = aTypeBlock;
    [self show];
}
- (void)show
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidden) name:@"push_showLogin" object:nil];
    
    arrayType=[self.dicType objectForJSONKey:@"list"];
    
    float tempF=(arrayType.count) * 40.0+12;
    float tempY=tempF>(kScreenHeight-100)?(kScreenHeight-100):tempF;

    [self.view_userContact setFrame:CGRectMake(kScreenWidth-128, kTopHeight, 120, tempY)];
    tableViewT.frame=CGRectMake(0, 9, W(self.view_userContact), H(self.view_userContact)-12);
    DLog(@"____________%f",tempY);
    [tableViewT reloadData];
   
    // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
    [self.overlayWindow addSubview:self];
    self.hidden = NO;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1.0f;
        
    }];
    
}

- (void)hidden
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
//    CGAffineTransform t=CGAffineTransformMakeTranslation(30, -50);
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
        self.view_userContact.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.rightType=nil;
        self.view_userContact.transform = CGAffineTransformMakeScale(1, 1);
        [self.overlayWindow removeFromSuperview];
        self.overlayWindow = nil;
    }];
   
        //
        
    
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
