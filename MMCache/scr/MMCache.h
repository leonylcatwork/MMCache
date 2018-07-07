//
//  MMCache.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCPolicyProtocol.h"
#import "MMCStorable.h"
#import "MMCLevel.h"


typedef NS_ENUM(NSInteger, MMCPolicyType) {
    MMCPolicyTypeLRU,
    MMCPolicyTypeLFU,
    MMCPolicyTypeFIFO
};


typedef NS_ENUM(NSInteger, MMCStorageType) {
    MMCStorageTypeInMemory,
    MMCStorageTypePersistent
};


@interface MMCache : NSObject


/*
 *  define max number of item in cache
 */
@property (nonatomic, assign) NSInteger      capacity;

/*
 *  cache policy: LRU, LFU, FIFO, etc.
 */
@property (nonatomic, assign) MMCPolicyType  policyType;

/*
 *  storage type: in memory or persistent
 */
@property (nonatomic, assign) MMCStorageType storageType;

+ (MMCache *)sharedCache;

+ (MMCache *)cacheWithCapacity:(NSInteger)capacity policyType:(MMCPolicyType)policyType storageType:(MMCStorageType)storageType;

- (BOOL)saveObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level;

- (BOOL)saveObject:(id<NSObject, NSCoding>)object;

- (id)objectForId:(NSString *)id;

- (BOOL)removeObjectForId:(NSString *)id;

- (void)expireObjectForId:(NSString *)id;

- (NSArray <NSString *> *)allIds;

- (NSInteger)size;

- (void)purify;

@end
