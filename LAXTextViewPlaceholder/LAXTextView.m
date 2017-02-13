
//
//  LAXTextView.m
//  LAXTextViewplaceholder
//
//  Created by 刘翱翔 on 2017/1/7.
//  Copyright © 2017年 liuaoxiang. All rights reserved.
//

#import "LAXTextView.h"
#import "NSObject+KVOCategory.h"
#import "NSObject+FBKVOController.h"

@interface LAXTextView ()

@property(nonatomic,copy) UIFont *placeholderFont;
@property (nonatomic, strong) UILabel * placeholderLabel;

@end

@implementation LAXTextView

#pragma mark - Setters

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        [self setup];
    }
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    if([placeholder isEqualToString:_placeholder]) {
        return;
    }
    
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self setNeedsDisplay];
    [self notificationAction];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    if([placeholderColor isEqual:_placeholderColor]) {
        return;
    }
    
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = _placeholderColor;
    [self setNeedsDisplay];
    [self notificationAction];
}

#pragma mark - Message text view

- (NSUInteger)numberOfLinesOfText {
    
    return [LAXTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine {
    
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text {
    
    return (text.length / [LAXTextView maxCharactersPerLine]) + 1;
}

#pragma mark - Text view overrides

- (void)setText:(NSString *)text {
    
    self.hasText2 = NO;
    if (text.length > 0) {
        self.hasText2 = YES;
        [self notificationAction];
    }
    
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    
    [self setPlaceholderFrame];
    self.placeholderFont = font;
    self.placeholderLabel.font = font;
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}



- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    
    _placeholder = nil;
    _placeholderColor = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
    [self.KVOController unobserveAll];
    
    //end_code
}

#pragma mark - custom func

- (CGRect)getRectFromString:(NSString *)string fontSize:(UIFont *)font {
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(100, 1000) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    return rect;
}

- (void)setPlaceholderFrame {
    //    self.backgroundColor = [UIColor blueColor];
    if (self.placeholderLabel != nil) {
        //        CGFloat h = [self getRectFromString:_placeholder fontSize:_placeholderFont].size.height;
        //        NSLog(@"%f", h);
        self.placeholderLabel.frame = CGRectMake(0, 7, self.bounds.size.width, 20);
        //        self.placeholderLabel.backgroundColor = [UIColor redColor];
        //self.placeholderLabel.frame = CGRectMake(5, 7, self.bounds.size.width - 20, 20);
    }
}

- (void)setup {
    
    //添加一个通知，监听textview的内容是否改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction) name:UITextViewTextDidChangeNotification object:self];
    
    
    self.placeholderLabel = [[UILabel alloc]init];
    self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
    
    __weak LAXTextView *ws = self;
    self.KVOController = [FBKVOController controllerWithObserver:self];
    [self.KVOController observe:self keyPath:@"frame" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld block:^(id observer, id object, NSDictionary *change)
     {
         [ws setPlaceholderFrame];
     }];
    
    self.placeholder = @"";
    self.placeholderFont = self.font;
    self.placeholderColor= [UIColor grayColor];
    
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.text = _placeholder;
    self.placeholderLabel.numberOfLines = 0;
    
    [self addSubview:self.placeholderLabel];
    
    self.font= [UIFont systemFontOfSize:14];
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    
    [self setNeedsDisplay];
}

- (void)notificationAction{
    
    self.placeholderLabel.hidden = (self.hasText || self.hasText2);
    self.placeholderLabel.text = _placeholder;
    
}

@end
