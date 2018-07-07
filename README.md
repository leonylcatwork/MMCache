# MMCache
A Cache Library with flexible storage options and policies

This is a practice project for beginner.

### Install

Copy /scr folder to your project and import "MMCache.h".


### Usage

1. Custom object must conform to NSCoding. Extend your existing class with category and adapt NSCoding.
2. Instantiate MMCache instance (singleton sharedCache is available).
3. Configure cache policy (LRU, LFU, FIFO, etc.), storage type (in memory or persistent), and cache capacity (in terms of number of cached items)
4. Add/remove/achieve object using provided methods.

Example

```
MMCache.sharedCache.policyType = MMCPolicyTypeLRU;
MMCache.sharedCache.storageType = MMCStorageTypeInMemory;
MMCache.sharedCache.capacity = 100;

NSArray <NSString *> *names = @[@"Ana, Elsa, Lisa, Christ"];
[MMCache.sharedCache saveObject:names level:MMCLevelHigh];

NSDictionary <NSString *, NSNumber *> *kids = @{@"Alex" : @5, @"Phil" : @2, @"Mark" : @10};
[MMCache.sharedCache saveObject:kids level:MMCLevelLow];

```

### To do

Persistent type of storage is not implemented yet. This class must conforms to protocol 'MMCStorable'.
