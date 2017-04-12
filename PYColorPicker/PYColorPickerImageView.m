//
//  PYColorPickerImageView.m
//  PYColorPicker
//
//  Created by PodiMac on 2017/4/12.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import "PYColorPickerImageView.h"

@implementation PYColorPickerImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width)];
    if (self) {
        
        self.image = [UIImage imageNamed:@"palette"];
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.image = [UIImage imageNamed:@"palette"];
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.layer.masksToBounds = YES;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width/2;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    
    if (pow(pointL.x - self.bounds.size.width/2, 2)+pow(pointL.y-self.bounds.size.width/2, 2) <= pow(self.bounds.size.width/2, 2)) {
        
        UIColor *color = [self colorAtPixel:pointL];
        if (self.selectedColorBlock) {
            
            self.selectedColorBlock(color);
        }
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    
    if (pow(pointL.x - self.bounds.size.width/2, 2)+pow(pointL.y-self.bounds.size.width/2, 2) <= pow(self.bounds.size.width/2, 2)) {
        
        UIColor *color = [self colorAtPixel:pointL];
        
        if (self.selectedColorBlock) {
            
            self.selectedColorBlock(color);
        }
    }
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    
    if (pow(pointL.x - self.bounds.size.width/2, 2)+pow(pointL.y-self.bounds.size.width/2, 2) <= pow(self.bounds.size.width/2, 2)) {
        
        UIColor *color = [self colorAtPixel:pointL];
        
        if (self.selectedColorBlock) {
            
            self.selectedColorBlock(color);
        }
    }
}



//获取图片某一点的颜色
- (UIColor *)colorAtPixel:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.image.size.width, self.image.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.image.CGImage;
    NSUInteger width = self.image.size.width;
    NSUInteger height = self.image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    NSLog(@"%f %f %f %f",(CGFloat)pixelData[0],(CGFloat)pixelData[1],(CGFloat)pixelData[2],(CGFloat)pixelData[3]);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)setImage:(UIImage *)image {
    UIImage *temp = [self imageForResizeWithImage:image resize:CGSizeMake(self.frame.size.width, self.frame.size.width)];
    [super setImage:temp];
}

- (UIImage *)imageForResizeWithImage:(UIImage *)picture resize:(CGSize)resize {
    CGSize imageSize = resize; //CGSizeMake(25, 25)
    UIGraphicsBeginImageContextWithOptions(imageSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [picture drawInRect:imageRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

@end
