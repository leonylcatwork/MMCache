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
        MMCContainer *container = [storage leastAccessed];
        if (container.id) {
            if ([storage removeObjectForId:container.id]) {
                NSLog(@"<LFU> FULL [%@ accessed %ld] was removed", container.object, (long)container.accessCount);
            }
        }
    }
    return [storage saveObject:object];
}


@end
