//
//  TextPasteViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 10..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface TextPasteViewController : UIViewController<UITextViewDelegate>{
    DataBase *dbMsg;
    IBOutlet UITextView *textView;
    
    int textCheck;
    NSString *text;
}

- (IBAction)backBtnEvent:(id)sender;
- (IBAction)saveBtnEvent:(id)sender;

- (void)setText:(NSString *)_text;
@end
