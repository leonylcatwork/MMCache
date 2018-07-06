//
//  MMCStorageProtocol.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCStorageProtocol.h"


@protocol MMCPolicyProtocol <NSObject>

@required

- (BOOL)saveObject:(MMCContainer *)object toStorage:(id<MMCStorageProtocol>)storage maxCapacity:(NSInteger)maxCapacity;

@end

