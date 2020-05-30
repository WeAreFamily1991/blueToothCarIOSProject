//
//  ImageSelectEditorView.m
//  XinKaiFa55like
//
//  Created by junseek on 2017/3/23.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "ImageSelectEditorView.h"
#import <Photos/Photos.h>
//#import <ZYQAssetPickerController.h>
#import "XHImageUrlViewer.h"
#import "LFImagePickerController.h"
@interface ImageSelectEditorView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,XHImageUrlViewerDelegate,LFImagePickerControllerDelegate>//ZYQAssetPickerControllerDelegate,
{
    XHImageUrlViewer *imageViewer;
    
    //    UIButton *btnAddImage;/
    NSArray *arrayUrlImage;
}
@property(nonatomic,strong)UIImagePickerController *ipc;

@end
@implementation ImageSelectEditorView


-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self addview];
        _arrayDeleteIds=[NSMutableArray new];
        _maxNumber=9;
    }
    return self;
}
-(NSMutableArray *)imageViewArray{
    if (_imageViewArray==nil) {
        _imageViewArray =[NSMutableArray new];
    }
    return _imageViewArray;
}

-(void)addview{
    
    //    UIButton*btn=[UIButton new];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"upadd"] forState:UIControlStateNormal];
    //    //    btn.backgroundColor=[UIColor grayColor];
    //    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    btnAddImage=btn;
    //    [self addSubview:btn];
}

#pragma mark   获取请求参数
-(NSMutableArray*)getRequsetArrywithkey:(NSString*)key removeServer:(BOOL)abool{
    NSMutableArray *marry=  [NSMutableArray array];
    
    for (int i=0; i<self.imageViewArray.count; i++) {
        UIImageView *image=self.imageViewArray[i];
        //    NSMutableArray *marry;
        if (abool && image.tag>0) {
            continue;
        }
        NSMutableDictionary*dic=[NSMutableDictionary dictionary];
        [dic setValue:[NSString stringWithFormat:@"name%d.jpeg",i] forKey:@"fileName"];
        [dic setValue:[NSString stringWithFormat:@"%@[]",key] forKey:@"fileKey"];
        NSData *imgData=UIImageJPEGRepresentation(image.image, 1.0);
        [dic setObject:imgData forKey:@"fileData"];
        [dic setValue:@"image" forKey:@"fileType"];
        [marry addObject:dic];
    }
    return marry;
    
}
-(NSMutableArray*)getRequsetArrywithFixedkey:(NSString*)key removeServer:(BOOL)abool{
    NSMutableArray *marry=  [NSMutableArray array];
    for (int i=0; i<self.imageViewArray.count; i++) {
        UIImageView *image=self.imageViewArray[i];
        //    NSMutableArray *marry;
        if (abool && image.tag>0) {
            continue;
        }
        NSMutableDictionary*dic=[NSMutableDictionary dictionary];
        [dic setValue:[NSString stringWithFormat:@"name%d.jpeg",i] forKey:@"fileName"];
        [dic setValue:key forKey:@"fileKey"];
        NSData *imgData=UIImageJPEGRepresentation(image.image, 1.0);
        [dic setObject:imgData forKey:@"fileData"];
        [dic setValue:@"image" forKey:@"fileType"];
        [marry addObject:dic];
    }
    return marry;
    
}
-(NSMutableArray*)getServerImageUrl{
    NSMutableArray *marry=  [NSMutableArray array];
    for (int i=0; i<self.imageViewArray.count; i++) {
        UIImageView *image=self.imageViewArray[i];
        if (image.data && [[image.data valueForJSONStrKey:@"id"] notEmptyOrNull]) {
            [marry addObject:[image.data valueForJSONStrKey:@"url"]];
        }
    }
    return marry;
    
}
/**
 设置网络或得的图片数组
 
 @param array @[@{@"url":@"",@"id":@"1"}]
 */
-(void)setImageUrlArray:(NSArray *)array imageChange:(ImageSelectEditorViewBlock)imgChange{
    self.imageChange=imgChange;
    arrayUrlImage=array;
    for (NSDictionary *dic in arrayUrlImage) {
        [self addImageViews:nil dataUrl:dic];
    }
    [self loadRefrshImageViewData];
}
///点击选择图片触发
-(void)ImageSelectEditorViewClicekdSelect:(showImageSelectEditorViewBlock)showImages{
    self.imageSelect = showImages;
}
-(void)imageAddButtonClicked{
    self.imageSelect?self.imageSelect(1):nil;
    [[self supViewController].view endEditing:YES];
    if ((self.maxNumber- self.imageViewArray.count)<1) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"您最多只能选择%d张",self.maxNumber]];
        return;
    }
    __weak typeof(self) weakSelf=self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kS(@"order_comment", @"comment_add_image") message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *CameraAction = [UIAlertAction actionWithTitle:kS(@"generalPage", @"zTakePhoto") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
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
            weakSelf.ipc.allowsEditing = NO;
            weakSelf.ipc.delegate=self;
            //打开
            [[weakSelf supViewController] presentViewController:weakSelf.ipc animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
            }];
        }else
        {
            //如果不可用
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"设备相机不能使用..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
            [alert show];
        }
    }];
    UIAlertAction *PhotoLibraryAction = [UIAlertAction actionWithTitle:kS(@"generalPage", @"zChooseFromAlbum") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:(self.maxNumber- self.imageViewArray.count)>0?(self.maxNumber- self.imageViewArray.count):9 delegate:self];
        imagePicker.allowTakePicture = NO;
        imagePicker.allowPickingVideo = NO;
        imagePicker.doneBtnTitleStr = kS(@"generalPage", @"zComplete");
        //        imagePicker.allowEditting = NO;
        [[self supViewController] presentViewController:imagePicker animated:YES completion:nil];
        
        
    }];
    [alertController addAction:CameraAction];
    [alertController addAction:PhotoLibraryAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kS(@"generalPage", @"cancel") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [[self supViewController] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 选择照片
//设备协议
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    DLog(@"_____info:%@",info);
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize size =  image.size ;
    CGFloat fullW = kScreenWidth*2;
    CGFloat fullH = kScreenHeight*2;
    CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
    ratio = ratio>1?1:ratio;
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    
    //处理图片
    UIImage *logo=[[Utility Share] imageWithImageSimple:image scaledToSize:CGSizeMake(W, H)];
    // NSData *imgData=UIImageJPEGRepresentation(logo, 1.0);
    
    [self addImageViews:logo dataUrl:nil];
    [self loadRefrshImageViewData];
    [[self supViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[self supViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark LFImagePickerControllerDelegate
- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingResult:(NSArray<LFResultObject *> *)results{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *thumbnailFilePath = [documentPath stringByAppendingPathComponent:@"thumbnail"];
    NSString *originalFilePath = [documentPath stringByAppendingPathComponent:@"original"];
    
    NSFileManager *fileManager = [NSFileManager new];
    if (![fileManager fileExistsAtPath:thumbnailFilePath])
    {
        [fileManager createDirectoryAtPath:thumbnailFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![fileManager fileExistsAtPath:originalFilePath])
    {
        [fileManager createDirectoryAtPath:originalFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    for (NSInteger i = 0; i < results.count; i++) {
        LFResultObject *result = results[i];
        if ([result isKindOfClass:[LFResultImage class]]) {
            LFResultImage *resultImage = (LFResultImage *)result;
            [self addImageViews:resultImage.originalImage dataUrl:nil];
        } else {
            /** 无法处理的数据 */
            NSLog(@"%@", result.error);
        }
    }
    [self loadRefrshImageViewData];
}
//- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingThumbnailImages:(NSArray<UIImage *> *)thumbnailImages originalImages:(NSArray<UIImage *> *)originalImages infos:(NSArray<NSDictionary *> *)infos
//{
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
//    NSString *thumbnailFilePath = [documentPath stringByAppendingPathComponent:@"thumbnail"];
//    NSString *originalFilePath = [documentPath stringByAppendingPathComponent:@"original"];
//
//    NSFileManager *fileManager = [NSFileManager new];
//    if (![fileManager fileExistsAtPath:thumbnailFilePath])
//    {
//        [fileManager createDirectoryAtPath:thumbnailFilePath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    if (![fileManager fileExistsAtPath:originalFilePath])
//    {
//        [fileManager createDirectoryAtPath:originalFilePath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//
//    for (NSInteger i = 0; i < originalImages.count; i++) {
//        //        UIImage *thumbnailImage = thumbnailImages[i];
//        UIImage *image = originalImages[i];
//        //        NSDictionary *info = infos[i];
//        //        NSString *name = [NSString stringWithFormat:@"%@.jpeg", info[kImageInfoFileName]];
//        [self addImageViews:image dataUrl:nil];
//    }
//    [self loadRefrshImageViewData];
//}


-(void)loadRefrshImageViewData{
    
    for (UIView *vi in [self subviews]) {
        [vi removeFromSuperview];
    }
    float fw=81;
    float fjg=10;
    NSInteger count1=_imageViewArray.count;//数组长度
    NSInteger numT=(W(self)-fjg)/(fw+fjg);//每排个数
    //  DLog(@"count_image:%d_______count1j=%d",count_image,count1);
    float rm_y=0;
    for (int i=0; i<=count1; i+=numT)   //根据数组添加图片
    {
        rm_y=(fw+fjg)*(i/numT)+fjg;
        DLog(@"__I:%d______rm_y:%f",i,rm_y);
        
        for (int j=0; j<numT; j++)
        {
            if (i+j==count1) {
                UIButton *btnImage=[RHMethods buttonWithFrame:CGRectMake(j*(fw+fjg) +fjg, rm_y, fw, fw) title:@"" image:[_imageName notEmptyOrNull]?_imageName:@"08sch" bgimage:@""];
                btnImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
                btnImage.tag=i+j;
                [btnImage addTarget:self action:@selector(imageAddButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btnImage];
                break;
            }else if (i+j>count1-1)
            {
                break;
            }else{//70 77
                DLog(@"i+j=%d",i+j);
                
                UIImageView *ImageView=[_imageViewArray objectAtIndex:i+j];
                ImageView.frame=CGRectMake(j*(fw+10)+10, rm_y, fw, fw);
                [ImageView viewLayerRoundBorderWidth:0.1 cornerRadius:4 borderColor:[UIColor clearColor]];
                [self addSubview:ImageView];
                {
                    UIButton *btnDelete=[RHMethods buttonWithFrame:CGRectMake(XW(ImageView)-10, Y(ImageView)-10, 20, 20) title:nil image:@"closei" bgimage:nil supView:self];
                    btnDelete.tag=i+j;
                    [btnDelete addTarget:self action:@selector(deleteImagesClicked:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        rm_y=(fw+10)*(i/numT+1);
    }
    self.frameHeight=rm_y+10;
    
    self.imageChange?self.imageChange(1):nil;
}

-(void)addImageViews:(UIImage *)image dataUrl:(NSDictionary *)dic{
    UIImageView *imageV=[[UIImageView alloc]initWithImage:image];
    [imageV setContentMode:UIViewContentModeScaleAspectFill];
    imageV.clipsToBounds=YES;
    imageV.userInteractionEnabled=YES;
    if (dic && [[dic valueForJSONStrKey:@"id"] notEmptyOrNull]) {
        imageV.tag=[[dic valueForJSONStrKey:@"id"] integerValue];
        [imageV imageWithURL:[dic valueForJSONStrKey:@"url"] useProgress:NO useActivity:NO];
        [imageV setAddValue:[dic valueForJSONStrKey:@"url"] forKey:@"dataurl"];
    }else{
        imageV.tag=0;
    }
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageButtonClicked:)];
    [imageV addGestureRecognizer:tap];
    [self.imageViewArray addObject:imageV];
}


//放大图片
-(void)imageButtonClicked:(UITapGestureRecognizer *)tap{
    [[self supViewController].view endEditing:YES];
    //放大图片
    if (!imageViewer) {
        imageViewer = [[XHImageUrlViewer alloc] init];
    }
    imageViewer.delegate=self;
    imageViewer.hiddenDeleteButton=NO;
    
    NSInteger index=0;
    NSInteger selectIndex = 0;
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (UIImageView *imageT in _imageViewArray) {
        if (imageT==tap.view) {
            selectIndex=index;
        }
        index++;
        NSMutableDictionary *dt=[[NSMutableDictionary alloc] init];
        [dt setValue:imageT.image forKey:@"DefaultImage"];
        if (imageT.tag!=0) {
            for (NSDictionary *dic in arrayUrlImage) {
                if (imageT.tag==[[dic valueForJSONStrKey:@"id"] integerValue]) {
                    [dt setValue:[dic valueForJSONStrKey:@"url"] forKey:@"url"];
                    [dt setValue:[dic valueForJSONStrKey:@"id"] forKey:@"id"];
                    break;
                }
            }
        }
        [dt setValue:imageT forKey:@"view"];
        [array addObject:dt];
    }
    [imageViewer showWithImageDatas:array selectedIndex:selectIndex];
    
}


#pragma mark button
-(void)deleteImagesClicked:(UIButton *)btnD{
    UIImageView *imageV=[_imageViewArray objectAtIndex:btnD.tag];
    if (imageV.tag>0) {
        [_arrayDeleteIds addObject:[NSString stringWithFormat:@"%ld",imageV.tag]];
    }
    [_imageViewArray removeObjectAtIndex:btnD.tag];
    [self loadRefrshImageViewData];
}
#pragma mark XHImageViewerDelegate
//删除操作后剩下的imageArray
- (void)imageUrlViewer:(XHImageUrlViewer *)view deleteArray:(NSArray*)deleteArray remainArray:(NSArray *)remainArray{
    DLog(@"deleteArray:%@____________remainArray:_%@",deleteArray,remainArray);
    for (NSDictionary *dic in deleteArray) {
        [_imageViewArray removeObject:[dic valueForJSONStrKey:@"view"]];
        if ([[dic valueForJSONStrKey:@"id"] notEmptyOrNull] && [[dic valueForJSONStrKey:@"id"] integerValue]!=0) {
            [_arrayDeleteIds addObject:[dic valueForJSONStrKey:@"id"]];
        }
    }
    if ([deleteArray count]) {
        [self loadRefrshImageViewData];
    }
}
-(void)dealloc{
    self.imageChange=nil;
}

+(void)showMyDemo{
    
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
