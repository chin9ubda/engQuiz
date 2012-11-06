//
//  ExViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamLoadViewController.h"

@interface ExViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    UIImagePickerController *imagePickerController;
    uint32_t *pixels;
    UIImage *img;
    IBOutlet UINavigationBar *navigationbar;
    
    ExamLoadViewController *exLoadView;
}

- (IBAction)backBtnEvent:(id)sender;
- (IBAction)exLoadEvent:(id)sender;
- (IBAction)addBtnEvent:(id)sender;
@end
