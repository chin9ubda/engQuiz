//
//  RepositoryViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "RepositoryViewController.h"
#import "SentenceViewController.h"

@interface RepositoryViewController ()

@end

@implementation RepositoryViewController

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

- (void)reLoadTable{
    
    if(rAndi.selectedSegmentIndex == 0)
        rArray = [dbMsg getRSentenceData:1];
    if(rAndi.selectedSegmentIndex == 1)
        rArray = [dbMsg getRSentenceData:2];
    cellCount = rArray.count/2;
    
    NSLog(@"count :::  %d selected ::: %d",rArray.count, rAndi.selectedSegmentIndex);
    [rTableView reloadData];
}

- (IBAction)segmentedselectedEvent:(id)sender {
    [self reLoadTable];
}


#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = [indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    

    if (index == 0) {
        cell.textLabel.text = [rArray objectAtIndex:1];
    }else {
        cell.textLabel.text = [rArray objectAtIndex:(index * 2) - 1];
    }
    
    return cell;
}




// ---------------- Section Count Setting ---------------- //

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return cellCount;
}



// ---------------- Cell Select Event ---------------- //


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = [indexPath row];
    
    SentenceViewController *sentenceVeiw = [[SentenceViewController alloc]init];
    
    if (index == 0) {
        [sentenceVeiw setInit:@"보관함":[rArray objectAtIndex:1]];
    }else {
        [sentenceVeiw setInit:@"보관함":[rArray objectAtIndex:(index * 2) - 1]];
    }
    
    [self presentModalViewController:sentenceVeiw animated:YES];
}




- (void)viewDidUnload {
    rTableView = nil;
    rAndi = nil;
    [super viewDidUnload];
}
@end
