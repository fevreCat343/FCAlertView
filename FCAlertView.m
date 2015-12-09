//
//  FCAlertView.m
//  gitDemo
//
//  Created by John on 15/12/9.
//  Copyright © 2015年 FeverCat. All rights reserved.
//
typedef void (^animationFinished)();
#import "FCAlertView.h"
#define DEFAULT_BG_COlOR [UIColor colorWithRed:200.0/255 green:100.0/255 blue:100.0/255 alpha:1]
#define DEFAULT_TEXT_COLOR [UIColor whiteColor]
@interface FCAlertView ()
@property (copy, nonatomic) NSString *content;

@end
@implementation FCAlertView
{
    BOOL _stopProcessing;
    UILabel *_contentL;
    CGRect _contentF;
    UIView *_bgV;
}

- (instancetype)initWithAlertContent:(NSString *)content {
    return [self initWithAlertContent:content textColor:DEFAULT_TEXT_COLOR backgroundColor:DEFAULT_BG_COlOR];
}

- (instancetype)initWithAlertContent:(NSString *)content
                           textColor:(UIColor *)textColor
                     backgroundColor:(UIColor *)backgroundColor {
    if (self = [super init]){
        self.backgroundColor = [UIColor clearColor];
        _content = content;
        if (_content) {
            _contentL = [[UILabel alloc] init];
            _contentL.numberOfLines = 0;
            _contentL.text = content;
            _contentL.textColor = textColor;
            _contentL.textAlignment = NSTextAlignmentCenter;
            
            _bgV = [[UIView alloc] init];
            _bgV.backgroundColor = backgroundColor;
            [_bgV addSubview:_contentL];
            [self addSubview:_bgV];
            
            _bgV.alpha = 0.0f;
            
            CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
            CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
            NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
            textAttr[NSFontAttributeName] = _contentL.font;
            _contentF = [content boundingRectWithSize:CGSizeMake(screenW - 20, screenH - 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil];
        }
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    _bgV.layer.cornerRadius = 4;
    _bgV.clipsToBounds = YES;
}
#pragma mark -
- (void)showOnView:(UIView *)view forTime:(CGFloat)duration
{
    [self setupFramesOnView:view];
    [self animationShowThenDisappearWithDuration:0.25 delay:duration finished:nil];
}
- (void)showOnView:(UIView *)view
{
    [self setupFramesOnView:view];
    [self animationShowThenDisappearWithDuration:0.25 delay:1 finished:nil];
}
- (void)showOnView:(UIView *)view begin:(Begin)begin completion:(Complation)completion
{
    if(begin) begin();
    [self setupFramesOnView:view];
    [self animationShowThenDisappearWithDuration:0.25 delay:1 finished:^{
        completion();
    }];
}
#pragma mark - privateMethod
- (void)setupFramesOnView:(UIView *)view
{
    self.frame = view.bounds;
    _contentL.frame = (CGRect){{10, 10}, _contentF.size};
    _bgV.bounds = (CGRect){{0,0},_contentF.size.width + 20, _contentF.size.height + 20};
    _bgV.center = self.center;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}
- (void)animationShowThenDisappearWithDuration:(CGFloat)duration delay:(CGFloat)delay finished:(Complation)finish
{
    [UIView animateWithDuration:duration animations:^{
        _bgV.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            _bgV.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (finish) finish();
        }];
    }];
}
@end
