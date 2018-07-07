//
//  MMCache.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCPolicyProtocol.h"
#import "MMCStorageProtocol.h"
#import "MMCContainer.h"


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


@property (nonatomic, assign) NSInteger capacity;
@property (nonatomic, assign) MMCPolicyType policyType;
@property (nonatomic, assign) MMCStorageType storageType;

+ (MMCache *)sharedCache;

+ (MMCache *)cacheWithCapacity:(NSInteger)capacity policyType:(MMCPolicyType)policyType storageType:(MMCStorageType)storageType;

- (BOOL)saveObject:(id<NSCoding, NSObject>)object level:(MMCLevel)level;

- (BOOL)saveObject:(id<NSCoding, NSObject>)object;

- (id)objectForId:(NSString *)id;

- (BOOL)removeObjectForId:(NSString *)id;

- (void)expireObjectForId:(NSString *)id;

- (NSArray <NSString *> *)allIds;

- (NSInteger)size;

- (void)purify;

@end
