//
//  MailTextComposer.m
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "MailTextComposer.h"
#import "NSDateFormatter+WorkMailApp.h"
#import "Preferences.h"

@implementation MailTextComposer

- (NSDictionary *)composeMailText
{
    NSString *subject = nil,*messageBody = self.additionalNote, *recepient = [Preferences sharedPreferences].recepient;
    NSString *userName = [Preferences sharedPreferences].userName;

    switch (self.mailCaseType)
    {
        case WorkMailCaseTypeDayOff:
        {
            NSString *dayOffDate = [[NSDateFormatter shortDateFormatter] stringFromDate:self.date];
            subject = [NSString stringWithFormat:@"%@, day off %@", userName, dayOffDate];
        }
            break;
            
        case WorkMailCaseTypeSickDay:
        {
            NSString *date = [[NSDateFormatter shortDateFormatter] stringFromDate:self.date];
            subject = [NSString stringWithFormat:@"%@, sick day %@", userName, date];
        }
            break;
            
        case WorkMailCaseTypeDelay:
        {
            NSString *date = [[NSDateFormatter shortDateFormatter] stringFromDate:self.date];
            NSString *time = [[NSDateFormatter timeFormatter] stringFromDate:self.date];
            subject = [NSString stringWithFormat:@"%@, delay %@ until %@", userName, date, time];
        }
            break;

        case WorkMailCaseTypeWeekPlan:
        {
            NSString *date = [[NSDateFormatter shortDateFormatter] stringFromDate:[NSDate date]];
            subject = [NSString stringWithFormat:@"%@, weekplan %@", userName, date];
            messageBody = [NSString stringWithFormat:@"Problems:\n%@\nPlans:\n%@", self.problems, self.plans];
        }
            break;
            
        case WorkMailCaseTypeEarlyGone:
        {
            NSString *time = [[NSDateFormatter timeFormatter] stringFromDate:self.date];
            subject = [NSString stringWithFormat:@"%@, early gone at %@", userName, time];
        }
            break;
            
        case WorkMailCaseTypeOutOfOffice:
        {
            NSString *leaveTime = [[NSDateFormatter timeFormatter] stringFromDate:self.date];
            NSString *arrivalTime = [[NSDateFormatter timeFormatter] stringFromDate:self.time];

            subject = [NSString stringWithFormat:@"%@, out of office from %@ to %@", userName, leaveTime, arrivalTime];
        }

            
        default:
            break;
    }
    
    NSMutableDictionary *res = @{}.mutableCopy;
    
    [res setValue:subject forKey:kSubject];
    [res setValue:messageBody forKey:kMessageBody];
    [res setValue:recepient forKey:kRecepient];
    
    return res;
}


- (BOOL)validate:(NSError *__autoreleasing *)error
{
    if (self.mailCaseType == WorkMailCaseTypeDayOff
        || self.mailCaseType == WorkMailCaseTypeSickDay
        || self.mailCaseType == WorkMailCaseTypeEarlyGone) {
        
        if (!self.date) {
            *error = [NSError errorWithDomain:@"domain"
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey : @"Error",
                                                NSLocalizedFailureReasonErrorKey : @"No date specified"}];
        }
        
        return NO;
    }
    
    return YES;
}


@end
