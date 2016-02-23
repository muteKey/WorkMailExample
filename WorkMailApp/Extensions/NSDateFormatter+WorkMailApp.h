//
//  NSDateFormatter+WorkMailApp.h
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (WorkMailApp)
+ (NSDateFormatter*)shortDateFormatter;
+ (NSDateFormatter*)timeFormatter;
@end
