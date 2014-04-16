//
//  Created by Dmitry Ivanenko on 15.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import "DIDatepickerDateView.h"


const CGFloat kDIDatepickerItemWidth = 46.;
const CGFloat kDIDatepickerSelectionLineWidth = 51.;


@interface DIDatepickerDateView ()

@property (strong, nonatomic) UILabel *dateLabel;
@property (nonatomic, strong) UIView *selectionView;

@end


@implementation DIDatepickerDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    [self setupViews];

    return self;
}

- (void)setupViews
{
    [self addTarget:self action:@selector(dateWasSelected) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDate:(NSDate *)date
{
    _date = date;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    [dateFormatter setLocale:locale];

    [dateFormatter setDateFormat:@"dd EEE"];
    NSString *dayString = [dateFormatter stringFromDate:date];

    [dateFormatter setDateFormat:@"MMMM"];
    NSString *monthString = [[dateFormatter stringFromDate:date] uppercaseString];

    NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", dayString, monthString]];
    [dateString addAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20], NSForegroundColorAttributeName: [UIColor blackColor] } range:NSMakeRange(0, 2)];
    [dateString addAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:13], NSForegroundColorAttributeName: [UIColor blackColor] } range:NSMakeRange(3, 2)];
    [dateString addAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:8], NSForegroundColorAttributeName: [UIColor colorWithRed:153./255. green:153./255. blue:153./255. alpha:1.] } range:NSMakeRange(6, dateString.string.length - 6)];

    if ([self isWeekday:date]) {
        [dateString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13] range:NSMakeRange(3, 2)];
    }

    self.dateLabel.attributedText = dateString;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;

    self.selectionView.alpha = (int)_isSelected;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _dateLabel.numberOfLines = 2;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
    }

    return _dateLabel;
}

- (UIView *)selectionView
{
    if (!_selectionView) {
        _selectionView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 51) / 2, self.frame.size.height - 3, 51, 3)];
        _selectionView.alpha = 0;
        _selectionView.backgroundColor = [UIColor colorWithRed:242./255. green:93./255. blue:28./255. alpha:1.];
        [self addSubview:_selectionView];
    }

    return _selectionView;
}

- (void)setItemSelectionColor:(UIColor *)itemSelectionColor
{
    _selectionView.backgroundColor = itemSelectionColor;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.selectionView.alpha = self.isSelected ? 1 : .5;
    } else {
        self.selectionView.alpha = self.isSelected ? 1 : 0;
    }
}


#pragma mark Other methods

- (BOOL)isWeekday:(NSDate *)date
{
    NSInteger day = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday];

    const NSInteger kSunday = 1;
    const NSInteger kSaturday = 7;

    BOOL isWeekdayResult = day == kSunday || day == kSaturday;

    return isWeekdayResult;
}

- (void)dateWasSelected
{
    self.isSelected = YES;

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
