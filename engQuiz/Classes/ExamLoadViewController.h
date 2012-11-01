//
//  ExamLoadViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface ExamLoadViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    int tableCellCount;
    int pNumber;
    int cNumber;
    int sNumber;
    
    NSMutableArray *pArray;
    NSMutableArray *bArray;
    NSMutableArray *tArray;
    NSMutableArray *examArray;
    
    DataBase *dbMsg;
    
    IBOutlet UIButton *publisherName;
    IBOutlet UIButton *className;
    IBOutlet UIButton *classNumber;
    
    UIAlertView *alert;
    IBOutlet UITableView *bookTable;
}

- (IBAction)publisherSelect:(id)sender;
- (IBAction)classSelect:(id)sender;
- (IBAction)numberSelect:(id)sender;
- (IBAction)searchEvent:(id)sender;

- (IBAction)backBtnEvent:(id)sender;
@end
