//
//  ExSentence.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 9..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"

@interface ExSentence : UIView{
    DataBase *dbMsg;
    IBOutlet UILabel *wordLabel;
    IBOutlet UILabel *exLabel;
}

@end
