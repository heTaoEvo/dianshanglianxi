//
//  YJSearchBar.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/30.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJSearchBar.h"


@interface YJSearchBar ()
@property (nonatomic, strong) UIImageView *backGroundView;

@end

@implementation YJSearchBar

- (void)awakeFromNib
{
    NSLog(@"加载");
    [self setupSubviews];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setupSubviews {
    
    self.backGroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.backGroundView];
    
    self.textField = [[UITextField alloc] initWithFrame:self.bounds];
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.delegate = self;

    self.textField.clearButtonMode = YES;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.returnKeyType = UIReturnKeySearch;
    //self.textField.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OCSearchBarDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self setupDefaultLeftImageView];
    [self setupDefaultBackGroundView];
}

- (void)setupDefaultBackGroundView {
    
    // 使用颜色创建UIImage
//    CGSize imageSize = self.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
////    [RGB(26, 66, 38) set];
//    [[UIColor colorWithRed:26 green:66 blue:38 alpha:1] set];
//
//    
//    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
//    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.backGroundView.layer.cornerRadius = 6;
    self.backGroundView.layer.masksToBounds = YES;
    
    self.backGroundView.layer.borderWidth = 1;
    self.backGroundView.layer.borderColor = TextColor.CGColor;
}

- (void)setupDefaultLeftImageView {
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_search"]];
    [leftImageView setFrame:CGRectMake(13, 6, 22, 25)];
    self.leftImageView = leftImageView;
}

- (void)setFont:(UIFont *)font {
    self.textField.font = font;
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    [self.textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)setTextColor:(UIColor *)textColor {
    [self.textField setTextColor:textColor];
    
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setBackViewImage:(UIImage *)backViewImage {
    [self.backGroundView setImage:backViewImage];
    
}

- (void)setLeftImageView:(UIImageView *)leftImageView {
    if (self.leftImageView.superview) {
        [self.leftImageView removeFromSuperview];
    }
    [self addSubview:leftImageView];
    CGRect rect = self.textField.bounds;
    rect.origin.x = rect.origin.x+leftImageView.frame.origin.x+leftImageView.frame.size.width+5;
    rect.size.width = rect.size.width - leftImageView.frame.origin.x - leftImageView.frame.size.width-5;
    [self.textField setFrame:rect];
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

- (void)resignFirstResponder {
    [self.textField resignFirstResponder];
}

- (void)becomeFirstResponder {
    [self.textField becomeFirstResponder];
}


#pragma mark -
#pragma mark - OCTextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBarShouldBeginEditing:)] ) {
        return [self.delegate OCSearchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.isFirstResponder = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBarTextDidBeginEditing:)]) {
        [self.delegate OCSearchBarTextDidBeginEditing:self];
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBarShouldEndEditing:)]) {
        return [self.delegate OCSearchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBarTextDidEndEditing:)]) {
        [self.delegate OCSearchBarTextDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBar:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate OCSearchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBarSearchButtonClicked:)]) {
        [self.delegate OCSearchBarSearchButtonClicked:self];
    }
    return YES;
}

- (void)OCSearchBarDidChange:(NSNotification *)notification {
    UITextField *textField = [notification object];
    if (self.delegate && [self.delegate respondsToSelector:@selector(OCSearchBar:textDidChange:)]) {
        [self.delegate OCSearchBar:self textDidChange:textField.text];
    }
}

@end

