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
#include <sstream>
#include <stack>
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <vector>

#include <tr1/memory>

#include <citar/corpus/TaggedWord.hh>
#include <citar/tagger/hmm/HMMTagger.hh>
#include <citar/tagger/hmm/LinearInterpolationSmoothing.hh>
#include <citar/tagger/hmm/Model.hh>
#include <citar/tagger/wordhandler/KnownWordHandler.hh>
#include <citar/tagger/wordhandler/SuffixWordHandler.hh>

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
    citar::tagger::SuffixWordHandler *suffixWordHandler;
    citar::tagger::KnownWordHandler *knownWordHandler;
    citar::tagger::LinearInterpolationSmoothing *smoothing;
public:
    std::vector<Token> tokens;
    std::vector<std::string> tag;
    std::string origin;
    int word_cnt;
    int word_cnt_real;
    int word_cnt_exist_dic;
    std::tr1::shared_ptr<citar::tagger::HMMTagger> hmmTagger;
    std::tr1::shared_ptr<citar::tagger::Model> model;
    std::map<std::string, int> analysis;
    
    Tokenizer(std::string origin, std::string lexiconPath, std::string ngramsPath);
    ~Tokenizer();
    void run();
    std::string cascadeStr();
    int atWordToken(int num);
    int atWordRealToken(int num);
    int atWordExistDBToken(int num);
};

#endif /* defined(__engQuiz__Tokenizer__) */
