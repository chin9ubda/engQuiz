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
        dbMsg = [DataBase getInstance];
        [self getEx];
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
    [self getEx];
}

-(void)getEx{
    NSString *word = @"from";
    
    
    
    wordLabel.text = word;
//    exLabel.text = [dbMsg getAndCheckSentence:word];
//    exLabel.text = word;
    exLabel.text = @"단어가 없습니다.";
//    exLabel.text = @"word";

}

@end
