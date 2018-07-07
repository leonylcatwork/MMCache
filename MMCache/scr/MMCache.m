//
//  MMCache.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCache.h"
#import "MMCObject.h"
#import "MMCPolicyLFU.h"
#import "MMCPolicyLRU.h"
#import "MMCPolicyFIFO.h"
#import "MMCInMemoryStorage.h"
#import "NSString+MD5.h"


@interface MMCache ()

@property (nonatomic, strong) id<MMCStorable> storage;
@property (nonatomic, strong) id<MMCPolicyProtocol> policy;

@end


@implementation MMCache


- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultDuration = 24 * 60 * 60; // 24 hrs
    }
    return self;
}


+ (MMCache *)sharedCache {
    static dispatch_once_t onceToken;
    static MMCache *_sharedCache;
    dispatch_once(&onceToken, ^{
        _sharedCache = MMCache.new;
    });
    return _sharedCache;
}


+ (MMCache *)cacheWithCapacity:(NSInteger)capacity policyType:(MMCPolicyType)policyType storageType:(MMCStorageType)storageType {
    MMCache *cache = MMCache.new;
    cache.storageType = storageType;
    cache.policyType = policyType;
    return cache;
}


- (void)setStorageType:(MMCStorageType)storageType {
    switch (storageType) {
        case MMCStorageTypeInMemory: {
            _storage = MMCInMemoryStorage.new;
            break;
        }
        default: {
            [NSException raise:@"MMCStorageUndefined" format:@"storage type undefined"];
            break;
        }
    }
}


- (void)setPolicyType:(MMCPolicyType)policyType {
    switch (policyType) {
        case MMCPolicyTypeLRU: {
            _policy = MMCPolicyLRU.new;
            break;
        }
        case MMCPolicyTypeLFU: {
            _policy = MMCPolicyLFU.new;
            break;
        }
        case MMCPolicyTypeFIFO: {
            _policy = MMCPolicyFIFO.new;
            break;
        }
        default: {
            [NSException raise:@"MMCPolicyUndefined" format:@"cache policy type undefined"];
            break;
        }
    }
}


- (NSString *)saveObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level duration:(NSTimeInterval)duration {
    MMCObject *container = MMCObject.add(object, level, duration);
    container.id = [NSString stringWithFormat:@"%p", container].md5;
    if ([self.policy saveObject:container toStorage:self.storage maxCapacity:self.capacity]) {
        return container.id;
    }
    return nil;
}


- (NSString *)saveObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level {
    return [self saveObject:object level:level duration:self.defaultDuration];
}


- (NSString *)saveObject:(id<NSObject, NSCoding>)object {
    return [self saveObject:object level:MMCLevelDefault];
}


- (id)objectForId:(NSString *)id {
    return [self.storage objectForId:id].object;
}


- (void)expireObjectForId:(NSString *)id {
    MMCObject *container = [self.storage objectForId:id];
    container.duration = -1;
}


- (BOOL)removeObjectForId:(NSString *)id {
    return [self.storage removeObjectForId:id];
}


- (NSArray <NSString *> *)allIds {
    return self.storage.allIds;
}


- (NSInteger)size {
    return self.storage.count;
}


- (void)purify {
    [self.storage purify];
}

@end
