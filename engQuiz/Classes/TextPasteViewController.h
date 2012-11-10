//
//  TextPasteViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 10..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface TextPasteViewController : UIViewController{
    DataBase *dbMsg;
    IBOutlet UITextView *textView;
}

- (IBAction)backBtnEvent:(id)sender;
- (IBAction)saveBtnEvent:(id)sender;
@end
