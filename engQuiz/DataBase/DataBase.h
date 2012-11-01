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

-(NSMutableArray *)getExamIds:(int)bId;
-(NSMutableArray *)getExamTheme:(int)_id;
-(NSString *)getExamSentence:(int)_id;

-(NSMutableArray *)getVocaData;
-(NSMutableArray *)searchVoca:(NSString *)msg;

-(int)saveRSentence:(NSString *)content:(NSString *)date:(int)type;
-(int)saveRQuestion:(int)sid:(NSString *)qtext:(int)qnumber;
-(void)saveRAnswer:(int)pid:(NSString *)qcontent:(int)solution;



-(NSMutableArray *)getRSentenceData:(int)type;
//-(NSString *)getRSentence:(int)_id;
//-(NSString *)getRQuestion:(int)sid;
//-(NSString *)getRAnswer:(int)sid;

@end