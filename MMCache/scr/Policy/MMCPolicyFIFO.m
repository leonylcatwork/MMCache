//
//  MMCPolicyFIFO.m
//  MMCache
//
//  Created by leon on 07/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCPolicyFIFO.h"
#import "MMCObject.h"
#import "MMCStorable.h"


@implementation MMCPolicyFIFO


- (BOOL)saveObject:(MMCObject *)object toStorage:(id<MMCStorable>)storage maxCapacity:(NSInteger)maxCapacity {
    if (maxCapacity > 0 && [storage count] >= maxCapacity) {
        MMCObject *container = [storage firstAdded];
        if (container.id) {
            if ([storage removeObjectForId:container.id]) {
                NSLog(@"<FIFO> FULL [%@ added at %@] was removed", container.object, container.addedTime);
            }
        }
    }
    return [storage saveObject:object];
}



@end
