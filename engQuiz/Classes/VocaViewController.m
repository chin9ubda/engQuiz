//
//  VocaViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "VocaViewController.h"
#import "VocaCell.h"
#import "EduViewController.h"
#import "ExSentence.h"

@interface VocaViewController ()

@end

@implementation VocaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dbMsg = [DataBase getInstance];
        [self setAllVocaData];
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

- (IBAction)searchBtnEvent:(id)sender {
    [self searchEvent];
}

- (IBAction)eduBtnEvent:(id)sender {
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"취소"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"틀린 단어 위주", @"순서대로",@"단어",@"숙어", nil];
    [actionsheet showInView:self.view];
}

-(void) searchEvent{
    if ([searchMsg.text isEqualToString:@""]) {
        [self setAllVocaData];
    }else {
        vArray = [dbMsg searchVoca:searchMsg.text];
//        cellCount = vArray.count / 4;
    }
    [self keyBoardDown];
    [vocaTable reloadData];
    [vocaTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)setAllVocaData{
    vArray = [dbMsg getVocaData:0:3];
    
//    cellCount = vArray.count / 4;
}


#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = [indexPath row];
    
    VocaCell *vocaCell = [[VocaCell alloc]init];
    
    vocaCell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if(vocaCell == nil){
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VocaCell" owner:nil options:nil];
        
        vocaCell = [array objectAtIndex:0];

    }

    
    if (index == 0) {
        vocaCell.wordLabel.text = [vArray objectAtIndex:0];
        vocaCell.meanLabel.text = [vArray objectAtIndex:1];
        if ([[vArray objectAtIndex:2]integerValue] == 1)
            vocaCell.classLabel.text = @"중";
        else if([[vArray objectAtIndex:2]integerValue] == 2)
            vocaCell.classLabel.text = @"고";
        else
            vocaCell.classLabel.text = @"기";
    }else if (index <= vArray.count / 4 - 1){
        vocaCell.wordLabel.text = [vArray objectAtIndex:index * 4];
        vocaCell.meanLabel.text = [vArray objectAtIndex:index * 4 + 1];
        if ([[vArray objectAtIndex:index * 4 + 2]integerValue] == 1)
            vocaCell.classLabel.text = @"중";
        else if([[vArray objectAtIndex:index * 4 + 2]integerValue] == 2)
            vocaCell.classLabel.text = @"고";
        else
            vocaCell.classLabel.text = @"기";
    }

    return vocaCell;
}




// ---------------- Section Count Setting ---------------- //

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return vArray.count / 4;
}



// ---------------- Cell Select Event ---------------- //


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index = [indexPath row];
    
    if (eSentence != nil) {
        [eSentence removeFromSuperview];
        eSentence = nil;
    }
    
    eSentence = [[ExSentence alloc]init];
    
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"exSentence" owner:self options:nil];
    eSentence = (ExSentence *)[xibs objectAtIndex:0];
    [eSentence awakeFromNib];
    
    eSentence.frame = CGRectMake(0, 40, 320, 300);
    
    if (index == 0) {
        [eSentence setWord:[vArray objectAtIndex:0]:[vArray objectAtIndex:1]];
    }else if (index <= vArray.count / 4 - 1){
        [eSentence setWord:[vArray objectAtIndex:index *4]:[vArray objectAtIndex:index *4 + 1]];
    }
    
    
    [self.view addSubview:eSentence];

}


// --------- TextField BeginEditing --------- //


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardDown)];
    [self.view addGestureRecognizer:tap];
    
    return YES;
}


// -------- TextField EndEditing -------- //


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self searchEvent];
    return true;
}

-(void)keyBoardDown{
    
    [searchMsg resignFirstResponder];
    [self.view removeGestureRecognizer:tap];    
}


#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        EduViewController *eduView = [[EduViewController alloc]init];
        
        if (buttonIndex == 0) {
            NSLog(@"틀린 단어 위주");
            [eduView setVocaArray:[dbMsg getVocaData:0:3]];
        }else if(buttonIndex == 1){
            NSLog(@"순서대로");
            [eduView setVocaArray:vArray];
        }else if(buttonIndex == 2){
            NSLog(@"단어");
            [eduView setVocaArray:[dbMsg getVocaData:1:0]];
        }else if(buttonIndex == 3){
            NSLog(@"숙어");
            [eduView setVocaArray:[dbMsg getVocaData:2:0]];
        }
        
        [self presentModalViewController:eduView animated:YES];
    }
}

#pragma mark UITabber Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    switch ([item tag] ) {
        case 0:
            vArray = [dbMsg getVocaData:0:3];
            break;
        case 1:
            vArray = [dbMsg getVocaData:0:1];
            break;
        case 2:
            vArray = [dbMsg getVocaData:0:3];
            break;
        case 3:
            vArray = [dbMsg getVocaData:1:3];
            break;
        case 4:
            vArray = [dbMsg getVocaData:2:3];
            break;
        default:
            break;
    }
    
    [vocaTable reloadData];
    [vocaTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
//    NSLog(@"check : %d",[item tag]);
}

- (void)viewDidUnload {
    vocaTable = nil;
    searchMsg = nil;
    tabbalContoller = nil;
    [super viewDidUnload];
}
@end
