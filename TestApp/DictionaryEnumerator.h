//
//  DictionaryEnumerator.h
//  TestApp
//
//  Created by Ravi Joshi on 7/13/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^EnumeratorBlock)(void);

@interface DictionaryEnumerator : NSEnumerator

- (instancetype)initWithBlock:(EnumeratorBlock)block;

- (id)nextObject;

@end
