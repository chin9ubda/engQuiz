#include "IProblemMaker.h"
#include <algorithm>


Problem::Problem()
{
}

void Problem::addItems(std::string qcontent, int solution)
{
	ProblemItem item;
    
    std::transform(qcontent.begin(), qcontent.end(), qcontent.begin(), tolower);
	item.qcontent = qcontent;
	item.solution = solution;
    
	items.push_back(item);
    
    if (solution > 0)
    {
        this->solution = items.size();
    }
}


Problem::~Problem()
{
}


IProblemMaker::IProblemMaker(Tokenizer* tokenizer)
{
    this->tokenizer = tokenizer;
    tokenizer->run();
}

IProblemMaker::~IProblemMaker()
{
    delete tokenizer;
}


std::string IProblemMaker::getProblemContent()
{
	return problem_content;
}

std::vector<Problem> &IProblemMaker::getProblems()
{
	return problem;
}