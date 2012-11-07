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
    
    navi = true;
    
    // 지문 : 학교 : 학년
    pArray = [self setExam:examSentence:1 :1];
    
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


- (void)setInit:(NSString *)name:(NSString *)getSentence{
    
    bName = name;
//    pNumber = page;
    examSentence = getSentence;
    
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
    
    NSMutableArray *rArray = [dbMsg getRSentenceData:1];
    
    NSLog(@"count :::::: %d",rArray.count);
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
