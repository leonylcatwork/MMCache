//
//  MMCPolicyLFU.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCPolicyLFU.h"
#import "MMCContainer.h"
#import "MMCStorageProtocol.h"


@implementation MMCPolicyLFU


- (BOOL)saveObject:(MMCContainer *)object toStorage:(id<MMCStorageProtocol>)storage maxCapacity:(NSInteger)maxCapacity {
    if (maxCapacity > 0 && [storage count] >= maxCapacity) {
        MMCContainer *lfu = [storage leastAccessed];
        if (lfu.id) {
            if ([storage removeObjectForId:lfu.id]) {
                NSLog(@"<LFU> Cache is full, [%@ %@ accessed %ld] was removed", lfu.id, lfu.object, (long)lfu.accessCount);
            }
        }
    }
    return [storage saveObject:object];
}


- (void)purifyStorage:(id<MMCStorageProtocol>)storage {
    [storage purify];
}


@end
