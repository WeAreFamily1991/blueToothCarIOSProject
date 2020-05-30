//
//  OrderService.m
//  HanBaApp
//
//  Created by 55like on 2018/1/11.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "MYBaseService.h"

/**
 服务事件对象用来存储监听者的对象与方法与block
 */
@interface ServiceEventObjct : NSObject
/**
 监听的对象用来清理内存，如果为空的话就不再调用方法 或者block
 */
@property(nonatomic,weak)id listenerObj;

@property(nonatomic,copy)NSString*reUseID ;

/**
 回调事件
 */
@property(nonatomic,copy)MYBaseServicecallBlock eventBlock;


/**
 回掉方法
 */
@property(nonatomic,assign)SEL eventSelector;

/**
 监听事件的类型 @[@"支付成功",@"拍照成功",@"提交订单成功"];
 */
@property(nonatomic,strong)NSArray*actionTypeArray;


@end


@implementation ServiceEventObjct
@end


@interface MYBaseService()
{
    
    //网络请求 只读模式
    MYBaseService *(^ _apiUrl)(NSString* apiUrl);
    MYBaseService *(^ _paraDic)(NSMutableDictionary* paraDic);
    MYBaseService *(^ _allBlock)(AllcallBlock allBlock);
    MYBaseService *(^ _success)(void (^successBlock)(id data,NSString*msg));
    MYBaseService *(^ _erro)(AllcallBlock erroBlock);
    MYBaseService *(^ _masktyp)(SVProgressHUDMaskType masktyp);
    MYBaseService *(^ _hiddenErrMSG)();
    void (^ _startload)();
    
}
@property(nonatomic,strong)NSMutableArray*eventArray;


//网络请求相关
@property(nonatomic,copy)NSString*mnet_apiUrl;
@property(nonatomic,copy)AllcallBlock mnet_allBlock;
@property(nonatomic,strong)NSMutableDictionary*mnet_paraDic;
@property(nonatomic,copy)void (^ mnet_successBlock)(id data,NSString*msg);
@property(nonatomic,copy)AllcallBlock mnet_erroBlock;
@property(nonatomic,assign)SVProgressHUDMaskType mnet_masktyp;
@property(nonatomic,assign)BOOL mnet_hiddenErrMSG;
@end
@implementation MYBaseService
//
//static OrderService *_utilityinstance=nil;
//static dispatch_once_t utility;
/**
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventArray = [NSMutableArray new];
        self.currentEventStatus = 200;
    }
    return self;
}

+(instancetype)shareInstence{
    id xxObj=[UTILITY getAddValueForKey:NSStringFromClass([self class])];
    //    id xxObj=[UTILITY getAddValueForKey:@"xxObj"];
    if (xxObj==nil) {
        xxObj=[[self alloc] init];
//        [xxObj setEventArray:[NSMutableArray new]];
//        [xxObj setCurrentEventStatus:200];
        [UTILITY setAddValue:xxObj forKey:NSStringFromClass([self class])];
        
        //        [UTILITY setAddValue:xxObj forKey:@"xxObj"];
    }
    return xxObj;
}
-(void)addEventWithObj:(id)obj actionTypeArray:(NSArray *)actionTypeArray reUseID:(NSString *)reUseID WithBlcok:(MYBaseServicecallBlock)evenBlock{
    [self addEventWithObj:obj  actionTypeArray:actionTypeArray reUseID:reUseID WitheventSelector:nil WithBlcok:evenBlock];
}
-(void)addEventWithObj:(id)obj actionTypeArray:(NSArray *)actionTypeArray reUseID:(NSString *)reUseID WitheventSelector:(SEL)eventSelector{
    
    [self addEventWithObj:obj actionTypeArray:actionTypeArray reUseID:reUseID WitheventSelector:eventSelector WithBlcok:nil];
}

-(void)addEventWithObj:(id)obj actionTypeArray:(NSArray *)actionTypeArray reUseID:(NSString *)reUseID WitheventSelector:(SEL)eventSelector WithBlcok:(MYBaseServicecallBlock)evenBlock{
    
    ServiceEventObjct*eventObj=nil;
    for (NSInteger i=self.eventArray.count-1; i>=0; i--) {
        ServiceEventObjct*eventObjxx=self.eventArray[i];
        if (eventObjxx.listenerObj==nil) {
            [self.eventArray removeObject:eventObjxx];
        }else{
            if (eventObjxx.listenerObj==obj&&[eventObjxx.reUseID isEqualToString:reUseID]) {
                eventObj=eventObjxx;
            }
        }
    }
    if (eventObj==nil) {
        eventObj=[ServiceEventObjct new];
        [self.eventArray addObject:eventObj];
        eventObj.listenerObj=obj;
        eventObj.reUseID=reUseID;
    }
    
    eventObj.actionTypeArray=actionTypeArray;
    
    if (evenBlock) {
        eventObj.eventBlock = evenBlock;
    }
    if (eventSelector) {
        eventObj.eventSelector=eventSelector;
    }
}


-(void)dispatchEventWithActionType:(NSString*)evnetType actionData:(id)actionData{
    self.currentEvnetType=evnetType;
    self.currentEventData=actionData;
    for (NSInteger i=self.eventArray.count-1; i>=0; i--){
        ServiceEventObjct*eventObj=self.eventArray[i];
        if (eventObj.listenerObj==nil) {
            [self.eventArray removeObject:eventObj];
        }else{
            if (eventObj.actionTypeArray==nil) {
                eventObj.eventBlock?eventObj.eventBlock(self):nil;
                eventObj.eventSelector?[eventObj.listenerObj performSelector:eventObj.eventSelector withObject:self]:nil;
            }else{
                for (NSString*actiontypeStr in eventObj.actionTypeArray) {
                    if ([actiontypeStr isEqualToString:evnetType]) {
                        eventObj.eventBlock?eventObj.eventBlock(self):nil;
                        eventObj.eventSelector?[eventObj.listenerObj performSelector:eventObj.eventSelector withObject:self]:nil;
                    }
                }
            }
        }
    }
    self.currentEvnetType=nil;
    self.currentEventStatus=200;
    self.currentEventMsg=nil;
    self.currentEventData=nil;
    
}


-(void)releaseEvnetObj{
    for (NSInteger i=self.eventArray.count-1; i>=0; i--) {
        ServiceEventObjct*eventObj=self.eventArray[i];
        if (eventObj.listenerObj==nil) {
            [self.eventArray removeObject:eventObj];
        }
    }
}
#pragma mark  网络请求相关

-(void)loadDataWithApi:(NSString*)apiStr withParam:(NSMutableDictionary*)param withBlock:(AllcallBlock)block{
    krequestParam
    if (param) {
        [dictparam addEntriesFromDictionary:param];
    }
    SVProgressHUDMaskType mstktype =self.mnet_masktyp;
    self.mnet_masktyp=SVProgressHUDMaskTypeClear;
    BOOL hiddenErrMSG=self.mnet_hiddenErrMSG;
    self.mnet_hiddenErrMSG=NO;
    
    [NetEngine createHttpAction:apiStr withCache:NO withParams:dictparam withMask:mstktype onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            block(dic,200,[resData valueForJSONKey:@"info"]);
        }else{
            block(nil,[resData ojsk:@"status"].intValue,[resData valueForJSONKey:@"info"]);
            hiddenErrMSG?nil:[SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
        }
    } onError:^(NSError *error) {
        block(nil,1001,@"网络错误");
        hiddenErrMSG?nil:[SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}
- (MYBaseService *(^)(NSString *))apiUrl{
    if (_apiUrl==nil) {
        __weak __typeof(self) weakSelf = self;
        _apiUrl = ^MYBaseService *(NSString *apiUrl) {
            weakSelf.mnet_apiUrl=apiUrl;
            weakSelf.mnet_paraDic=nil;
            weakSelf.mnet_allBlock=nil;
            weakSelf.mnet_successBlock=nil;
            weakSelf.mnet_erroBlock=nil;
            weakSelf.mnet_masktyp=SVProgressHUDMaskTypeClear;
            weakSelf.mnet_hiddenErrMSG=NO;
            return weakSelf;
        };
    }
    return _apiUrl;
}
-(MYBaseService *(^)(NSMutableDictionary *))paraDic{
    if (_paraDic==nil) {
        __weak __typeof(self) weakSelf = self;
        _paraDic = ^MYBaseService *(NSMutableDictionary *paraDic) {
            weakSelf.mnet_paraDic=paraDic;
            return weakSelf;
        };
    }
    return _paraDic;
}
-(MYBaseService *(^)(AllcallBlock))allBlock{
    if (_allBlock==nil) {
        __weak __typeof(self) weakSelf = self;
        _allBlock = ^MYBaseService *(AllcallBlock allBlock) {
            weakSelf.mnet_allBlock=allBlock;
            return weakSelf;
        };
    }
    return _allBlock;
}
-(MYBaseService *(^)(void (^)(id data,NSString*msg)))success{
    if (_success==nil) {
        __weak __typeof(self) weakSelf = self;
        _success = ^MYBaseService *(void (^successBlock)(id data,NSString*msg)) {
            weakSelf.mnet_successBlock = successBlock;
            return weakSelf;
        };
    }
    return _success;
}
-(MYBaseService *(^)(AllcallBlock))erro{
    if (_erro==nil) {
        __weak __typeof(self) weakSelf = self;
        _erro = ^MYBaseService *(AllcallBlock erroBlock) {
            weakSelf.mnet_erroBlock = erroBlock;
            return weakSelf;
        };
    }
    return _erro;
}
-(MYBaseService *(^)(SVProgressHUDMaskType))masktyp{
    if (_masktyp==nil) {
        __weak __typeof(self) weakSelf = self;
        _masktyp = ^MYBaseService *(SVProgressHUDMaskType masktyp) {
            weakSelf.mnet_masktyp = masktyp;
            return weakSelf;
        };
    }
    return _masktyp;
}
-(MYBaseService *(^)())hiddenErrMSG{
    if (_hiddenErrMSG==nil) {
        __weak __typeof(self) weakSelf = self;
        _hiddenErrMSG = ^MYBaseService *() {
            weakSelf.mnet_hiddenErrMSG = YES;
            return weakSelf;
        };
    }
    return _hiddenErrMSG;
    
}
-(void (^)())startload{
    if (_startload==nil) {
        
        __weak __typeof(self) weakSelf = self;
        _startload = ^void() {
            NSString*mnet_apiUrl=weakSelf.mnet_apiUrl;
            NSMutableDictionary*mnet_paraDic=weakSelf.mnet_paraDic;
            AllcallBlock mnet_allBlock=weakSelf.mnet_allBlock;
            void (^ mnet_successBlock)(id data,NSString*msg)=weakSelf.mnet_successBlock;
            AllcallBlock mnet_erroBlock=weakSelf.mnet_erroBlock;
            weakSelf.mnet_apiUrl=nil;
            weakSelf.mnet_paraDic=nil;
            weakSelf.mnet_allBlock=nil;
            weakSelf.mnet_successBlock=nil;
            weakSelf.mnet_erroBlock=nil;
            //    return;
            [weakSelf loadDataWithApi:mnet_apiUrl withParam:mnet_paraDic withBlock:^(id data, int status, NSString *msg) {
                mnet_allBlock?mnet_allBlock(data,status,msg):nil;
                if (status==200) {
                    mnet_successBlock?mnet_successBlock(data,msg):nil;
                }else{
                    mnet_erroBlock?mnet_erroBlock(data,status,msg):nil;
                }
            }];
        };
    }
    return _startload;
}
@end
