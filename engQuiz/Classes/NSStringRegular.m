//
//  NSStringRegular.m
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 15..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import "NSStringRegular.h"

@implementation NSStringRegular

-(NSString *)stringChange:(NSString *)msg{
    NSError *error   = nil;
    
    msg = [msg stringByReplacingOccurrencesOfString :@"'" withString:@"’"];
    msg = [msg stringByReplacingOccurrencesOfString :@"\n" withString:@"\r"];
//    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9:space:|-|_|?|:|&|;|,|.|!|'|\"]" options:0 error:&error];
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9:space:|-|_|?|:|&|;|,|.|!|’|\"]" options:0 error:&error];
    
    NSString *resultSentence = @"";
    for (int i = 0; i < msg.length; i++) {
        NSTextCheckingResult *match = [regexp firstMatchInString:[msg substringWithRange:(NSRange){i,1}] options:0 range:NSMakeRange(0, [msg substringWithRange:(NSRange){i,1}].length)];
        if(match.numberOfRanges!=0){
            resultSentence = [NSString stringWithFormat:@"%@%@",resultSentence,[msg substringWithRange:(NSRange){i,1}]];
            
        }else if([[msg substringWithRange:(NSRange){i,1}] isEqualToString:@"\r"]||
                 [[msg substringWithRange:(NSRange){i,1}] isEqualToString:@" "]){
            resultSentence = [NSString stringWithFormat:@"%@%@",resultSentence,[msg substringWithRange:(NSRange){i,1}]];
        }
    }
    
    return resultSentence;
}

@end
