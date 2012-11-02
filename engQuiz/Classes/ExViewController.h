//
//  ExViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

//namespace tesseract {
//    class TessBaseAPI;
//};

@interface ExViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate>{
    
    UIImagePickerController *imagepickerController;
//    MBProgressHUD *progressHud;
//    
//    tesseract::TessBaseAPI *tesseract;
//    uint32_t *pixels;
//    UIImage *img;
}

- (IBAction)backBtnEvent:(id)sender;
- (IBAction)exLoadEvent:(id)sender;
- (IBAction)addBtnEvent:(id)sender;
@end
