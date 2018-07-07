//
//  Dog+NSCoding.m
//  MMCache
//
//  Created by leon on 07/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "Dog+NSCoding.h"
#import "Macro.h"

@implementation Dog (NSCoding)


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:KEY(Dog, name)];
    [encoder encodeObject:self.breed forKey:KEY(Dog, breed)];
    [encoder encodeObject:self.favoriteFood forKey:KEY(Dog, favoriteFood)];
    [encoder encodeInteger:self.age forKey:KEY(Dog, age)];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.name         = [decoder decodeObjectForKey:KEY(Dog, name)];
        self.breed        = [decoder decodeObjectForKey:KEY(Dog, name)];
        self.favoriteFood = [decoder decodeObjectForKey:KEY(Dog, name)];
        self.age          = [decoder decodeIntegerForKey:KEY(Dog, age)];
    }
    return self;
}


@end
