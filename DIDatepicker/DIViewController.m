//
//  DIViewController.m
//  DIDatepicker
//
//  Created by Dmitry Ivanenko on 14.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import "DIViewController.h"
#import "DIDatepicker.h"


@interface DIViewController ()

@property (weak, nonatomic) IBOutlet DIDatepicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;

@end


@implementation DIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];

    self.datepicker.dates = @[
                              [NSDate dateWithTimeIntervalSinceNow:0],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 1],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 2],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 3],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 4],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 5],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 6],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 7],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 8],
                              [NSDate dateWithTimeIntervalSinceNow:86400 * 9],
                              ];
    [self.datepicker selectDateAtIndex:0];
}

- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEEddMMMM" options:0 locale:nil];

    self.selectedDateLabel.text = [formatter stringFromDate:self.datepicker.selectedDate];
}

@end
