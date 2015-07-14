//
//  BinarySearchTree.m
//  TestApp
//
//  Created by Ravi Joshi on 7/14/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import "BinarySearchTree.h"
#import "TreeNode.h"

@interface BinarySearchTree ()

@property (nonatomic, assign, readwrite) NSInteger count;

@end

@implementation BinarySearchTree

- (TreeNode *)findKey:(id)data andNode:(TreeNode *)node {
    if (!node || data == node.data) {
        return node;
    }

    if ([data integerValue] > [node.data integerValue]) {
        return [self findKey:data andNode:node.rightNode];
    } else {
        return [self findKey:data andNode:node.leftNode];
    }
}

// Non-desctructive iterative insertion into binary tree

- (TreeNode *)insertNode:(id)nodeData andRoot:(TreeNode *)root {
    
    // Create a new node with passed in Data
    TreeNode *newNode = [[TreeNode alloc] init];
    newNode.data = nodeData;
    newNode.leftNode = newNode.rightNode = nil;
    
    
    if (root == nil) {
        return newNode;
    }
    
    TreeNode *currentNode = root;
    TreeNode *prevNode = nil;
    
    while (currentNode) {
        prevNode = currentNode;
        if ([nodeData integerValue] < [currentNode.data integerValue]) {
            currentNode = currentNode.leftNode;
        } else {
            currentNode = currentNode.rightNode;
        }
    }
    
    if ([nodeData integerValue] < [prevNode.data integerValue]) {
        prevNode.leftNode = newNode;
    } else {
        prevNode.rightNode = newNode;
    }
    
    if (currentNode !=nil) {
        if ([currentNode.data integerValue] < [newNode.data integerValue]) {
            newNode.leftNode = currentNode;
        } else {
            newNode.rightNode = currentNode;
        }
    }
    return newNode;
}

- (TreeNode *)deleteNode:(id)nodeData andRoot:(TreeNode *)rootNode {
    TreeNode *currentNode = rootNode;
    TreeNode *parentNode = nil;
    
    while (currentNode && [currentNode.data integerValue] != [nodeData integerValue]) {
        parentNode = currentNode;
        if ([nodeData integerValue] < [currentNode.data integerValue]) {
            currentNode = currentNode.leftNode;
        } else {
            currentNode = [currentNode rightNode];
        }
    }

    if (currentNode == nil) {
        NSLog(@"Node Not Found");
        return nil;
    }
    
    TreeNode *qNode, *sucessorNode = nil;
    
    if (currentNode.leftNode == nil) {
        // only theright child exists
        qNode = currentNode.rightNode;
    } else if (currentNode.rightNode == nil) {
        // only the left child exists
        qNode = currentNode.leftNode;
    } else {
        // if both child exists, then we have to find the in-order successor to allow delete to happen
        qNode = currentNode.rightNode;
        sucessorNode = currentNode.rightNode;
        while (sucessorNode.leftNode) {
            sucessorNode = sucessorNode.leftNode;
        }
        sucessorNode.leftNode = currentNode.leftNode;
    }
    
    if (parentNode == nil) {
        return qNode;
    }
    
    // Depending upon if the current node is the right or the left child, we assign the
    if (parentNode.leftNode == currentNode) {
        parentNode.leftNode = qNode;
    } else {
        parentNode.rightNode = qNode;
    }
    
    currentNode = nil;
    
    return nil;
}

@end

