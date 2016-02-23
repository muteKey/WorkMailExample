//
//  Preferences.m
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

+ (instancetype)sharedPreferences
{
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}


- (NSString *)userName {
    return @"Kirill Ushkov";
}

- (NSString *)recepient {
    return @"test@gmail.com";
}

@end
