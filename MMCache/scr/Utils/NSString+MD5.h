//
//  NSString+MD5.h
//  momo_ios
//
//  Created by Leonc on 29/04/2017.
//  Copyright © 2017 MaiMemo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)


- (NSString *)md5;


- (NSString *)sha1;


- (NSString *)sha256;


+ (NSString *)randomMD5;


@end
