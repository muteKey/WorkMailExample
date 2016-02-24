//
//  NSString+Validation.h
//
//  Created by Kirill on 3/17/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)
- (BOOL)isValidEmail;
- (BOOL)isEmpty;
- (BOOL)containsOnlyAlphaNumeric;
@end
