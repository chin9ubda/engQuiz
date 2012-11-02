//
//  ViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExViewController.h"
#import "VocaViewController.h"
#import "RepositoryViewController.h"
#import "DataBase.h"

@interface MainViewController : UIViewController{
    
    ExViewController *exView;
    VocaViewController *vocaView;
    RepositoryViewController *repositoryView;
    DataBase *dbMsg;
}

- (IBAction)exBtnEvent:(id)sender;
- (IBAction)vocaBtnEvent:(id)sender;
- (IBAction)repositoryBtnEvent:(id)sender;
@end
