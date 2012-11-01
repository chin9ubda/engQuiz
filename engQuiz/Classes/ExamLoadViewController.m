//
//  ExamLoadViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "ExamLoadViewController.h"
#import "SentenceViewController.h"
#import "ThemeCell.h"

@interface ExamLoadViewController ()

@end

@implementation ExamLoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

- (IBAction)publisherSelect:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"출판사"
                                       message:@"\n\n\n\n\n\n\n"
                                      delegate:nil
                             cancelButtonTitle:@"Cancel"
                             otherButtonTitles:nil, nil];
    
    UITableView *myView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 264, 150)];
    
    pArray = [dbMsg getPublisherIds];
    
    tableCellCount = pArray.count + 1;
    myView.tag = 1;
    myView.delegate = self;
    myView.dataSource = self;
    [alert addSubview:myView];
    
    [alert show];
}

- (IBAction)classSelect:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"학교"
                                       message:@"\n\n\n\n\n\n\n"
                                      delegate:nil
                             cancelButtonTitle:@"Cancel"
                             otherButtonTitles:nil, nil];
    
    UITableView *myView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 264, 150)];
    
    tableCellCount = 3;
    myView.tag = 2;
    myView.delegate = self;
    myView.dataSource = self;
    [alert addSubview:myView];
    
    [alert show];
}

- (IBAction)numberSelect:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"학년"
                                       message:@"\n\n\n\n\n\n\n"
                                      delegate:nil
                             cancelButtonTitle:@"Cancel"
                             otherButtonTitles:nil, nil];
    
    UITableView *myView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 264, 150)];
    
    tableCellCount = 4;
    myView.tag = 3;
    myView.delegate = self;
    myView.dataSource = self;
    [alert addSubview:myView];
    
    [alert show];
}

- (IBAction)searchEvent:(id)sender {
    bArray = [dbMsg getBookIds:pNumber:cNumber:sNumber];
    tableCellCount = bArray.count;
    
    bookTable.tag = 0;
    
    [bookTable reloadData];    
}


#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = [indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if (tableView.tag == 0) {
        cell.textLabel.text = [dbMsg getBookName:[[bArray objectAtIndex:index]integerValue]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        
    }
    
    else if (tableView.tag == 1) {
        if (index == 0) {
            cell.textLabel.text = @"전체";
        }else{
            cell.textLabel.text = [dbMsg getPublisherName:[[pArray objectAtIndex:index-1]integerValue]];
        }
    }
    
    else if (tableView.tag == 2) {
        
        switch (index) {
                
            case 0:
                cell.textLabel.text = @"전체";
                break;
            case 1:
                cell.textLabel.text = @"중학교";
                break;
                
            case 2:
                cell.textLabel.text = @"고등학교";
                break;
                
            default:
                break;
        }
    }
    
    else if (tableView.tag == 3) {
        
        switch (index) {
            case 0:
                cell.textLabel.text = @"전체";
                break;
                
            case 1:
                cell.textLabel.text = @"1 학년";
                break;
                
            case 2:
                cell.textLabel.text = @"2 학년";
                break;
                
            case 3:
                cell.textLabel.text = @"3 학년";
                break;
                
            default:
                break;
        }
    }
    
    else if (tableView.tag == 4) {
        
        //        cell.textLabel.text = [dbMsg getPublisherName:[[tArray objectAtIndex:index]integerValue]];
        
        //        cell = [[ThemeCell alloc]init];
        
        examArray = [dbMsg getExamTheme:[[tArray objectAtIndex:index]integerValue]];
        
        ThemeCell *themeCell = [[ThemeCell alloc]init];
        
        themeCell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
        if(themeCell == nil){
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ThemeCell" owner:nil options:nil];
            
            themeCell = [array objectAtIndex:0];
            
            themeCell.themeLabel.text = [examArray objectAtIndex:0];
            themeCell.pageNum.text = [NSString stringWithFormat:@"%@p",[examArray objectAtIndex:1]];
        }
        return themeCell;
    }
    
    return cell;
}




// ---------------- Section Count Setting ---------------- //

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return tableCellCount;
}



// ---------------- Cell Select Event ---------------- //


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = [indexPath row];
    
    if (tableView.tag == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"선택"
                                           message:@"\n\n\n\n\n\n\n"
                                          delegate:nil
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:nil, nil];
        
        UITableView *myView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 264, 150)];
        
        tArray = [dbMsg getExamIds:[[bArray objectAtIndex:index]integerValue]];
        tableCellCount = tArray.count;
        myView.tag = 4;
        myView.delegate = self;
        myView.dataSource = self;
        [alert addSubview:myView];
        
        [alert show];
    }else{
        if (tableView.tag == 1) {
            if (index == 0) {
                pNumber = index;
                [publisherName setTitle: @"전체" forState:UIControlStateNormal];
            }else {
                pNumber = [[pArray objectAtIndex:index-1]integerValue];
                [publisherName setTitle:[dbMsg getPublisherName:pNumber] forState:UIControlStateNormal];
            }
        }
        
        else if (tableView.tag == 2) {
            
            switch (index) {
                case 0:
                    cNumber = index;
                    [className setTitle: @"전체" forState:UIControlStateNormal];
                    break;
                    
                case 1:
                    cNumber = index;
                    [className setTitle: @"중학교" forState:UIControlStateNormal];
                    break;
                    
                case 2:
                    cNumber = index;
                    [className setTitle: @"고등학교" forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
        }
        
        else if (tableView.tag == 3) {
            
            switch (index) {
                case 0:
                    sNumber = index;
                    [classNumber setTitle: @"전체" forState:UIControlStateNormal];
                    break;
                    
                case 1:
                    sNumber = index;
                    [classNumber setTitle: @"1 학년" forState:UIControlStateNormal];
                    break;
                    
                case 2:
                    sNumber = index;
                    [classNumber setTitle: @"2 학년" forState:UIControlStateNormal];
                    break;
                    
                case 3:
                    sNumber = index;
                    [classNumber setTitle: @"3 학년" forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
        }
        
        else if (tableView.tag == 4) {
            
            SentenceViewController *sentenceVeiw = [[SentenceViewController alloc]init];
            
            examArray = [dbMsg getExamTheme:[[tArray objectAtIndex:index]integerValue]];
            [sentenceVeiw setInit:[examArray objectAtIndex:0] :[NSString stringWithFormat:@"%@p",[examArray objectAtIndex:1]]:[[tArray objectAtIndex:index]integerValue]];
            
            [self presentModalViewController:sentenceVeiw animated:YES];
            
        }
        [self disAlert];
    }
}

- (void)disAlert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)viewDidUnload {
    publisherName = nil;
    className = nil;
    classNumber = nil;
    //    [self setSearchEvent:nil];
    bookTable = nil;
    [super viewDidUnload];
}


@end
