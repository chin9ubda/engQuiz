//
//  SentenceViewController.h
//  TesseractSample
//
//  Created by 박 찬기 on 12. 10. 26..
//
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface SentenceViewController : UIViewController{
    
    IBOutlet UILabel *bookName;
    IBOutlet UILabel *pageNumber;
    IBOutlet UITextView *sentenceTextView;
    
    int examId;
    DataBase *dbMsg;
    NSString *bName;
    NSString *pNumber;
    
    int sid;
    int qid;
    
    
    IBOutlet UILabel *questionLabel;
    IBOutlet UILabel *answerLabel01;
    IBOutlet UILabel *answerLabel02;
    IBOutlet UILabel *answerLabel03;
    IBOutlet UILabel *answerLabel04;
    
    NSMutableArray *pArray;
    UILabel *label[5];
}
- (IBAction)backEvent:(id)sender;
- (void)setInit:(NSString *)name:(NSString *)page:(int)_id;
- (IBAction)saveExam:(id)sender;
@end
