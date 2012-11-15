#pragma once
#include "iproblemmaker.h"
#include "SQLDictionary.h"
#include "Tokenizer.h"


class SimpleProblemMaker :
	public IProblemMaker
{
    bool procReal();
    bool procExistDic();
public:
	std::vector<Problem*> problem;
	SQLDictionary *dic;
	std::string example;
	std::string problem_content;
	SimpleProblemMaker(Tokenizer *tokenizer);
	~SimpleProblemMaker(void);
	virtual bool makeProblem(int level, int d); 
	virtual std::vector<Problem*> &getProblems();
	virtual std::string getProblemContent(); 
};

