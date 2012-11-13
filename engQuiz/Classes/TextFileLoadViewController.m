//
//  TextFileLoadViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 13..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "TextFileLoadViewController.h"

@interface TextFileLoadViewController ()

@end

@implementation TextFileLoadViewController

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
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray *filenames = [manager contentsOfDirectoryAtPath:documentPath error:&error ];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        NSString *temp = @"";
        int count = 0;
        items = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < filenames.count; i++) {
            temp = [filenames objectAtIndex:i];
            if ([[temp substringWithRange:(NSRange){temp.length - 4,4}] isEqualToString:@".txt"]) {
                [items insertObject:temp atIndex:count];
                count++;
            }
        }
//        items = [NSMutableArray arrayWithArray:filenames];
    }
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
- (void)viewDidUnload {
    itemTable = nil;
    [super viewDidUnload];
}


- (void)fileRead:(NSString *)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *FileManager;
    FileManager = [NSFileManager defaultManager];
    

    // Open File
    NSString *tmpFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    
//    FILE *file = fopen([tmpFile cStringUsingEncoding:NSASCIIStringEncoding], "w");
    
    
    NSFileHandle *hFile = [NSFileHandle fileHandleForReadingAtPath:tmpFile];
	if ( hFile == nil )
	{
		NSLog(@"no file to read");
		return ;
	}
    
    
//    NSData* pData2 = [file readDataOfLength:nLen];
    NSData *loadData = [hFile readDataToEndOfFile];
    [hFile closeFile];
	
	// NSData를 화면에 출력할 수 있는 NSString 타입을 변환한다.
	NSString* sReadString = [[NSString alloc] initWithData:loadData encoding:NSUTF8StringEncoding];
//	NSLog(@"%@",sReadString);
    
    
    text = sReadString;
    
    [[[UIAlertView alloc] initWithTitle:@"확인"
                                message:[NSString stringWithFormat:@"%@", sReadString]
                               delegate:self
                      cancelButtonTitle:nil
                      otherButtonTitles:@"저장",@"취소", nil] show];

    
    
//    NSLog(@"%@",file);
    
    /** re_test.txt 파일 삭제 */
//    [FileManager removeFileAtPath: @"re_test.txt" handler:nil];
//    NSLog(@"delete file [press return]");
//    getchar();
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = [indexPath row];
    [self fileRead:[items objectAtIndex:index]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self saveEvent];
            break;
        case 1:
            
            break;
        default:
            break;
    }
}
-(void)saveEvent{
    NSError *error   = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9:space:]" options:0 error:&error];
    NSString *temp = text;
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
    
    [dbMsg saveSentence:[NSString stringWithFormat:@"%@",resultSentence] :date :@"filename"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bookTableReload" object:nil];
    [self dismissModalViewControllerAnimated:YES];
}
@end
