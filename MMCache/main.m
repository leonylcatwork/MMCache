//
//  main.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCache.h"
#import "Dog.h"
#import "Cat.h"


#define CACHE MMCache.sharedCache


Dog *RandomDog(void) {
    Dog *dog = Dog.new;
    dog.age = arc4random_uniform(15);
    NSString *pool = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = NSMutableString.string;
    NSInteger length = arc4random_uniform(10) + 1;
    for (NSInteger i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [pool characterAtIndex:arc4random_uniform((int)pool.length)]];
    }
    dog.name = randomString.copy;
    NSArray *breeds = @[@"Husky", @"Barbet", @"Yorkshire Terrier", @"Alaskan Klee Kai", @"Australian Terrier", @"Akita", @"Bloodhound"];
    dog.breed = breeds[(NSUInteger)arc4random_uniform((int)breeds.count)];
    NSArray *favoriteFood = @[@"veg", @"sausage", @"biscuts", @"beans", @"meat", @"chicken"];
    dog.favoriteFood = favoriteFood[(NSUInteger)arc4random_uniform((int)favoriteFood.count)];
    return dog;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CACHE.storageType = MMCStorageTypeInMemory;
        CACHE.policyType = MMCPolicyTypeLRU;
        CACHE.capacity = 10000;

        for (NSInteger i = 0; i < 10000; i++) {
            [CACHE saveObject:RandomDog()];
        }

        NSArray <NSString *> *allIds = CACHE.allIds;
        for (NSInteger i = 0; i < 1000; i++) {
            NSInteger index = arc4random_uniform((int)allIds.count);
            [CACHE objectForId:allIds[index]];
        }

        Dog *dog1 = [Dog dogWithName:@"billy" age:2 breed:@"Husky"];
        [CACHE saveObject:dog1];

        CACHE.policyType = MMCPolicyTypeFIFO;

        Dog *dog2 = [Dog dogWithName:@"lucas" age:3 breed:@"Barbet"];
        [CACHE saveObject:dog2];

        CACHE.policyType = MMCPolicyTypeLFU;

        Cat *cat1 = [Cat dogWithName:@"luna" age:1 breed:@"British Shorthair"];
        [CACHE saveObject:cat1];

        Cat *cat2 = [Cat dogWithName:@"benny" age:5 breed:@"Burmese"];
        [CACHE saveObject:cat2];

        for (NSInteger i = 0; i < 100; i++) {
            [CACHE saveObject:RandomDog()];
        }

        NSLog(@"");
    }
    return 0;
}
