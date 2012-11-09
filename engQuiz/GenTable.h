//
//  GenTable.h
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 9..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#ifndef __engQuiz__GenTable__
#define __engQuiz__GenTable__

#include <iostream>
#include <vector>

class GenTableData
{
public:
    GenTableData(std::string label, int fail, int success);
    
    std::string label;
    int fail;
    int success;
};

class GenTable
{
public:
    std::vector<GenTableData> datas;
    std::string run();
};

#endif /* defined(__engQuiz__GenTable__) */
