//
//  Cat.h
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"


@interface Cat : Pet

@property (nonatomic, copy) NSString *breed;

+ (Cat *)dogWithName:(NSString *)name age:(NSInteger)age breed:(NSString *)breed;

@end
