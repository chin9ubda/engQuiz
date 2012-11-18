#pragma once

#include "Tokenizer.h"
#include "SQLDictionary.h"
#include <string>
#include <vector>

#define MAX_ITEMS_LENGTH 4

class SQLDictionary;

class ProblemItem
{
public:
    std::string qcontent;
	int solution;
};

class Problem
{
public:
    std::string pcontent;
    std::vector <ProblemItem> items;
    int solution;

	void addItems(std::string qcontent, int solution);

	Problem();
	~Problem();
};

class Word
{
public:
    std::string word;
    std::string mean;
    int dtype;
    int wtype;
    std::string sim;
    int vcheck;
};

class IProblemMaker
{
protected:
    Tokenizer *tokenizer;
	std::vector<Problem> problem;
	std::string example;
	std::string problem_content;
public:
    
	IProblemMaker(Tokenizer &tokenizer);
	~IProblemMaker(void);
	virtual bool makeProblem(int level, int num) = 0;
	std::vector<Problem> &getProblems();
	std::string getProblemContent();

};

