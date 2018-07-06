//
//  Pet.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy  ) NSString *favoriteFood;

@end
