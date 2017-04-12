//
//  PYColorPickerImageView.h
//  PYColorPicker
//
//  Created by PodiMac on 2017/4/12.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYColorPickerImageView : UIImageView
@property (copy, nonatomic) void(^selectedColorBlock)(UIColor *color);

@end
