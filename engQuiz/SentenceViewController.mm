//
//  SentenceViewController.m
//  TesseractSample
//
//  Created by 박 찬기 on 12. 10. 26..
//
//

#import "SentenceViewController.h"
#include "SimpleProblemMaker.h"
#import "KakaoLinkCenter.h"
#include "CitarPOS.h"

@interface SentenceViewController ()

@end

@implementation SentenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dbMsg = [DataBase getInstance];
        checkState = false;
        dismissType = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    //    [self setTexts];
    navi = true;
    
    // 지문 : 학교 : 학년
    if (nowType == 0) {
        pArray = [self setExam:examSentence:1 :1];
    }else {
        pArray = [self getRepository];
        [saveBtn setEnabled:NO];
    }
    
    [self labelInit];
    [self setTexts:0];
    
    if (nowType == 2) {
        [answerHiddenBtn1 setHidden:YES];
        [answerHiddenBtn2 setHidden:YES];
        [answerHiddenBtn3 setHidden:YES];
        [answerHiddenBtn4 setHidden:YES];
    }
    
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
    questionLabel = nil;
    answerLabel01 = nil;
    answerLabel02 = nil;
    answerLabel03 = nil;
    answerLabel04 = nil;
    navigationBar = nil;
    sentenceView = nil;
    answerCheck1Btn = nil;
    answerCheck2Btn = nil;
    answerCheck3Btn = nil;
    answerCheck4Btn = nil;
    answerHiddenBtn1 = nil;
    answerHiddenBtn2 = nil;
    answerHiddenBtn3 = nil;
    answerHiddenBtn4 = nil;
    saveBtn = nil;
    webView = nil;
    [super viewDidUnload];
}
- (IBAction)backEvent:(id)sender {
    [self dismissModalViewControllerAnimated:dismissType];
    if (!dismissType) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ocr_dismiss" object:nil];
    }
}


- (void)setInit:(NSString *)name:(NSString *)getSentence:(int)type:(int)_id{
    
    bName = name;
    examSentence = getSentence;
    
    nowType = type;
    nowId = _id;
}

-(void)labelInit{
    label[0] = questionLabel;
    label[1] = answerLabel01;
    label[2] = answerLabel02;
    label[3] = answerLabel03;
    label[4] = answerLabel04;
    
}

- (IBAction)saveExam:(id)sender {
    [self saveRepository:1];
    [self dismissModalViewControllerAnimated:dismissType];
    if (!dismissType) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ocr_dismiss" object:nil];
    }
}

-(void)saveOX{
    [self saveRepository:2];
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
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    int year = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"MM"];
    int month = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"dd"];
    int day = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    NSString *tempMonth = @"";
    NSString *tempDay = @"";
    if (month < 10) {
        tempMonth = [NSString stringWithFormat:@"0%d",month];
    }else{
        tempMonth = [NSString stringWithFormat:@"%d",month];
    }
    
    if (day < 10) {
        tempDay = [NSString stringWithFormat:@"0%d",day];
    }else{
        tempDay = [NSString stringWithFormat:@"%d",day];
    }
    
    NSString *date =[NSString stringWithFormat:@"%d%@%@",year,tempMonth,tempDay];
    
    int ox = 0;
    
    NSString *result;
    
    if ([[pArray objectAtIndex:5] intValue] == c) {
        ox = 0;
        result = @"정답입니다.";
        [dbMsg vocaXUpdate:label[c].text :true];
        
        if (!checkState) {
            [dbMsg logUpdate:date :@"problem" :true];
            checkState = true;
        }
    }else{
        ox = 1;
        result = @"틀렸습니다.";
        [dbMsg vocaXUpdate:label[c].text :false];
        if (!checkState) {
            [dbMsg logUpdate:date :@"problem" :false];
            checkState = true;
        }
    }
    
    if (nowType == 0 || ox == 1) {
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



- (void)saveRepository:(int)type{
    
    //    sid = [dbMsg saveRSentence:bName :@"000000" :1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    int year = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"MM"];
    int month = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"dd"];
    int day = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    NSString *date =[NSString stringWithFormat:@"%d%d%d",year,month,day];

    sid = [dbMsg saveRSentence:exam2 :date :type];
    qid = [dbMsg saveRQuestion:sid :questionLabel.text :1];
    
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
    [webView loadHTMLString:sentence baseURL:nil];

    //    NSLog(@"%d",sentenceTextView.)
    //    [sentenceTextView setText:[dbMsg getExamSentence:examId]];
    //    [sentenceTextView setEditable:NO];
}

- (void)setTexts:(int)poz{
    
    if (poz == 0) {
        check = [[pArray objectAtIndex:5] intValue];
        
        for (int i = 0; i < 5; i++) {
            if (check == i && nowType == 2) {
                [label[i] setTextColor:[UIColor redColor]];
            }
            [label[i] setText:[pArray objectAtIndex:i]];
        }
    }else{
        check = [[pArray objectAtIndex:poz * 5 + 6] intValue];
        
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

- (NSMutableArray *)setMakeExam:(NSString *)msg:(int)class1:(int)class2 {
    
    NSMutableArray *eArray = [NSMutableArray arrayWithCapacity:0];
    
    
    // 문제 생성
    std::string str([msg UTF8String]);
    
    Tokenizer tokenizer(str);
    tokenizer.run();
    
    SimpleProblemMaker *prob = new SimpleProblemMaker(tokenizer);
    prob->makeProblem(1, 1);
    
    // 지문
    std::string str_ji = prob->getProblemContent().c_str();
    originJimoon = [NSString stringWithUTF8String:str_ji.c_str()];
    
    [self setSentence: [NSString stringWithUTF8String:JimoonMaker::getHTMLJimoon(str_ji).c_str()]];
    
    
    // 문제
    std::vector<Problem> problems = prob->getProblems();
    
    Problem nowProb = problems[0];
    
    [eArray insertObject:[NSString stringWithUTF8String:nowProb.pcontent.c_str()] atIndex:0];
    
    // 문제 항목
    for (int i=0; i<4; i++)
    {
        NSString *strprobitem = [NSString stringWithUTF8String:nowProb.items[i].qcontent.c_str()];
        
        [eArray insertObject:strprobitem atIndex:i+1];
    }
    
    // 정답 번호
    [eArray insertObject:[NSNumber numberWithInt:nowProb.solution] atIndex:5];
    
    delete prob;
    
    // 문자열 문제만들기
    std::ostringstream oss;
    oss << JimoonMaker::getSTRJimoon(str_ji) << std::endl << std::endl;
    oss << nowProb.pcontent << std::endl;
    for (int i=0; i<4; i++)
    {
        oss << nowProb.items[i].qcontent << std::endl;
    }
    
    exam = [NSString stringWithUTF8String:oss.str().c_str()];
    exam2 = sText;
    [self setSentence:sText];
    
    return eArray;
}

- (NSMutableArray *)getRepository{
    NSMutableArray *returnArrray = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *problemArray = [dbMsg getRQuestion:nowId];
    
    NSArray *itemArray = [dbMsg getRAnswer:[[problemArray objectAtIndex:0] intValue]];
    
    [returnArrray insertObject:[problemArray objectAtIndex:1] atIndex:0];
    
    [returnArrray insertObject:[itemArray objectAtIndex:1] atIndex:1];
    [returnArrray insertObject:[itemArray objectAtIndex:4] atIndex:2];
    [returnArrray insertObject:[itemArray objectAtIndex:7] atIndex:3];
    [returnArrray insertObject:[itemArray objectAtIndex:10] atIndex:4];
    
    int checkNum;
    
    if ([[itemArray objectAtIndex:2] intValue] == 1) {
        checkNum = 1;
    }else if ([[itemArray objectAtIndex:5] intValue] == 1) {
        checkNum = 2;
    }else if ([[itemArray objectAtIndex:8] intValue] == 1) {
        checkNum = 3;
    }else if ([[itemArray objectAtIndex:11] intValue] == 1) {
        checkNum = 4;
    }
    [returnArrray insertObject:[NSNumber numberWithInt:checkNum] atIndex:5];
    
    [self setSentence:examSentence];
    
    
    return returnArrray;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self naviEvent];
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self saveOX];
    }
}

- (void)setDIsType:(BOOL)type{
    dismissType = type;
}

- (IBAction)messageSend:(id)sender {
    MFMessageComposeViewController *smsController = [[MFMessageComposeViewController alloc] init];
    smsController.messageComposeDelegate = self;
    if([MFMessageComposeViewController canSendText])
    {
        smsController.body = exam;
        smsController.recipients = nil;
        smsController.messageComposeDelegate = self;
        [self presentModalViewController:smsController animated:YES];
    }
}

- (IBAction)kakaoSend:(id)sender {
    if (![KakaoLinkCenter canOpenKakaoLink]) {
        return;
    }
    
    NSMutableArray *metaInfoArray = [NSMutableArray array];
    
    NSDictionary *metaInfoAndroid = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"android", @"os",
                                     @"phone", @"devicetype",
                                     @"market://details?id=com.kakao.talk", @"installurl",
                                     @"example://example", @"executeurl",
                                     nil];
    
    NSDictionary *metaInfoIOS = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"ios", @"os",
                                 @"phone", @"devicetype",
                                 @"http://itunes.apple.com/app/id362057947?mt=8", @"installurl",
                                 @"example://example", @"executeurl",
                                 nil];
    
    [metaInfoArray addObject:metaInfoAndroid];
    [metaInfoArray addObject:metaInfoIOS];
    

    [KakaoLinkCenter openKakaoLinkWithURL:@"" appVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] appBundleID:[[NSBundle mainBundle] bundleIdentifier] appName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"] message:exam];

}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultCancelled) {
        [self dismissModalViewControllerAnimated:YES];
    }else if (result == MessageComposeResultSent) {
        [self dismissModalViewControllerAnimated:YES];
    }
}
@end
