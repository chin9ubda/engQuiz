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
    EduViewController *eduView = [[EduViewController alloc]init];
    
    [eduView setVocaArray:vArray];
    [self presentModalViewController:eduView animated:YES];
}

-(void) searchEvent{
    if ([searchMsg.text isEqualToString:@""]) {
        [self setAllVocaData];
    }else {
        vArray = [dbMsg searchVoca:searchMsg.text];
        cellCount = vArray.count / 4;
    }
    [self keyBoardDown];
    [vocaTable reloadData];
}

- (void)setAllVocaData{
    vArray = [dbMsg getVocaData];
    
    cellCount = vArray.count / 4;
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
        if ([[vArray objectAtIndex:3]integerValue] == 1)
            vocaCell.classLabel.text = @"중";
        else if([[vArray objectAtIndex:3]integerValue] == 2)
            vocaCell.classLabel.text = @"고";
        else
            vocaCell.classLabel.text = @"기";
    }else{
        vocaCell.wordLabel.text = [vArray objectAtIndex:index * 4];
        vocaCell.meanLabel.text = [vArray objectAtIndex:index * 4 + 1];
        if ([[vArray objectAtIndex:index * 4 + 3]integerValue] == 1)
            vocaCell.classLabel.text = @"중";
        else if([[vArray objectAtIndex:index * 4 + 3]integerValue] == 2)
            vocaCell.classLabel.text = @"고";
        else
            vocaCell.classLabel.text = @"기";
    }

    return vocaCell;
}




// ---------------- Section Count Setting ---------------- //

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return cellCount;
}



// ---------------- Cell Select Event ---------------- //


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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


- (void)viewDidUnload {
    vocaTable = nil;
    searchMsg = nil;
    [super viewDidUnload];
}
@end
