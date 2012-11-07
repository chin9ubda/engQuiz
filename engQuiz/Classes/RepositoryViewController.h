//
//  RepositoryViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface RepositoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *rTableView;
    DataBase *dbMsg;
    NSMutableArray *rArray;
    int cellCount;
    IBOutlet UISegmentedControl *rAndi;
    
    int type;
}

- (IBAction)backBtnEvent:(id)sender;
- (void)reLoadTable;
- (IBAction)segmentedselectedEvent:(id)sender;
@end
