//
//  CantGoBackViewController.h
//  Zhongdu
//
//  Created by 55like on 2018/4/3.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "BaseViewController.h"

/**
 不能返回的控制器
 */
@interface CantGoBackViewController : BaseViewController

/**
 判断不能返回的条件

 @return 判断结果
 */
-(BOOL)cantGoBack;
@end
