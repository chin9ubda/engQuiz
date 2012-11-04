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


#define BookTableTag 1
#define ChapterTableTag 2
#define ThemeTableTag 3


#define PublicTag 11
#define Class1Tag 12
#define Class2Tag 13


@interface ExamLoadViewController ()

@end

@implementation ExamLoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dbMsg = [DataBase getInstance];
        bCell = [[BookListCell alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{    [chapterTable setHidden:YES];
    [themeTable setHidden:YES];
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
    myView.tag = PublicTag;
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
    myView.tag = Class1Tag;
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
    myView.tag = Class2Tag;
    myView.delegate = self;
    myView.dataSource = self;
    [alert addSubview:myView];
    
    [alert show];
}

- (IBAction)searchEvent:(id)sender {
    
//    [chapterTable setFrame:CGRectMake(320, chapterTable.frame.origin.y, chapterTable.frame.size.width, chapterTable.frame.size.height)];
//    [themeTable setFrame:CGRectMake(380, themeTable.frame.origin.y, themeTable.frame.size.width, themeTable.frame.size.height)];
//
//    bookNumber = 0;
//    chapterNumber = 0;
//    
//    bArray = [dbMsg getBookIds:pNumber:cNumber:sNumber];
//    tableCellCount = bArray.count;
//    
//    [bookTable reloadData];    
}


#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = [indexPath row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if (tableView.tag == BookTableTag) {
        
        cell.textLabel.text = [dbMsg getBookName:[[bArray objectAtIndex:index]integerValue]];
        
    }
    
    else if (tableView.tag == ChapterTableTag) {
        if (index == 0) {
            cell.textLabel.text = [cArray objectAtIndex:1];
        }else {
            cell.textLabel.text = [cArray objectAtIndex:index * 2 + 1];
        }
    }

    else if (tableView.tag == ThemeTableTag) {
        if (index == 0) {
            cell.textLabel.text = [tArray objectAtIndex:1];
        }else {
            cell.textLabel.text = [tArray objectAtIndex:index * 2 + 1];
        }
    }

    else if (tableView.tag == PublicTag) {
        if (index == 0) {
            cell.textLabel.text = @"전체";
        }else{
            cell.textLabel.text = [dbMsg getPublisherName:[[pArray objectAtIndex:index-1]integerValue]];
        }
    }
    
    else if (tableView.tag == Class1Tag) {
        
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
    
    else if (tableView.tag == Class2Tag) {
        
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
    
    return cell;
}




// ---------------- Section Count Setting ---------------- //

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return tableCellCount;
    if (tableView.tag == PublicTag) {
        return pArray.count + 1;
    }else if (tableView.tag == Class1Tag) {
        return 3;
    }else if (tableView.tag == Class2Tag) {
        return 3;
    }else if ( tableView.tag == BookTableTag) {
        return bArray.count;
    }else if ( tableView.tag == ChapterTableTag) {
        return cArray.count / 2;
    }else if ( tableView.tag == ThemeTableTag) {
        return tArray.count / 2;
    }
    
    return 0;
}



// ---------------- Cell Select Event ---------------- //


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = [indexPath row];
    
    if (tableView.tag == BookTableTag) {
        if (bookNumber == index + 1) {
            [cArray removeAllObjects];
            [self tableRePoz:2];
        }else{
            bookNumber = index + 1;
            [cArray removeAllObjects];
            cArray = [dbMsg getChapterData:[[bArray objectAtIndex:index]integerValue]];
            if (cArray.count != 0) {
                [chapterTable setHidden:NO];
                [self moveView2:chapterTable duration:0.3 curve: UIViewAnimationCurveLinear x:80];
            }else{
                [self tableRePoz:2];
            }
            [chapterTable reloadData];
        }
        [bookTable reloadData];
    }else if ( tableView.tag == ChapterTableTag) {
        if (chapterNumber == index + 1) {
            [tArray removeAllObjects];
            [self tableRePoz:1];
        }else{
            chapterNumber = index + 1;
            [tArray removeAllObjects];
            tArray = [dbMsg getThemeData:[[cArray objectAtIndex:index]integerValue]];
            if (tArray.count != 0) {
                [themeTable setHidden:NO];
                [self moveView2:themeTable duration:0.3 curve: UIViewAnimationCurveLinear x:140];
            }else{
                [self tableRePoz:1];
            }
            [themeTable reloadData];
        }
        [bookTable reloadData];
    }else if ( tableView.tag == ThemeTableTag){
        SentenceViewController *sentenceVeiw = [[SentenceViewController alloc]init];
        
        if (index == 0) {
            [sentenceVeiw setInit:[dbMsg getBookName:[[bArray objectAtIndex:bookNumber - 1]integerValue]]:[[tArray objectAtIndex:0]integerValue]];
        }else {
            [sentenceVeiw setInit:[dbMsg getBookName:[[bArray objectAtIndex:bookNumber - 1]integerValue]]:[[tArray objectAtIndex:index * 2]integerValue]];
        }
        
        [self presentModalViewController:sentenceVeiw animated:YES];
    }
    else{
        if (tableView.tag == PublicTag) {
            if (index == 0) {
                pNumber = index;
                [publisherName setTitle: @"전체" forState:UIControlStateNormal];
            }else {
                pNumber = [[pArray objectAtIndex:index-1]integerValue];
                [publisherName setTitle:[dbMsg getPublisherName:pNumber] forState:UIControlStateNormal];
            }
        }
        
        else if (tableView.tag == Class1Tag) {
            
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
        
        else if (tableView.tag == Class2Tag) {
            
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
        [self disAlert];
    }
}

- (void)tableRePoz:(int)type{
    switch (type) {
        case 0:
            bookNumber = 0;
            [self moveView2:chapterTable duration:0.1 curve: UIViewAnimationCurveLinear x:320];
            break;
        case 1:
            chapterNumber = 0;
            [self moveView2:themeTable duration:0.1 curve: UIViewAnimationCurveLinear x:380];
            break;
        case 2:
            bookNumber = 0;
            chapterNumber = 0;
            [self moveView2:chapterTable duration:0.1 curve: UIViewAnimationCurveLinear x:320];
            [self moveView2:themeTable duration:0.1 curve: UIViewAnimationCurveLinear x:380];
            break;
        default:
            break;
    }
}

- (void)disAlert{
    [chapterTable setFrame:CGRectMake(320, chapterTable.frame.origin.y, chapterTable.frame.size.width, chapterTable.frame.size.height)];
    [themeTable setFrame:CGRectMake(380, themeTable.frame.origin.y, themeTable.frame.size.width, themeTable.frame.size.height)];
    
    [chapterTable setHidden:YES];
    [themeTable setHidden:YES];

//    [self moveView2:chapterTable duration:0 curve: UIViewAnimationCurveLinear x:320];
//    [self moveView2:themeTable duration:0 curve: UIViewAnimationCurveLinear x:380];
    
    [alert dismissWithClickedButtonIndex:0 animated:YES];
//    [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:NO];

    bookNumber = 0;
    chapterNumber = 0;
    
    bArray = [dbMsg getBookIds:pNumber:cNumber:sNumber];
    tableCellCount = bArray.count;
    
    [bookTable reloadData];
}

- (void)viewDidUnload {
    publisherName = nil;
    className = nil;
    classNumber = nil;
    //    [self setSearchEvent:nil];
    bookTable = nil;
    chapterTable = nil;
    themeTable = nil;
    [super viewDidUnload];
}


// ---------------- MoveView ---------------- //
/* ------------------------------------------
 View Move Animation
 ------------------------------------------ */

- (void)moveView:(UIView *)view duration:(NSTimeInterval)duration
           curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    view.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}

- (void)moveView2:(UIView *)view duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    //    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    //    view.transform = transform;
    
    view.frame = CGRectMake(x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    // Commit the changes
    [UIView commitAnimations];
    
}

@end
