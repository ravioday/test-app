//
//  CustomDictionary.h
//  TestApp
//
//  Created by Ravi Joshi on 7/13/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryEnumerator.h"

// Lets  build first a fixed size dictionary
@interface CustomDictionary : NSObject

- (instancetype)initWithSize:(NSInteger)size;
- (id)objectForKey:(id)key;
- (void)setObject:(id) object forKey:(id)key;
- (void)removeObjectForKey:(id)key;

// Helper Methods
- (NSInteger)count;
- (DictionaryEnumerator *)keyEnumerator;

@end
