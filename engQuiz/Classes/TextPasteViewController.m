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
    [super viewDidLoad];
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
    NSError *error   = nil;
//    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@".+@.+" options:0 error:&error];
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
    
    [dbMsg saveSentence:[NSString stringWithFormat:@"%@",textView.text] :@"000000" :@"filename"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bookTableReload" object:nil];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    textView = nil;
    [super viewDidUnload];
}
@end
