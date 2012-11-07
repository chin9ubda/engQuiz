//
//  SentenceViewController.h
//  TesseractSample
//
//  Created by 박 찬기 on 12. 10. 26..
//
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface SentenceViewController : UIViewController<UITextViewDelegate>{
    
    IBOutlet UILabel *bookName;
    IBOutlet UILabel *pageNumber;
    IBOutlet UITextView *sentenceTextView;
    
    NSString *examSentence;

    DataBase *dbMsg;
    NSString *bName;
    NSString *pNumber;
    
    int sid;
    int qid;
    
    int check;
    
    int nowType;
    int nowId;
    
    int nowCheck;
    
    BOOL navi;
    
    
    IBOutlet UILabel *questionLabel;
    IBOutlet UILabel *answerLabel01;
    IBOutlet UILabel *answerLabel02;
    IBOutlet UILabel *answerLabel03;
    IBOutlet UILabel *answerLabel04;
    
    NSMutableArray *pArray;
    UILabel *label[5];
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIView *sentenceView;
    
    IBOutlet UIButton *answerCheck1Btn;
    IBOutlet UIButton *answerCheck2Btn;
    IBOutlet UIButton *answerCheck3Btn;
    IBOutlet UIButton *answerCheck4Btn;
}
- (IBAction)backEvent:(id)sender;
- (void)setInit:(NSString *)name:(NSString *)getSentence:(int)type:(int)_id;
- (IBAction)saveExam:(id)sender;
- (IBAction)naviEvent:(id)sender;
- (IBAction)answerCheck1:(id)sender;
- (IBAction)answerCheck2:(id)sender;
- (IBAction)answerCheck3:(id)sender;
- (IBAction)answerCheck4:(id)sender;
@end
