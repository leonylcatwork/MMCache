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


Dog *RandomDog(void) {
    Dog *dog = Dog.new;
    dog.age = arc4random_uniform(15);
    NSString *pool = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
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

        MMCache *sharedCache = MMCache.sharedCache;
        sharedCache.storageType = MMCStorageTypeInMemory;
        sharedCache.policyType = MMCPolicyTypeLRU;
        sharedCache.capacity = 100;

        for (NSInteger i = 0; i < 99; i++) {
            [sharedCache saveObject:RandomDog()];
        }

        NSArray <NSString *> *allIds = sharedCache.allIds;
        for (NSInteger i = 0; i < 99; i++) {
            NSInteger index = arc4random_uniform((int)allIds.count);
            [sharedCache objectForId:allIds[index]];
        }

        Dog *dog1 = [Dog dogWithName:@"billy" age:2 breed:@"Husky"];
        [sharedCache saveObject:dog1];

        Dog *dog2 = [Dog dogWithName:@"lucas" age:3 breed:@"Barbet"];
        [sharedCache saveObject:dog2];

        sharedCache.policyType = MMCPolicyTypeLFU;

        Cat *cat1 = [Cat dogWithName:@"luna" age:1 breed:@"British Shorthair"];
        [sharedCache saveObject:cat1];

        Cat *cat2 = [Cat dogWithName:@"benny" age:5 breed:@"Burmese"];
        [sharedCache saveObject:cat2];

        NSLog(@"");
    }
    return 0;
}
