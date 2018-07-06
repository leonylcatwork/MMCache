//
//  Dog.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "Dog.h"

@implementation Dog


+ (Dog *)dogWithName:(NSString *)name age:(NSInteger)age breed:(NSString *)breed {
    Dog *dog  = Dog.new;
    dog.name  = name;
    dog.age   = age;
    dog.breed = breed;
    return dog;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<%@, %@, %zd>", self.name, self.breed, self.age];
}


@end
