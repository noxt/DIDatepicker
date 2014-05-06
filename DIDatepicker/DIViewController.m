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

//    [self.datepicker fillDatesFromCurrentDate:14];
//    [self.datepicker fillCurrentWeek];
//    [self.datepicker fillCurrentMonth];
    [self.datepicker fillCurrentYear];
    [self.datepicker selectDateAtIndex:0];
}

- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEEddMMMM" options:0 locale:nil];

    self.selectedDateLabel.text = [formatter stringFromDate:self.datepicker.selectedDate];
}

@end
