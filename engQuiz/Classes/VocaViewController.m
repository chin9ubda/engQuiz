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
        collation = [UILocalizedIndexedCollation currentCollation];
        [self setAllVocaData];
    }
    return self;
}

- (void)viewDidLoad
{
    

//    NSLog(@"%d",[[collation sectionTitles] count]);
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
    
    NSString *tempSerchMsg = searchMsg.text;
    int section = 0;
    int index = 0;
    if ([tempSerchMsg isEqualToString:@""]) {
        [self setAllVocaData];
    }else {
        NSArray * tempArray = [dbMsg searchVoca:tempSerchMsg:type:check];
        if (tempArray.count != 0) {
            for (int i = 0; i < muArray.count; i++) {
                if ([[muArray objectAtIndex:i]isEqual:[tempSerchMsg substringWithRange:(NSRange){0,1}]]) {
                    section = i;
                    break;
                }
            }
            for (int i = 0; i < vArray[section].count; i+= 4) {
                if ([[vArray[section] objectAtIndex:i]isEqual:[tempArray objectAtIndex:0]]) {
                    index = i / 4;
                    break;
                }
            }
        }
    }
    [self keyBoardDown];
//    [vocaTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
    
    [vocaTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)setAllVocaData{
    muArray = nil;
    muArray = [NSMutableArray arrayWithCapacity:0];
    
    type = 0;
    check = 3;
    
    [self tableReload];
    for (int i = 0; i < [muArray count] - 1; i++) {
        vArray[i] = [dbMsg searchVoca:[muArray objectAtIndex:i]:0:3];
    }
}


#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = [indexPath row];
    int section = [indexPath section];
    
    VocaCell *vocaCell = [[VocaCell alloc]init];
    
    vocaCell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if(vocaCell == nil){
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VocaCell" owner:nil options:nil];
        
        vocaCell = [array objectAtIndex:0];

    }

    if (index == 0) {
        vocaCell.wordLabel.text = [vArray[section] objectAtIndex:0];
        vocaCell.meanLabel.text = [vArray[section] objectAtIndex:1];
        if ([[vArray[section] objectAtIndex:2]integerValue] == 1)
            vocaCell.classLabel.text = @"중";
        else if([[vArray[section] objectAtIndex:2]integerValue] == 2)
            vocaCell.classLabel.text = @"고";
        else
            vocaCell.classLabel.text = @"기";
    }else{
        vocaCell.wordLabel.text = [vArray[section] objectAtIndex:index * 4];
        vocaCell.meanLabel.text = [vArray[section] objectAtIndex:index * 4 + 1];
        if ([[vArray[section] objectAtIndex:index * 4 + 2]integerValue] == 1)
            vocaCell.classLabel.text = @"중";
        else if([[vArray[section] objectAtIndex:index * 4 + 2]integerValue] == 2)
            vocaCell.classLabel.text = @"고";
        else
            vocaCell.classLabel.text = @"기";
    }

    return vocaCell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return muArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
//    return [[collation sectionTitles] objectAtIndex:section];
    return [muArray objectAtIndex:section];
}



// ---------------- Section Count Setting ---------------- //

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return vArray[section].count / 4;
}



// ---------------- Cell Select Event ---------------- //


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index = [indexPath row];
    int section = [indexPath section];
    
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
        [eSentence setWord:[vArray[section] objectAtIndex:0]:[vArray[section] objectAtIndex:1]];
    }else{
        [eSentence setWord:[vArray[section] objectAtIndex:index *4]:[vArray[section] objectAtIndex:index *4 + 1]];

    }
    
    [self.view addSubview:eSentence];

}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return muArray;
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
//            [eduView setVocaArray:vArray];
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
            type = 0;
            check = 3;
            break;
        case 1:
            type = 0;
            check = 1;
            break;
        case 2:
            type = 0;
            check = 3;

            break;
        case 3:
            type = 1;
            check = 3;

            break;
        case 4:
            type = 2;
            check = 3;

            break;
        default:
            break;
    }
    
    [self tableReload];
    [vocaTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)tableReload{
    int count = 0;
    
    [muArray removeAllObjects];
    
    for (int i = 0; i < [[collation sectionIndexTitles] count] - 1; i++) {
        
        if ([dbMsg searchVoca:[[collation sectionIndexTitles] objectAtIndex:i] :type :check].count != 0) {
            
            vArray[count] = [dbMsg searchVoca:[[collation sectionIndexTitles] objectAtIndex:i] :type :check];
        [muArray insertObject:[[collation sectionIndexTitles] objectAtIndex:i] atIndex:count];
        count++;
        }
    }
    [vocaTable reloadData];

}

- (void)viewDidUnload {
    vocaTable = nil;
    searchMsg = nil;
    tabbalContoller = nil;
    [super viewDidUnload];
}
@end
