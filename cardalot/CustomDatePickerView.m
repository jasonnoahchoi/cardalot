//
//  CustomDatePickerView.m
//  CustomDatePicker
//
//  Created by sombra on 2015-03-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "CustomDatePickerView.h"

typedef enum : NSInteger {
    DayPicker = 0,
    HourPicker = 1,
    MinutePicker = 2,
} DatePickerType;

@interface CustomDatePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIButton *previousMonthButton;
@property (strong, nonatomic) UIButton *nextMonthButton;
@property (strong, nonatomic) UIButton *setDateButton;
@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) UILabel *monthAndYearLabel;

@property (strong, nonatomic) UIView *separatorViewOne;
@property (strong, nonatomic) UIView *separatorViewTwo;
@property (strong, nonatomic) UIView *separatorViewThree;

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDateFormatter *monthAndYearLabelDateFormatter;

@property (strong, nonatomic) NSDate *date;

@end

@implementation CustomDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self pickerView:self.pickerView didSelectRow:[self defaultRowValueForComponent:DayPicker] inComponent:DayPicker];
        
        self.backgroundColor = [UIColor darkGrayColor];
        self.layer.cornerRadius = 10.0;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        self.previousMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.previousMonthButton.frame = CGRectMake(8, 4, 30, 30);
        [self.previousMonthButton setTitle:@"<" forState:UIControlStateNormal];
        [self.previousMonthButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        [self.previousMonthButton addTarget:self action:@selector(previousMonthButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.previousMonthButton];
        
        self.monthAndYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(46, 9, 188, 21)];
        self.monthAndYearLabel.text = [self.monthAndYearLabelDateFormatter stringFromDate:self.date];
        self.monthAndYearLabel.textAlignment = NSTextAlignmentCenter;
        self.monthAndYearLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.monthAndYearLabel];
        
        self.nextMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextMonthButton.frame = CGRectMake(242, 4, 30, 30);
        [self.nextMonthButton setTitle:@">" forState:UIControlStateNormal];
        [self.nextMonthButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        [self.nextMonthButton addTarget:self action:@selector(nextMonthButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.nextMonthButton];
        
        self.separatorViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 35, 280, 1)];
        self.separatorViewOne.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.separatorViewOne];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 36, 280, 162)];
        [self addSubview:self.pickerView];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        self.separatorViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 198, 280, 1)];
        self.separatorViewTwo.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.separatorViewTwo];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.frame = CGRectMake(8, 210, 132, 30);
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
        
        self.separatorViewThree = [[UIView alloc] initWithFrame:CGRectMake(140, 199, 1, 50)];
        self.separatorViewThree.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.separatorViewThree];
        
        self.setDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.setDateButton.frame = CGRectMake(150, 210, 122, 30);
        [self.setDateButton setTitle:@"Set Date" forState:UIControlStateNormal];
        [self.setDateButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        [self.setDateButton addTarget:self action:@selector(setDateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.setDateButton];
        
        for (NSUInteger i = 0; i < 3; i++) {
            [self.pickerView selectRow:[self defaultRowValueForComponent:i] inComponent:i animated:NO];
        }
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self.date];
        [self setPickerView:self.pickerView rowInComponent:HourPicker toIntegerValue:[components hour] decrementing:NO animated:YES];
        [self setPickerView:self.pickerView rowInComponent:MinutePicker toIntegerValue:[components minute]  decrementing:NO animated:YES];
        
    }
    
    return self;
}

#pragma mark Custom getter
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"ccc d MMM";
    }
    return _dateFormatter;
}

- (NSDateFormatter *)monthAndYearLabelDateFormatter {
    if (!_monthAndYearLabelDateFormatter) {
        _monthAndYearLabelDateFormatter = [[NSDateFormatter alloc] init];
        _monthAndYearLabelDateFormatter.dateFormat = @"MMMM yyyy";
    }
    return _monthAndYearLabelDateFormatter;
}

- (NSDate *)date {
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self actualNumberOfRowsInComponent:component] * 200;
}

- (NSInteger)actualNumberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRows = 0;
    switch (component) {
        case DayPicker:
            numberOfRows = 30;
            break;
        case HourPicker:
            numberOfRows = 24;
            break;
        case MinutePicker:
            numberOfRows = 60;
            break;
    }
    return numberOfRows;
}

- (NSInteger)defaultRowValueForComponent:(NSInteger)component {
    return [self actualNumberOfRowsInComponent:component] * 100;
}

#pragma mark UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = 0;
    switch (component) {
        case DayPicker:
            width = 140;
            break;
        case HourPicker:
            width = 40;
            break;
        case MinutePicker:
            width = 40;
            break;
    }
    
    return width;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == DayPicker) {
        self.monthAndYearLabel.text = [self.monthAndYearLabelDateFormatter stringFromDate:[self dateForRow:row]];
    }
    
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @"";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    switch (component) {
        case DayPicker:
            title = [self stringOfDateForRow:row];
            [paragraphStyle setAlignment:NSTextAlignmentRight];
            break;
        case HourPicker:
            title = [NSString stringWithFormat:@"%02ld", row % [self actualNumberOfRowsInComponent:component]];
            [paragraphStyle setAlignment:NSTextAlignmentCenter];
            break;
        case MinutePicker:
            title = [NSString stringWithFormat:@"%02ld", row % [self actualNumberOfRowsInComponent:component]];
            [paragraphStyle setAlignment:NSTextAlignmentLeft];
            break;
    }
    
    return [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName: paragraphStyle}];
}

- (void)setPickerView:(UIPickerView *)pickerView rowInComponent:(NSInteger)component toIntegerValue:(NSInteger)value decrementing:(BOOL)decrementing animated:(BOOL)animated {
    if (decrementing) {
        BOOL valueSetted = NO;
        for (NSInteger i = 0; i < [self actualNumberOfRowsInComponent:component]; i++) {
            if ([[self pickerView:pickerView attributedTitleForRow:[pickerView selectedRowInComponent:component] - i forComponent:component].string integerValue] <= value) {
                [pickerView selectRow:[pickerView selectedRowInComponent:component] - i inComponent:component animated:animated];
                valueSetted = YES;
                break;
            }
        }
        if (!valueSetted && component == MinutePicker) {
            [pickerView selectRow:[pickerView selectedRowInComponent:HourPicker] - 1 inComponent:HourPicker animated:animated];
            if ([[self pickerView:pickerView attributedTitleForRow:[pickerView selectedRowInComponent:HourPicker] forComponent:HourPicker].string integerValue] == 0) {
                [pickerView selectRow:[pickerView selectedRowInComponent:DayPicker] - 1 inComponent:DayPicker animated:animated];
            }
        }

    } else {
        BOOL valueSetted = NO;
        for (NSInteger i = 0; i < [self actualNumberOfRowsInComponent:component]; i++) {
            if ([[self pickerView:pickerView attributedTitleForRow:[pickerView selectedRowInComponent:component] + i forComponent:component].string integerValue] >= value) {
                [pickerView selectRow:[pickerView selectedRowInComponent:component] + i inComponent:component animated:animated];
                valueSetted = YES;
                break;
            }
        }
        if (!valueSetted && component == MinutePicker) {
            [pickerView selectRow:[pickerView selectedRowInComponent:HourPicker] + 1 inComponent:HourPicker animated:animated];
            if ([[self pickerView:pickerView attributedTitleForRow:[pickerView selectedRowInComponent:HourPicker] forComponent:HourPicker].string integerValue] == 0) {
                [pickerView selectRow:[pickerView selectedRowInComponent:DayPicker] + 1 inComponent:DayPicker animated:animated];
            }
        }
    }
}

#pragma mark NSDate stuff
-(BOOL)isDate:(NSDate*)date1 sameDayAsDate:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
}

- (NSDate *)dateForRow:(NSInteger)row {
    row = row - [self defaultRowValueForComponent:DayPicker];
    NSDate *date = [self.date dateByAddingTimeInterval:60 * 60 * 24 * row];
    return [[NSCalendar currentCalendar] dateBySettingHour:0 minute:0 second:0 ofDate:date options:0];
}

- (NSString *)stringOfDateForRow:(NSInteger)row {
    NSDate *date = [self dateForRow:row];
    if ([self isDate:date sameDayAsDate:[NSDate date]]) {
        return NSLocalizedString(@"Today", @"Current day indicator");
    }
    return [self.dateFormatter stringFromDate:date];
}

- (NSInteger)daysInMonthForDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

- (NSDate *)dateWithSelectedTime {
    NSDate *date = [self dateForRow:[self.pickerView selectedRowInComponent:DayPicker]];
    NSInteger hour = [[self pickerView:self.pickerView attributedTitleForRow:[self.pickerView selectedRowInComponent:HourPicker] forComponent:HourPicker].string integerValue];
    NSInteger minute = [[self pickerView:self.pickerView attributedTitleForRow:[self.pickerView selectedRowInComponent:MinutePicker] forComponent:MinutePicker].string integerValue];
    return [[NSCalendar currentCalendar] dateBySettingHour:hour minute:minute second:0 ofDate:date options:0];
}

#pragma mark IBAction
- (IBAction)previousMonthButtonPressed:(id)sender {
    NSDate *date = [self dateForRow:[self.pickerView selectedRowInComponent:DayPicker]];
    NSInteger row = [self.pickerView selectedRowInComponent:DayPicker] - [self daysInMonthForDate:date];
    [self.pickerView selectRow:row inComponent:DayPicker animated:YES];
    [self pickerView:self.pickerView didSelectRow:row inComponent:DayPicker];
}

- (IBAction)nextMonthButtonPressed:(id)sender {
    NSDate *date = [self dateForRow:[self.pickerView selectedRowInComponent:DayPicker]];
    NSInteger row = [self.pickerView selectedRowInComponent:DayPicker] + [self daysInMonthForDate:date];
    [self.pickerView selectRow:row inComponent:DayPicker animated:YES];
    [self pickerView:self.pickerView didSelectRow:row inComponent:DayPicker];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y + 700);
    }];
}

- (IBAction)setDateButtonPressed:(id)sender {
    NSDate *selectedDate = [self dateWithSelectedTime];
    NSDictionary *userInfo = @{@"selectedDate": selectedDate};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DateSelected" object:nil userInfo:userInfo];
    [UIView animateWithDuration:1.0 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y + 700);
    }];
}

@end
