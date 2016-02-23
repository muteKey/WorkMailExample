//
//  NSDateFormatter+WorkMailApp.m
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "NSDateFormatter+WorkMailApp.h"

@implementation NSDateFormatter (WorkMailApp)

+ (NSDateFormatter*)shortDateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY/MM/dd";
    });
    return formatter;
}

+ (NSDateFormatter *)timeFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
    });
    return formatter;
}

@end
