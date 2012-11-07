//
//  DataBase.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 10. 27..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "DataBase.h"


#define DataBase_Name @"engquiz.sqlite"
#define Publisher_TableName @"Publisher"
#define Book_TableName @"Book"
#define ContentBook_TableName @"contentbook"
#define Dictionary_TableName @"dictionary"
#define Chapter_TableName @"chapter"

#define Problem_TableName @"problem"
#define Problemitem_TableName @"problemitem"
#define Contenttray_TableName @"contenttray"

@implementation DataBase
+ (DataBase*) getInstance{
    static DataBase* _db = nil;
    
    if (_db == nil) {
        _db = [[DataBase alloc] init];
    }
    
    return _db;
}

-(void)LoadDataBaseFile{
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:DataBase_Name];
    
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if([fileMgr fileExistsAtPath:filePath]){
        NSLog(@"file exist");
        
        [fileMgr removeItemAtPath:filePath error:&error];
        
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"engquiz" ofType:@"sqlite"];
        
        [fileMgr copyItemAtPath:resourcePath toPath:filePath error:&error];
        
    }else {
        NSLog(@"file not exist");
        
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"engquiz" ofType:@"sqlite"];
        
        [fileMgr copyItemAtPath:resourcePath toPath:filePath error:&error];
        
    }
    
    
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        
        sqlite3_close(database);
        
        NSLog(@"Error");
    }else{
        NSLog(@"Create / Open DataBase");
    }
    
}

-(void)fileList{
    
    
    sqlite3_stmt *selectStatement;
    NSString *query = [NSString stringWithFormat:@"SELECT _id FROM Exam"];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            NSLog(@"%@",[NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)]);
            
        }
        
    }else {
        NSLog(@"fail");
    }
    
    sqlite3_finalize(selectStatement);
    
}

-(NSMutableArray *)getPublisherIds{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    int count = 0;
    
    sqlite3_stmt *selectStatement;
    NSString *query = [NSString stringWithFormat:@"SELECT pid FROM %@",Publisher_TableName];
    
    const char *selectSql = [query UTF8String];
    
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)] atIndex:count];
            count++;
        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}


-(NSString *)getPublisherName:(int)_id{
    NSString *data;
    sqlite3_stmt *selectStatement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT content FROM %@ WHERE pid = %d",Publisher_TableName,_id];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            NSString *msg = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0) ];
            
            data = [NSString stringWithFormat:@"%@", msg];
            
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return data;
}







-(NSMutableArray *)getBookIds:(int)pNum:(int)cNum1:(int)cNum2{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    int count = 0;
    
    sqlite3_stmt *selectStatement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT bid FROM %@ ",Book_TableName];
    
    NSString *q1 = [NSString stringWithFormat:@"pid = %d",pNum];
    NSString *q2 = [NSString stringWithFormat:@"class1 = %d",cNum1];
    NSString *q3 = [NSString stringWithFormat:@"class2 = %d",cNum2];
    
    if (pNum != 0) {
        query = [NSString stringWithFormat:@"%@ WHERE %@",query, q1];
        count++;
    }
    if (cNum1 != 0) {
        if (count == 0) {
            query = [NSString stringWithFormat:@"%@ WHERE %@",query, q2];
        }else {
            query = [NSString stringWithFormat:@"%@ And %@",query, q2];
        }
        count++;
    }
    if (cNum2 != 0) {
        if (count == 0) {
            query = [NSString stringWithFormat:@"%@ WHERE %@",query, q3];
        }else {
            query = [NSString stringWithFormat:@"%@ And %@",query, q3];
        }
    }
    
    count = 0;
    
    const char *selectSql = [query UTF8String];
    
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)] atIndex:count];
            count++;
        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
//    NSLog(@"count :: %d",array.count);
    
    return array;
}


-(NSString *)getBookName:(int)_id{
    NSString *data;
    sqlite3_stmt *selectStatement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM %@ WHERE bid = %d",Book_TableName,_id];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            NSString *msg = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0) ];
            
            data = [NSString stringWithFormat:@"%@", msg];
            
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return data;
}



-(NSMutableArray *)getExamIds:(int)bId{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    int count = 0;
    
    sqlite3_stmt *selectStatement;
    NSString *query = [NSString stringWithFormat:@"SELECT id FROM %@ WHERE cid = %d",ContentBook_TableName, bId];
    
    const char *selectSql = [query UTF8String];
    
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)] atIndex:count];
            count++;
        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}


-(NSMutableArray *)getExamTheme:(int)_id{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    sqlite3_stmt *selectStatement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT theme, pagemin, pagemax FROM %@ WHERE id = %d",ContentBook_TableName,_id];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0) ] atIndex:0];
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 1)] atIndex:1];
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 1)] atIndex:2];
            
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}

-(NSString *)getExamSentence:(int)_id{
    NSString *data;
    sqlite3_stmt *selectStatement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT text FROM %@ WHERE id = %d",ContentBook_TableName,_id];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            NSString *msg = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0) ];
            
            data = [NSString stringWithFormat:@"%@", msg];
            
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return data;
}

-(NSMutableArray *)getVocaData:(int)type:(int)check{
    
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    sqlite3_stmt *selectStatement;
    int count = 0;
    NSString *query;
    if (check == 3) {
        if (type == 0) {
            query = [NSString stringWithFormat:@"SELECT word, mean, dtype, did FROM %@",Dictionary_TableName];
        }else {
            query = [NSString stringWithFormat:@"SELECT word, mean, dtype, did FROM %@ WHERE wtype = %d",Dictionary_TableName,type];
        }
    }else{
        if (type == 0) {
            query = [NSString stringWithFormat:@"SELECT word, mean, dtype, did FROM %@ WHERE vcheck = %d",Dictionary_TableName, check];
        }else {
            query = [NSString stringWithFormat:@"SELECT word, mean, dtype, did FROM %@ WHERE wtype = %d AND vcheck = %d",Dictionary_TableName,type,check];
        }
    }
    
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0) ] atIndex:count];
            
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1) ] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2) ] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3) ] atIndex:count];
            count++;
            
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}

-(NSMutableArray *)searchVoca:(NSString *)msg{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    int count = 0;
    NSString *query;
    
    sqlite3_stmt *selectStatement;

    query = [NSString stringWithFormat:@"SELECT word, mean, dtype, did FROM %@ WHERE word LIKE '%@%%'",Dictionary_TableName,msg];
//    query = [NSString stringWithFormat:@"SELECT word, mean, type, class FROM %@ WHERE word LIKE '%%%@%%'",Voca_TableName,msg];
    
    const char *selectSql = [query UTF8String];
    
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0) ] atIndex:count];
            
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1) ] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2) ] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3) ] atIndex:count];
            count++;
        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
    
    
    return array;
}




-(NSMutableArray *)getChapterData:(int)bid{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    sqlite3_stmt *selectStatement;
    int count = 0;
    
    NSString *query = [NSString stringWithFormat:@"SELECT cid, text FROM %@ WHERE bid = %d",Chapter_TableName, bid];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1) ] atIndex:count];
            count++;            
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}


-(NSMutableArray *)getThemeData:(int)cid{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    sqlite3_stmt *selectStatement;
    int count = 0;
    
    NSString *query = [NSString stringWithFormat:@"SELECT id, theme FROM %@ WHERE cid = %d",ContentBook_TableName, cid];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1) ] atIndex:count];
            count++;
        }
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}

- (int)saveRSentence:(NSString *)content:(NSString *)date:(int)type{
    sqlite3_stmt *insertStatement;
    
    int sid;
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO %@ (content,gdate,type) VALUES('%@','%@',%d)",Contenttray_TableName,content,date,type];
    
    const char *insertSql = [query UTF8String];
    
    //프리페어스테이트먼트를 사용
    if (sqlite3_prepare_v2(database, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
        
        sqlite3_bind_text(insertStatement, 2, insertSql,  -1, SQLITE_TRANSIENT);
        
        // sql문 실행
        if (sqlite3_step(insertStatement) != SQLITE_DONE) {
            NSLog(@"Error");
            
        }else{
            sqlite3_stmt *selectStatement;
            NSString *squery = [NSString stringWithFormat:@"SELECT cid FROM %@ ORDER BY cid DESC LIMIT 1",Contenttray_TableName];
            
            const char *selectSql = [squery UTF8String];
            
            if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
                
                // while문을 돌면서 각 레코드의 데이터를 받아서 출력한다.
                while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                    sid = sqlite3_column_int(selectStatement, 0);
                }
                
            }
            
            //statement close
            sqlite3_finalize(selectStatement);
        }
    }
    
    sqlite3_finalize(insertStatement);
    
    return sid;
}
-(int)saveRQuestion:(int)sid:(NSString *)qtext:(int)qnumber{
    sqlite3_stmt *insertStatement;
    int qid;
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO %@ (pid,level,pcontent) VALUES(%d,%d,'%@')",Problem_TableName,sid,qnumber,qtext];
    
    const char *insertSql = [query UTF8String];
    
    //프리페어스테이트먼트를 사용
    if (sqlite3_prepare_v2(database, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
        
        sqlite3_bind_text(insertStatement, 2, insertSql,  -1, SQLITE_TRANSIENT);
        
        // sql문 실행
        if (sqlite3_step(insertStatement) != SQLITE_DONE) {
            NSLog(@"Error");
            
        }else{
            sqlite3_stmt *selectStatement;
            NSString *squery = [NSString stringWithFormat:@"SELECT tid FROM %@ ORDER BY pid DESC LIMIT 1",Problem_TableName];
            
            const char *selectSql = [squery UTF8String];
            
            if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
                
                // while문을 돌면서 각 레코드의 데이터를 받아서 출력한다.
                while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                    qid = sqlite3_column_int(selectStatement, 0);
                }
                
            }
            
            //statement close
            sqlite3_finalize(selectStatement);
        }
    }
    
    sqlite3_finalize(insertStatement);
    
    return qid;
}

-(void)saveRAnswer:(int)pid:(NSString *)qcontent:(int)solution{
    sqlite3_stmt *insertStatement;
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO %@ (pid,qcontent,solution) VALUES(%d,'%@',%d)",Problemitem_TableName,pid,qcontent,solution];
    
    const char *insertSql = [query UTF8String];
    
    //프리페어스테이트먼트를 사용
    if (sqlite3_prepare_v2(database, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
        
        sqlite3_bind_text(insertStatement, 2, insertSql,  -1, SQLITE_TRANSIENT);
        
        // sql문 실행
        if (sqlite3_step(insertStatement) != SQLITE_DONE) {
            NSLog(@"Error");
            
        }
    }
    
    sqlite3_finalize(insertStatement);
}


-(void)setVocaCheck:(int)did:(int)check{
    NSString *query = [NSString stringWithFormat:@"UPDATE %@ SET vcheck = %d  WHERE did = %d",Dictionary_TableName,check,did];
    
    const char *updateSql = [query UTF8String];
    
    if (sqlite3_exec(database, updateSql, nil,nil,nil) != SQLITE_OK) {
        NSLog(@"Error");
    }else{
        NSLog(@"OK");
    }

}

-(NSMutableArray *)getRSentenceData:(int)type{
    NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
    int count = 0;
    
    sqlite3_stmt *selectStatement;
    NSString *query = [NSString stringWithFormat:@"SELECT cid, content FROM %@ WHERE type = %d",Contenttray_TableName,type];
    
    const char *selectSql = [query UTF8String];
    
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) {
            
            [array insertObject: [NSNumber numberWithInteger: sqlite3_column_int(selectStatement, 0)] atIndex:count];
            count++;
            [array insertObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1) ] atIndex:count];
            count++;

        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
    return array;
}



-(bool)existsWord:(NSString *)word{
    
    sqlite3_stmt *selectStatement;
    NSString *query = [NSString stringWithFormat:@"SELECT word FROM %@ WHERE word = %@",
                       Dictionary_TableName,word];
    
    const char *selectSql = [query UTF8String];
    bool result = false;
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        if (sqlite3_step(selectStatement) == SQLITE_ROW) {
            result = true;
            
        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
    return result;
}


-(NSString*)getRandomWord{
    
    sqlite3_stmt *selectStatement;
    NSString *res = @"";
    NSString *query = [NSString stringWithFormat:@"SELECT word FROM %@ ORDER BY RANDOM() LIMIT 1",
                       Dictionary_TableName];
    
    const char *selectSql = [query UTF8String];
    
    if (sqlite3_prepare_v2(database, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        
        if (sqlite3_step(selectStatement) == SQLITE_ROW)
        {
            res = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
        }
        
    }
    
    sqlite3_finalize(selectStatement);
    
    return res;
}
@end
