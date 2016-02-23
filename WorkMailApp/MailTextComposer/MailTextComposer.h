//
//  MailTextComposer.h
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WorkMailCaseType) {
    WorkMailCaseTypeDayOff = 0,
    WorkMailCaseTypeSickDay,
    WorkMailCaseTypeDelay,
    WorkMailCaseTypeWeekPlan,
    WorkMailCaseTypeOutOfOffice,
    WorkMailCaseTypeEarlyGone
};

static NSString *kRecepient = @"kRecepient";
static NSString *kSubject = @"kSubject";
static NSString *kMessageBody = @"kMessageBody";

@interface MailTextComposer : NSObject

@property (nonatomic) WorkMailCaseType mailCaseType;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) NSString *additionalNote;

@property (nonatomic, strong) NSString *problems;

@property (nonatomic, strong) NSString *plans;


- (NSDictionary*)composeMailText;

@end
