//
//  MessageChatViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/4/30.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MessageChatViewController.h"
#import "TChatController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface MessageChatViewController ()<TChatControllerDelegate>
@property(nonatomic,strong)TChatController*chat;
@property(nonatomic,strong)NSDate*currentDate;
@end

@implementation MessageChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentDate = [NSDate new];
    //初始化 TUIKit 的会话UI类
    _chat = [[TChatController alloc] init];
    _chat.conversation = self.userInfo;
    _chat.delegate = self;
    [self addChildViewController:_chat];
    [self.view addSubview:_chat.view];
    _chat.view.frameY=kTopHeight;
    _chat.view.frameHeight-=kTopHeight;
//    _chat.inputController.view.frameBY=0;
    [_chat setupViews];
    
}

- (void)chatController:(TChatController *)chatController didSelectMoreAtIndex:(NSInteger)index
{
    if(index == 0 || index == 1 || index == 2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if(index == 0){
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
        else if(index == 1){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModePhoto;
        }
        else{
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            picker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModeVideo;
            picker.videoQuality =UIImagePickerControllerQualityTypeHigh;
        }
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypeData] inMode:UIDocumentPickerModeOpen];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//- (void)chatController:(TChatController *)chatController didSelectMessages:(NSMutableArray *)msgs atIndex:(NSInteger)index
//{
//    TMessageCellData *data = msgs[index];
//    if([data isKindOfClass:[TImageMessageCellData class]]){
//        ImageViewController *image = [[ImageViewController alloc] init];
//        image.data = (TImageMessageCellData *)data;
//        [self presentViewController:image animated:YES completion:nil];
//    }
//    else if([data isKindOfClass:[TVideoMessageCellData class]]){
//        VideoViewController *video = [[VideoViewController alloc] init];
//        video.data = (TVideoMessageCellData *)data;
//        [self presentViewController:video animated:YES completion:nil];
//    }
//    else if([data isKindOfClass:[TFileMessageCellData class]]){
//        FileViewController *file = [[FileViewController alloc] init];
//        file.data = (TFileMessageCellData *)data;
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:file];
//        //[self presentViewController:nav animated:YES completion:nil];
//        [self.navigationController pushViewController:file animated:YES];
//    }
//}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation=  image.imageOrientation;
        if(imageOrientation != UIImageOrientationUp)
        {
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        NSDate*mydate = [NSDate new];
        if (mydate.timeIntervalSince1970 - self.currentDate.timeIntervalSince1970 < 3) {
            return;
        }
        
        
        self.currentDate = [NSDate new];
        
        [_chat sendImageMessage:image];
    }
    else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        [_chat sendVideoMessage:url];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    [_chat sendFileMessage:url];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)getLocalPath:(NSURL *)url
{
    NSString *imageName = [url lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    return localFilePath;
}
@end
