//
//  ConversationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/4/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ConversationViewController.h"
#import "TConversationController.h"
@interface ConversationViewController ()<TConversationControllerDelegagte>

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化 TUIKit 的会话列表UI类
    TConversationController *conv = [[TConversationController alloc] init];
    conv.delegate = self;
    conv.view.frameWidth=kScreenWidth-30;
    conv.view.frameY=kTopHeight;
    conv.view.frameHeight=kScreenHeight-kTopHeight-20-50;
    [self addChildViewController:conv];
    [self.view addSubview:conv.view];
    conv.view.backgroundColor=rgb(0, 0, 0);
    conv.tableView.frameWidth=conv.view.frameWidth-20;
    conv.tableView.frameHeight=kScreenHeight-kTopHeight-20-50-20-40;
     [self navbarTitle:@"ddd"];
    // Do any additional setup after loading the view.
}
#pragma mark TConversationControllerDelegagte

- (void)conversationController:(TConversationController *)conversationController didSelectConversation:(TConversationCellData *)conversation{
    
}
- (void)conversationController:(TConversationController *)conversationController DidClickRightBarButton:(UIButton *)rightBarButton{
    
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
