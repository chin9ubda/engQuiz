//
//  SentenceViewController.m
//  TesseractSample
//
//  Created by 박 찬기 on 12. 10. 26..
//
//

#import "SentenceViewController.h"
#include "SimpleProblemMaker.h"

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
//    [self setTexts];
    
    
    // 지문 : 학교 : 학년
    pArray = [self setExam:[dbMsg getExamSentence:examId]:1 :1];
    
    [self labelInit];
    [self setTexts:0];
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


- (void)setInit:(NSString *)name:(int)_id{
    
    bName = name;
//    pNumber = page;
    examId = _id;
    
}

-(void)labelInit{
    label[0] = questionLabel;
    label[1] = answerLabel01;
    label[2] = answerLabel02;
    label[3] = answerLabel03;
    label[4] = answerLabel04;

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

- (void)setSentence:(NSString *)sentence{
    
    [bookName setText:bName];
    [pageNumber setText:pNumber];
    
    [sentenceTextView setText:sentence];
//    [sentenceTextView setText:[dbMsg getExamSentence:examId]];
//    [sentenceTextView setEditable:NO];
}

- (void)setTexts:(int)poz{
    
    if (poz == 0) {
        int check = [[pArray objectAtIndex:5] intValue];
        
        for (int i = 0; i < 5; i++) {
            if (check == i) {
                [label[i] setTextColor:[UIColor redColor]];
            }
            [label[i] setText:[pArray objectAtIndex:i]];
        }
    }else{
        int check = [[pArray objectAtIndex:poz * 5 + 6] intValue];
        
        for (int i = 0; i < 5; i++) {
            if (check == i) {
                [label[i] setTextColor:[UIColor redColor]];
            }
            [label[i] setText:[pArray objectAtIndex:poz * 5 + (i + 1)]];
        }
    }
}


/* ----------------------------------------
 문제 생성.. 
 msg : 지문
 class : 중 = 1 , 고 = 2
 class2 : 학년
 
 %%여기에다 넣어주세요 ㅋㅋ
 ---------------------------------------- */

- (NSMutableArray *)setExam:(NSString *)msg:(int)class1:(int)class2{
    
    NSMutableArray *eArray = [NSMutableArray arrayWithCapacity:0];
    
    // 문제 생성
    std::string str([msg UTF8String]);
    SimpleProblemMaker *prob = new SimpleProblemMaker();
    prob->makeProblem(str, 1, 1);
    
    // 지문
    NSString *sText = [NSString stringWithUTF8String:prob->getProblemContent().c_str()];
    
    
    // 문제
    std::vector<Problem*> problems = prob->getProblems();
    
    Problem* nowProb = problems[0];
    
    [eArray insertObject:[NSString stringWithUTF8String:nowProb->pcontent.c_str()] atIndex:0];
    
    // 문제 항목
    for (int i=0; i<4; i++)
    {
        NSString *strprobitem = [NSString stringWithUTF8String:nowProb->items[i]->qcontent.c_str()];
        
        [eArray insertObject:strprobitem atIndex:i+1];
    }
    
    // 정답 번호
    [eArray insertObject:[NSNumber numberWithInt:nowProb->solution] atIndex:5];
    
    delete prob;
    
    [self setSentence:sText];
    
    return eArray;
}
@end
