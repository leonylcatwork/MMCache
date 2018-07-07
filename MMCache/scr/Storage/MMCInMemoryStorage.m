//
//  MMCInMemoryStorage.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCInMemoryStorage.h"
#import "MMCObject.h"


@interface MMCInMemoryStorage ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, MMCObject *> *storage;
@property (nonatomic, strong) NSMutableOrderedSet <NSString *> *added;
@property (nonatomic, strong) NSMutableOrderedSet <NSString *> *accessed;

@end


@implementation MMCInMemoryStorage


- (NSMutableDictionary <NSString *, MMCObject *> *)storage {
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


- (BOOL)saveObject:(MMCObject *)object {
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


- (MMCObject *)objectForId:(NSString *)id {
    if (!id) return nil;
    @synchronized(self) {
        MMCObject *object = self.storage[id];
        if (object.duration < 0 || NSDate.date.timeIntervalSinceNow > object.duration) {
            return nil;
        }
        if (object) {
            object.accessTime = NSDate.date;
            [self.accessed removeObject:object.id];
            [self.accessed addObject:object.id];
            object.accessCount++;
        }
        return object;
    }
}


- (NSInteger)count {
    @synchronized(self) {
        return self.storage.count;
    }
}


- (MMCObject *)firstAdded {
    @synchronized(self) {
        NSString *id = self.added.firstObject;
        return self.storage[id];
    }
}


- (MMCObject *)lastAdded {
    @synchronized(self) {
        NSString *id = self.added.lastObject;
        return self.storage[id];
    }
}


- (MMCObject *)lastAccessed {
    @synchronized(self) {
        NSString *id = self.accessed.lastObject;
        return self.storage[id];
    }
}


- (MMCObject *)leastAccessed {
    NSInteger min = INT_MAX;
    MMCObject *minobject;
    NSArray <MMCObject *> *objects = self.storage.allValues;
    NSTimeInterval interval = NSDate.date.timeIntervalSinceNow;
    for (MMCObject *object in objects) {
        if (object.duration < 0 || interval > object.duration) {
            if (object.id) self.storage[object.id] = nil;
            continue;
        }
        if (object.accessCount < min) {
            minobject = object;
        } else if (object.accessCount == min) {
            NSComparisonResult r = [object.addedTime compare:minobject.addedTime];
            if (r == NSOrderedAscending) {
                minobject = object;
            } else if (r == NSOrderedSame && object.level < minobject.level) {
                minobject = object;
            }
        }
    }
    return minobject;
}


- (MMCObject *)mostAccessed {
    NSInteger max = 0;
    MMCObject *minobject;
    NSArray <MMCObject *> *objects = self.storage.allValues;
    NSTimeInterval interval = NSDate.date.timeIntervalSinceNow;
    for (MMCObject *object in objects) {
        if (object.duration < 0 || interval > object.duration) {
            if (object.id) self.storage[object.id] = nil;
            continue;
        }
        if (object.accessCount > max) {
            minobject = object;
        } else if (object.accessCount == max) {
            NSComparisonResult r = [object.addedTime compare:minobject.addedTime];
            if (r == NSOrderedDescending) {
                minobject = object;
            } else if (r == NSOrderedSame && object.level < minobject.level) {
                minobject = object;
            }
        }
    }
    return minobject;
}


- (MMCObject *)leastRecentAccessed {
    MMCObject *lru;
    NSArray <MMCObject *> *objects = self.storage.allValues;
    NSTimeInterval interval = NSDate.date.timeIntervalSinceNow;
    for (MMCObject *object in objects) {
        if (object.duration < 0 || interval > object.duration) {
            if (object.id) self.storage[object.id] = nil;
            continue;
        }
        if (!lru) {
            lru = object;
        } else {
            NSComparisonResult r = [object.accessTime compare:lru.accessTime];
            if (r == NSOrderedAscending) {
                lru = object;
            } else if (r == NSOrderedSame) {
                r = [object.addedTime compare:lru.addedTime];
                if (r == NSOrderedAscending) {
                    lru = object;
                } else if (r == NSOrderedSame && object.level < lru.level) {
                    lru = object;
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
