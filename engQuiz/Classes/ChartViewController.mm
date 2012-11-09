//
//  ChartViewController.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 6..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "ChartViewController.h"
#include "GenTable.h"

@interface ChartViewController ()

@end

@implementation ChartViewController

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
    GenTable table;
    table.datas.push_back(GenTableData("asdf",2,2));
    table.datas.push_back(GenTableData("asdf3",3,3));
    
    std::string temp = table.run();
    
    NSString *html = [NSString stringWithUTF8String:temp.c_str()];
    
    NSLog(@"test :  %@",html);
    
//    NSString *html = @"<html><head><title>Should be half</title></head><body>I wish the answer were just 42</body></html>";
    [webView loadHTMLString:html baseURL:nil];
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
- (void)viewDidUnload {
    webView = nil;
    [super viewDidUnload];
}
@end
