//
//  Created by Dmitry Ivanenko on 14.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import <UIKit/UIKit.h>

// some defines for keys, that should cover the basic configuration for the drawing process
// of DIDatePickerview. It's just colors and fonts for now. For everything else it
// would probably be easier to reimplement the view

#define DIDatePickerViewDayTextColor        @"dayTextColor"
#define DIDatePickerViewWeekdayTextColor    @"weekdayTextColor"
#define DIDatePickerViewMonthTextColor      @"monthTextColor"
#define DIDatePickerViewBackgroundColor     @"backgroundColor"

#define DIDatePickerViewDayTextFont         @"dayTextFont"
#define DIDatePickerViewWeekdayTextFont     @"weekdayTextFont"
#define DIDatePickerViewWeekendDayTextFont  @"weekendDayTextFont"
#define DIDatePickerViewMonthTextFont       @"monthTextFont"

#define DIDatePickerViewLineColor           @"lineColor"
#define DIDatePickerViewSelectionColor      @"selectionColor"


@interface DIDatepicker : UIControl

// data
@property (strong, nonatomic) NSArray *dates;
@property (strong, nonatomic, readonly) NSDate *selectedDate;

// UI properties - left in for compability, should they be deprecated?
@property (strong, nonatomic) UIColor *bottomLineColor;
@property (strong, nonatomic) UIColor *selectedDateBottomLineColor;

// instead of adding a multitude of properties, we use one
// configuration dictionary for the view drawing process
// this allows other view classes to
@property (strong, nonatomic) NSDictionary *viewConfiguration;

@property (assign) CGFloat spaceBetweenDateViews;

// configuration of view used. class must conform to 
@property (assign) Class viewClass;

// methods
- (void)fillDatesFromCurrentDate:(NSInteger)nextDatesCount;
- (void)fillDatesFromDate:(NSDate *)fromDate numberOfDays:(NSInteger)nextDatesCount;
- (void)fillCurrentWeek;
- (void)fillCurrentMonth;
- (void)fillCurrentYear;
- (void)selectDate:(NSDate *)date;
- (void)selectDateAtIndex:(NSUInteger)index;

@end
