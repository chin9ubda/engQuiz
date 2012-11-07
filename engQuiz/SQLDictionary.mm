//
//  SQLDictionary.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 7..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "SQLDictionary.h"
#include "DataBase.h"

bool SQLDictionary::exsistWord(std::string word)
{
    DataBase *dbMsg;
    
    dbMsg = [DataBase getInstance];
    
    bool result;
    
    NSString* nsword = [NSString stringWithUTF8String:word.c_str()];
    
    result = [dbMsg existsWord: nsword ];
    
    return result;
}


std::string SQLDictionary::getRandomWord()
{
    DataBase *dbMsg;
    
    dbMsg = [DataBase getInstance];
    
    std::string result([[dbMsg getRandomWord] UTF8String]);
    
    
    
    return result;
}