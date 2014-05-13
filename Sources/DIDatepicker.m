//
//  Created by Dmitry Ivanenko on 14.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import "DIDatepicker.h"
#import "DIDatepickerDateView.h"

const NSTimeInterval kSecondsInDay = 24 * 60 * 60;
const NSInteger kMondayOffset = 2;


@interface DIDatepicker ()

@property (strong, nonatomic) UIScrollView *datesScrollView;

@end


@implementation DIDatepicker

- (void)awakeFromNib
{
    _viewClass = [DIDatepickerDateView class];
    [self setupViews];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return self;

    _viewClass = [DIDatepickerDateView class];
    [self setupViews];

    return self;
}

- (void)setupViews
{
    self.spaceBetweenDateViews = 15.0;

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor whiteColor];
    self.bottomLineColor = [UIColor colorWithWhite:0.816 alpha:1.000];
    self.selectedDateBottomLineColor = [UIColor colorWithRed:0.910 green:0.278 blue:0.128 alpha:1.000];
}


#pragma mark Setters | Getters

- (void)setDates:(NSArray *)dates
{
    _dates = dates;

    [self updateDatesView];

    self.selectedDate = nil;
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _selectedDate = selectedDate;

    for (id subview in self.datesScrollView.subviews) {
        if ([subview isKindOfClass:[_viewClass class]]) {
            UIControl<DIDatepickerViewProtocol> *dateView = (UIControl<DIDatepickerViewProtocol> *)subview;
            dateView.isSelected = [dateView.date isEqualToDate:selectedDate];
        }
    }

    [self updateSelectedDatePosition];

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (UIScrollView *)datesScrollView
{
    if (!_datesScrollView) {
        _datesScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _datesScrollView.showsHorizontalScrollIndicator = NO;
        _datesScrollView.autoresizingMask = self.autoresizingMask;
        [self addSubview:_datesScrollView];
    }
    return _datesScrollView;
}

- (void)setSelectedDateBottomLineColor:(UIColor *)selectedDateBottomLineColor
{
    _selectedDateBottomLineColor = selectedDateBottomLineColor;

    for (id subview in self.datesScrollView.subviews) {
        if ([subview conformsToProtocol:@protocol(DIDatepickerViewProtocol)]) {
            UIControl<DIDatepickerViewProtocol> *dateView = (UIControl<DIDatepickerViewProtocol> *)subview;
            [dateView setItemSelectionColor:selectedDateBottomLineColor];
        }
    }
}


#pragma mark Public methods

- (void)fillDatesFromCurrentDate:(NSInteger)nextDatesCount
{
    NSAssert(nextDatesCount < 1000, @"Too much dates");

    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSInteger day = 0; day < nextDatesCount; day++) {
        [dates addObject:[NSDate dateWithTimeIntervalSinceNow:day * kSecondsInDay]];
    }

    self.dates = dates;
}

- (void)fillDatesFromDate:(NSDate *)fromDate numberOfDays:(NSInteger)nextDatesCount
{
    NSAssert(nextDatesCount < 1000, @"Too much dates");

    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSInteger day = 0; day < nextDatesCount; day++)
    {
        [dates addObject:[fromDate dateByAddingTimeInterval:day * kSecondsInDay]];
    }
    
    self.dates = dates;
}

- (void)fillCurrentWeek
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:today];

    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSInteger weekday = 0; weekday < 7; weekday++) {
        [dates addObject:[NSDate dateWithTimeInterval:(kMondayOffset + weekday - todayComponents.weekday) * kSecondsInDay sinceDate:today]];
    }

    self.dates = dates;
}

- (void)fillCurrentMonth
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:today];
    NSDateComponents *todayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:today];

    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSInteger day = 1; day <= days.length; day++) {
        [todayComponents setDay:day];
        [dates addObject:[calendar dateFromComponents:todayComponents]];
    }

    self.dates = dates;
}

- (void)fillCurrentYear
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponents = [calendar components:NSCalendarUnitYear fromDate:today];

    NSMutableArray *dates = [[NSMutableArray alloc] init];

    NSUInteger daysInYear = [self numberOfDaysInThisYear];
    for (NSInteger day = 1; day <= daysInYear; day++) {
        [todayComponents setDay:day];
        [dates addObject:[calendar dateFromComponents:todayComponents]];
    }

    self.dates = dates;
}

- (NSUInteger)numberOfDaysInThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *startOfYear;
    NSTimeInterval lengthOfYear;
    [calendar rangeOfUnit:NSYearCalendarUnit
                startDate:&startOfYear
                 interval:&lengthOfYear
                  forDate:[NSDate date]];
    NSDate *endOfYear = [startOfYear dateByAddingTimeInterval:lengthOfYear];
    NSDateComponents *components = [calendar components:NSDayCalendarUnit
                                         fromDate:startOfYear
                                           toDate:endOfYear
                                          options:0];
    return [components day];
}

- (void)selectDate:(NSDate *)date
{
    NSAssert([self.dates indexOfObject:date] != NSNotFound, @"Date not found in dates array");

    self.selectedDate = date;
}

- (void)selectDateAtIndex:(NSUInteger)index
{
    NSAssert(index < self.dates.count, @"Index too big");

    self.selectedDate = self.dates[index];
}


#pragma mark Private methods

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // draw bottom line
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
    CGContextSetLineWidth(context, .5);
    CGContextMoveToPoint(context, 0, rect.size.height - .5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - .5);
    CGContextStrokePath(context);
}

- (void)updateDatesView
{
    [self.datesScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat currentItemXPosition = self.spaceBetweenDateViews;
    for (NSDate *date in self.dates) {
        UIControl<DIDatepickerViewProtocol> *dateView = [[_viewClass alloc] initWithFrame:CGRectMake(currentItemXPosition,
                                                                                                     0,
                                                                                                     [_viewClass itemWidth],
                                                                                                     self.frame.size.height)];
        dateView.date = date;
        dateView.selected = [date isEqualToDate:self.selectedDate];
        [dateView setItemSelectionColor:self.selectedDateBottomLineColor];
        [dateView addTarget:self action:@selector(updateSelectedDate:) forControlEvents:UIControlEventValueChanged];

        [self.datesScrollView addSubview:dateView];

        currentItemXPosition += [_viewClass itemWidth] + self.spaceBetweenDateViews;
    }

    self.datesScrollView.contentSize = CGSizeMake(currentItemXPosition, self.frame.size.height);
}

- (void)updateSelectedDate:(UIControl<DIDatepickerViewProtocol> *)dateView
{
    self.selectedDate = dateView.date;
}

- (void)updateSelectedDatePosition
{
    NSUInteger itemIndex = [self.dates indexOfObject:self.selectedDate];

    CGSize itemSize = CGSizeMake([_viewClass itemWidth] + self.spaceBetweenDateViews, self.frame.size.height);
    CGFloat itemOffset = itemSize.width * itemIndex - (self.frame.size.width - ([_viewClass itemWidth] + 2 * self.spaceBetweenDateViews)) / 2;

    itemOffset = MAX(0, MIN(self.datesScrollView.contentSize.width - (self.frame.size.width ), itemOffset));

    [self.datesScrollView setContentOffset:CGPointMake(itemOffset, 0) animated:YES];
}

@end
