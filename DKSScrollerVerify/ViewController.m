//
//  ViewController.m
//  DKSScrollerVerify
//
//  Created by aDu on 2018/3/26.
//  Copyright © 2018年 DuKaiShun. All rights reserved.
//

#import "ViewController.h"

#define SliderWidth 240
#define SliderHeight 40
#define SliderLabelTextColor [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1]
#define SliderLabelBorderColor [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1].CGColor
#define SliderMinimumTrackTintColor [UIColor redColor]
#define SliderLabelFont 14
#define SliderLabelText @"滑动解锁/获取验证码"
#define ThumbImageWidth 40
#define ThumbImageHeight 40
@interface ViewController ()

@property (nonatomic ,strong) CheckCodeSlider *slider;
@property (nonatomic ,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSlider];
}

- (void)createSlider {
    _slider = [[CheckCodeSlider alloc] initWithFrame:CGRectMake(0, 0, SliderWidth, SliderHeight)];
    _slider.center = self.view.center;
    _slider.minimumTrackTintColor = [UIColor clearColor];
    _slider.maximumTrackTintColor = [UIColor clearColor];
    _slider.layer.masksToBounds = YES;
    _slider.layer.cornerRadius = SliderHeight / 2;
    UIImage *sliderImg = [self originImage:[UIImage imageNamed:@"doble_arrow"] scaleToSize:CGSizeMake(SliderHeight, SliderHeight)];
    [_slider setThumbImage:sliderImg forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SliderWidth, SliderHeight)];
    _label.center = self.view.center;
    _label.text = SliderLabelText;
    _label.font = [UIFont systemFontOfSize:SliderLabelFont];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = SliderLabelTextColor;
    _label.layer.masksToBounds = YES;
    _label.layer.cornerRadius = SliderHeight / 2;
    _label.layer.borderWidth = 1;
    _label.layer.borderColor = SliderLabelBorderColor;
    [self.view addSubview:_label];
}

- (void)sliderValueChanged:(UISlider *)slider {
    [_slider setValue:slider.value animated:NO];
    if (slider.value == 1) {
        UIImage *sliderImg = [self originImage:[UIImage imageNamed:@"right_img"] scaleToSize:CGSizeMake(SliderHeight, SliderHeight)];
        [_slider setThumbImage:sliderImg forState:UIControlStateNormal];
    } else {
        UIImage *sliderImg = [self originImage:[UIImage imageNamed:@"doble_arrow"] scaleToSize:CGSizeMake(SliderHeight, SliderHeight)];
        [_slider setThumbImage:sliderImg forState:UIControlStateNormal];
    }
    if (slider.value > 0) {
        _slider.minimumTrackTintColor = [UIColor redColor];
    } else {
        _slider.minimumTrackTintColor = [UIColor clearColor];
    }
    
    if (!slider.isTracking && slider.value != 1) {
        [_slider setValue:0 animated:YES];
        if (slider.value > 0) {
            _slider.minimumTrackTintColor = SliderMinimumTrackTintColor;
        } else {
            _slider.minimumTrackTintColor = [UIColor clearColor];
        }
    }
}

- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return scaledImage;
}

@end

@implementation CheckCodeSlider
//覆写父类UISlider的方法改变滑条frame
- (CGRect)trackRectForBounds:(CGRect)bounds {
    [super trackRectForBounds:bounds];
    return CGRectMake(0, 0, SliderWidth, SliderHeight);
}

@end
