//
//  JKAutolayoutSliderViewController.m
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/15/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKAutolayoutSliderViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <JKAutolayoutReadyScrollView/ScrollViewAutolayoutCreator.h>

@interface JKAutolayoutSliderViewController ()

@end

@implementation JKAutolayoutSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScrollViewAutolayoutCreator* autoLayoutScrollView = [[ScrollViewAutolayoutCreator alloc] initWithSuperView:self.view];
    NSArray* headerViews = @[@"first_header", @"second_header"];
    NSDictionary* subHeaderViews = @{@"first_header": @[@"1", @"2"], @"second_header": @[@"2", @"4"]};
    NSDictionary* metrics = @{@"padding": @(10)};
    NSInteger outerIndexTracker = 0, innerIndexTracker;
    UIView* previousSubHeadersCollectionView = nil;
    for (NSString* header in headerViews) {
        innerIndexTracker = 0;
        UIView* headerLabelView = [UIView new];
        UILabel* headerLabel = [UILabel new];
        [headerLabelView bk_whenTapped:^{
            NSLog(@"Section %ld Pressed", (long)outerIndexTracker);
        }];
        [headerLabelView addSubview:headerLabel];
        [headerLabelView setBackgroundColor:[UIColor redColor]];
        headerLabel.text = header;
        [autoLayoutScrollView.contentView addSubview:headerLabelView];
        
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[headerLabelView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(headerLabelView)]];
        if (outerIndexTracker == 0) {
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[headerLabelView]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(headerLabelView)]];
        } else {
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousSubHeadersCollectionView]-padding-[headerLabelView]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(previousSubHeadersCollectionView, headerLabelView)]];
        }
        
        [headerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[headerLabel]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        [headerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[headerLabel]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        
        NSArray* subHeadersCollection = subHeaderViews[header];
        UIView* subHeaderView = [UIView new];
        [autoLayoutScrollView.contentView addSubview:subHeaderView];
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[subHeaderView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(subHeaderView)]];
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabelView]-padding-[subHeaderView(innerSubviewsHolderHeight)]" options:kNilOptions metrics:@{@"innerSubviewsHolderHeight": @(subHeadersCollection.count * 30), @"padding": @(10)} views:NSDictionaryOfVariableBindings(headerLabelView, subHeaderView)]];
        
        UIView* innerLabelViewRef = nil;
        
        for (NSString* subHeader in subHeadersCollection) {
            UIView* innerLabelView = [UIView new];
            [innerLabelView bk_whenTapped:^{
                NSLog(@"Section %ld and Row %ld pressed", outerIndexTracker, innerIndexTracker);
            }];
            UILabel* innerLabel = [UILabel new];
            innerLabel.text = subHeader;
            [subHeaderView addSubview:innerLabelView];
            [innerLabelView addSubview:innerLabel];
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[innerLabelView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabelView)]];
            if (innerIndexTracker == 0) {
                [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[innerLabelView]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabelView)]];
            } else {
                [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerLabelViewRef]-[innerLabelView]" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(innerLabelViewRef, innerLabelView)]];
            }
            
            [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[innerLabel]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(innerLabel)]];
            [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[innerLabel]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(innerLabel)]];
            
            innerLabelViewRef = innerLabelView;
            innerIndexTracker++;
        }
        previousSubHeadersCollectionView = subHeaderView;
        if (header == [headerViews lastObject]) {
            [autoLayoutScrollView addBottomSpaceConstraintToLastView:subHeaderView withBottomPadding:20.0f];
        }
        outerIndexTracker++;
    }
}

@end
