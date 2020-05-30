//
//  FormCellService.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/27.
//  Copyright © 2018 55like. All rights reserved.
//
#import "BaseFormCellView.h"
#import "FormCellService.h"
//#import "XAFileUpLoadService.h"

@implementation FormCellService
-(void)upLoadDataWithDataBindeViewArray:(NSMutableArray*)bindeViewArray withBlock:(AllcallBlock)block{
    
    if (bindeViewArray==nil||bindeViewArray.count==0) {
        block(nil,200,nil);
        return;
    }
    
    NSMutableArray *arrayImages=[NSMutableArray new];
    for (int i=0; i<bindeViewArray.count; i++) {
        UIImageView*imageView=bindeViewArray[i];
        if ([imageView getAddValueForKey:@"uplaodDataDic"]) {
               [arrayImages addObject:[imageView getAddValueForKey:@"uplaodDataDic"]];
        }else{
            //图片的情况
            NSMutableDictionary*dic=[NSMutableDictionary dictionary];
            [dic setValue:[NSString stringWithFormat:@"name%d.jpeg",i] forKey:@"fileName"];
            [dic setValue:@"path[]" forKey:@"fileKey"];
            NSData *imgData=UIImageJPEGRepresentation(imageView.image, 1.0);
            [dic setObject:imgData forKey:@"fileData"];
            [dic setValue:@"image" forKey:@"fileType"];
            [arrayImages addObject:dic];
        }
    }
    krequestParam
    
    
//    [[XAFileUpLoadService shareInstence] uplaodBatchImageWithfileArray:arrayImages onCompletion:^(id resData, BOOL isCache) {
//        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
//            NSMutableArray*imageUrlArray=[resData ojk:@"data"];
//            for (int i=0; i<imageUrlArray.count; i++) {
//                if (i<bindeViewArray.count) {
//                    UIImageView*imageView=bindeViewArray[i];
//                    [imageView setAddValue:imageUrlArray[i] forKey:@"dataurl"];
//                }
//            }
//            block(nil,200,nil);
//        }else{
//            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
//        }
//    }];
    
    
    
    [NetEngine uploadAllFileAction:@"common/fileUpload" withParams:dictparam fileArray:arrayImages progress:^(NSProgress *uploadProgress) {
    } onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSMutableArray*imageUrlArray=[[resData ojk:@"data"] ojk:@"list"];
            for (int i=0; i<imageUrlArray.count; i++) {
                if (i<bindeViewArray.count) {
                    UIImageView*imageView=bindeViewArray[i];
                    [imageView setAddValue:imageUrlArray[i] forKey:@"dataurl"];
                }
            }
            block(nil,200,nil);
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:alertErrorTxt];
        
//        block(nil,999,nil);
    } withMask:SVProgressHUDMaskTypeBlack];
}
-(void)getRequestDictionaryWithformCellViewArray:(NSMutableArray*)formCellViewArray withBlock:(AllcallBlock)block{
    
    NSMutableArray*bindeViewArray=[NSMutableArray new];
    for (int i=0; i<formCellViewArray.count; i++) {
        BaseFormCellView*viewCell=formCellViewArray[i];
        if (![viewCell isKindOfClass:[BaseFormCellView class]]) {
            continue;
        }
        NSArray*array=[viewCell getNoUploadImageViewArray];
        if (array.count) {
            [bindeViewArray addObjectsFromArray:array];
        }
    }
    [self upLoadDataWithDataBindeViewArray:bindeViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            NSMutableDictionary*dictparam=[NSMutableDictionary new];
            for (int i=0; i<formCellViewArray.count; i++) {
                BaseFormCellView*viewCell=formCellViewArray[i];
                if (![viewCell isKindOfClass:[BaseFormCellView class]]) {
                    continue;
                }
                NSMutableDictionary*dataDic=[viewCell getDataAndValueStrDic];
                if ([[dataDic ojsk:@"isSimplicity"] isEqualToString:@"1"]||![[dataDic ojsk:@"requestkey"] notEmptyOrNull]) {
                    continue;
                }
//                chenyong
                if (([[dataDic ojsk:@"valueStr"] isKindOfClass:[NSString class]]&&[[dataDic ojsk:@"valueStr"] notEmptyOrNull])||(![[dataDic ojsk:@"valueStr"] isKindOfClass:[NSString class]]&&[dataDic ojsk:@"valueStr"]!=nil )) {
                    [dictparam setObject:[dataDic ojsk:@"valueStr"] forKey:[dataDic ojsk:@"requestkey"]];
                }else{
                    if ([[dataDic ojsk:@"isMust"] isEqualToString:@"1"]) {
                        [SVProgressHUD showImage:nil status:[dataDic ojsk:@"placeholder"]];
                        return;
                    }else{
                         [dictparam setObject:@"" forKey:[dataDic ojsk:@"requestkey"]];
                    }
                }
            }
            block(dictparam,200,nil);
        }
    }];
    
}

-(void)getNoMustRequestDictionaryWithformCellViewArray:(NSMutableArray*)formCellViewArray withBlock:(AllcallBlock)block{
    
    NSMutableArray*bindeViewArray=[NSMutableArray new];
    for (int i=0; i<formCellViewArray.count; i++) {
        BaseFormCellView*viewCell=formCellViewArray[i];
        if (![viewCell isKindOfClass:[BaseFormCellView class]]) {
            continue;
        }
        NSArray*array=[viewCell getNoUploadImageViewArray];
        if (array.count) {
            [bindeViewArray addObjectsFromArray:array];
        }
    }
    [self upLoadDataWithDataBindeViewArray:bindeViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            NSMutableDictionary*dictparam=[NSMutableDictionary new];
            for (int i=0; i<formCellViewArray.count; i++) {
                BaseFormCellView*viewCell=formCellViewArray[i];
                if (![viewCell isKindOfClass:[BaseFormCellView class]]) {
                    continue;
                }
                NSMutableDictionary*dataDic=[viewCell getDataAndValueStrDic];
                if ([[dataDic ojsk:@"valueStr"] notEmptyOrNull]) {
                    [dictparam setObject:[dataDic ojsk:@"valueStr"] forKey:[dataDic ojsk:@"requestkey"]];
                }else{
                    //                    if ([[dataDic ojsk:@"isMust"] isEqualToString:@"1"]) {
                    //                        [SVProgressHUD showImage:nil status:[dataDic ojsk:@"placeholder"]];
                    //                        return;
                    //                    }else{
                    [dictparam setObject:@"" forKey:[dataDic ojsk:@"requestkey"]];
                    //                    }
                }
            }
            block(dictparam,200,nil);
        }
    }];
    
}
-(void)bendCellDataWithCellViewArray:(NSMutableArray*)formCellViewArray withDataDic:(NSMutableDictionary*)dataDic{
    for (int i=0; i<formCellViewArray.count; i++) {
        BaseFormCellView*viewCell=formCellViewArray[i];
        if (![viewCell isKindOfClass:[BaseFormCellView class]]) {
            continue;
        }
        [viewCell setValueStr:[dataDic ojsk:[viewCell.data ojsk:@"requestkey"]]];
    }
}

-(void)getCofigDicWithDicCode:(NSString*)dicCode withBlock:(AllcallBlock)block{
    if([dicCode isEqualToString:@"gender"]){
        NSMutableDictionary *dic=[NSMutableDictionary new];
        NSMutableArray*baseDictItemList=[NSMutableArray new];
        NSArray*arraytitle=@[kS(@"personalInfo", @"gender_male"),kS(@"personalInfo", @"gender_female"),];
        for (int i=0; i<arraytitle.count; i++) {
            NSMutableDictionary*mdicdd=[NSMutableDictionary new];
            [baseDictItemList addObject:mdicdd];
           [ mdicdd setObject:arraytitle[i] forKey:@"itemName"];
        }
        [dic setObject:baseDictItemList forKey:@"baseDictItemList"];
        block(dic,200,nil);
        
    }else   if([dicCode isEqualToString:@"forumviewType"]){
        krequestParam
        [NetEngine createPostAction:@"posts/queryPostsType" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
            if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                NSMutableDictionary *dic=[resData getSafeObjWithkey:@"data"];
                for (NSMutableDictionary*mdic in [dic ojk:@"records"]) {
                    [mdic setObject:[mdic ojsk:@"name"] forKey:@"itemName"];
                }
                [dic setObject:[dic ojk:@"records"] forKey:@"baseDictItemList"];
                [dic removeObjectForKey:@"records"];
                block(dic,200,nil);
            }else{
                //                [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
                
            }
        }];
    }else{
        krequestParam
        [dictparam setObject:dicCode forKey:@"dictCode"];
        [NetEngine createPostAction:@"purchaseSupplyInfo/getDictDto" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
            if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                block(dic,200,nil);
            }else{
            }
        }];
    }
    
 
}
@end
