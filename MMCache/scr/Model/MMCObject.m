//
//  MMCContainer.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCObject.h"


@implementation MMCObject


+ (MMCObject *)addObject:(id<NSObject, NSCoding>)object level:(MMCLevel)level duration:(NSTimeInterval)duration {
    if (!object) return nil;
    MMCObject *container = MMCObject.new;
    container.object        = object;
    container.addedTime     = NSDate.date;
    container.accessTime    = container.addedTime;
    container.level         = level;
    container.duration      = duration;
    container.accessCount   = 0;
    return container;
}


+ (MMCObject * (^)(id<NSObject, NSCoding>object, MMCLevel level, NSTimeInterval duration))add {
    return ^(id object, MMCLevel level, NSTimeInterval duration) {
        return [self addObject:object level:level duration:duration];
    };
}


- (NSData *)objectData {
    return [NSKeyedArchiver archivedDataWithRootObject:self.object];
}


//- (void)dealloc {
//    NSLog(@"<dealloc> %@", self.id ? : self);
//}



@end
