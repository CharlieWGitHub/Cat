//
//  SettingViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/7.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "GestureLockView.h"
#import "CLoginViewController.h"
#import "VPNViewController.h"

//测试选照片
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

//


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)UITableView * personTable;
@property(nonatomic,strong) NSArray * dataArr;
@end

@implementation SettingViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    
    self.dataArr = @[ @"takePhoto-->单选图片/拍照",@"takePhotos->多选",@"takeVideo-->拍摄/相册",@"我的评价",@"消息中心",@"清理缓存",@"设置"];
    
    [self.view addSubview:self.personTable];
    [self.personTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0 , 0, 15, 0));
        
    }];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rotateViews:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (void) rotateViews:(NSNotification *)notif {
    UIDeviceOrientation  orientation = [UIDevice currentDevice].orientation;
    switch (orientation)
    {
    case UIDeviceOrientationPortrait:
      NSLog(@"屏幕--- home 键在下侧 --- ");
 break;
      case UIDeviceOrientationLandscapeLeft:
   NSLog(@"屏幕 left --- home 键在右侧 --- ");
          break;
    case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕 home 键在上侧 --- ");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕 right --- home 键在左侧 --- ");
            break;
        default:
            break;
    }
    
    /*
     
     UIDevice* device = [sender valueForKey:@"object"];
     
     NSLog(@"\n rotateViews --%@",[NSString stringWithFormat:@"%ld",(long)device.orientation]);
     
     switch (device.orientation) {
     case UIDeviceOrientationUnknown: {
     
     NSLog(@"UIDeviceOrientationUnknown");
     break;
     }
     case UIDeviceOrientationPortrait: {
     // do something
     NSLog(@"UIDeviceOrientationPortrait");
     break;
     }
     case UIDeviceOrientationPortraitUpsideDown: {
     // do something
     NSLog(@"UIDeviceOrientationPortraitUpsideDown");
     break;
     }
     case UIDeviceOrientationLandscapeLeft: {
     // do something
     NSLog(@"UIDeviceOrientationLandscapeLeft");
     break;
     }
     case UIDeviceOrientationLandscapeRight: {
     // do something
     NSLog(@"UIDeviceOrientationLandscapeRight");
     break;
     }
     case UIDeviceOrientationFaceUp: {
     // do something
     NSLog(@"UIDeviceOrientationFaceUp");
     break;
     }
     case UIDeviceOrientationFaceDown: {
     // do something
     NSLog(@"UIDeviceOrientationFaceDown");
     break;
     }
     }
     */
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden = @"identif";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        //拍照、相册选择
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            [self takePhoto];
        }];
        [alertVc addAction:takePhotoAction];
        UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            [self pushTZImagePickerController];
        }];
        [alertVc addAction:imagePickerAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:cancelAction];
        //        UIPopoverPresentationController *popover = alertVc.popoverPresentationController;
        //        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        //        if (popover) {
        //            popover.sourceView = cell;
        //            popover.sourceRect = cell.bounds;
        //            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        //        }
        [self presentViewController:alertVc animated:YES completion:nil];
        
        
        
        
        //        VPNViewController * vpn = [[VPNViewController alloc]init];
        //        vpn.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:vpn animated:YES];
    }else if (indexPath.row ==1){
        //多选
        TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        //              imagePickerVc.videoMaximumDuration = 15; // 视频最大拍摄时间
        //是否可以选择视频
        imagePickerVc.allowPickingVideo = NO;
        
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
        //        AboutUsViewController * about = [[AboutUsViewController alloc]init];
        //        about.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:about animated:YES];
    }
    else if (indexPath.row ==2){
        //        拍摄/相册
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self selectMethod:1];
        }];
        [alertVc addAction:takePhotoAction];
        UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self selectMethod:2];
        }];
        [alertVc addAction:imagePickerAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:cancelAction];
        
        [self presentViewController:alertVc animated:YES completion:nil];
        
        
        //        CLoginViewController * login  =[[CLoginViewController alloc]init];
        //        login.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:login animated:YES];
    }
    if (indexPath.row==3) {
        //        GestureLockView * gestures = [[GestureLockView alloc]init];
        //        gestures.hidesBottomBarWhenPushed = YES;
        //        gestures.gestureType = 0;
        //        [self.navigationController pushViewController:gestures animated:YES];
    }else if (indexPath.row ==4){
        
        TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        imagePickerVc.videoMaximumDuration = 15; // 视频最大拍摄时间
        //是否可以选择视频
        imagePickerVc.allowPickingVideo = YES;
        
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}
-(void)selectMethod:(NSInteger)indexMethod{
    // 拍摄
    if (indexMethod ==1) {
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPicker.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeMovie];
        imgPicker.mediaTypes = mediaTypes;
        imgPicker.videoMaximumDuration = 20.0f;
        [self presentViewController:imgPicker animated:YES completion:nil];
    } else {
        
        TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:NO];
        //        imagePickerVc.videoMaximumDuration = 15; // 视频最大拍摄时间
        //是否可以选择视频
        //        imagePickerVc.allowPickingVideo = YES;
        //        imagePickerVc.allowPickingImage = NO;
        
        //展示相册中的视频
        imagePickerVc.allowPickingVideo = YES;
        //不展示图片
        imagePickerVc.allowPickingImage = NO;
        //不显示原图选项
        imagePickerVc.allowPickingOriginalPhoto = NO;
        //按时间排序
        imagePickerVc.sortAscendingByModificationDate = YES;
        
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        //
        UIImage *selecteImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"照片-%@",selecteImg);
    }else if ([type isEqualToString:@"public.movie"]){
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"视频:%@",videoUrl);
        [[TZImageManager manager]saveVideoWithUrl:videoUrl completion:^(PHAsset *asset, NSError *error) {
            
            [[TZImageManager manager]getVideoOutputPathWithAsset:asset success:^(NSString *outputPath) {
                
                NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
                
            } failure:^(NSString *errorMessage, NSError *error) {
                
            }];
            
        }];
    }
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    NSLog(@"--=-=--%@",photos);
}

-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{
    NSLog(@"=====%@",coverImage);
    
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
        // NSData *data = [NSData dataWithContentsOfFile:outputPath];
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    
}

#pragma mark layz
-(UITableView *)personTable{
    if (!_personTable) {
        _personTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _personTable.delegate = self;
        _personTable.dataSource = self;
        
    }
    return _personTable;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
