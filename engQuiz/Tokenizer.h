//
//  Tokenizer.h
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 7..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#ifndef __engQuiz__Tokenizer__
#define __engQuiz__Tokenizer__

#include <iostream>
#include <vector>


enum token_type
{
    TOKEN_TYPE_WORD,
    TOKEN_TYPE_SPECIAL,
};


class Token
{
    std::string token;
    enum token_type type;
    char prob_num;
    bool existDB;
public:
    Token(std::string token, bool existDB);
    Token(std::string token, enum token_type type, bool existDB);
    inline std::string getToken();
    inline enum token_type getType();
    inline bool getExistDB();
    inline short getProbNum();
    void setProbNum(char num);
};


class Tokenizer
{
public:
    std::vector<Token> tokens;
    std::string origin;
    int word_cnt;
    int word_cnt_real;
    int word_cnt_exist_dic;
    
    Tokenizer(std::string origin);
    void run();
    std::string cascadeStr();
    int atWordToken(int num);
    int atWordRealToken(int num);
    int atWordExistDBToken(int num);
};

#endif /* defined(__engQuiz__Tokenizer__) */
