//
//  BinarySearchTree.h
//  TestApp
//
//  Created by Ravi Joshi on 7/14/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  TreeNode;

@interface BinarySearchTree : NSObject

@property (nonatomic, assign, readonly) NSInteger count; 

- (TreeNode *)findKey:(id)data andNode:(TreeNode *)node;

- (TreeNode *)insertNode:(id)nodeData andRoot:(TreeNode *)node;
//
//- (void)deleteNode:(id)nodeData;

@end
