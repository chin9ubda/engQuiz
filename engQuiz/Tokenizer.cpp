//
//  Tokenizer.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 7..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "Tokenizer.h"
#include <sstream>
#include <stack>


Token::Token(std::string token, enum token_type type) : type(type), token(token), prob_num(0)
{
}


Token::Token(std::string token) : type(TOKEN_TYPE_WORD), token(token), prob_num(0)
{
}

std::string Token::getToken()
{
    return token;
}

enum token_type Token::getType()
{
    return type;
}

short Token::getProbNum()
{
    return this->prob_num;
}

void Token::setProbNum(char num)
{
    this->prob_num = num;
}


Tokenizer::Tokenizer(std::string origin): word_cnt(0), word_cnt_real(0)
{
    this->origin = origin;
}

void Tokenizer::run()
{
    int i;
    int buf_pos = 0;
    char buf[1024];
    //std::stack<char> nor_stack;
    bool sign = false;

    for(i=0;i<origin.length();i++)
    {
        if ((origin[i] <= 'Z' && origin[i] >= 'A') || (origin[i] <= 'z' && origin[i] >= 'a'))
        {
            buf[buf_pos++] = origin[i];
            sign = true;
            continue;
        } else {
            if (sign)
            {
                buf[buf_pos] = '\0';
                Token token(buf);
                tokens.push_back(token);
                
                if (strlen(buf)>2)
                {
                    word_cnt_real++;
                }
                
                word_cnt++;
                buf_pos = 0;
                sign = false;
            }
        }
        
        if (origin[i-1] != origin[i])
        {
            buf[0] = origin[i];
            buf[1] = '\0';
            Token token(buf, TOKEN_TYPE_SPECIAL);
            tokens.push_back(token);
        }
    }
    
}


std::string Tokenizer::cascadeStr()
{
    std::ostringstream oss;
    
    std::vector<Token>::iterator iter;
    
    for(iter = tokens.begin(); iter != tokens.end(); iter++)
    {
        if (iter->getProbNum() > 0)
        {
            oss << "<<" << iter->getProbNum() << ">>";
        } else {
            oss << iter->getToken();
        }
    }
    
    return oss.str();
}


int Tokenizer::atWordToken(int num)
{
    int cnt = 0;
    int ret = 0;
    std::vector<Token>::iterator iter;
    
    for(iter = tokens.begin(); iter != tokens.end(); iter++, ret++)
    {
        if (iter->getType() == TOKEN_TYPE_WORD)
        {
            if (cnt == num)
                return ret;
            cnt++;
        }
    }
    return -1;
}


int Tokenizer::atWordRealToken(int num)
{
    int cnt = 0;
    int ret = 0;
    std::vector<Token>::iterator iter;
    
    for(iter = tokens.begin(); iter != tokens.end(); iter++, ret++)
    {
        if (iter->getType() == TOKEN_TYPE_WORD && iter->getToken().length() > 2)
        {
            if (cnt == num)
                return ret;
            cnt++;
        }
    }
    return -1;
}