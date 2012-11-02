//
//  ExViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "ExViewController.h"
#import "ExamLoadViewController.h"

//#import "MBProgressHUD.h"
//#include "baseapi.h"
//
//#include "environ.h"
//#import "pix.h"

@interface ExViewController ()

@end

@implementation ExViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnEvent:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)exLoadEvent:(id)sender {
    
    ExamLoadViewController *exLoadView = [[ExamLoadViewController alloc]init];
    
    [self presentModalViewController:exLoadView animated:YES];
}

- (IBAction)addBtnEvent:(id)sender {
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"취소"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"사진 촬영", @"앨범에서 가져오기", nil];
    [actionsheet showInView:self.view];
}

#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"사진 찍기");
        
        imagepickerController = [[UIImagePickerController alloc] init];
        [imagepickerController setDelegate:self];
        
        [imagepickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        
//        NSArray *xibs = [[NSBundle mainBundle]  loadNibNamed:@"OverlayView" owner:self options:nil];
//        OverlayView *overlay = (OverlayView *)[xibs objectAtIndex:0];
//        
//        imagepickerController.allowsEditing=NO;
//        imagepickerController.showsCameraControls = NO;
//        imagepickerController.cameraViewTransform = CGAffineTransformScale(imagepickerController.cameraViewTransform,CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
//        
//        imagepickerController.cameraOverlayView = overlay;
        
        
        [self presentModalViewController:imagepickerController animated:YES];
        
    }else if(buttonIndex == 1){
        NSLog(@"앨범에서 불러오기");
        
        imagepickerController = [[UIImagePickerController alloc] init];
        [imagepickerController setDelegate:self];
        [imagepickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentModalViewController:imagepickerController animated:YES];
        
    }
}

// 사진 고르기 취소
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

// 사진 찍기 취소
- (IBAction)closeCamer:(id)sender {
    [imagepickerController dismissModalViewControllerAnimated:YES];
}


// 사진 찍기 버튼 눌렀을 때
- (IBAction)tookPicture:(id)sender {
    [imagepickerController takePicture];
//    SJ_DEBUG_LOG(@"Take Picture");
}


//// 3. 가지고 온 사진을 편집한다 (crop, 회전 등)
//#pragma mark UIImagePickerContoller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
//    SentenceViewController *sentenceVeiw = [[SentenceViewController alloc]init];
//    
//    if (index == 0) {
//        [sentenceVeiw setInit:[dbMsg getBookName:[[bArray objectAtIndex:bookNumber + 1]integerValue]]:[[tArray objectAtIndex:0]integerValue]];
//    }else {
//        [sentenceVeiw setInit:[dbMsg getBookName:[[bArray objectAtIndex:bookNumber + 1]integerValue]]:[[tArray objectAtIndex:index * 2]integerValue]];
//    }
//    
    
//    SJ_DEBUG_LOG(@"Image Selected");
//    if(imagepickerController.sourceType == UIImagePickerControllerSourceTypeCamera){
//        dismiss_type = IMAGEPICKER_CAMERA;
//    }else{
//        dismiss_type = IMAGEPICKER_PHOTO_ALBUM;
//    }
//    
//    scanImage = image;
//    [picker dismissModalViewControllerAnimated:NO];
//    
//    return;
}
@end
