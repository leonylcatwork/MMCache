//
//  MMCStorageProtocol.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCStorable.h"


@protocol MMCPolicyProtocol <NSObject>

@required

- (BOOL)saveObject:(MMCObject *)object toStorage:(id<MMCStorable>)storage maxCapacity:(NSInteger)maxCapacity;

@end

