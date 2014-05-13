//
//  Created by Dmitry Ivanenko on 14.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DIDatepicker : UIControl

// data
@property (strong, nonatomic) NSArray *dates;
@property (strong, nonatomic, readonly) NSDate *selectedDate;

// UI
@property (strong, nonatomic) UIColor *bottomLineColor;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) UIColor *selectedDateBottomLineColor;

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
