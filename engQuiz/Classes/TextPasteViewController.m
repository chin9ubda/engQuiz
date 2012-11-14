//
//  TextPasteViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 10..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "TextPasteViewController.h"

@interface TextPasteViewController ()

@end

@implementation TextPasteViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTextViewSize:) name:UIKeyboardWillShowNotification object:nil];
    [textView becomeFirstResponder];
    [super viewDidLoad];
    
//    if (textCheck != 0) {
//        textView.text = text;
//    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnEvent:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveBtnEvent:(id)sender {
    [self saveEvent];
}

//- (void)setText:(NSString *)_text{
//    textCheck = 1;
//    text = _text;
//}


-(void)saveEvent{
    NSError *error   = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9:space:]" options:0 error:&error];
    NSString *temp = textView.text;
    NSString *resultSentence = @"";
    for (int i = 0; i < temp.length; i++) {
        NSTextCheckingResult *match = [regexp firstMatchInString:[temp substringWithRange:(NSRange){i,1}] options:0 range:NSMakeRange(0, [temp substringWithRange:(NSRange){i,1}].length)];
        if(match.numberOfRanges!=0){
            resultSentence = [NSString stringWithFormat:@"%@%@",resultSentence,[temp substringWithRange:(NSRange){i,1}]];
            
        }else if([[temp substringWithRange:(NSRange){i,1}] isEqualToString:@"\n"]||
                 [[temp substringWithRange:(NSRange){i,1}] isEqualToString:@" "]){
            resultSentence = [NSString stringWithFormat:@"%@%@",resultSentence,[temp substringWithRange:(NSRange){i,1}]];
        }
    }
    
    textView.text = resultSentence;
    
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
    
    [dbMsg saveSentence:[NSString stringWithFormat:@"%@",textView.text] :date :@"filename"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bookTableReload" object:nil];
    [self dismissModalViewControllerAnimated:YES];
}

/* ----------------------------------------
 Keyboard 높이만큼 TextView 의 사이즈 변경
 ---------------------------------------- */
-(void)setTextViewSize:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [textView setFrame:CGRectMake(0, 0, textView.frame.size.width, textView.frame.size.height - kbSize.height)];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    //textView에 어느 글을 쓰더라도 이 메소드를 호출합니다.
    if ([text isEqualToString:@"\n"]) {
        // return키를 누루면 원래 줄바꿈이 일어나므로 \n을 입력하는데 \n을 입력하면 실행하게 합니다.
        [self saveEvent];
        return FALSE; //리턴값이 FALSE이면, 입력한 값이 입력되지 않습니다.
    }
    return TRUE; //평소에 경우에는 입력을 해줘야 하므로, TRUE를 리턴하면 TEXT가 입력됩니다.
}


- (void)viewDidUnload {
    textView = nil;
    [super viewDidUnload];
}
@end
