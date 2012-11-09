//
//  GenTable.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 9..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "GenTable.h"
#include <sstream>

#define HEIGHT_PIXEL 500


GenTableData::GenTableData(std::string label, int fail, int success)
: label(label), fail(fail), success(success)
{
    
}

std::string GenTable::run()
{
    std::string str;
    std::ostringstream oss(str);
    
    int maxdata = 0;
    
    std::vector<GenTableData>::iterator iter;
    
    oss << "<table border=\"0\">";
    
    for (iter = datas.begin(); iter!=datas.end(); iter++)
    {
        int total;
        total = iter->fail + iter->success;
        
        maxdata = std::max(total, maxdata);
    }
    
    for (iter = datas.begin(); iter!=datas.end(); iter++)
    {
        oss << "<tr width=\"" << 100/datas.size() << "%\" >";
        oss << "<table border=\"0\">";
        
        // 위에 공백
        oss << "<tr>";
        oss << "<td bgcolor=\"white\" height=\"" << (int)(HEIGHT_PIXEL * ((double)(maxdata-iter->fail-iter->success)/maxdata)) << "%\">";
        oss << "&nbsp;";
        oss << "</td>";
        oss << "</tr>";
        
        // 성공
        oss << "<tr>";
        oss << "<td bgcolor=\"blue\" height=\"" << (int)(HEIGHT_PIXEL * ((double)(maxdata-iter->fail)/maxdata)) << "%\">";
        oss << iter->success;
        oss << "</td>";
        oss << "</tr>";
        
        
        // 실패
        oss << "<tr>";
        oss << "<td bgcolor=\"blue\" height=\"" << (int)(HEIGHT_PIXEL * ((double)(maxdata-iter->success)/maxdata)) << "%\">";
        oss << iter->fail;
        oss << "</td>";
        oss << "</tr>";
        
        oss << "</table>";
        oss << "</tr>";
    }
    
    
    // 레이블 출력
    for (iter = datas.begin(); iter!=datas.end(); iter++)
    {
        oss << "<tr>";
        oss << "<td>";
        oss << iter->label;
        oss << "</td>";
        oss << "</tr>";
    }
    
    oss << "</table>";
    
    return oss.str();
}