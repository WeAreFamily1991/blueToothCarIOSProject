//
//  WSNetTool.m
//  EastCollection
//
//  Created by 55like on 17/02/2017.
//  Copyright © 2017 55like. All rights reserved.
//

#import "WSNetTools.h"

#import "SDDataCache.h"
#import "NSObject+JSONCategories.h"
#import "NSObject+WDKeyValue.h"
//#import "NSString+JSONSTR.h"

@implementation WSNetTools



+(void)fileWithAPIUrl:(NSString*)apiurl Json:(NSDictionary*)json{
    [self fileJson:json modelname:[apiurl stringByReplacingOccurrencesOfString:@"/" withString:@""] HeadrPrefix:@"XA" folderName:nil];
}

+(void)fileJson:(NSDictionary*)dic modelname:(NSString*)modelname HeadrPrefix:(NSString*)hpx folderName:(NSString*)folderName{
//    name=@"model";
    
    if (folderName==nil) {
        modelname=[modelname capitalizedString];
        folderName= [NSString stringWithFormat:@"%@%@Model",hpx,modelname];
    }
    
    /*******************************用于存储m文件代码***********************/
    NSMutableString*mfilemstr=[NSMutableString new];
    /*******************************用于存储h文件代码***********************/
    NSMutableString*hfilemstr=[NSMutableString new];
    //    [hfilemstr appendString:[NSString stringWithFormat:@"#import <Foundation/Foundation.h>\n\n"]];
    [hfilemstr appendString:[NSString stringWithFormat:@"@interface %@%@Model : WSModelObject\n",hpx,modelname]];
    
    
    /*******************************用于存储替代属性名函数***********************/
    NSMutableString*replacepropertstr=[NSMutableString new];
    [replacepropertstr appendString:@"\n- (NSDictionary *)wreplacedKeyFromPropertyName//\n{\n    return @{"];
    /*******************************用于存储数组替换函数***********************/
    NSMutableString*replaceArraystr=[NSMutableString new];
    [replaceArraystr appendString:@"\n- (NSDictionary *)wobjectClassInArray//\n{\n    return @{"];
    BOOL ishavenameReplace=NO;
    
    BOOL ishavedicArray=NO;
    /*******************************解析的字典***********************/
    NSDictionary*dictionary=dic;
    
    
    NSArray*keyArry=[dictionary allKeys];
    for (NSString *keyname in keyArry) {
        //        NSLog(@"%dkey: %@",i, s);
        
        NSString*realKeyName=keyname;
        if ([realKeyName isEqualToString:@"id"]) {
            ishavenameReplace=YES;
            
            
            realKeyName=@"ZJid";
            [replacepropertstr appendString:[NSString stringWithFormat:@"@\"%@\" : @\"%@\",",realKeyName,keyname]];
            
        }
        if ([realKeyName isEqualToString:@"class"]) {
            ishavenameReplace=YES;
            
            
            realKeyName=@"ZJclass";
            [replacepropertstr appendString:[NSString stringWithFormat:@"@\"%@\" : @\"%@\",",realKeyName,keyname]];
            
        }
        id value=[dictionary getSafeObjWithkey:keyname];
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            /*******************************对字典的处理**********************/
            //            [self fileJson:value index:i+1 name:@""];
            NSString *className=[NSString stringWithFormat:@"%@%@",modelname,[realKeyName capitalizedString]];
            
            [ hfilemstr insertString:[NSString stringWithFormat:@"#import \"%@%@Model.h\"\n",hpx,className] atIndex:0];
            
            //               NSString*prefixi=[NSString stringWithFormat:@"%@I",prefix];
//            [self fileJson:value name:className Prefix:modelname HeadrPrefix:hpx];
            [self fileJson:value modelname:className HeadrPrefix:hpx folderName:folderName];
            
            [hfilemstr appendString:[NSString stringWithFormat:@"@property(nonatomic,strong)%@%@Model*%@;\n",hpx,className,realKeyName]];
            
            
            
        }else if ([value isKindOfClass:[NSArray class]]) {
            /*******************************对数组的处理**********************/
            NSArray *array=value;
            id sbvalue=[array firstObject];
            if ([sbvalue isKindOfClass:[NSDictionary class]]) {
                ishavedicArray=YES;
                
//                NSString *className=[NSString stringWithFormat:@"sub%@",realKeyName];
                
                NSString *className=[NSString stringWithFormat:@"%@%@",modelname,[realKeyName capitalizedString]];
//                [ hfilemstr insertString:[NSString stringWithFormat:@"#import \"%@%@.h\"\n",modelname,className] atIndex:0];
                
                [ hfilemstr insertString:[NSString stringWithFormat:@"#import \"%@%@Model.h\"\n",hpx,className] atIndex:0];
                
                //                realKeyName=@"ZJid";
                [replaceArraystr appendString:[NSString stringWithFormat:@"@\"%@\" : [%@%@Model  class],",realKeyName,hpx,className]];
                //                NSString*prefixi=[NSString stringWithFormat:@"%@I",prefix];
                
                
//                [self fileJson:sbvalue name:className Prefix:modelname HeadrPrefix:hpx];
                
                [self fileJson:sbvalue modelname:className HeadrPrefix:hpx folderName:folderName];
                
                 [hfilemstr appendString:[NSString stringWithFormat:@"@property(nonatomic,strong)NSArray<%@%@Model*>*%@;\n",hpx,className,realKeyName]];
            }else{
                 [hfilemstr appendString:[NSString stringWithFormat:@"@property(nonatomic,strong)NSArray*%@;\n",realKeyName]];
            }
            
        }else{
            
            [hfilemstr appendString:[NSString stringWithFormat:@"@property(nonatomic,copy)NSString*%@;//%@\n",realKeyName,value]];
            
        }
        
        if ([keyname isEqual:[keyArry lastObject]]) {
            [hfilemstr appendString:[NSString stringWithFormat:@"@end"]];
            [hfilemstr insertString:@"\n" atIndex:0];
            
            [mfilemstr appendString:[NSString stringWithFormat:@"\n#import \"%@%@Model.h\"\n",hpx,modelname]];
            [mfilemstr appendString:[NSString stringWithFormat:@"@implementation %@%@Model\n",hpx,modelname]];
            
            //            replacepropertstr
            //            replacepropertstr del
            
            //            [replacepropertstr substringToIndex:replacepropertstr.length-1];
            
            NSRange range1={replacepropertstr.length-1,1};
            [replacepropertstr deleteCharactersInRange:range1];
            [replacepropertstr appendString:@"};\n}\n"];
            if (ishavenameReplace) {
                [mfilemstr appendString:replacepropertstr];
            }
            
            //            [replaceArraystr substringToIndex:replaceArraystr.length-1];
            NSRange range = {replaceArraystr.length-1,1};
            [ replaceArraystr deleteCharactersInRange:range];
            [replaceArraystr appendString:@"};\n}\n"];
            if (ishavedicArray) {
                [mfilemstr appendString:replaceArraystr];
            }
            
            
            
            
            
            [mfilemstr appendString:[NSString stringWithFormat:@"@end"]];
            
            
            
        }
        
        
        //#import "hqspztParam.h"
        //
        //        @implementation hqspztParam
        //
        //        @end
        //        NSArray*arry=[NSArray new];
        //
        //        if ([s isEqual:[arry firstObject]]) {
        //
        //        }
        //
        //        if ([s isEqual:[arry lastObject]]) {
        //
        //        }
    }
    //    [hfilemstr insertString:@"#import \"WDExtension.h\"" atIndex:0];
    
    [hfilemstr insertString:@"#import \"WSModelObject.h\"" atIndex:0];
    [hfilemstr insertString:@"\n" atIndex:0];
    [mfilemstr insertString:@"\n" atIndex:0];
    [hfilemstr appendFormat:@"\n/*%@*/",dic.jsonStrSYS];
//    [hfilemstr appendFormat:@"/*%@*/",dic.jsonStrSYS];
    
    //    NSLog(@"%@",hfilemstr);
    //    NSLog(@"%@",mfilemstr);
    [self writeFile:[NSString stringWithFormat:@"%@%@Model.h",hpx,modelname] data:hfilemstr folderName:folderName];
    [self writeFile:[NSString stringWithFormat:@"%@%@Model.m",hpx,modelname] data:mfilemstr folderName:folderName];
    
    
}


+(void)writeFile:(NSString*)fileName data:(NSString*)data folderName:(NSString*)prefix

{
    //获得应用程序沙盒的Documents目录，官方推荐数据文件保存在此
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString* doc_path = [path objectAtIndex:0];
    //    doc_path=@"/Users/home/Desktop/mobile/";
    doc_path=[NSString stringWithFormat:@"/Users/55like/Desktop/mobile/%@/",prefix];
    
    //NSLog(@"Documents Directory:%@",doc_path);
    
    //创建文件管理器对象
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString* realFileName = [doc_path stringByAppendingPathComponent:fileName];
    //NSString* new_folder = [doc_path stringByAppendingPathComponent:@"test"];
    //创建目录
    //[fm createDirectoryAtPath:new_folder withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:doc_path withIntermediateDirectories:YES attributes:nil error:nil];
    //    if (![fm fileExistsAtPath:realFileName]){
    if ([fm createFileAtPath:realFileName contents:[data dataUsingEncoding:NSUTF8StringEncoding] attributes:nil]) {
        //        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@写入成功",fileName]];
        
    }else{
        
        //        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@写入失败",fileName]];
        
    }
    
    //    }
}





@end
