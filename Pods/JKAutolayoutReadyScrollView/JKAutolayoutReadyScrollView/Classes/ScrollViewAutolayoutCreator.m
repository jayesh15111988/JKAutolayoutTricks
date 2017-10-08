//
//  ScrollViewAutolayoutCreator.m
//  JKAutolayoutReadyScrollView
//
//  Created by Jayesh Kawli Backup on 7/16/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ScrollViewAutolayoutCreator.h"
#import <TPKeyboardAvoidingScrollView.h>

@interface ScrollViewAutolayoutCreator ()

@property (nonatomic, strong) TPKeyboardAvoidingScrollView* scrollView;

@end

@implementation ScrollViewAutolayoutCreator

- (instancetype)initWithSuperView:(UIView*)superView andHorizontalScrollingEnabled:(BOOL)horizontalScrollingEnabled {
    
    if (self = [super init]) {
        _scrollView = [TPKeyboardAvoidingScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
        [superView addSubview:_scrollView];
        [_scrollView addSubview:_contentView];
    
        if (!horizontalScrollingEnabled) {
            [superView addConstraint:[NSLayoutConstraint constraintWithItem:superView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
            [superView addConstraint:[NSLayoutConstraint constraintWithItem:superView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        }
    
        NSDictionary* view = NSDictionaryOfVariableBindings(_scrollView, _contentView);
    
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:kNilOptions metrics:nil views:view]];
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:kNilOptions metrics:nil views:view]];
    
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:kNilOptions metrics:nil views:view]];
        [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:kNilOptions metrics:nil views:view]];
    }
    return self;
}

- (void)addBottomSpaceConstraintToLastView:(UIView*)lastView withBottomPadding:(CGFloat)bottomPadding {
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-bottomPadding-|" options:kNilOptions metrics:@{@"bottomPadding": @(bottomPadding)} views:NSDictionaryOfVariableBindings(lastView)]];
}

- (void)scrollToTop {
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
}

- (void)scrollToRight {
    CGPoint rightOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width, 0);
    [self.scrollView setContentOffset:rightOffset animated:YES];
}

- (void)scrollToBottom {
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
}

- (void)scrollToLeft {
    [self.scrollView setContentOffset:
     CGPointMake(-self.scrollView.contentInset.left, 0) animated:YES];
}

@end
