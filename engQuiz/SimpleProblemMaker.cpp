#include "SimpleProblemMaker.h"
#include <sstream>
#include <vector>
#include <ctime>

SimpleProblemMaker::SimpleProblemMaker(void)
{
    dic = SQLDictionary::InstancePtr();
}


SimpleProblemMaker::~SimpleProblemMaker(void)
{
	std::vector<Problem*>::iterator iter;

	for (iter = problem.begin() ; iter != problem.end(); iter++)
	{
		delete *iter;
	}
}

bool SimpleProblemMaker::makeProblem(string example, int level, int num)
{
	std::istringstream iss(example);
	Tokenizer tokenizer(example);
    this->example = example;
	std::srand(time(NULL));
    bool res;
    
    tokenizer.run();
    
    if (tokenizer.word_cnt_exist_dic > 0)
    {
        res = procExistDic(tokenizer);
    } else {
        res = procReal(tokenizer);
    }

	return res;
}

bool SimpleProblemMaker::procReal(Tokenizer &tokenizer)
{
    int num_ex, num_real;
	///////////////////// 문제생성
	Problem *prob = new Problem();
    
    num_ex = rand() % tokenizer.word_cnt_real;
    num_real = tokenizer.atWordRealToken(num_ex);
    
    std::string solution = tokenizer.tokens[num_real].getToken();
    
	tokenizer.tokens[num_real].setProbNum((char)1);
    
	problem_content = tokenizer.cascadeStr();
    
	prob->pcontent = "빈칸에 알맞은 단어를 넣으세요.";
	
	int sol = rand() % 4;
    
	for (int i=0; i<4; i++)
	{
		if (sol == i)
		{
			prob->addItems(solution, 1);
		} else {
			prob->addItems(dic->getRandomWord(), 0);
		}
	}
    
	problem.push_back(prob);
    
    return true;

    
}

bool SimpleProblemMaker::procExistDic(Tokenizer &tokenizer)
{
    int num_ex, num_real;
	///////////////////// 문제생성
	Problem *prob = new Problem();
    
    num_ex = rand() % tokenizer.word_cnt_exist_dic;
    num_real = tokenizer.atWordExistDBToken(num_ex);
    
    std::string solution = tokenizer.tokens[num_real].getToken();
    
	tokenizer.tokens[num_real].setProbNum((char)1);
    
	problem_content = tokenizer.cascadeStr();
    
	prob->pcontent = "빈칸에 알맞은 단어를 넣으세요.";
	
	int sol = rand() % 4;
    string simstr[3];
    if (!dic->getRandomSimItems(solution, simstr, 3))
    {
        return false;
    }
    
    int simcnt = 0;
	for (int i=0; i<4; i++)
	{
		if (sol == i)
		{
			prob->addItems(solution, 1);
		} else {
			prob->addItems(simstr[simcnt++], 0);
		}
	}
    
	problem.push_back(prob);
    
    return true;
}

std::string SimpleProblemMaker::getProblemContent()
{
	return problem_content;
}

vector<Problem*> &SimpleProblemMaker::getProblems()
{
	return problem;
}