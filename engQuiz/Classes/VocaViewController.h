//
//  VocaViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface VocaViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>{
    
    IBOutlet UITableView *vocaTable;
    DataBase *dbMsg;
    
    NSMutableArray *vArray;
    NSMutableArray *wArray;
    NSMutableArray *mArray;
    
    IBOutlet UITextField *searchMsg;
    UITapGestureRecognizer *tap;

    int cellCount;
}
- (IBAction)backBtnEvent:(id)sender;
- (IBAction)searchBtnEvent:(id)sender;

@end
