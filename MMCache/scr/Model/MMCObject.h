//
//  MMCContainer.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCLevel.h"

@interface MMCObject : NSObject

@property (nonatomic, strong) id<NSObject, NSCoding> object;
@property (nonatomic, copy  ) NSString       *id;
@property (nonatomic, strong) NSDate         *addedTime;
@property (nonatomic, strong) NSDate         *accessTime;
@property (nonatomic, assign) MMCLevel       level;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSInteger      accessCount;


+ (MMCObject *)addObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level duration:(NSTimeInterval)duration;

+ (MMCObject * (^)(id<NSObject, NSCoding> object, MMCLevel level, NSTimeInterval duration))add;

- (NSData *)objectData;


@end
