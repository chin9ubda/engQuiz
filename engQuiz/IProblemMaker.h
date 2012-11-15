#pragma once

#include "Tokenizer.h"
#include <string>
#include <vector>

#define MAX_ITEMS_LENGTH 4


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
    std::vector <ProblemItem*> items;
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
public:
	IProblemMaker(Tokenizer *tokenizer);
	~IProblemMaker(void);
	virtual bool makeProblem(int level, int num) = 0;
	virtual std::vector<Problem*> &getProblems() = 0;
	virtual std::string getProblemContent() = 0; 

};

