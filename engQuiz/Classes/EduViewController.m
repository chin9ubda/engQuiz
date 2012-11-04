//
//  EduViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 4..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "EduViewController.h"

@interface EduViewController ()

@end

@implementation EduViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setEduText:nowPoz];
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

- (void)setVocaArray:(NSMutableArray *)getArray{
    vArray = getArray;
}

- (IBAction)lastWordBtnEvent:(id)sender {
    nowPoz--;
    [self setEduText:nowPoz];
}

- (IBAction)nextWordBtnEvent:(id)sender {
    nowPoz++;
    [self setEduText:nowPoz];
}

- (IBAction)meanBtnEvent:(id)sender {
    [meanBtn setHidden:YES];
}

- (void)setEduText:(int)poz{
    if (poz == 0) {
        wordLabel.text = [vArray objectAtIndex:0];
        meanLabel.text = [vArray objectAtIndex:1];
        
        
        [lastWordBtn setEnabled:NO];
        [nextWordBtn setEnabled:YES];
        
//        if ([[vArray objectAtIndex:3]integerValue] == 1)
//            vocaCell.classLabel.text = @"중";
//        else if([[vArray objectAtIndex:3]integerValue] == 2)
//            vocaCell.classLabel.text = @"고";
//        else
//            vocaCell.classLabel.text = @"기";
    }else{
        wordLabel.text = [vArray objectAtIndex:poz * 4];
        meanLabel.text = [vArray objectAtIndex:poz * 4 + 1];
        if(poz == vArray.count/4){
            [lastWordBtn setEnabled:YES];
            [nextWordBtn setEnabled:NO];
        }else{
            [lastWordBtn setEnabled:YES];
            [nextWordBtn setEnabled:YES];
        }
//        if ([[vArray objectAtIndex:index * 4 + 3]integerValue] == 1)
//            vocaCell.classLabel.text = @"중";
//        else if([[vArray objectAtIndex:index * 4 + 3]integerValue] == 2)
//            vocaCell.classLabel.text = @"고";
//        else
//            vocaCell.classLabel.text = @"기";
    }
    
    [meanBtn setHidden:NO];
}

- (void)viewDidUnload {
    wordLabel = nil;
    meanLabel = nil;
    lastWordBtn = nil;
    nextWordBtn = nil;
    meanBtn = nil;
    [super viewDidUnload];
}
@end