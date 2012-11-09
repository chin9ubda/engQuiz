//
//  ExSentence.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 9..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "ExSentence.h"

@implementation ExSentence

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        dbMsg = [DataBase getInstance];
//        [self getEx];
        // Initialization code
    }
    return self;
}

//-(void)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{
    dbMsg = [DataBase getInstance];
    [self getEx];
}

-(void)setWord:(NSString *)_word:(NSString *)_mean{
    
    word = _word;
    mean = _mean;
}

- (IBAction)exitBtn:(id)sender {
    [self removeFromSuperview];
}

-(void)getEx{    
    wordLabel.text = word;
    meanLabel.text = mean;
    
    NSString *temp = [dbMsg getAndCheckSentence:word];
    int tempInt;
    if (![temp isEqualToString:@"단어가 없습니다"]) {
        if ([temp rangeOfString:word options:NSCaseInsensitiveSearch].location != 0) {
            tempInt = [temp rangeOfString:word options:NSCaseInsensitiveSearch].location;
            
            exTextView.text = [temp substringWithRange:(NSRange){[self leftCheck:temp :tempInt] + 1, [self rightCheck:temp :tempInt] - [self leftCheck:temp :tempInt]}];
            
            NSLog(@"temp :::: %@",[temp substringWithRange:(NSRange){[self leftCheck:temp :tempInt] + 1, [self rightCheck:temp :tempInt] - [self leftCheck:temp :tempInt]}]);
            
            NSLog(@"%d",[self rightCheck:temp :tempInt]);

        }
    }
}

-(int)leftCheck:(NSString *)msg:(int)poz{
    int result = -1;
    int check = 0;
    for (int i = poz; i > 0; i--) {
        if([[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"."]||
           [[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"\n"]){
            check = 1;
            result = i;
            break;
        }
    }
    return result;
}

-(int)rightCheck:(NSString *)msg:(int)poz{
    int result = msg.length - 1;
    
    int check = 0;
    for (int i = poz; i < msg.length; i++) {
        if([[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"."] ||
           [[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"\n"]||
           [[msg substringWithRange:(NSRange){i,1}] isEqualToString:@""]||
           [[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"!"]||
           [[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"?"]){
            check = 1;
            result = i;
            break;
        }
    }
    return result;
}

@end
