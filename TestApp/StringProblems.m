

//
//  StringProblems.m
//  TestApp
//
//  Created by Ravi Joshi on 7/15/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import "StringProblems.h"

@implementation StringProblems

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark- Convert Integer to String

- (void)convertIntegerToString:(int)num {
    BOOL isNegative = num < 0;
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    num = abs(num);
    
    while (num > 0) {
        [resultString appendString:[NSString stringWithFormat:@"%ld", (long)num % 10]];
        num = num/10;
    }
    
    resultString = [self reverseString:resultString];
    
    if (isNegative) {
        [resultString insertString:@"-" atIndex:0];
    }
    
    NSLog(@"String Is: %@", resultString);
}

#pragma mark- Convert String to Integer 

- (void)convertStringToInteger:(NSString *)numericString {
    BOOL isNegative = [[numericString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"-"];

    int beginIterationIndex = 0;
    if (isNegative) {
        beginIterationIndex = 1;
    }
    
    NSInteger result = 0;
    
    for (int i = beginIterationIndex; i < numericString.length; i++) {
        result = result * 10 + ([numericString characterAtIndex:i] - '0') ;
    }
 
    result = isNegative ? -result : result;
    NSLog(@"Result Number is %ld", (long)result);
}

#pragma mark- Helper Methods
- (NSMutableString *)reverseString:(NSMutableString *)passedInString {
    
    NSMutableString *localString =[[NSMutableString alloc] init];
    [passedInString enumerateSubstringsInRange:NSMakeRange(0,[passedInString length])
                                 options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                              usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  [localString appendString:substring];
                              }];
    
    return localString;
}

@end
