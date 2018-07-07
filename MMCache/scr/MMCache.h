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
 *  define default duration of an item
 */
@property (nonatomic, assign) NSInteger      defaultDuration;


/*
 *  cache policy: LRU, LFU, FIFO, etc.
 */
@property (nonatomic, assign) MMCPolicyType  policyType;

/*
 *  storage type: in memory or persistent
 */
@property (nonatomic, assign) MMCStorageType storageType;


/*
 *  singleton cache
 */
+ (MMCache *)sharedCache;


/*
 *  create new cache instance with parameters
 */
+ (MMCache *)cacheWithCapacity:(NSInteger)capacity policyType:(MMCPolicyType)policyType storageType:(MMCStorageType)storageType;


/*
 *  save an object to cache with level and duration
 *  returns id for retrieval if successful, nil otherwise
 */
- (NSString *)saveObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level duration:(NSTimeInterval)duration;


/*
 *  save an object to cache with level
 *  returns id for retrieval if successful, nil otherwise
 */
- (NSString *)saveObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level;


/*
 *  save an object to cache with default level
 *  returns id for retrieval if successful, nil otherwise
 */
- (NSString *)saveObject:(id<NSObject, NSCoding>)object;


/*
 *  retrieve an object with id
 */
- (id)objectForId:(NSString *)id;


/*
 *  remove an object from cache with id
 */
- (BOOL)removeObjectForId:(NSString *)id;


/*
 *  set an object as expired (does not remove it until cache is full)
 */
- (void)expireObjectForId:(NSString *)id;


/*
 *  query all ids from cache
 */
- (NSArray <NSString *> *)allIds;


/*
 *  query item count
 */
- (NSInteger)size;


/*
 *  remove all items in cache
 */
- (void)purify;

@end
