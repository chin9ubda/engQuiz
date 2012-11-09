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
    
    navi = true;
    
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
    navigationBar = nil;
    sentenceView = nil;
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

- (IBAction)naviEvent:(id)sender {
    if (navi) {
//        [navigationBar setHidden:YES];
        [self moveView:navigationBar duration:0.2 curve:UIViewAnimationCurveLinear y:-44];
        
        navi = false;
    }else{
//        [navigationBar setHidden:NO];
        [self moveView:navigationBar duration:0.2 curve:UIViewAnimationCurveLinear y:0];

        navi = true;
    }
}

- (IBAction)answerCheck1:(id)sender {
    if (nowCheck != 1) {
        nowCheck = 1;
        [answerCheck1Btn setSelected:YES];
        [answerCheck2Btn setSelected:NO];
        [answerCheck3Btn setSelected:NO];
        [answerCheck4Btn setSelected:NO];
    }else{
        [self checkAnser:1];
    }
}

- (IBAction)answerCheck2:(id)sender {
    if (nowCheck != 2) {
        nowCheck = 2;
        [answerCheck1Btn setSelected:NO];
        [answerCheck2Btn setSelected:YES];
        [answerCheck3Btn setSelected:NO];
        [answerCheck4Btn setSelected:NO];
    }else{
        [self checkAnser:2];
    }
}

- (IBAction)answerCheck3:(id)sender {
    if (nowCheck != 3) {
        nowCheck = 3;
        [answerCheck1Btn setSelected:NO];
        [answerCheck2Btn setSelected:NO];
        [answerCheck3Btn setSelected:YES];
        [answerCheck4Btn setSelected:NO];
    }else{
        [self checkAnser:3];
    }
}

- (IBAction)answerCheck4:(id)sender {
    if (nowCheck != 4) {
        nowCheck = 4;
        [answerCheck1Btn setSelected:NO];
        [answerCheck2Btn setSelected:NO];
        [answerCheck3Btn setSelected:NO];
        [answerCheck4Btn setSelected:YES];
    }else{
        [self checkAnser:4];
    }
}

-(void)checkAnser:(int)c{
    
    UIAlertView *alert;
    NSString *msg = [NSString stringWithFormat:@"%@ : %@\n%@ : %@\n%@ : %@\n%@ : %@",answerLabel01.text,[dbMsg getMean:answerLabel01.text],answerLabel02.text,[dbMsg getMean:answerLabel02.text],answerLabel03.text,[dbMsg getMean:answerLabel03.text],answerLabel04.text,[dbMsg getMean:answerLabel04.text]];
    
    NSString *result;
    
    if ([[pArray objectAtIndex:5] intValue] == c) {
        result = @"정답입니다.";
    }else{
        result = @"틀렸습니다.";
    }
    
    if (nowType == 0) {
        alert = [[UIAlertView alloc] initWithTitle:result
                                           message:msg
                                          delegate:self
                                 cancelButtonTitle:@"확 인"
                                 otherButtonTitles:@"오답노트에 저장", nil];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:result
                                           message:msg
                                          delegate:self
                                 cancelButtonTitle:@"확 인"
                                 otherButtonTitles:nil, nil];
    }
    
    [alert show];

}

- (void)naviEvent {
    if (navi) {
        //        [navigationBar setHidden:YES];
        [self moveView:navigationBar duration:0.2 curve:UIViewAnimationCurveLinear y:-44];
        
        navi = false;
    }else{
        //        [navigationBar setHidden:NO];
        [self moveView:navigationBar duration:0.2 curve:UIViewAnimationCurveLinear y:0];
        
        navi = true;
    }
}



- (void)saveRepository{
    
//    sid = [dbMsg saveRSentence:bName :@"000000" :1];
    sid = [dbMsg saveRSentence:sentenceTextView.text :@"000000" :1];
    qid = [dbMsg saveRQuestion:sid :answerLabel01.text :1];
    [dbMsg saveRAnswer:sid:answerLabel01.text :0];
    [dbMsg saveRAnswer:sid:answerLabel02.text :0];
    [dbMsg saveRAnswer:sid:answerLabel03.text :1];
    [dbMsg saveRAnswer:sid:answerLabel04.text :0];
    
    int sol[4]; 
    
    sol[check - 1] = 1;
    
    [dbMsg saveRAnswer:qid:answerLabel01.text :sol[0]];
    [dbMsg saveRAnswer:qid:answerLabel02.text :sol[1]];
    [dbMsg saveRAnswer:qid:answerLabel03.text :sol[2]];
    [dbMsg saveRAnswer:qid:answerLabel04.text :sol[3]];
      
//    NSMutableArray *rArray = [dbMsg getRSentenceData:1];
//    
//    NSLog(@"count :::::: %d",rArray.count);
}

- (void)setSentence:(NSString *)sentence{
    
    [bookName setText:bName];
    [pageNumber setText:pNumber];
    
    [sentenceTextView setText:sentence];
    
//    NSLog(@"%d",sentenceTextView.)
//    [sentenceTextView setText:[dbMsg getExamSentence:examId]];
//    [sentenceTextView setEditable:NO];
}

- (void)setTexts:(int)poz{
    
    if (poz == 0) {
        int check = [[pArray objectAtIndex:5] intValue];
        
        for (int i = 0; i < 5; i++) {
            if (check == i && nowType == 2) {
                [label[i] setTextColor:[UIColor redColor]];
            }
            [label[i] setText:[pArray objectAtIndex:i]];
        }
    }else{
        int check = [[pArray objectAtIndex:poz * 5 + 6] intValue];
        
        for (int i = 0; i < 5; i++) {
            if (check == i && nowType == 2) {
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"down");
    [self naviEvent];
//    if ([[touches anyObject]locationInView:sentenceTextView] )
//    [touches anyObject]location
    
    
//    UITouch *touch = [[event allTouches] anyObject];
////.    if(Ball.hidden == YES){
//    float touch_x = [touch locationInView:touch.view].x;
//    float touch_y = [touch locationInView:touch.view].y;
//    
//    if (sentenceView.frame.origin.x <= touch_x <= sentenceView.frame.origin.x + sentenceView.frame.size.width && sentenceView.frame.origin.y <= touch_y <= sentenceView.frame.origin.y + sentenceView.frame.size.height) {
//        NSLog(@"down");
//    }
    
//        if(touch_x < 50){ //일정 Y값 범위 내에서만 발사
//            Ball_move_x = (touch_x - 60) / 10;
//            Ball_move_y = (touch_y - 30) / 10;
//            moveSign = YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


- (void)moveView:(UIView *)view duration:(NSTimeInterval)duration
            curve:(int)curve y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    view.frame = CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height);
    // Commit the changes
    [UIView commitAnimations];

}


//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//
//- (void)textViewDidBeginEditing:(UITextView *)textView;
//- (void)textViewDidEndEditing:(UITextView *)textView;

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
//- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"ohohoh");
//}
//
@end
