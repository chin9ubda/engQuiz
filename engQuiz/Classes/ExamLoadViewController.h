//
//  ExamLoadViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"
#import "BookListCell.h"
#import "TextPasteViewController.h"

@interface ExamLoadViewController : UIViewController<UIActionSheetDelegate,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    int tableCellCount;
    int pNumber;
    int cNumber;
    int sNumber;
    
    NSMutableArray *pArray;
    NSMutableArray *bArray;
    NSMutableArray *tArray;
    NSMutableArray *cArray;
    NSMutableArray *gArray;
    
    DataBase *dbMsg;
    
    IBOutlet UIButton *publisherName;
    IBOutlet UIButton *className;
    IBOutlet UIButton *classNumber;
    
    UIAlertView *alert;
    IBOutlet UITableView *bookTable;
    IBOutlet UITableView *chapterTable;
    IBOutlet UITableView *themeTable;
    
    int bookNumber;
    int chapterNumber;
    BookListCell *bCell;
    IBOutlet UIScrollView *scrollView;
    
    BOOL pageControlUsed;
    
    UILabel *rootLabel;
    UIButton *naviButton[2];
    UILabel *naviLabel[2];
    IBOutlet UIScrollView *naviScroll;
    
    UIImagePickerController *imagePickerController;
    TextPasteViewController *textPasteView;
}

- (IBAction)publisherSelect:(id)sender;
- (IBAction)classSelect:(id)sender;
- (IBAction)numberSelect:(id)sender;
- (IBAction)addSentence:(id)sender;

- (IBAction)backBtnEvent:(id)sender;
@end
