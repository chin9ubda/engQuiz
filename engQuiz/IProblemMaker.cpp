#include "IProblemMaker.h"
#include <algorithm>


Problem::Problem()
{
}

void Problem::addItems(std::string qcontent, int solution)
{
	ProblemItem *item;
	item = new ProblemItem();
    
    std::transform(qcontent.begin(), qcontent.end(), qcontent.begin(), tolower);
	item->qcontent = qcontent;
	item->solution = solution;
    
	items.push_back(item);
    
    if (solution > 0)
    {
        this->solution = items.size();
    }
}


Problem::~Problem()
{
	std::vector<ProblemItem*>::iterator iter;

	for (iter= items.begin(); iter != items.end(); iter++)
	{
		delete (*iter);
	}
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