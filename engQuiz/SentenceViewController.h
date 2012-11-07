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
}
- (IBAction)backEvent:(id)sender;
- (void)setInit:(NSString *)name:(NSString *)getSentence;
- (IBAction)saveExam:(id)sender;
- (IBAction)naviEvent:(id)sender;
@end
