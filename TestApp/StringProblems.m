

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

#pragma mark- Reverse all words in a sentence.
// Reverse the whole sentence first and then reverse each word in the sentence.

- (NSString *)reverseWordsInSentence:(NSString *)passedInSentences {
    NSMutableString *sentence = [NSMutableString string];
    NSString *reversedSentence = [self reverseString:[passedInSentences mutableCopy]];
    NSArray *stringsArray = [reversedSentence componentsSeparatedByString:@" "];
    for (NSString *string in stringsArray) {
        NSString *reversedWord = [self reverseString:[string mutableCopy]];
        [sentence appendString:reversedWord];
    }
    
    return sentence;
}

#pragma mark - Compute all Mnemonics for a phone number using Iteration
// For instance: 2276696 => ACRONYM or ABPOMZN and many others. so list all of them.

- (NSArray *)mnemonicsForNumber:(NSString *)number {
    NSDictionary *numToAlpha = @{@"0" : @"0",
                                 @"1" : @"1",
                                 @"2" : @"ABC",
                                 @"3" : @"DEF",
                                 @"4" : @"GHI",
                                 @"5" : @"JKL",
                                 @"6" : @"MNO",
                                 @"7" : @"PQRS",
                                 @"8" : @"TUV",
                                 @"9" : @"WXYZ"};
    
    NSArray *previousResultsArray = [NSArray array];
    
    for (int i =0; i < number.length; i++) {
        NSString *currentChar = [number substringWithRange:NSMakeRange(i, 1)];
        NSString *digitToAlphabet = numToAlpha[currentChar];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int j = 0; j < digitToAlphabet.length; j++) {
            NSMutableString *currentAlphabet = [[digitToAlphabet substringWithRange:NSMakeRange(j, 1)] mutableCopy];
            if (previousResultsArray.count == 0) {
                [tempArray addObject:[currentAlphabet mutableCopy]];
            } else {
                for (NSMutableString *string in previousResultsArray) {
                    NSMutableString *localMutableCopy = [string mutableCopy];
                    [localMutableCopy appendString:currentAlphabet];
                    [tempArray addObject:localMutableCopy];
                }
            }
        }
        
        previousResultsArray = [NSArray arrayWithArray:tempArray];
    }
    
    return previousResultsArray;
}

#pragma mark- Convert an Integer to a Roman String
// For instance Given a symbol-value table of roman numerals. {I: 1, V: 5, ..L: 50, ...M: 1000}, if passed in Integer is 55 the function should return LV.

- (NSString *)converIntToRoman:(NSNumber *)number {
    NSArray *valueSymbolsArray = @[@{@(1000): @"M"}, @{@(500): @"D"}, @{@(100): @"C"}, @{@(50): @"L"}, @{@(10): @"X"}, @{ @(5): @"V"}, @{@(1): @"I"}];
    NSMutableString *romanString = [NSMutableString stringWithFormat:@""];
    for (NSDictionary *valueSymbolPair in valueSymbolsArray) {
        NSNumber *key = [[valueSymbolPair allKeys] lastObject];
        while(number.integerValue >= key.integerValue) {
            number = @(number.integerValue - key.integerValue);
            [romanString appendString:valueSymbolPair[key]];
        }
    }
    
    return romanString;
}

- (NSInteger)convertRomanStringToInteger:(NSString *)string {
    NSDictionary *symbolsToValueTable = @{@"I": @(1), @"V": @(5), @"X": @(10), @"L": @(50), @"C": @(100), @"D": @(500), @"M": @(1000)};
    NSString *lastAlphabet = [string substringWithRange:NSMakeRange(string.length - 1, 1)];
    
    NSInteger sum = [symbolsToValueTable[lastAlphabet] integerValue];
    for (NSInteger i = string.length - 2; i >= 0; i--) {
        NSString *currentAlphabet = [string substringWithRange:NSMakeRange(i, 1)];
        if (sum < [symbolsToValueTable[currentAlphabet] integerValue]) {
            sum += [symbolsToValueTable[currentAlphabet] integerValue];
        } else {
            sum -=  [symbolsToValueTable[currentAlphabet] integerValue];
        }
    }
    
    return sum;
}

#pragma mark- Get all valid ip Addresses for String

- (NSMutableArray *)getAllValidIPAddressesForString:(NSString *)string {
    NSMutableArray *ipAddresses = [NSMutableArray array];
    for (int i = 1; i < string.length && i < 4; i++) {
        NSString *firstPart = [string substringWithRange:NSMakeRange(0, i)];
        if ([self isValid:firstPart]) {
            for (int j = 1; i + j < string.length && j < 4; j++) {
                NSString *secondPart = [string substringWithRange:NSMakeRange(i, i+j)]; // substring(i, j)
                if ([self isValid:secondPart]) {
                    for (int k =1; i + j + k < string.length && k < 4; k++) {
                        NSString *thirdPart = [string substringWithRange:NSMakeRange(i+j, i+j+k)]; // substring(i+j, k)
                        NSString *fourthPart = [string substringWithRange:NSMakeRange(i + j + k, string.length - 1)];
                        if ([self isValid:thirdPart] && [self isValid:fourthPart])  {
                            // Add the logic to place dots  as firstPart.secondPart.thirdPart.fourthPart.
                            NSString *ipAddress = [NSString stringWithFormat:@"%@.%@.%@.%@", firstPart, secondPart, thirdPart, fourthPart];
                            [ipAddresses addObject:ipAddress];
                        }
                    }
                }
            }
        }
    }
    return ipAddresses;
}

- (BOOL)isValid:(NSString *)string {
    if (string.length > 3) return false;
    
    if ([[string substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"] && string.length > 1   ) return false;
    
    if (0 <= string.integerValue && string.integerValue <=255) return true;

    return false;
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
