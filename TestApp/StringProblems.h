//
//  StringProblems.h
//  TestApp
//
//  Created by Ravi Joshi on 7/15/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringProblems : NSObject

- (void)convertIntegerToString:(int)num;

- (void)convertStringToInteger:(NSString *)numericString;

- (NSMutableArray *)mnemonicsForNumber:(NSString *)number;

@end
