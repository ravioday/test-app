//
//  CustomDictionary.m
//  TestApp
//
//  Created by Ravi Joshi on 7/13/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import "CustomDictionary.h"
#import "DictionaryBucket.h"

@interface CustomDictionary ()
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation CustomDictionary

- (instancetype)initWithSize:(NSInteger)size {
    self = [super init];
    
    if (self) {
        self.size = size;
        _array = [NSMutableArray arrayWithCapacity:size];
    }
    return self;
}

- (id)objectForKey:(id)key {
    DictionaryBucket *bucket = self.array[[key hash] % self.size];
    while (bucket) {
        if ([bucket.key isEqual:key]) {
            return bucket.objectForKey;
        }
        bucket = bucket.next;
    }
    return nil;
}

- (void)removeObjectForKey:(id)key {
    
    NSInteger bucketIndex = [key hash] % self.size;
    DictionaryBucket *bucket = self.array[bucketIndex];
    
    DictionaryBucket *previousBucket = nil;
    while (bucket) {
        if ([bucket.key isEqual:key]) {
            if (previousBucket == nil) {
                // Case when the very first object in the linked list is to be  removed.
                [self.array replaceObjectAtIndex:bucketIndex withObject:bucket.next];
            } else {
                previousBucket.next = bucket.next;
            }
            
            self.count--;
            return;
        }
        previousBucket = bucket;
        bucket = bucket.next;
    }
}

- (void)setObject:(id) object forKey:(id)key {
    DictionaryBucket *newBucket = [[DictionaryBucket alloc] init];
    newBucket.key = key;
    newBucket.objectForKey = object;
    NSInteger bucketIndex = [key hash] % self.size;
    newBucket.next = self.array[bucketIndex];
    self.array[bucketIndex] = newBucket;
    self.count++;
}

// Helper Methods

- (NSInteger)count {
    return self.count;
}

- (DictionaryEnumerator *)keyEnumerator {
    DictionaryEnumerator *enumerator = [[DictionaryEnumerator alloc] initWithBlock:^id{
        __block NSInteger index = -1;
        __block DictionaryBucket * bucket = nil;
        bucket = [bucket next];
        
        while (!bucket) {
            index++;
            if (index >= self.size) {
                return nil;
            }
            bucket = _array[index];
        }
        
        return bucket;
    }];
    
    return enumerator;
}

@end
