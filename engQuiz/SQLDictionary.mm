//
//  SQLDictionary.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 7..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "SQLDictionary.h"
#include "DataBase.h"
#include <sstream>

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


Word SQLDictionary::getWordInfo(std::string word)
{
    Word clsword;
    DataBase *dbMsg;
    
    dbMsg = [DataBase getInstance];
    
    NSString *nsword = [NSString stringWithUTF8String:word.c_str()];
    
    NSMutableArray *result = [dbMsg getWordInformation:nsword];
    
    // 단어
    
    clsword.word = word;
    
    // 의미
    clsword.mean = std::string([[result objectAtIndex:1] UTF8String]);
    clsword.dtype = [[result objectAtIndex:2] intValue];
    clsword.wtype = [[result objectAtIndex:3] intValue];
    clsword.sim = std::string([[result objectAtIndex:4] UTF8String]);
    clsword.vcheck = [[result objectAtIndex:5] intValue];
    
    return clsword;
}

bool SQLDictionary::getRandomSimItems(std::string word, std::string data[], int length)
{
    if (length > 10)
        return false;
    
    Word wordinfo = getWordInfo(word);
    std::vector<std::string> wordtok;
    
    std::istringstream iss(wordinfo.sim);
    std::string substr;
    
    while (getline(iss, substr, ','))
    {
        wordtok.push_back(substr);
    }
    
    int remain = length;
    for (int i=0; i<length; i++)
    {
        int sel = rand() % remain--;
        
        data[i] = wordtok[sel];
        wordtok.erase(wordtok.begin()+sel);
    }
    
    return true;
}
