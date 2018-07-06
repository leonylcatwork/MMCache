//
//  MMCInMemoryStorage.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCInMemoryStorage.h"
#import "MMCContainer.h"


@interface MMCInMemoryStorage ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, MMCContainer *> *storage;
@property (nonatomic, strong) NSMutableOrderedSet <NSString *> *added;
@property (nonatomic, strong) NSMutableOrderedSet <NSString *> *accessed;

@end


@implementation MMCInMemoryStorage


- (NSMutableDictionary <NSString *, MMCContainer *> *)storage {
    if (!_storage) _storage = NSMutableDictionary.dictionary;
    return _storage;
}


- (NSMutableOrderedSet <NSString *> *)added {
    if (!_added) _added = NSMutableOrderedSet.orderedSet;
    return _added;
}


- (NSMutableOrderedSet <NSString *> *)accessed {
    if (!_accessed) _accessed = NSMutableOrderedSet.orderedSet;
    return _accessed;
}


#pragma mark - MMCStorageProtocol


- (BOOL)saveObject:(MMCContainer *)object {
    if (!object || !object.id) return NO;
    @synchronized(self) {
        self.storage[object.id] = object;
        [self.added addObject:object.id];
    }
    return YES;
}


- (BOOL)removeObjectForId:(NSString *)id {
    if (!id) return NO;
    @synchronized(self) {
        self.storage[id] = nil;
        [self.added removeObject:id];
        [self.accessed removeObject:id];
        return YES;
    }
}


- (MMCContainer *)objectForId:(NSString *)id {
    if (!id) return nil;
    @synchronized(self) {
        MMCContainer *container = self.storage[id];
        if (container) {
            container.accessTime = NSDate.date;
            [self.accessed removeObject:container.id];
            [self.accessed addObject:container.id];
        }
        return container;
    }
}


- (NSInteger)count {
    @synchronized(self) {
        return self.storage.count;
    }
}


- (MMCContainer *)firstAdded {
    @synchronized(self) {
        NSString *id = self.added.firstObject;
        return self.storage[id];
    }
}


- (MMCContainer *)lastAdded {
    @synchronized(self) {
        NSString *id = self.added.lastObject;
        return self.storage[id];
    }
}


- (MMCContainer *)lastAccessed {
    @synchronized(self) {
        NSString *id = self.accessed.lastObject;
        return self.storage[id];
    }
}


- (MMCContainer *)leastAccessed {
    NSInteger min = INT_MAX;
    MMCContainer *minContainer;
    for (MMCContainer *container in self.storage.allValues) {
        if (container.accessCount < min) {
            minContainer = container;
        } else if (container.accessCount == min) {
            NSComparisonResult r = [container.addedTime compare:minContainer.addedTime];
            if (r == NSOrderedAscending) {
                minContainer = container;
            } else if (r == NSOrderedSame && container.level < minContainer.level) {
                minContainer = container;
            }
        }
    }
    return minContainer;
}


- (MMCContainer *)mostAccessed {
    NSInteger max = 0;
    MMCContainer *minContainer;
    for (MMCContainer *container in self.storage.allValues) {
        if (container.accessCount > max) {
            minContainer = container;
        } else if (container.accessCount == max) {
            NSComparisonResult r = [container.addedTime compare:minContainer.addedTime];
            if (r == NSOrderedDescending) {
                minContainer = container;
            } else if (r == NSOrderedSame && container.level < minContainer.level) {
                minContainer = container;
            }
        }
    }
    return minContainer;
}


- (MMCContainer *)leastRecentAccessed {
    MMCContainer *lru;
    for (MMCContainer *container in self.storage.allValues) {
        if (!lru) {
            lru = container;
        } else {
            NSComparisonResult r = [container.accessTime compare:lru.accessTime];
            if (r == NSOrderedAscending) {
                lru = container;
            } else if (r == NSOrderedSame) {
                r = [container.addedTime compare:lru.addedTime];
                if (r == NSOrderedAscending) {
                    lru = container;
                } else if (r == NSOrderedSame && container.level < lru.level) {
                    lru = container;
                }
            }
        }
    }
    return lru;
}


- (void)purify {
    @synchronized(self) {
        self.storage  = NSMutableDictionary.dictionary;
        self.added    = NSMutableOrderedSet.orderedSet;
        self.accessed = NSMutableOrderedSet.orderedSet;
    }
}


- (NSArray <NSString *> *)allIds {
    return self.added.array;
}


@end
