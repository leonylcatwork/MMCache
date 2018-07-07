//
//  MMCContainer.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MMCLevel) {
    MMCLevelDefault,
    MMCLevelHigh,
    MMCLevelImportant
};


@interface MMCContainer : NSObject

@property (nonatomic, copy  ) NSString *id;
@property (nonatomic, strong) id<NSCoding, NSObject> object;
@property (nonatomic, strong) NSDate *addedTime;
@property (nonatomic, strong) NSDate *accessTime;
@property (nonatomic, assign) MMCLevel level;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSInteger accessCount;


+ (MMCContainer *)addObject:(id<NSCoding, NSObject>)object level:(MMCLevel)level duration:(NSTimeInterval)duration;

+ (MMCContainer * (^)(id<NSCoding, NSObject> object, MMCLevel level, NSTimeInterval duration))add;

- (NSData *)objectData;


@end
