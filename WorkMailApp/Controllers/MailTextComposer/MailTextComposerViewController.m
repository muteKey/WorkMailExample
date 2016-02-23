//
//  MailTextComposer.m
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "MailTextComposerViewController.h"
#import "DatePickerView.h"
#import "NSDateFormatter+WorkMailApp.h"
#import <MessageUI/MessageUI.h>

@interface MailTextComposerViewController ()<UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet DatePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet UITextField *additionalNoteField;

@property (weak, nonatomic) IBOutlet UITextField *plansForWeekField;
@property (weak, nonatomic) IBOutlet UITextField *problemsField;
@property (weak, nonatomic) IBOutlet UITextField *arriveTimeField;


@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDate *selectedTime;

@property (nonatomic, strong) NSString *additionalNote;

@property (nonatomic, strong) MailTextComposer *composer;

@end

@implementation MailTextComposerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) wSelf = self;
    self.datePickerView.datePickerCompletion = ^(NSDate *date) {

        if (wSelf.mailCaseType == WorkMailCaseTypeDayOff || wSelf.mailCaseType == WorkMailCaseTypeSickDay) {
            wSelf.dateField.text = [[NSDateFormatter shortDateFormatter] stringFromDate:date];
            wSelf.selectedDate = date;
        }
        else if (wSelf.mailCaseType == WorkMailCaseTypeEarlyGone) {
            wSelf.dateField.text = [[NSDateFormatter timeFormatter] stringFromDate:date];
            wSelf.selectedDate = date;
        }
        else if (wSelf.mailCaseType == WorkMailCaseTypeOutOfOffice){
            
            if ([wSelf.datePickerView.nextTextResponder respondsToSelector:@selector(setText:)]) {
                [wSelf.datePickerView.nextTextResponder setText:[[NSDateFormatter timeFormatter] stringFromDate:date]];
            }
            
            if (wSelf.datePickerView.nextTextResponder == wSelf.dateField) {
                wSelf.selectedDate = date;
            }
            else if (wSelf.datePickerView.nextTextResponder == wSelf.arriveTimeField) {
                wSelf.selectedTime = date;
            }
        }
        
        wSelf.datePickerView.hidden = YES;
    };
    
    self.datePickerView.datePicker.date = [NSDate date];
    self.datePickerView.datePicker.maximumDate = [NSDate date];
}

#pragma mark - UI actions

- (IBAction)doneTapped:(UIBarButtonItem *)sender {
    [self collectData];
    [self.view endEditing:YES];
    
    NSDictionary *mailDict = [self.composer composeMailText];
    
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];

    if ([MFMailComposeViewController canSendMail])
    {
        mail.mailComposeDelegate = self;
        [mail setSubject: mailDict[kSubject]];
        [mail setMessageBody: mailDict[kMessageBody]
                      isHTML: NO];
        [mail setToRecipients:@[ mailDict[kRecepient]]];
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

- (IBAction)dateFieldTapped:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.mailCaseType == WorkMailCaseTypeDelay) {
        self.datePickerView.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    else if (self.mailCaseType == WorkMailCaseTypeOutOfOffice || self.mailCaseType == WorkMailCaseTypeEarlyGone) {
        self.datePickerView.datePicker.datePickerMode = UIDatePickerModeTime;
    }
    
    self.datePickerView.nextTextResponder = self.dateField;
    self.datePickerView.hidden = NO;
}

- (IBAction)arriveTimeFieldTapped:(UIButton *)sender {
    [self.view endEditing:YES];
    self.datePickerView.datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePickerView.hidden = NO;
    self.datePickerView.nextTextResponder = self.arriveTimeField;
}


- (void)collectData {
    self.composer.additionalNote = self.additionalNoteField.text;
    self.composer.date = self.selectedDate;
    self.composer.time = self.selectedTime;
    self.composer.plans = self.plansForWeekField.text;
    self.composer.problems = self.problemsField.text;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.datePickerView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.plansForWeekField) {
        [self.problemsField becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - MFMailComposerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Accessors + mutators

- (MailTextComposer *)composer {
    if (!_composer) {
        _composer = [MailTextComposer new];
    }
    return _composer;
}

- (void)setMailCaseType:(WorkMailCaseType)mailCaseType {
    self.composer.mailCaseType = mailCaseType;
}

- (WorkMailCaseType)mailCaseType {
    return self.composer.mailCaseType;
}

@end
