//
//  EduViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 4..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EduViewController : UIViewController{
    NSMutableArray *vArray;
    IBOutlet UILabel *wordLabel;
    IBOutlet UILabel *meanLabel;
    
    int nowPoz;
    IBOutlet UIButton *lastWordBtn;
    IBOutlet UIButton *nextWordBtn;
    IBOutlet UIButton *meanBtn;
}

- (IBAction)backBtnEvent:(id)sender;

- (void)setVocaArray:(NSMutableArray *)getArray;
- (IBAction)lastWordBtnEvent:(id)sender;
- (IBAction)nextWordBtnEvent:(id)sender;
- (IBAction)meanBtnEvent:(id)sender;
@end
