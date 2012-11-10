//
//  DataBase.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@interface DataBase : NSObject{
    sqlite3 *database;
}
+ (DataBase*) getInstance;

-(void)LoadDataBaseFile;
-(void)fileList;

-(NSMutableArray *)getPublisherIds;
-(NSString *)getPublisherName:(int)_id;

-(NSMutableArray *)getBookIds:(int)pNum:(int)cNum1:(int)cNum2;
-(NSString *)getBookName:(int)_id;

-(NSMutableArray *)getInsertBook;


-(NSMutableArray *)getExamIds:(int)bId;
-(NSMutableArray *)getExamTheme:(int)_id;
-(NSString *)getExamSentence:(int)_id;

-(NSMutableArray *)getVocaData:(int)type:(int)check;
-(NSMutableArray *)searchVoca:(NSString *)msg;

-(NSMutableArray *)getChapterData:(int)bid;
-(NSMutableArray *)getThemeData:(int)cid;

-(int)saveRSentence:(NSString *)content:(NSString *)date:(int)type;
-(int)saveRQuestion:(int)sid:(NSString *)qtext:(int)qnumber;
-(void)saveRAnswer:(int)pid:(NSString *)qcontent:(int)solution;

-(void)setVocaCheck:(int)did:(int)check;

-(NSString *)getAndCheckSentence:(NSString *)word;

-(void)deleteRdata:(int)cid;

-(void)deleteInsertSentence:(int)_id;

-(NSString *)getMean:(NSString *)word;

-(NSMutableArray *)getRSentenceData:(int)type;
-(NSMutableArray *)getRQuestion:(int)tid;
-(NSMutableArray *)getRAnswer:(int)pid;


-(bool)existsWord:(NSString *)word;
-(NSString *)getRandomWord;
-(NSMutableArray *)getWordInformation:(NSString*)word;

-(void)saveSentence:(NSString *)sentence:(NSString *)gdate:(NSString *)filename;

@end