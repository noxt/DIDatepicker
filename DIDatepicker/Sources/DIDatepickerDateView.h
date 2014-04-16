//
//  Created by Dmitry Ivanenko on 15.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const CGFloat kDIDatepickerItemWidth;
extern const CGFloat kDIDatepickerSelectionLineWidth;


@interface DIDatepickerDateView : UIControl

// data
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isSelected;

// methods
- (void)setItemSelectionColor:(UIColor *)itemSelectionColor;

@end
