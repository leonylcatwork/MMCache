//
//  MMCPolicyLRU.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCPolicyLRU.h"
#import "MMCContainer.h"
#import "MMCStorageProtocol.h"


@implementation MMCPolicyLRU


- (BOOL)saveObject:(MMCContainer *)object toStorage:(id<MMCStorageProtocol>)storage maxCapacity:(NSInteger)maxCapacity {
    if (maxCapacity > 0 && [storage count] >= maxCapacity) {
        MMCContainer *lru = [storage leastRecentAccessed];
        if (lru.id) {
            if ([storage removeObjectForId:lru.id]) {
                NSLog(@"<LRU> Cache is full, [%@ %@ accessed at %@] was removed", lru.id, lru.object, lru.accessTime);
            }
        }
    }
    return [storage saveObject:object];
}


- (void)purifyStorage:(id<MMCStorageProtocol>)storage {
    [storage purify];
}


@end
