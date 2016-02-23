//
//  KNPickerView.h
//  keen
//
//  Created by Kirill Ushkov on 22.05.15.
//
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerCompletionBlock)(NSDate *date);

@interface DatePickerView : UIView

@property (copy, nonatomic) DatePickerCompletionBlock datePickerCompletion;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, weak) id nextTextResponder;

@end

