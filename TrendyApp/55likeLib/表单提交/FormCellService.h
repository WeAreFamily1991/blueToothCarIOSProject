//
//  FormCellService.h
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/27.
//  Copyright © 2018 55like. All rights reserved.
//

#import "MYBaseService.h"
#define kFormCellService [FormCellService shareInstence]
NS_ASSUME_NONNULL_BEGIN

@interface FormCellService : MYBaseService

/**
 获取请求参数
 @param formCellViewArray FormCellView view 的数组
 @param block 回调请求参数在date中 200的时候是成功
 */
-(void)getRequestDictionaryWithformCellViewArray:(NSMutableArray*)formCellViewArray withBlock:(AllcallBlock)block;

-(void)getNoMustRequestDictionaryWithformCellViewArray:(NSMutableArray*)formCellViewArray withBlock:(AllcallBlock)block;


/**
 绑定数据

 @param formCellViewArray FormCellView view 的数组
 @param dataDic 要绑定的数据
 */
-(void)bendCellDataWithCellViewArray:(NSMutableArray*)formCellViewArray withDataDic:(NSMutableDictionary*)dataDic;
-(void)getCofigDicWithDicCode:(NSString*)dicCode withBlock:(AllcallBlock)block;
@end

NS_ASSUME_NONNULL_END
