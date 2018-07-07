//
//  MMCPolicyLFU.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCPolicyLFU.h"
#import "MMCObject.h"
#import "MMCStorable.h"


@implementation MMCPolicyLFU


- (BOOL)saveObject:(MMCObject *)object toStorage:(id<MMCStorable>)storage maxCapacity:(NSInteger)maxCapacity {
    if (maxCapacity > 0 && [storage count] >= maxCapacity) {
        MMCObject *container = [storage leastAccessed];
        if (container.id) {
            if ([storage removeObjectForId:container.id]) {
                NSLog(@"<LFU> FULL [%@ accessed %ld] was removed", container.object, (long)container.accessCount);
            }
        }
    }
    return [storage saveObject:object];
}


@end
