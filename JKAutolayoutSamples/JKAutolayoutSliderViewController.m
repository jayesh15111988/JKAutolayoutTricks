//
//  JKAutolayoutSliderViewController.m
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/15/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKAutolayoutSliderViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <JKAutolayoutReadyScrollView/ScrollViewAutolayoutCreator.h>

@interface JKAutolayoutSliderViewController ()

@end

@implementation JKAutolayoutSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScrollViewAutolayoutCreator* autoLayoutScrollView = [[ScrollViewAutolayoutCreator alloc] initWithSuperView:self.view];
    NSArray* headerViews = @[@"first_header", @"second_header", @"third_header"];
    NSDictionary* subHeaderViews = @{@"first_header": @[@"1", @"2", @"3", @"11", @"22"], @"second_header": @[@"4", @"5", @"6"], @"third_header": @[@"7", @"8", @"9"]};
    NSDictionary* metrics = @{@"padding": @(10)};
    NSInteger outerIndexTracker = 0, innerIndexTracker;
    UIView* previousSubHeadersCollectionView = nil;
    for (NSString* header in headerViews) {
                innerIndexTracker = 0;
        UILabel* headerLabel = [UILabel new];
        [headerLabel setBackgroundColor:[UIColor redColor]];
        UIButton* headerButton = [UIButton new];
        [headerLabel addSubview:headerButton];
        headerLabel.text = header;
        [autoLayoutScrollView.contentView addSubview:headerLabel];
        
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[headerLabel]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(headerLabel)]];
        if (outerIndexTracker == 0) {
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[headerLabel]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(headerLabel)]];
        } else {
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousSubHeadersCollectionView]-padding-[headerLabel]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(previousSubHeadersCollectionView, headerLabel)]];
        }
        
        [headerLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[headerButton]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(headerButton)]];
         [headerLabel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[headerButton]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(headerButton)]];
        [headerButton setTitle:@"asdasd" forState:UIControlStateNormal];
        [[headerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
        }];
        NSArray* subHeadersCollection = subHeaderViews[header];
        UIView* subHeaderView = [UIView new];
        [autoLayoutScrollView.contentView addSubview:subHeaderView];
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[subHeaderView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(subHeaderView)]];
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabel]-[subHeaderView(innerSubviewsHolderHeight)]" options:kNilOptions metrics:@{@"innerSubviewsHolderHeight": @(subHeadersCollection.count * 30)} views:NSDictionaryOfVariableBindings(headerLabel, subHeaderView)]];
        
        UILabel* innerLabelRef = nil;
        for (NSString* subHeader in subHeadersCollection) {
            UILabel* innerLabel = [UILabel new];
            innerLabel.text = subHeader;
            [subHeaderView addSubview:innerLabel];
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[innerLabel]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabel)]];
            if (innerIndexTracker == 0) {
                [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[innerLabel]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabel)]];
            } else {
                [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerLabelRef]-[innerLabel]" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(innerLabelRef, innerLabel)]];
            }
            innerLabelRef = innerLabel;
            innerIndexTracker++;
        }
        previousSubHeadersCollectionView = subHeaderView;
        outerIndexTracker++;
    }
}

@end
