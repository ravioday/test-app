//
//  TreeNode.h
//  TestApp
//
//  Created by Ravi Joshi on 7/14/15.
//  Copyright (c) 2015 Ravi Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject

@property (nonatomic, strong) TreeNode *leftNode;
@property (nonatomic, strong) TreeNode *rightNode;
@property (nonatomic, strong) id data;

@end
