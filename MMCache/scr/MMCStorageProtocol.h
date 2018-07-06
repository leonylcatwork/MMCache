//
//  MMCStorageProtocol.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMCContainer;

@protocol MMCStorageProtocol <NSObject>

@required

- (MMCContainer *)objectForId:(NSString *)id;

- (BOOL)saveObject:(MMCContainer *)object;

- (BOOL)removeObjectForId:(NSString *)id;

- (NSInteger)count;

- (MMCContainer *)firstAdded;

- (MMCContainer *)lastAdded;

- (MMCContainer *)lastAccessed;

- (MMCContainer *)leastAccessed;

- (MMCContainer *)mostAccessed;

- (MMCContainer *)leastRecentAccessed;

- (void)purify;

- (NSArray <NSString *> *)allIds;


@end

