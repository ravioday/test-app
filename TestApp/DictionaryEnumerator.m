//
//  DictionaryEnumerator.m
//  TestApp
//
//  Created by Ravi Joshi on 7/13/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import "DictionaryEnumerator.h"

@interface DictionaryEnumerator()

@property (nonatomic, copy) EnumeratorBlock block;

@end

@implementation DictionaryEnumerator

- (instancetype)initWithBlock:(EnumeratorBlock)block {
    self = [super init];
    
    if (self) {
        _block = block;
    }
    return self;
}

- (id)nextObject {
    return _block();
}

@end
