
#import "Foundation_defines.h"
//http://app.trendy.365use.net/api/login/index
#define baseDomain  @"app.trendycarshare.jp"
#define basePort    @"0"
#define basePath     @"api"
#define basePicPath  @"app.trendycarshare.jp/upload/"


#define baseWebPath  @"http://app.trendycarshare.jp"


////http://app.trendy.365use.net/api/login/index
//#define baseDomain  @"app.trendy.365use.net"
//#define basePort    @"0"
//#define basePath     @"api"
//#define basePicPath  @"m.trendy.365use.net/upload/"
//
//
//#define baseWebPath  @"http://app.trendy.365use.net"


///////固定域名（用于登录、找回密码）
//#define baseDomainFixed  @"www.junseek.com.cn"//www.junseek.cn
//#define basePortFixed    @"80"
//#define basePathFixed     @"app"
//#define basePicPathFixed  @"www.junseek.com.cn/"//@"www.junseek.com.cn/"

#define baseDomainFixed  @""
#define basePortFixed    @"0"
#define basePathFixed     @"app"
#define basePicPathFixed  @""






#define baseUseSSL  [[Utility Share] userAppUseSSL]  //是否加密https

//语音
#define soapDomain   baseDomain
#define soapPort   @"0"
#define soapPath     @""
#define soapPicPath  @""


#define kfAry(number) [MYRHTableView fArrayWithCont:number]



// WEBsocket
#define LikeWEBsocket @"ws://123.206.187.225:666"//[NSString stringWithFormat:@"ws://%@:%@",[[Utility Share] userAppIp],[[Utility Share] userAppsocketport]]// @"ws://120.26.104.99:13838"// @"ws://182.254.155.39:444"//



#define default_PageSize 20
#define default_StartPage 1
//[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]   [NSString stringWithFormat:@"55LikelibResources.bundle/%@",@"radio08.png"]

//#define Models_path @"/Users/thomas/Documents/work/Genius/AFDFramework/AFDFramework/Utility/"


#define kVersion7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define kVersion8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)

//iphone X
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
#define kIphoneXBottom  IOS11_OR_LATER_SPACE(k_KEY_WINDOW.safeAreaInsets.bottom)
#define kIphoneXLeft  IOS11_OR_LATER_SPACE(k_KEY_WINDOW.safeAreaInsets.left)
#define kIphoneXRight  IOS11_OR_LATER_SPACE(k_KEY_WINDOW.safeAreaInsets.right)
#define kIphoneXTop  IOS11_OR_LATER_SPACE(k_KEY_WINDOW.safeAreaInsets.top)
#else
#define kIphoneXBottom  0
#define kIphoneXLeft  0
#define kIphoneXRight  0
#define kIphoneXTop 0
#endif
#define kStatusBarH   ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kTopHeight ((kStatusBarH==40?20:kStatusBarH) + 44)
//wifi、tel
#define kContentHeight (H(self.view)-kTopHeight)


#define IOS11_OR_LATER_SPACE(par)\
({\
float space = 0.0;\
if (@available(iOS 11.0, *))\
space = par;\
(space);\
})
#define k_KEY_WINDOW [UIApplication sharedApplication].keyWindow


#define kLibImage(imagstr) [NSString stringWithFormat:@"libSouce.bundle/%@",imagstr]


#define rgbwhiteColor [UIColor whiteColor]
#define rgbpublicColor rgb(13,112,161)//17b4eb
#define rgbBlue RGBCOLOR(75, 100,  155)
#define rgbGray RGBACOLOR(245, 245, 245, 1)
#define rgbTxtGray RGBACOLOR(150, 150, 150, 1)
#define rgbTitleColor RGBCOLOR(0, 0,  0)
#define rgbTitleDeepGray RGBACOLOR(70, 70, 70, 1)
#define rgbTxtDeepGray rgb(100,100,100)
#define rgbLineColor RGBACOLOR(80, 80, 80, 0.2)
#define rgbOrange RGBCOLOR(255, 108, 70)
#define rgbRedColor RGBCOLOR(237, 0,  35)
#define fontTitle Font(16)
#define fontTxtContent Font(14)
#define fontSmallTxtContent Font(12)
#define fontSmallTitle Font(10)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]// ///UIColorFromRGB(0xff822c)
#define rgbHexColor(hexColor) [UIColor colorWithHexString:hexColor]

#define CN 1
#define UI_language(cn,us) CN?cn:us

#define UI_btn_back CN?@"返回":@"back"

#define UI_btn_search CN?@"搜索":@"Search"

#define UI_btn_upload CN?@"上传":@"Upload"
#define UI_btn_submit CN?@"提交":@"Submit"
#define UI_btn_cancel CN?@"取消":@"cancel"
#define UI_btn_confirm CN?@"确定":@"OK"
#define UI_btn_delete CN?@"删除":@"Delete"
#define UI_tips_load CN?@"正在加载...":@"Loading..."

//#define alertErrorTxt @"哎呀！服务器偷懒了,待会再试试"
//#define alertMessaget @"哎呀！服务器偷懒了,待会再试"
#define alertErrorTxt kS(@"generalPage", @"NetworkErrorConnect")
#define alertMessaget kS(@"generalPage", @"NetworkErrorConnect")
#define KScrollYMobileDistance 300.0



#define DOCUMENTS_FOLDER [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SpeechSoundDir"]//录音的存放文件夹
#define DOCUMENTS_CHAT_FOLDER [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"downAudio"]//语音聊天的录音存放文件夹
#define FILEPATH [DOCUMENTS_FOLDER stringByAppendingPathComponent:[self fileNameString]]  //录音的路径

#define documentsDirectory_SpeechSound  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"SpeechSoundDir"]//录音临时文件
#define K_alreadyNum @"K_alreadyNum"

#define DOCUMENTS_SHARE_IMAGES [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"shareImages"]//分享图片、GIF存放文件夹

//存放视频文件
#define DOCUMENTS_MOVIE [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"downloadMovie"]//

#define DOCUMENTS_Recorder [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"ZKAudioRecorder"]//临时录音的存放文件夹_培训
#define DOCUMENTS_RecorderAfterTranscoding [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"ZKAudioRecorderAfterTranscoding"]//MP3录音的存放文件夹_培训

#define DOCUMENTS_TriningAudio [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"downloadTriningAudio"]//MP3录音的存放文件夹_培训

///录音数据
#define ZKAudioDataV3 @"ZKAudioDataV3"




#define ZKShowAudioPlayBtton @"ZKShowAudioPlayBtton"
#define ZKHiddenAudioPlayBtton @"ZKHiddenAudioPlayBtton"

///常用
#define krequestParam NSMutableDictionary*dictparam=[NSMutableDictionary new];\
if ([[kUtility_Login userToken] notEmptyOrNull]) {[dictparam setValue:[kUtility_Login userToken] forKey:@"token"];\
} if ([[kUtility_Login userId] notEmptyOrNull]){[dictparam setValue:[kUtility_Login userId] forKey:@"uid"];}\
[dictparam setValue:kLanguageService.appLanguage forKey:@"language"];




//****************************************2017-04-05  登录 ************************************************
#define MFuseronpage @"user/onpage?hairstylist=1"//开机广告图片
#define MFuserrelogin @"user/relogin"//登陆检查
#define MFuserlogin @"user/login"//登陆
#define MFusergetversion @"user/getversion"////版本更新
#define MFuserforgetpwd @"user/forgetpwd"//忘记密码
#define MFusergetcode @"user/getcode"//获取验证码



