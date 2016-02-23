//
//  Preferences.h
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject

+ (instancetype)sharedPreferences;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *recepient;


@end
