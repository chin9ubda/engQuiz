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
        int t;
        for (t=0; t<wordtok.size(); t++)
        {
            if (substr == wordtok[t])
                break;
        }
        
        if(t==wordtok.size())
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


std::string SQLDictionary::getRandomMunzangs(int excnum)
{
    DataBase *dMsg = [DataBase getInstance];
    
    std::string result([[dMsg getRandomMunzang:excnum] UTF8String]);
    
    Tokenizer tok(result);
    tok.run();
    
    /// 너무 긴거 자르기;
    for (std::vector<std::string>::iterator iter = tok.munzang.begin(); iter != tok.munzang.end(); iter++)
    {
        if (iter->size() > 40)
        {
            tok.munzang.erase(iter);
            iter = tok.munzang.begin();
        }
    }
    
    std::string ret = tok.munzang[rand()%tok.munzang.size()];
    
    return ret;
}