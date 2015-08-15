//
//  ScrollViewAutolayoutCreator.m
//  JKAutolayoutReadyScrollView
//
//  Created by Jayesh Kawli Backup on 7/16/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ScrollViewAutolayoutCreator.h"
#import <TPKeyboardAvoidingScrollView.h>

@implementation ScrollViewAutolayoutCreator

- (instancetype)initWithSuperView:(UIView*)superView {
    
    if (self = [super init]) {
        TPKeyboardAvoidingScrollView* scrollView = [TPKeyboardAvoidingScrollView new];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
        [superView addSubview:scrollView];
        [scrollView addSubview:_contentView];
    
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:superView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:superView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    
        NSDictionary* view = NSDictionaryOfVariableBindings(scrollView, _contentView);
    
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:kNilOptions metrics:nil views:view]];
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:view]];
    
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:kNilOptions metrics:nil views:view]];
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:kNilOptions metrics:nil views:view]];
    }
    return self;
}

- (void)addBottomSpaceConstraintToLastView:(UIView*)lastView withBottomPadding:(CGFloat)bottomPadding {
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-bottomPadding-|" options:kNilOptions metrics:@{@"bottomPadding": @(bottomPadding)} views:NSDictionaryOfVariableBindings(lastView)]];
}

@end
