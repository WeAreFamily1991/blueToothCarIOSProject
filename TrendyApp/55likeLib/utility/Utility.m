
#import "Utility.h"
#import <Reachability.h>
#import "NSObject+JSONCategories.h"
#import "NSDictionary+expanded.h"
#import "NSString+JSONCategories.h"
#import "LoginViewController.h"
//#import "DMHessian.h"
#import <arpa/inet.h>
#import "NetEngine.h"
#import "AppDelegate.h"
//#import "LoginView.h"
//#import "RegisterView.h"

#import "LoginViewController.h"
#import "CustomTabBar.h"
#import "NSObject+JSONCategories.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


//振动
#import <AudioToolbox/AudioToolbox.h>
//
///分享
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>
////支付宝
//#import <AlipaySDK/AlipaySDK.h>
//#import "Order.h"
////微信支付
//#import "WXApi.h"
////极光推送
//#import "JPUSHService.h"

//启动页
#import "StartTransitionView.h"
//相册
#import <Photos/Photos.h>
#import "DEMOHOMEViewController.h"
#import "Utility_KeyBoardTool.h"
#import "SDWebImageManager.h"
#import "SDWebImageCompat.h"


#define picMidWidth 200
#define picSmallWidth 100
@interface Utility ()<UIAlertViewDelegate>{//SRWebSocketDelegate
    
    NSString *phoneNum;
    UIAlertView *alertview;
    
    
    SystemSoundID sound;//系统声音的id 取值范围为：1000-2000
    
    StartTransitionView *startView;
    
    UIAlertView *alertTempScorket;
    
    
    NSInteger intConnectionNum;//连接socket服务器次数
    
    
    NSDictionary *dicTempDownload;
    float paramProgress_temp;
    BOOL automaticDownload;
    
    
    BOOL aboolOneLogin;
    BOOL aboolAgainLogin_message;
    
    BOOL abool_backPassword_socket;
    
    
    
}
@property (nonatomic,strong) NSURL *phoneNumberURL;
@property (nonatomic,strong) Reachability *reachability;

@end

@implementation Utility


static Utility *_utilityinstance=nil;
static dispatch_once_t utility;
-(BOOL)userAppUseSSL{
    return YES;
}
+(id)Share
{
    dispatch_once(&utility, ^ {
        _utilityinstance = [[Utility alloc] init];
        
        [Utility_KeyBoardTool shareInstence];
    });
    return _utilityinstance;
}


+(Utility*)ShareUility{
    Utility*h= [Utility Share];
    return h;
}

- (BOOL)offline
{
    return ![[NetEngine Share] isReachable];
}

#pragma mark -
#pragma mark validateEmail
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
#pragma mark validateTel
- (BOOL) validateTel: (NSString *) candidate {
    NSString *telRegex = @"^1[3-9]\\d{9}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    NSPredicate *PHSP = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    if ([telTest evaluateWithObject:candidate] == YES || [PHSP evaluateWithObject:candidate] == YES) {
        return YES;
    }else{
        return NO;
    }
    //    if (candidate.length>=5) {
    //        NSString *str = [NSString stringWithFormat:@"%.0f",candidate.doubleValue];
    //        return [str isEqualToString:candidate];
    //    }else{
    //        return NO;
    //    }
}
///验证字母
-(BOOL)validateLetter:(NSString *)str{
    NSString *regex = @"[a-zA-Z]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}
#pragma mark validateEmail
- (BOOL) validateUrl:(NSString *)candidate{
    //((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)
    ///\b(([\w-]+:\/\/?|[\w]?[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/
    NSString *urlRegex = @"";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:candidate];
}
#pragma ImagePeSize
-(CGFloat)percentage:(NSString*)per width:(NSInteger)width
{
    if (per) {
        NSArray *stringArray = [per componentsSeparatedByString:@"*"];
        
        if ([stringArray count]==2) {
            CGFloat w=[[stringArray objectAtIndex:0] floatValue];
            CGFloat h=[[stringArray objectAtIndex:1] floatValue];
            if (w>=width) {
                return h*width/w;
            }else{
                return  h;
            }
        }
    }
    return width;
}

/**
 *    保存obj的array到本地，如果已经存在会替换本地。
 *
 *    @param    obj    待保存的obj
 *    @param    key    保存的key
 */
+ (void)saveToArrayDefaults:(id)obj forKey:(NSString*)key
{
    [self saveToArrayDefaults:obj replace:obj forKey:key];
}
+ (void)saveToArrayDefaults:(id)obj replace:(id)oldobj forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:key];
    
    NSMutableArray *marray = [NSMutableArray array];
    if (!oldobj) {
        oldobj = obj;
    }
    if (array) {
        [marray addObjectsFromArray:array];
        if ([marray containsObject:oldobj]) {
            [marray replaceObjectAtIndex:[marray indexOfObject:oldobj] withObject:obj];
        }else{
            [marray addObject:obj];
        }
    }else{
        [marray addObject:obj];
    }
    [defaults setValue:marray forKey:key];
    [defaults synchronize];
}

+ (BOOL)removeForArrayObj:(id)obj forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:key];
    
    NSMutableArray *marray = [NSMutableArray array];
    if (array) {
        [marray addObjectsFromArray:array];
        if ([marray containsObject:obj]) {
            [marray removeObject:obj];
        }
    }
    if (marray.count) {
        [defaults setValue:marray forKey:key];
    }else{
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    return marray.count;
}
/**
 *    保存obj到本地
 *
 *    @param    obj    数据
 *    @param    key    键
 */
+ (void)saveToDefaults:(id)obj forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:obj forKey:key];
    [defaults synchronize];
}

+ (id)defaultsForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
+ (void)removeForKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)Utuid{
    return [[Utility Share] userId];
}
+(NSString *)Uttoken{
    return [[Utility Share] userToken];
}
+(id)uid
{
    return [[Utility Share] userId];
}
-(void)ShowMessage:(NSString *)title msg:(NSString *)msg
{
    title=title?title:@"";
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:kS(@"generalPage", @"OK") otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark makeCall
- (NSString*) cleanPhoneNumber:(NSString*)phoneNumber
{
    return [[[[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]
              stringByReplacingOccurrencesOfString:@"-" withString:@""]
             stringByReplacingOccurrencesOfString:@"(" withString:@""]
            stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    //return number1;
}

- (void) makeCall:(NSString *)phoneNumber
{
    phoneNum=[self cleanPhoneNumber:phoneNumber];
    if ([phoneNum intValue]!=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打号码?"
                                                        message:phoneNum
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"拨打",nil];
        
        [alert show];
    }else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"无效号码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil] show];
        return;
    }
}



#pragma mark TimeTravel
- (NSString*)timeToNow:(NSString*)theDate needYear:(BOOL)needYear
{
    if (!theDate || ![theDate notEmptyOrNull]) {
        return @"";
    }
    if (![self isPureFloat:theDate]) {
        return theDate;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *d=[NSDate dateWithTimeIntervalSince1970:[theDate integerValue]];
    //NSDate *d=[dateFormatter dateFromString:theDate];
    if (!d) {
        return theDate;
    }
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=(now-late)>0 ? (now-late) : 0;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString=[timeString floatValue] <=1?@"刚刚":[NSString stringWithFormat:@"%@ 分前", timeString];
        
    }else if (cha/3600>1 && cha/3600<24) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    else
    {
        if (needYear) {
            [dateFormatter setDateFormat:@"yy-MM-dd"];
        }
        else
        {
            [dateFormatter setDateFormat:@"MM-dd"];
        }
        timeString=[dateFormatter stringFromDate:d];
        // timeString = [NSString stringWithFormat:@"%.0f 天前",cha/3600/24];
    }
    
    return timeString;
}

///改变时间格式yyyy-MM-dd HH:mm
- (NSString*)time_ChangeTheFormat:(NSString*)theDate{
    DLog(@"________%@",theDate);
    if (!theDate || ![theDate notEmptyOrNull]) {
        return @"";
    }
    if (![self isPureFloat:theDate]) {
        return theDate;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    //    NSDate *d=[dateFormatter dateFromString:theDate];
    //    DLog(@"_______________%@",d);
    //    if (!d) {
    //        return @"";
    //    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *aTime = [NSDate dateWithTimeIntervalSince1970:[theDate integerValue]];
    return [dateFormatter stringFromDate:aTime];
}

-(NSInteger)ACtimeToNow:(NSString*)theDate
{
    /*
     -1过期
     */
    
    
    if (!theDate || ![theDate notEmptyOrNull]) {
        return -1;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    NSDate *d=[dateFormatter dateFromString:theDate];
    if (!d) {
        return -1;
    }
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    // NSString *timeString=@"";
    
    NSTimeInterval cha=(now-late);//>0 ? (now-late) : 0
    //    if (cha==0) {
    //        return -1;
    //    }else{
    return -cha/3600/24;
    //}
    
    
    //    if (cha/3600<1) {
    //        timeString = [NSString stringWithFormat:@"%f", cha/60];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@ 分前", timeString];
    //
    //    }else if (cha/3600>1 && cha/3600<24) {
    //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@ 小时前", timeString];
    //    }
    //    else
    //    {
    //        /* if (needYear) {
    //         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //         }
    //         else
    //         {
    //         [dateFormatter setDateFormat:@"MM-dd"];
    //         }
    //         timeString=[dateFormatter stringFromDate:d];*/
    //        timeString = [NSString stringWithFormat:@"%.0f 天前",cha/3600/24];
    //    }
    //
    //    return timeString;
}


- (NSString*)timeToNow_zk:(NSString*)theDate{
    if (!theDate || ![theDate notEmptyOrNull]) {
        return @"";
    }
    if (![self isPureFloat:theDate]) {
        return theDate;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//@"yyyy-MM-dd HH:mm:ss"
    NSDate *d=[NSDate dateWithTimeIntervalSince1970:[theDate integerValue]];//[dateFormatter dateFromString:theDate];
    if (!d) {
        return theDate;
    }
    
    NSString *timeString=@"";
    
    NSString *todayString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *dateOfCurrentString = [dateFormatter stringFromDate:d];
    NSString *dateOfYesterdayString = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]]];
    
    if ( [todayString isEqualToString:dateOfCurrentString]) {
        timeString=@"今天";
    }else if ([dateOfCurrentString isEqualToString:dateOfYesterdayString]){
        timeString=@"昨天";
    }
    else
    {
        
        [dateFormatter setDateFormat:@"MM/dd"];
        timeString=[dateFormatter stringFromDate:d];
    }
    
    return timeString;
}

//时间戳
-(NSString *)timeToTimestamp:(NSString *)timestamp{
    if (!timestamp || ![timestamp notEmptyOrNull]) {
        return @"";
    }
    if (![self isPureFloat:timestamp]) {
        return timestamp;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *aTime = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
    
    NSString *str=[dateFormatter stringFromDate:aTime];
    return str;
}

//data-固定格式时间yyyy-MM-dd
-(NSString *)timeToFormatConversion:(NSString *)aDate{
    if (!aDate || ![aDate notEmptyOrNull]) {
        return @"";
    }
    if (![self isPureFloat:aDate]) {
        return aDate;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *aTime = [NSDate dateWithTimeIntervalSince1970:[aDate integerValue]];
    
    NSString *str=[dateFormatter stringFromDate:aTime];
    return str;
}

///data-固定格式时间 录音使用
-(NSString *)timeToFormatAudio:(NSString *)aDate{
    if (!aDate || ![aDate notEmptyOrNull]) {
        return @"";
    }
    if (![self isPureFloat:aDate]) {
        return aDate;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *aTime = [NSDate dateWithTimeIntervalSince1970:[aDate integerValue]];
    
    NSString *str=[dateFormatter stringFromDate:aTime];
    return str;
}

#pragma mark login



#pragma mark 版本更新
-(NSString *)VersionSelectString{
    //CFBundleShortVersionString
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
-(NSString *)VersionSelect{
    NSString *v = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return v;
}

- (void)versionUpdate:(BOOL)abool{
    NSString *version=[self VersionSelect];
    
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"ios",@"type",nil];//[[Utility Share] userId],@"uid",[[Utility Share] userToken],@"token",
    [NetEngine createHttpAction:@"welcome/getversion" withCache:NO withParams:dic withMask:abool?SVProgressHUDMaskTypeClear:SVProgressHUDMaskTypeNil onCompletion:^(id resData, BOOL isCache) {
        DLog(@"resData Version:%@",resData);
        if ([[resData valueForJSONKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *userDict = [resData objectForJSONKey:@"data"];
            // 更新包路径
            self.APPpackPath = [userDict valueForJSONStrKey:@"url"];
            DLog(@"packPath:%@",self.APPpackPath);
            
            self.APPnewAppVersion = [userDict valueForJSONStrKey:@"number"];
            DLog(@"newVersion:%@",self.APPnewAppVersion);
            if ([self.APPnewAppVersion floatValue]>[version floatValue]) {
                // 分为强制更新与不强制更新
                NSString *force = [userDict valueForJSONStrKey:@"forces"];
                if ([force isEqualToString:@"1"]) {
                    // 强制更新、、[NSString stringWithFormat:@"发现新版本啦！ %@",_APPnewAppVersion]
                    UIAlertView *forceAlterView = [[UIAlertView alloc] initWithTitle:@"发现新版本啦！" message:[userDict valueForJSONStrKey:@"content"] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                    forceAlterView.tag=199;
                    [forceAlterView show];
                }else{
                    // 不强制更新
                    UIAlertView *notForceAlterView = [[UIAlertView alloc] initWithTitle:@"发现新版本啦！" message:[userDict valueForJSONStrKey:@"content"] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
                    notForceAlterView.tag=198;
                    [notForceAlterView show];
                }
                
            }else{
                if (abool) {
                    [SVProgressHUD showImage:nil status:@"当前是最新版本啦！"];
                }
                
            }
            
        }else{
            if (abool) {
                [SVProgressHUD showImage:nil status:[resData valueForJSONKey:@"msg"]];
            }
        }
    } onError:^(NSError *error) {
        if (abool) {
            [SVProgressHUD showImage:nil status:alertErrorTxt];
            
        }
    }];
    
    
    
}
#pragma mark UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==alertTempScorket) {
        if (buttonIndex==1) {
            intConnectionNum=0;
            //            [self WebSocketConnectServer];
        }
        
    }else if (alertView.tag == 199) {
        // 强制更新
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_APPpackPath]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
        
    }else if (alertView.tag == 198){
        // 不强制更新
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_APPpackPath]];
        }else{
            DLog(@"不更新");
        }
    }else if (alertView.tag==1010){
        aboolAgainLogin_message=NO;
    }else if ([alertView.title isEqualToString:@"拨打号码?"]) {//phoneCall AlertView
        if (buttonIndex==1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNum]]];
        }
        phoneNum=nil;
    }else if (alertView.tag==121 && buttonIndex==1){
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}



//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


#pragma mark view
//类似qq聊天窗口的抖动效果
-(void)viewAnimations:(UIView *)aV{
    CGFloat t =5.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    CGAffineTransform translateTop =CGAffineTransformTranslate(CGAffineTransformIdentity,0.0,1);
    CGAffineTransform translateBottom =CGAffineTransformTranslate(CGAffineTransformIdentity,0.0,-1);
    
    aV.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse animations:^{//UIViewAnimationOptionRepeat
        //[UIView setAnimationRepeatCount:2.0];
        aV.transform = translateRight;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.07 animations:^{
            aV.transform = translateBottom;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.07 animations:^{
                aV.transform = translateTop;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    aV.transform =CGAffineTransformIdentity;//回到没有设置transform之前的坐标
                } completion:NULL];
            }];
        }];
        //        if(finished){
        //            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        //                aV.transform =CGAffineTransformIdentity;//回到没有设置transform之前的坐标
        //            } completion:NULL];
        //        }else{
        //            aV.transform = translateTop;
        //
        //        }
    }];
}

//view 左右抖动
-(void)leftRightAnimations:(UIView *)view{
    
    CGFloat t =5.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    view.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        view.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                view.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
    
}

#pragma mark image
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
/////通过颜色来生成一个纯色图片
- (UIImage *)imageFromColor:(UIColor *)color rect:(CGSize )aSize{
    CGRect rect = CGRectMake(0, 0,aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



#pragma mark -数据格式化
//////////////数据格式化
//格式化电话号码
-(NSString *)ACFormatPhone:(NSString *)str{
    if (str.length<10) {
        return str;
    }else{
        NSString *s1=[str substringToIndex:3];
        NSString *s2=[str substringWithRange:NSMakeRange(3, 4)];
        NSString *s3=[str substringFromIndex:7];
        DLog(@"%@,%@,%@",s1,s2,s3);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@ %@",s1,s2,s3];
        return turntoCarIDString;
    }
}
///格式化手机号
-(NSString *)ACFormatMobile:(NSString *)str{
    if (str.length<10) {//含固定电话
        return str;
    }else{
        NSString *s1=[str substringToIndex:3];
        NSString *s2=[str substringWithRange:NSMakeRange(3, 4)];
        NSString *s3=[str substringFromIndex:7];
        DLog(@"%@,%@,%@",s1,s2,s3);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ **** %@",s1,s3];
        return turntoCarIDString;
    }
}
///格式化身份证号
-(NSString *)ACFormatIDC:(NSString *)str{
    if (str.length==18) {
        NSString *s1=[str substringToIndex:3];
        NSString *s2=[str substringWithRange:NSMakeRange(3, 3)];
        NSString *s3=[str substringWithRange:NSMakeRange(6, 4)];
        NSString *s4=[str substringWithRange:NSMakeRange(10, 4)];
        NSString *s5=[str substringFromIndex:14];
        DLog(@"%@,%@,%@,%@,%@",s1,s2,s3,s4,s5);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",s1,s2,s3,s4,s5];
        return turntoCarIDString;
    }else if(str.length>=15){
        NSString *s1=[str substringToIndex:(str.length-8)];
        NSString *s4=[str substringWithRange:NSMakeRange((str.length-8), 4)];
        NSString *s5=[str substringFromIndex:(str.length-4)];
        DLog(@"%@,%@,%@",s1,s4,s5);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@ %@",s1,s4,s5];
        return turntoCarIDString;
    }else{
        return str;
    }
}

//// 格式化组织机构代码证
-(NSString *)ACFormatOCC:(NSString *)str{
    if (str.length<9) {
        return str;
    }else{
        NSString *s1=[str substringToIndex:4];
        NSString *s2=[str substringWithRange:NSMakeRange(4, 4)];
        NSString *s3=[str substringFromIndex:8];
        DLog(@"%@,%@,%@",s1,s2,s3);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@ %@",s1,s2,s3];
        return turntoCarIDString;
    }
}
////格式化车牌号
-(NSString *)ACFormatPlate:(NSString *)str{
    if (str.length<7) {
        return str;
    }else{
        NSString *s1=[str substringToIndex:(str.length-5)];
        NSString *s2=[str substringWithRange:NSMakeRange((str.length-5), 5)];
        DLog(@"%@,%@",s1,s2);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@",s1,s2];
        return turntoCarIDString;
    }
}
//格式化vin
-(NSString *)ACFormatVin:(NSString *)str{
    if (str.length<17) {
        return str;
    }
    else
    {
        NSString *s1=[str substringToIndex:4];
        NSString *s2=[str substringWithRange:NSMakeRange(4, 4)];
        NSString *s3=[str substringWithRange:NSMakeRange(8, 1)];
        NSString *s4=[str substringWithRange:NSMakeRange(9, 4)];
        NSString *s5=[str substringWithRange:NSMakeRange(13, 4)];
        DLog(@"%@,%@,%@,%@,%@",s1,s2,s3,s4,s5);
        NSString *turntoVinString=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",s1,s2,s3,s4,s5];
        return turntoVinString;
    }
}
//------数字格式化----------------
-(NSString*)ACFormatNumStr:(NSString*)nf
{
    float f=[nf floatValue];
    //    DLog(@"%f",f);//
    //    NSNumberFormatter * formatter=[[NSNumberFormatter alloc]init];
    //    formatter.numberStyle=kCFNumberFormatterDecimalStyle;
    //    NSString *turnstr=[formatter stringFromNumber:[NSNumber numberWithFloat:f]];
    //    NSRange range=[turnstr rangeOfString:@"."];
    //    if (range.length==0) {
    //        turnstr =[turnstr stringByAppendingString:@".00"];
    //    }
    //    DLog(@"turnstr=%@_________range.length:%d",turnstr,range.location);
    //    if ([[turnstr substringWithRange:NSMakeRange(turnstr.length-2, 1)] isEqualToString:@"."]) {
    //        turnstr=[turnstr stringByAppendingString:@"0"];
    //    }
    //    NSRange range2=[turnstr rangeOfString:@"."];
    //    turnstr=[turnstr substringToIndex:range2.location+3];
    
    NSNumberFormatter * formatter=[[NSNumberFormatter alloc]init];
    formatter.numberStyle=kCFNumberFormatterDecimalStyle;//kCFNumberFormatterCurrencyStyle;//kCFNumberFormatterDecimalStyle;//kCFNumberFormatterCurrencyStyle;
    NSString *turnstr=[formatter stringFromNumber:[NSNumber numberWithFloat:f]];
    
    
    //    DLog(@"turnstr=%@_______",turnstr);
    
    //    turnstr=[turnstr substringFromIndex:1];
    //
    //    DLog(@"turnstr=%@___asdfasdfas____",turnstr);
    return turnstr;
}
-(NSString *)ZKFromatNumStr:(NSString *)nf{
    float f=[nf floatValue];
    NSNumberFormatter * formatter=[[NSNumberFormatter alloc]init];
    formatter.numberStyle=kCFNumberFormatterDecimalStyle;
    NSString *turnstr=[formatter stringFromNumber:[NSNumber numberWithFloat:f]];
    
    //        DLog(@"turnstr=%@___asdfasdfas____",turnstr);
    return turnstr;
    
}
//格式化身份证号
-(NSString *)ACFormatIDC_DH:(NSString *)str{
    if (str.length==18) {
        NSString *s1=[str substringToIndex:3];
        NSString *s2=[str substringWithRange:NSMakeRange(3, 3)];
        NSString *s3=[str substringWithRange:NSMakeRange(6, 4)];
        NSString *s4=[str substringWithRange:NSMakeRange(10, 4)];
        NSString *s5=[str substringFromIndex:14];
        DLog(@"%@,%@,%@,%@,%@",s1,s2,s3,s4,s5);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",s1,s2,@"****",@"****",@"****"];
        return turntoCarIDString;
    }else if(str.length>=15){
        NSString *s1=[str substringToIndex:(str.length-8)];
        NSString *s4=[str substringWithRange:NSMakeRange((str.length-8), 4)];
        NSString *s5=[str substringFromIndex:(str.length-4)];
        DLog(@"%@,%@,%@",s1,s4,s5);
        NSString *turntoCarIDString=[NSString stringWithFormat:@"%@ %@ %@",s1,@"****",@"****"];
        return turntoCarIDString;
    }else{
        return str;
    }
}
//格式化vin2
-(NSString *)ACFormatVin_DH:(NSString *)str{
    if (str.length<17) {
        return str;
    }
    else
    {
        NSString *s1=[str substringToIndex:4];
        NSString *s2=[str substringWithRange:NSMakeRange(4, 4)];
        NSString *s3=[str substringWithRange:NSMakeRange(8, 1)];
        NSString *s4=[str substringWithRange:NSMakeRange(9, 4)];
        NSString *s5=[str substringWithRange:NSMakeRange(13, 4)];
        DLog(@"%@,%@,%@,%@,%@",s1,s2,s3,s4,s5);
        NSString *turntoVinString=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",s1,@"****",s3,@"****",s5];
        return turntoVinString;
    }
}


//
#pragma mark 振动
- (void)StartSystemShake {
    if (!SIMULATOR) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
}


//播放提示音
-(void)playSystemSound{
    //    if (!SIMULATOR) {
    
    if (!sound) {
        /*
         ReceivedMessage.caf--收到信息，仅在短信界面打开时播放。
         sms-received1.caf-------三全音
         sms-received2.caf-------管钟琴
         sms-received3.caf-------玻璃
         sms-received4.caf-------圆号
         sms-received5.caf-------铃声
         sms-received6.caf-------电子乐
         SentMessage.caf--------发送信息
         
         */
        
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"sms-received1",@"caf"];
        //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
        //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
        if (path) {
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                DLog(@"获取的声音的时候，出现错误");
                //加载资源文件路径
                NSString *resoursePath=[[NSBundle mainBundle]pathForResource:@"sms-received1_zk.caf" ofType:nil];
                OSStatus errorT = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:resoursePath],&sound);
                if (errorT != kAudioServicesNoError) {//获取的声音的时候，出现错误
                    DLog(@"本地声音出现错误");
                }
            }
        }
    }
    if (sound) {
        AudioServicesPlaySystemSound(sound);
    }
    
    
    
    
    //    }
    
    
}

#pragma mark  启动过渡图片
-(void)showStartTransitionView{
    if (!startView) {
        [self updateAPPStartPageADData];
        startView=[[StartTransitionView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    [startView show];
}
///引导页
-(void)showStartGuideTransitionView{
    if (!startView) {
        [self updateAPPStartPageADData];
        startView=[[StartTransitionView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    [startView showGuide];
}
-(void)hiddenStartTransitionView:(BOOL)stopCountDown{
    if (startView) {
        if (stopCountDown) {
            startView.isStopCountdown=YES;
        }
        startView.isStopDataInteraction=YES;
        [startView hidden];
    }
}

-(void)updateAPPStartPageADData{
    krequestParam
    NSDictionary *dic=[Utility defaultsForKey:default_APPStartPageAD];
    if ([[dic valueForJSONStrKey:@"id"] notEmptyOrNull]) {
        [dictparam setValue:[dic valueForJSONStrKey:@"id"] forKey:@"id"];
    }
    [NetEngine createGetAction_LJ:[NSString stringWithFormat:@"welcome/onpage%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
//            [self updateADImageData:[resData objectForJSONKey:@"data"]];
            [self updateADImageData:[[[resData objectForJSONKey:@"data"] ojk:@"list"] firstObject]];
        }
    }];
}
-(void)updateADImageData:(NSDictionary *)dic{
    if ([[dic allKeys] count]) {
        NSString *url=[dic valueForJSONStrKey:@"path"];
        NSString *urlImage =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        
        NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:urlImage]];
        if (cacheImageKey.length) {
            NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
            if (cacheImagePath.length && [[NSFileManager defaultManager] fileExistsAtPath:cacheImagePath]) {
                NSMutableDictionary *dicTemp=[[NSMutableDictionary alloc] initWithDictionary:dic];
                [dicTemp setValue:urlImage forKey:@"imageCacheName"];
                [Utility saveToDefaults:dicTemp forKey:default_APPStartPageAD];
            }else{
                DLog(@"cacheImagePath:%@",cacheImagePath);
                //不存在
                //下载
                [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:urlImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    float currentProgress = (float)receivedSize/(float)expectedSize;
                    if (currentProgress>=1) {
                        
                    }
                }completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (image) {
                        [SDWebImageManager.sharedManager.imageCache storeImage:image forKey:urlImage completion:^{
                            DLog(@"fenxiang_ok:%@",imageURL);
                            NSMutableDictionary *dicTemp=[[NSMutableDictionary alloc] initWithDictionary:dic];
                            //                            [dicTemp setValue:cacheImagePath forKey:@"imageFile"];
                            [dicTemp setValue:urlImage forKey:@"imageCacheName"];
                            [Utility saveToDefaults:dicTemp forKey:default_APPStartPageAD];
                            
                        }];
                    }else{
                        DLog(@"图片下载失败 error :%@",error);
                    }
                } ];
                
            }
        }
    }else{
        [Utility removeForKey:default_APPStartPageAD];
    }
    
    
}



- (float)freeDiskSpace

{
    
    NSError *error = nil;
    float totalFreeSpace;
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (fattributes!=nil) {
        NSNumber *freeFileSystemSizeInBytes = [fattributes objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        
    } else {
        
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return totalFreeSpace;
    
}


#pragma mark 提示信息
-(void)showAgainLoginMessage:(NSString *)strMessage{
    if (!aboolAgainLogin_message && !aboolOneLogin) {
        aboolAgainLogin_message=YES;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"下线提醒" message:strMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag=1010;
        [alert show];
    }
}



////用户权限获取
-(void)showAccessPermissionsAlertViewMessage:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往设置", nil];
    alertV.tag=121;
    [alertV show];
}


///生成二维码
-(UIImage *)generatedCode:(NSString *)str withSize:(CGFloat )fw{
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    return  [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:fw];
    
    
}
//改变二维码大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}


#pragma mark - gotopayforAlipay

/// Get IP Address  ipv4
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
/// Get IP Address  ipv6
- (NSString *)getIPAddressIpv6
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}



#pragma mark - 写入系统相册相关
/**
 *  返回相册
 */
- (PHAssetCollection *)collection{
    NSString *app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!app_Name) {
        app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:app_Name]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:app_Name].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}
/**
 *  写入本地相册
 */
- (void)saveImageLocalAlbum:(UIImage *)imageS{
    if (!imageS) {
        [SVProgressHUD showImage:nil status:@"未找到保存的图片！"];
        return;
    }
    __weak typeof(self) weakSelf=self;
    [self isSaveStatusWithBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            [weakSelf saveImage:imageS withStatusBlock:^(id data, int status, NSString *msg) {
                if (status==200) {
                    [SVProgressHUD showSuccessWithStatus:msg];
                }else{
                    [SVProgressHUD showImage:nil status:msg];
                }
            }];
        }
    }];
    
}

/**
 *  写入本地相册(多图）
 */
- (void)saveImagesLocalAlbum:(NSArray *)images withBlock:(AllcallBlock)aBlock{
    if (images.count<=0) {
        [SVProgressHUD showImage:nil status:@"未找到保存的图片！"];
        return;
    }
    _saveImagesBlock=aBlock;
    __weak typeof(self) weakSelf=self;
    [self isSaveStatusWithBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            NSMutableArray *array=[NSMutableArray arrayWithArray:images];
            [weakSelf sortWriteImageData:array];
        }
    }];
    
}
-(void)sortWriteImageData:(NSMutableArray *)images{
    __weak typeof(self) weakSelf=self;
    [self saveImage:images[0] withStatusBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            [images removeObjectAtIndex:0];
            if (images.count>0) {
                [weakSelf sortWriteImageData:images];
            }else{
                weakSelf.saveImagesBlock(nil, 200, msg);
                [SVProgressHUD showSuccessWithStatus:msg];
            }
        }else{
            weakSelf.saveImagesBlock(nil, 0, msg);
            [SVProgressHUD showImage:nil status:msg];
        }
    }];
}

/**
 判断系统相册写入状态
 
 @param ablock 状态
 */
-(void)isSaveStatusWithBlock:(AllcallBlock)ablock{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        //可以写入
        ablock(nil,200,nil);
    }else if(status == PHAuthorizationStatusNotDetermined){
        //用户还没有做出选择
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){//允许
                ablock(nil,200,nil);
            }else{//拒绝
                ablock(nil,0,nil);
            }
        }];
    }else{
        NSString *app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        if (!app_Name) {
            app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
        }
        [self showAccessPermissionsAlertViewMessage:[NSString stringWithFormat:@"‘%@’没有访问相机的权限，请前往【设置】允许‘%@’访问",app_Name,app_Name]];
        ablock(nil,0,nil);
    }
}
-(void)saveImage:(UIImage *)imaget withStatusBlock:(AllcallBlock)aBlock{
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetId = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改"性质的代码
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
        PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:imaget];
        assetId = createAssetRequest.placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            DLog(@"保存图片到相机胶卷中失败");
            //            [SVProgressHUD showImage:nil status:@"保存图片到相机胶卷中失败"];
            aBlock(nil,0,@"保存图片到相机胶卷中失败!");
            return;
        }
        DLog(@"成功保存图片到相机胶卷中");
        
        // 2. 获得相册对象
        PHAssetCollection *collection = [self collection];
        
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                DLog(@"添加图片到相册中失败");
                aBlock(nil,0,@"添加图片到相册中失败!");
                //                [SVProgressHUD showImage:nil status:@"添加图片到相册中失败"];
                return;
            }
            DLog(@"成功添加图片到相册中");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                aBlock(nil,200,@"保存成功!");
            }];
        }];
    }];
}


-(void)showDemoButton{
    
#ifdef DEBUG
    WSSizeButton*btnShowDemo=[self getAddValueForKey:@"btnShowDemo"];
    if (btnShowDemo==nil) {
        btnShowDemo=[RHMethods buttonWithframe:CGRectMake(100, 100, 50, 50) backgroundColor:RGBACOLOR(0, 0, 0, 0.5) text:@"DEMO" font:15 textColor:[UIColor whiteColor] radius:0 superview:[UIApplication sharedApplication].keyWindow];
        [self setAddValue:btnShowDemo forKey:@"btnShowDemo"];
        btnShowDemo.layer.cornerRadius=5;
        btnShowDemo.frameBY=30;
        btnShowDemo.frameRX=15;
        [btnShowDemo addViewClickBlock:^(UIView *view) {
            [UTILITY.currentViewController pushController:[DEMOHOMEViewController class] withInfo:nil withTitle:@"DEMO" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                
            }];
        }];
    }
    
    
#endif
}
#pragma mark  内存测试统计


/**
 更改Button图标文本方位
 上下居中
 
 @param btn1 目标对象
 */
-(void)updateButtonImageTitleEdgeInsets_topBottom:(UIButton *)btn1{
    [self updateButtonImageTitleEdgeInsets_topBottom:btn1 space:2];
}
-(void)updateButtonImageTitleEdgeInsets_topBottom:(UIButton *)btn1 space:(float)fs{
    CGSize imageSize = btn1.imageView.frame.size;
    CGSize titleSize = btn1.titleLabel.frame.size;
    CGSize textSize = [btn1.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + fs);
    btn1.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn1.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}
/**
 更改Button图标文本方位
 左右更换
 
 @param btnTemp 目标对象
 */
-(void)updateButtonImageTitleEdgeInsets_leftRight:(UIButton *)btnTemp{
    CGSize imageSize = btnTemp.imageView.frame.size;
    [btnTemp setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
    [btnTemp setImageEdgeInsets:UIEdgeInsetsMake(0, btnTemp.titleLabel.bounds.size.width, 0, -btnTemp.titleLabel.bounds.size.width)];
}
/**
 更改Button图标文本方位
 左右更换
 
 @param btnTemp 目标Button
 @param fs 间隔（图文）
 */
-(void)updateButtonImageTitleEdgeInsets_leftRight:(UIButton *)btnTemp space:(float)fs{
    CGSize imageSize = btnTemp.imageView.frame.size;
    float edga_left=0;//左侧偏移量
    float f_jg=fs;//文字图标间隔
    [btnTemp setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width+edga_left, 0, imageSize.width)];
    [btnTemp setImageEdgeInsets:UIEdgeInsetsMake(0, (btnTemp.titleLabel.bounds.size.width+f_jg)+edga_left, 0, -(btnTemp.titleLabel.bounds.size.width+f_jg))];
}
-(BaseViewController *)currentViewController{
    if (!_currentViewController) {
        UINavigationController *curNav = [[[[Utility Share] CustomTabBar_zk] viewControllers] objectAtIndex:[[[Utility Share] CustomTabBar_zk]selectedIndex]];
        _currentViewController=[curNav.viewControllers lastObject];
    }
    return _currentViewController;
}
@end
