//
//  OFCHeaderImageSelectCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/12.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OFCImageUpLoadCellView.h"
#import "LFImagePickerController.h"
#import <Photos/Photos.h>
@interface OFCImageUpLoadCellView()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,LFImagePickerControllerDelegate>
{
    UIImage*imageTemp;
}
@property(nonatomic,strong)UIImageView*imageViewLogo;
@property(nonatomic,strong)UIImagePickerController*ipc;
@end

@implementation OFCImageUpLoadCellView
-(void)addFCView{
    
    self.frameHeight=60;
    [self defaultNameLabel].hidden=YES;
    [self defaultTextfield].hidden=YES;
    [self defaultLineView].hidden=YES;
    self.backgroundColor=[UIColor clearColor];
    UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 8, 13) defaultimage:@"arrowr1" supView:self];
    imgVRow.frameRX=15;
    [imgVRow beCY];
    self.defaultTextfield.frameWidth=self.frameWidth-self.defaultTextfield.frameX-17-15;
    self.defaultTextfield.placeholder=[NSString stringWithFormat:@"%@%@",kS(@"generalPage", @"pleaseSelect"),[self.data ojsk:@"name"]];
    self.defaultTextfield.userInteractionEnabled=NO;
    [self addViewTarget:self select:@selector(selectBtnClick:)];
    
//    UIImageView*imgVPhoto=[RHMethods imageviewWithFrame:CGRectMake(0, 9.5, 40, 40) defaultimage:@"photo" supView:self];
//    imgVPhoto.frameRX=32.5;
//    _imageViewLogo=imgVPhoto;
//    [imgVPhoto beRound];
    
    
    
    {
        
        //        NSArray*arraytitle=[self.otherInfo ojk:@"list"];
        //        for (int i=0; i<arraytitle.count; i++) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(15, 15, kScreenWidth-30, 225) backgroundcolor:rgb(255, 255, 255) superView:self];
        self.frameHeight=viewContent.frameYH+5;
        //            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UIImageView*viewCenter=[UIImageView viewWithFrame:CGRectMake(0, 0, 223, 135) backgroundcolor:rgb(255, 255, 255) superView:viewContent];
        [viewCenter beCX];[viewCenter beCY];
        _imageViewLogo=viewCenter;
        viewCenter.layer.cornerRadius=5;
        viewContent.layer.cornerRadius=5;
        viewCenter.layer.borderWidth=1;
        viewContent.layer.borderWidth=1;
        viewCenter.layer.borderColor=rgb(238, 238, 238).CGColor;
        viewContent.layer.borderColor=rgb(238, 238, 238).CGColor;
        UIImageView*imgVTakePhoto=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 62, 62) defaultimage:@"mfile1" supView:viewCenter];
        [imgVTakePhoto beCY];[imgVTakePhoto beCX];
        /* UILabel*lbPlaceHolder=*/[RHMethods ClableY:viewCenter.frameYH+14.5 W:viewContent.frameWidth-20 Height:14 font:14 superview:viewContent withColor:rgb(153, 153, 153) text:[self.data ojsk:@"placeholder"]];
        //            viewContent.frameY=i==0?20:15;
        //        }
    }
    
}


-(NSMutableArray*)getNoUploadImageViewArray{
    
    NSMutableArray*array=[NSMutableArray new];
    if (![[_imageViewLogo getAddValueForKey:@"dataurl"] notEmptyOrNull]&&imageTemp) {
        [array addObject:_imageViewLogo];
    }
    return array;
}

-(void)selectBtnClick:(UIView*)btn{
    //    [UTILITY.currentViewController.view endEditing:YES];
    [self updateUserLogo];
    
}
-(void)setValueStr:(NSString *)valueStr{
    [_imageViewLogo setAddValue:valueStr forKey:@"dataurl"];
    [_imageViewLogo imageWithURL:valueStr useProgress:NO useActivity:NO defaultImage:@"avatar-1"];
}

-(NSString *)valueStr{
    
    NSString*valueStr=[_imageViewLogo getAddValueForKey:@"dataurl"];
    if (valueStr) {
        return valueStr;
    }else{
        return @"";
    }
}

-(void)updateUserLogo{
    [UTILITY.currentViewController.view endEditing:YES];
    __weak typeof(self) weakSelf=self;
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:kS(@"order_comment", @"comment_add_image") preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kS(@"generalPage", @"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:kS(@"generalPage", @"zTakePhoto") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            if (!app_Name) {
                app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
            }
            [[Utility Share] showAccessPermissionsAlertViewMessage:[NSString stringWithFormat:@"‘%@’没有访问相机的权限，请前往【设置】允许‘%@’访问",app_Name,app_Name]];
            return;
        }
        if (!weakSelf.ipc) {
            weakSelf.ipc=[[UIImagePickerController alloc]init];
        }
        //判断当前相机是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {// 打开相机
            weakSelf.ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设置是否可编辑
            weakSelf.ipc.allowsEditing = YES;
            weakSelf.ipc.delegate=self;
            //打开
            [UTILITY.currentViewController presentViewController:weakSelf.ipc animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
            }];
        }else
        {
            //如果不可用
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"设备不可用..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
            [alert show];
        }
    }];
    UIAlertAction *xAction = [UIAlertAction actionWithTitle:kS(@"generalPage", @"zChooseFromAlbum") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:10 delegate:self];
        imagePicker.allowTakePicture = NO;
        imagePicker.allowPickingVideo = NO;
        imagePicker.doneBtnTitleStr = kS(@"generalPage", @"zComplete");
        //        imagePicker.allowEditting = NO;
        imagePicker.allowPickingOriginalPhoto=YES;
        
        imagePicker.showRadioImage=YES;
        imagePicker.cropImageSize=CGSizeMake(300.0, 300.0);
        
        [UTILITY.currentViewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addAction:xAction];
    [UTILITY.currentViewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - delegate function

#pragma mark UIImagePicker
//设备协议
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    DLog(@"_____info:%@",info);
    //获得编辑过的图片
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //处理图片
    UIImage *logo=[[Utility Share] imageWithImageSimple:image scaledToSize:CGSizeMake(300.0, 300.0)];
    imageTemp=logo;
    _imageViewLogo.image=logo;
//    [_imageViewLogo getAddValueForKey:@"dataurl"]
    [_imageViewLogo removeAddValueForkey:@"dataurl"];
    [UTILITY.currentViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [UTILITY.currentViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark LFImagePickerControllerDelegate
- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingRadioCropImages:(UIImage *)cropImage originalImages:(UIImage *)originalImage{
    [_imageViewLogo removeAddValueForkey:@"dataurl"];
    imageTemp=cropImage;
    _imageViewLogo.image=cropImage;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

