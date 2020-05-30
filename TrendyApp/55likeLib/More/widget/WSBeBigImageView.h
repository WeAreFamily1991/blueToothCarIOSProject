//
//  zbigimage.h
//  GangFuBao
//
//  Created by 55like on 15/11/26.
//  Copyright © 2015年 55like. All rights reserved.
//

#import <UIKit/UIKit.h>




/**
 点击后会自动放大 属性可以不赋值 不赋值的情况下显示 自身图片
 */
@interface WSBeBigImageView : UIImageView

/**
 大图路径
 */
@property(nonatomic,copy)NSString*url;
/**
 缓存图片路径（小图路径）
 */
@property(nonatomic,copy)NSString*cacheUrl;
@end
