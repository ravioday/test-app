//
//  NodesController.m
//  TestApp
//
//  Created by Ravi Joshi on 11/1/14.
//  Copyright (c) 2014 Ravi Joshi. All rights reserved.
//

#import "NodesController.h"


@interface Node : NSObject

@property (nonatomic, strong) NSNumber *nodeData;
@property (nonatomic, strong) Node *next;

// Temporarily for addition type problems
@property (nonatomic, assign) NSInteger carry;

@end

@implementation Node


@end

@implementation NodesController


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)performAlgoRoutines {
    NSLog(@"**************** Linked list algorithms ****************\n\n");
}


// Write a algorithm to delete duplicates from linked list.

- (void)deleteDuplicateFromLinkedList:(Node*)node {
    NSMutableDictionary *mutableDiciotnary = [NSMutableDictionary dictionary];
    Node *previousNode = nil;
    while (!node) {
        if ([mutableDiciotnary objectForKey:node.nodeData]) {
            // Removing the current duplicate by linking the previous with the next of the current node.
            previousNode.next = node.next;
        } else {
            [mutableDiciotnary setObject:node forKey:node.nodeData];
            previousNode = node;
        }
        node = node.next;
    }
}


- (void)deletePassedInNodeFromMiddleOfALinkedList:(Node *)node {
    if (node.next ==nil) {
        // This is the last node
        return;
    }
    if (node) {
        Node *nextNode = node.next;
        node.nodeData= nextNode.nodeData;
        node.next = nextNode.next;
    }
}


- (void)moveLastNodeToTheFrontOfList:(Node *)rootNode {
    if (!rootNode || !rootNode.next) {
        return;
    }
    // We make two pointers one moves to the last and the other to the second last element , then we make the second last as the last and last as the root.
    Node *lastNode = rootNode;
    Node *secondLastNode = nil ;
    while (lastNode!=nil) {
        secondLastNode = lastNode;
        lastNode = lastNode.next;
    }
    secondLastNode.next = nil;
    lastNode.next = rootNode;
    rootNode = lastNode;
}


// Given that numbers are stored in a linked list in reverse order, add two such numbers stored in this list.


- (Node *)addLinkList1:(Node *)n1 withLinkList2:(Node *)n2 andCarry:(NSInteger)carry {
    
    if (!n1 || !n2) {
        // Breakage or numbers terminated
        return nil;
    }
    Node *resultNode = [self createNodeWithCarry:carry];
    NSInteger value = carry;
    if (!n1) {
        value = value + n1.nodeData.intValue;
    }
    
    if (!n2) {
        value = value + n2.nodeData.intValue;
    }
    
    resultNode.nodeData = @(value % 10);
    
    Node *more = [self addLinkList1:n1==nil ? nil : n1.next
                      withLinkList2:n2==nil ? nil : n2.next
                           andCarry:value > 10 ? 1 : 0];
    
    resultNode.next = more;
    return resultNode;
}


- (Node *)findTheBeginingOfTheCircularLinkListWithHeadNode:(Node *)head {
    Node *ptr1 = head;
    Node *ptr2 = head;

    while (!ptr2.next) {
        ptr1 = ptr1.next;
        ptr2 =ptr2.next.next;
        if (ptr1 == ptr2) {
            // We have found the meeting point
            break;
        }
    }
    
    if (ptr2.next == nil) {
        // this means this is not a loop
        return nil;
    }
    
    // move ptr1 back to head.
    ptr1 = head;
    
    while (ptr1 != ptr2) {
        ptr1 = ptr1.next;
        ptr2 = ptr2.next;
    }
    
    Node *node = ptr2;
    return node;
}

- (Node *)findTheConvergenceOfYShapedLinkedList1:(Node *)head1 andNode:(Node *)head2 {
    Node *ptr1 = head1;
    Node *ptr2 = head2;
    
    NSInteger length1 = 0;
    NSInteger length2 = 0;
    
    while (!ptr1) {
        length1 ++;
        ptr1 = ptr1.next;
    }
    
    while (!ptr2) {
        length2 ++;
        ptr2 = ptr2.next;
    }
    
    BOOL isMerged = ptr1==ptr2;
    
    if (isMerged) {
        // Find the point of onvergence;
        Node *longerForklet= head1;
        Node *shorterforklet = head2;
    
        if (length1 < length2) {
            longerForklet = head2;
            shorterforklet = head1;
        }
    
        NSInteger diff = length2-length1;
        while (diff !=0 ) {
            longerForklet = longerForklet.next;
            diff--;
        }
        
        // Now we have ensured that both forklets are at eqaul distances from the point of convergence.
    
        while (longerForklet != shorterforklet) {
            shorterforklet   = shorterforklet.next;
            longerForklet = longerForklet.next;
        }
    
        return longerForklet;
        
    }else {
    
        return nil;
        // Not a y
    }
    
}

- (Node *)createNodeWithCarry:(NSInteger)carry {
    Node *node  = [[Node alloc] init];
    node.nodeData = nil;
    node.next = nil;
    node.carry = carry;
    return node;
}



// Sort a Linked List : We are going to use merge sort.

- (Node *)mergeSort:(Node *)root {
    Node *splitPoint = [self findSplitPointNode:root];
    Node *firstNode = [self mergeSort:root];
    Node *secondNode = [self mergeSort:splitPoint];
    [self mergeNodeA:firstNode andNodeB:secondNode];

    return nil;
}


- (Node *)findSplitPointNode:(Node *)node {
    
    // For finding the midpoint we will have 2 pointers one moving at twice the speed.
    
    Node *fastNode = node;
    Node *slowNode = node;
    
    while (!fastNode) {
        fastNode = fastNode.next.next;
        slowNode = slowNode.next;
    }
    
    fastNode = slowNode;
    fastNode = fastNode.next;
    slowNode.next = nil;
    return nil;
}


- (Node *)mergeNodeA:(Node *)A andNodeB:(Node *)B {

    Node *start;
    Node *prev;
    if (A.nodeData > B.nodeData) {
        Node *temp = A;
        A = B;
        B = temp;
    }
    
    start  = A;
    
    while (A && B) {
        if (A.nodeData <= B.nodeData) {
            prev = A;
            A = A.next;
        } else {
            Node *temp = B.next;
            B.next = A;
            prev = B;
            B = temp;
        }
    }
    
    return start;
}



// Reverse a linked list
- (Node *)reverseAlinkedList:(Node *)head {
    Node *current = head;
    Node *prev = nil;
    Node *next = nil;
    while (current) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
    }

    return prev;
}

// Fold a Linked List :
- (void)foldALinkedListWithHead:(Node *)head {
    Node *fast = head;
    Node *slow = head;
    
    while (fast) {
        fast = fast.next.next;
        slow = slow.next;
    }
    
    Node *middlePointer = slow;
    Node *reverseHalf = [self reverseAlinkedList:middlePointer];

    while (reverseHalf && head != middlePointer) {
        Node *tempHead = head.next;
        Node *tempReverseHalf = reverseHalf.next;
    
        head.next = reverseHalf;
        reverseHalf.next = head.next;

        head = tempHead;
        reverseHalf = tempReverseHalf;
    }
    if (reverseHalf) {
        reverseHalf.next = nil;
    } else {
        head.next = nil;
    }
}




@end
