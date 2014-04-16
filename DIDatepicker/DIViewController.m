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

@end


@implementation DIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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
}

@end
