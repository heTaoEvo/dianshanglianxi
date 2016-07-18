//
//  YJSearchBar.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/30.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJSearchBar;

@protocol YJSearchBarDelegate <NSObject>


@optional

- (BOOL)OCSearchBarShouldBeginEditing:(YJSearchBar *)searchBar;
- (void)OCSearchBarTextDidBeginEditing:(YJSearchBar *)searchBar;
- (BOOL)OCSearchBarShouldEndEditing:(YJSearchBar *)searchBar;
- (void)OCSearchBarTextDidEndEditing:(YJSearchBar *)searchBar;

- (void)OCSearchBar:(YJSearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)OCSearchBar:(YJSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)OCSearchBarSearchButtonClicked:(YJSearchBar *)searchBar;

@end

@interface YJSearchBar : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIImage *backViewImage;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *leftImageView;//左侧放大镜
@property (nonatomic, copy  ) NSString *placeholder;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy)   NSString *text;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) BOOL isFirstResponder;

@property (nonatomic, weak) id <YJSearchBarDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)resignFirstResponder;
- (void)becomeFirstResponder;


@end
