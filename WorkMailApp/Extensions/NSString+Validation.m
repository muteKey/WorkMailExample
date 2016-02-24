//
//  NSString+Validation.m
//
//  Created by Kirill on 3/17/15.
//
//

#import "NSString+Validation.h"

@implementation NSString (Validation)
- (BOOL)isEmpty
{
    NSCharacterSet* characterSet = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet: characterSet].length == 0;
}

- (BOOL)isValidEmail {
    if ([self isEmpty]) {
        return NO;
    }
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)containsOnlyAlphaNumeric {
    if ([self isEmpty]) {
        return NO;
    }
    NSCharacterSet* notAlphaNumeric = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return [self rangeOfCharacterFromSet: notAlphaNumeric].location != NSNotFound;
}

@end
