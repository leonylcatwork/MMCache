//
//  Cat.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "Cat.h"

@implementation Cat


+ (Cat *)dogWithName:(NSString *)name age:(NSInteger)age breed:(NSString *)breed {
    Cat *cat  = Cat.new;
    cat.name  = name;
    cat.age   = age;
    cat.breed = breed;
    return cat;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<%@, %@, %zd>", self.name, self.breed, self.age];
}


@end
