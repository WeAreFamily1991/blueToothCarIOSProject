//
//  WsUseweekObj.h
//  jinYingWu
//
//  Created by 55like on 2017/11/30.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYRHTableView.h"

/**
 只是用来存储 变量
 */
@interface WsUseweekObj : NSObject
/**
 当前控件所在的SectionObj
 */
@property(nonatomic,weak)SectionObj*sectionObj;
/**
 当前控件所在的SectionObj 的地址 多少行 index row
 */
@property(nonatomic,assign)int sectionrow;

/**
 当前控件所在的indexPath；
 */
@property(nonatomic,assign)NSIndexPath * indexPath;
@end
