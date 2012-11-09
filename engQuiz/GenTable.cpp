//
//  GenTable.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 9..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "GenTable.h"
#include <sstream>

#define HEIGHT_PIXEL 300


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
    
    oss << "<table border=\"0\" width=\"90%\" >";
    
    for (iter = datas.begin(); iter!=datas.end(); iter++)
    {
        int total;
        total = iter->fail + iter->success;
        
        maxdata = std::max(total, maxdata);
    }
    
    oss << "<tr>";
    for (iter = datas.begin(); iter!=datas.end(); iter++)
    {
        oss << "<td width=\"" << 100/datas.size() << "%\"  valign=\"bottom\">";
        oss << "<table border=\"0\" width=\"100%\" height=\"" << HEIGHT_PIXEL << "\">";
        
        
        // 공백
        oss << "<tr>";
        oss << "<td bgcolor=\"white\" height=\"" << (int)(HEIGHT_PIXEL * ((maxdata-iter->success-iter->fail)/(double)maxdata)) << "\">";
        oss << "&nbsp;";
        oss << "</td>";
        oss << "</tr>";
        
        
        // 성공
        oss << "<tr>";
        oss << "<td bgcolor=\"blue\" height=\"" << (int)(HEIGHT_PIXEL * ((iter->success)/(double)maxdata)) << "\">";
        oss << "<center>";
        oss << iter->success;
        oss << "</center>";
        oss << "</td>";
        oss << "</tr>";
        
        
        // 실패
        oss << "<tr>";
        oss << "<td bgcolor=\"red\" height=\"" << (int)(HEIGHT_PIXEL * ((iter->fail)/(double)maxdata)) << "\">";
        oss << "<center>";
        oss << iter->fail;
        oss << "</center>";
        oss << "</td>";
        oss << "</tr>";
        
        oss << "</table>";
        oss << "</td>";
    }
    oss << "</tr>";
    
    
    // 레이블 출력
    oss << "<tr>";
    for (iter = datas.begin(); iter!=datas.end(); iter++)
    {
        oss << "<td>";
        oss << iter->label;
        oss << "</td>";
    }
    oss << "</tr>";
    
    oss << "</table>";
    
    return oss.str();
}