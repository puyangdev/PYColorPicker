//
//  ViewController.m
//  PYColorPicker
//
//  Created by PodiMac on 2017/4/12.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import "ViewController.h"
#import "PYColorPickerImageView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PYColorPickerImageView *colorPickImageView;
@property (weak, nonatomic) IBOutlet UIImageView *colorShowImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.colorPickImageView setSelectedColorBlock:^(UIColor *color)
    {
        self.colorShowImageView.backgroundColor=color;
//        self.view.backgroundColor=color;
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
