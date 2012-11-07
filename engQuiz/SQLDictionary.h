//
//  SQLDictionary.h
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 7..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#ifndef __engQuiz__SQLDictionary__
#define __engQuiz__SQLDictionary__

#include <iostream>
#include "IDictionary.h"

class SQLDictionary : public IDictionary<SQLDictionary>
{
public:
	virtual bool exsistWord(std::string word);
	virtual std::string getRandomWord();
};

#endif /* defined(__engQuiz__SQLDictionary__) */
