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


-(void)setInit:(NSString *)name:(NSString *)page:(int)_id{
    
    bName = name;
    pNumber = page;
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

- (NSMutableArray *)setExam:(NSString *)msg:(int)class:(int)class2{
    
    NSMutableArray *eArray = [NSMutableArray arrayWithCapacity:0];
    
    
    // 지문
    NSString *sText = msg;
    
    // 문제
    [eArray insertObject:[NSString stringWithFormat:@"문제1"] atIndex:0];
    // 보기
    [eArray insertObject:[NSString stringWithFormat:@"보기 1"] atIndex:1];
    // 보기2
    [eArray insertObject:[NSString stringWithFormat:@"보기 2"] atIndex:2];
    // 보기3
    [eArray insertObject:[NSString stringWithFormat:@"보기 3"] atIndex:3];
    // 보기4
    [eArray insertObject:[NSString stringWithFormat:@"보기 4"] atIndex:4];
    // 정답 번호
    [eArray insertObject:[NSNumber numberWithInt:3] atIndex:5];
    
    
    
    
    [self setSentence:sText];
    
    return eArray;
}
@end
