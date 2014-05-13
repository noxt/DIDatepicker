//
//  Created by Dmitry Ivanenko on 15.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DIDatepickerViewProtocol

@required

// data
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSDictionary *viewConfiguration;

// class methods communicating the size requirements of the view implementation
+ (CGFloat)itemWidth;


// deprecated methods, superseeded by viewConfiguration
- (void)setItemSelectionColor:(UIColor *)itemSelectionColor;

@end

@interface DIDatepickerDateView : UIControl<DIDatepickerViewProtocol>

@property (strong, nonatomic) NSDictionary *viewConfiguration;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isSelected;

@end
