//
//  DictionaryBucket.h
//  TestApp
//
//  Created by Ravi Joshi on 7/13/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>

// This is the Linked list
@interface DictionaryBucket : NSObject

// We copy the key so any manipulation to the original object does not affect the key in the dictionary
@property (nonatomic, copy) id key;
@property (nonatomic, strong) id objectForKey;
@property (nonatomic, strong) DictionaryBucket *next;

@end
