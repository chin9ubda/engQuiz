//
//  Tokenizer.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 7..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "Tokenizer.h"
#include "SQLDictionary.h"


std::string token2str(Token &token)
{
    return token.getToken();
}


Token::Token(std::string token, enum token_type type, bool existDB) : type(type), token(token), prob_num(0), existDB(existDB)
{
    
}


Token::Token(std::string token, bool existDB) : type(TOKEN_TYPE_WORD), token(token), prob_num(0), existDB(existDB)
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

bool Token::getExistDB()
{
    return this->existDB;
}


Tokenizer::Tokenizer(std::string origin, std::string lexiconPath, std::string ngramsPath): word_cnt(0), word_cnt_real(0), word_cnt_exist_dic(0)
{
    this->origin = origin;
    
    
    std::string homePath(getenv("HOME"));
    homePath += "/Resources/";
    
//    std::string lexiconPath = homePath + ANALYSIS_LEXICON;
//    std::string ngramsPath = homePath + ANALYSIS_NGRAMS;
    
    
    std::ifstream lexiconStream(lexiconPath.c_str());
    std::ifstream nGramStream(ngramsPath.c_str());
    
    
    model = citar::tagger::Model::readModel(lexiconStream, nGramStream);
    
	suffixWordHandler = new citar::tagger::SuffixWordHandler(model, 2, 2, 8);
    
	knownWordHandler = new citar::tagger::KnownWordHandler(model, suffixWordHandler);
    
	smoothing = new citar::tagger::LinearInterpolationSmoothing(model);
    
    
	hmmTagger = std::tr1::shared_ptr<citar::tagger::HMMTagger>(new citar::tagger::HMMTagger(model,
                                             knownWordHandler, smoothing));
    
    
}

Tokenizer::~Tokenizer()
{
    delete suffixWordHandler;
    delete knownWordHandler;
    delete smoothing;
}

void Tokenizer::run()
{
    int i;
    int buf_pos = 0;
    char buf[1024];
    //std::stack<char> nor_stack;
    bool sign = false;
    SQLDictionary dic = SQLDictionary::Instance();
    
    //tokens.push_back(Token("<BEGIN>", false));

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
                bool existDB = dic.exsistWord(buf);
                
                Token token(std::string(buf), existDB);
                tokens.push_back(token);
                
                if (buf_pos>2)
                {
                    word_cnt_real++;
                }
                
                if(buf_pos>2 && existDB)
                {
                    word_cnt_exist_dic++;
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
            
            
            Token token(std::string(buf), TOKEN_TYPE_SPECIAL, false);
            tokens.push_back(token);
        }
    }
    
    //tokens.push_back(Token("<END>", false));
    
    std::vector<std::string> sentents(tokens.size()+1);
    std::transform(tokens.begin(), tokens.end(), sentents.begin(), token2str);

    tag = hmmTagger->tag(sentents);
    
    std::vector<std::string>::iterator iter;
    std::vector<Token>::iterator iter2;
    for (iter = tag.begin(), iter2 = tokens.begin(); iter != tag.end(); iter++, iter2++)
    {
        if (iter2->getType() == TOKEN_TYPE_SPECIAL)
            continue;
        
        if (analysis.find(*iter) == analysis.end())
        {
            analysis[*iter] = 1;
        } else {
            analysis[*iter]++;
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
int Tokenizer::atWordExistDBToken(int num)
{
    int cnt = 0;
    int ret = 0;
    std::vector<Token>::iterator iter;
    
    for(iter = tokens.begin(); iter != tokens.end(); iter++, ret++)
    {
        if (iter->getType() == TOKEN_TYPE_WORD && iter->getToken().length() > 2 && iter->getExistDB())
        {
            if (cnt == num)
                return ret;
            cnt++;
        }
    }
    return -1;
}
