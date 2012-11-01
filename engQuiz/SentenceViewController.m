//
//  SentenceViewController.m
//  TesseractSample
//
//  Created by 박 찬기 on 12. 10. 26..
//
//

#import "SentenceViewController.h"

@interface SentenceViewController ()

@end

@implementation SentenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dbMsg = [DataBase getInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [self setTexts];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    bookName = nil;
    pageNumber = nil;
    sentenceTextView = nil;
    questionLabel = nil;
    answerLabel01 = nil;
    answerLabel02 = nil;
    answerLabel03 = nil;
    answerLabel04 = nil;
    [super viewDidUnload];
}
- (IBAction)backEvent:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


-(void)setInit:(NSString *)name:(NSString *)page:(int)_id{
    
    bName = name;
    pNumber = page;
    examId = _id;
    
}

- (IBAction)saveExam:(id)sender {
    [self saveRepository];
    [self dismissModalViewControllerAnimated:YES];
}


- (void)saveRepository{
    
//    sid = [dbMsg saveRSentence:bName :@"000000" :1];
    sid = [dbMsg saveRSentence:sentenceTextView.text :@"000000" :1];
    qid = [dbMsg saveRQuestion:sid :answerLabel01.text :1];
    [dbMsg saveRAnswer:sid:answerLabel01.text :0];
    [dbMsg saveRAnswer:sid:answerLabel02.text :0];
    [dbMsg saveRAnswer:sid:answerLabel03.text :1];
    [dbMsg saveRAnswer:sid:answerLabel04.text :0];
    
    NSMutableArray *rArray = [dbMsg getRSentenceData:1];
    
    NSLog(@"count :::::: %d",rArray.count);
}

- (void)setTexts{
    
    [bookName setText:bName];
    [pageNumber setText:pNumber];
    [sentenceTextView setText:[dbMsg getExamSentence:examId]];
    [sentenceTextView setEditable:NO];
}


/* ----------------------------------------
 
 문제 생성.. 
 msg : 지문
 class : 학년
 ---------------------------------------- */

- (void)setExam:(NSString *)msg:(int)class{
    
}
@end
