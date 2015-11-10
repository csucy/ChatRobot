//
//  NSArray+Log.m
//  03-Log的技巧
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
//    return @"-----";
    /**
     (
     "\U5f20\U4e09",
     lisi,
     123
     )

     */
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }];
    
    [strM appendString:@")\n"];
    
    return strM;
}

@end
