#pragma once

#include <string>
#include <vector>

#define MAX_ITEMS_LENGTH 4

using namespace std;

class ProblemItem
{
public:
	string qcontent;
	int solution;
};

class Problem
{
public:
	string pcontent;
	vector <ProblemItem*> items;
    int solution;

	void addItems(string qcontent, int solution);

	Problem();
	~Problem();
};

class IProblemMaker
{
public:
	IProblemMaker(void);
	virtual ~IProblemMaker(void);
	virtual bool makeProblem(string example, int level, int num) = 0; 
	virtual vector<Problem*> &getProblems() = 0;
	virtual string getProblemContent() = 0; 

};

