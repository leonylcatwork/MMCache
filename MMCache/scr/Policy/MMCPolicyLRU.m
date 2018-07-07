//
//  MMCPolicyLRU.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCPolicyLRU.h"
#import "MMCObject.h"
#import "MMCStorable.h"


@implementation MMCPolicyLRU


- (BOOL)saveObject:(MMCObject *)object toStorage:(id<MMCStorable>)storage maxCapacity:(NSInteger)maxCapacity {
    if (maxCapacity > 0 && [storage count] >= maxCapacity) {
        MMCObject *container = [storage leastRecentAccessed];
        if (container.id) {
            if ([storage removeObjectForId:container.id]) {
                NSLog(@"<LRU> FULL [%@ accessed at %@] was removed", container.object, container.accessTime);
            }
        }
    }
    return [storage saveObject:object];
}


@end
