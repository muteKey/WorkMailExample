//
//  KNPickerView.m
//  keen
//
//  Created by Kirill Ushkov on 22.05.15.
//
//

#import "DatePickerView.h"

@interface DatePickerView ()

@end

@implementation DatePickerView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                       owner:self
                                                     options:nil][0]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, CGRectGetMinY(self.frame), CGRectGetWidth(self.superview.frame), CGRectGetHeight(self.frame));
}

- (IBAction)doneTapped:(UIButton *)sender {
    if (self.datePickerCompletion) {
        self.datePickerCompletion(self.datePicker.date);
    }
}

@end
