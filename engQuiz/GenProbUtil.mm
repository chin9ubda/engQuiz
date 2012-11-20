//
//  GenProbUtil.cpp
//  engQuiz
//
//  Created by Baek, Jinuk on 12. 11. 20..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#include "GenProbUtil.h"
#include "JSONKit.h"

std::string getTranslate(std::string str)
{
    NSString *textFrom = [@"\"en\"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *textTo = [@"\"ko\"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *textEscaped = [[NSString stringWithUTF8String:("\""+str+"\"").c_str()] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/language/translate/v2?JFz7vu0CMUPSQi4O7cIv5lCD&q=%@&source=en&target=ko",
                     textEscaped,textFrom,textTo];
    
    NSString *translation = @"";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString* contents = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    //NSLog(@"# %@ %@ %@", fromL, toL, contents);
    //return [self translateCharacters: [[[contents JSONValue] objectForKey: @"responseData"] objectForKey: @"translatedText"]];
    
    NSRange match;
    match = [contents rangeOfString: @">"];
    contents = [contents substringFromIndex: match.location+1];
    
    match = [contents rangeOfString: @"<"];
    translation = [contents substringWithRange: NSMakeRange (0, match.location)];
    //NSLog(@"%@", contents);

    
    return std::string([translation UTF8String]);
    
}