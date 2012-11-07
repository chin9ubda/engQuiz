#pragma once
#include "iproblemmaker.h"
#include "SQLDictionary.h"


class SimpleProblemMaker :
	public IProblemMaker
{
public:
	vector<Problem*> problem;
	SQLDictionary *dic;
	std::string example;
	std::string problem_content;
	SimpleProblemMaker(void);
	~SimpleProblemMaker(void);
	virtual bool makeProblem(string example, int level, int d); 
	virtual vector<Problem*> &getProblems();
	virtual string getProblemContent(); 
};

