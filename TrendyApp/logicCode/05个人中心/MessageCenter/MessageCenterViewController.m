//
//  MessageCenterViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MYRHTableView.h"
#import "MessageCenterHeaderCellView.h"
#import "MessageCenterCellView.h"
#import "OrderMessageViewController.h"
#import "SystemMessageViewController.h"
#import "TConversationController.h"
#import "MessageChatViewController.h"
//#import "MessageCenterHeaderCellView.h"
@interface MessageCenterViewController ()<TConversationControllerDelegagte>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)MessageCenterHeaderCellView*messageview1;
@property(nonatomic,strong)MessageCenterHeaderCellView*messageview2;
@end

@implementation  MessageCenterViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarTitle:kST(@"messageCenter")];
    [self addView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      __weak __typeof(self) weakSelf = self;
    [kUserCenterService ucenter_getnoticesindex:@{} withBlock:^(id data, int status, NSString *msg) {
//        weakSelf.messageview1.valueStr=[data ojsk:@"ordernum"];
        weakSelf.messageview2.valueStr=[data ojsk:@"systemnum"];
//        weakSelf.messageview1.valueStr=@"122";
//        weakSelf.messageview2.valueStr=@"133";
    }];
}
#pragma mark -   write UI
-(void)addView{
    UIView*viewContentHeader=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 10) backgroundcolor:nil superView:self.view];
    {
        
        NSArray*arrayArray=@[
//        @{
//                                 @"classStr":@"MessageCenterHeaderCellView",
//                                 @"image":@"noticei0",
////                                 @"title":kST(@"orderMessage"),
//                                 @"title":kS(@"messageCenter", @"orderMessage"),
//                                 @"messageType":@"order",
//                                 @"frameY":@"10",
//                                 },
                             @{
                                 @"classStr":@"MessageCenterHeaderCellView",
                                 @"image":@"noticei2",
                                 @"messageType":@"system",
//                                 @"title":kST(@"systemMessage"),
                                 @"title":kS(@"messageCenter", @"systemMessage"),
                                 },
                             @{
                                 @"classStr":@"UIView",
                                 @"frameHeight":@"10",
                                 }];
        for (int i=0; i<arrayArray.count; i++) {
            UIView*cellView=[UIView getViewWithConfigData:arrayArray[i]];
            if ([[arrayArray[i] ojsk:@"messageType"] isEqualToString:@"order"]) {
                self.messageview1=(id)cellView;
            }
            if ([[arrayArray[i] ojsk:@"messageType"] isEqualToString:@"system"]) {
                self.messageview2=(id)cellView;
            }
            cellView.frameY=viewContentHeader.frameHeight;
            viewContentHeader.frameHeight=cellView.frameYH;
            [viewContentHeader addSubview:cellView];
            [cellView addViewTarget:self select:@selector(messageTypeClick:)];
        }
        
    }
    
    
    TConversationController *conv = [[TConversationController alloc] init];
    conv.delegate = self;
    conv.view.frameWidth=kScreenWidth;
    conv.view.frameY=viewContentHeader.frameYH;
    conv.view.frameHeight=kScreenHeight-viewContentHeader.frameYH;
    [self addChildViewController:conv];
    [self.view addSubview:conv.view];
//    conv.view.backgroundColor=rgb(0, 0, 0);
//    conv.tableView.frameWidth=conv.view.frameWidth-20;
//    conv.tableView.frameHeight=kScreenHeight-kTopHeight-20-50-20-40;
    
    
    
//
//
//    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
//    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_mtableView];
//    {
//        SectionObj*sobj=[SectionObj new];
//        [_mtableView.sectionArray addObject:sobj];
//
//
//        NSArray*arrayArray=@[@{
//                                 @"classStr":@"MessageCenterHeaderCellView",
//                                 @"image":@"noticei0",
//                                 @"title":kST(@"orderMessage"),
//                                 @"messageType":@"order",
//                                 @"frameY":@"10",
//                                 },
//                             @{
//                                 @"classStr":@"MessageCenterHeaderCellView",
//                                 @"image":@"noticei2",
//                                 @"messageType":@"system",
//                                 @"title":kST(@"systemMessage"),
//                                 },
//                             @{
//                                 @"classStr":@"UIView",
//                                 @"frameHeight":@"10",
//                                 }];
//        for (int i=0; i<arrayArray.count; i++) {
//            UIView*cellView=[UIView getViewWithConfigData:arrayArray[i]];
//            [sobj.noReUseViewArray addObject:cellView];
//            if ([[arrayArray[i] ojsk:@"messageType"] isEqualToString:@"order"]) {
//                self.messageview1=(id)cellView;
//            }
//            if ([[arrayArray[i] ojsk:@"messageType"] isEqualToString:@"system"]) {
//                self.messageview2=(id)cellView;
//            }
//            [cellView addViewTarget:self select:@selector(messageTypeClick:)];
//        }
//    }
//
//    {
//        SectionObj*sobj=[SectionObj new];
//        [_mtableView.sectionArray addObject:sobj];
//        sobj.dataArray=kfAry(13);
//        [sobj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
//            MessageCenterCellView*viewcell=[MessageCenterCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"MessageCenterCellView"];
//            return viewcell;
//        }];
//    }
    
    //    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
//        UIView*viewcell=[UIView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
//        return viewcell;
//    }];
    
}
-(void)messageTypeClick:(UIButton*)btn{
    
    NSString*messageType=[btn.data ojsk:@"messageType"];
//    if ([messageType isEqualToString:@"order"]) {
//        [self pushController:[OrderMessageViewController class] withInfo:nil withTitle:kST(@"orderMessage")];
//    }else
        if([messageType isEqualToString:@"system"]){
        
        [self pushController:[SystemMessageViewController class] withInfo:nil withTitle:kST(@"systemMessage")];
    }
    
    
}

- (void)conversationController:(TConversationController *)conversationController didSelectConversation:(TConversationCellData *)conversation{
    
    [self pushController:[MessageChatViewController class] withInfo:conversation withTitle:conversation.title];
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
