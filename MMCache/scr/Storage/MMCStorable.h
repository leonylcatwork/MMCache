//
//  MMCStorageProtocol.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMCObject;

@protocol MMCStorable <NSObject>

@required

- (MMCObject *)objectForId:(NSString *)id;

- (BOOL)saveObject:(MMCObject *)object;

- (BOOL)removeObjectForId:(NSString *)id;

- (NSInteger)count;

- (MMCObject *)firstAdded;

- (MMCObject *)lastAdded;

- (MMCObject *)lastAccessed;

- (MMCObject *)leastAccessed;

- (MMCObject *)mostAccessed;

- (MMCObject *)leastRecentAccessed;

- (void)purify;

- (NSArray <NSString *> *)allIds;


@end

