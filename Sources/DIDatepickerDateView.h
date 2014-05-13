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

// class methods communicating the size requirements of the view implementation
+ (CGFloat)itemWidth;

// methods for supporting simple restyling (e.g. font & color)
- (void)setItemSelectionColor:(UIColor *)itemSelectionColor;

@end

@interface DIDatepickerDateView : UIControl<DIDatepickerViewProtocol>

@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isSelected;

@end
