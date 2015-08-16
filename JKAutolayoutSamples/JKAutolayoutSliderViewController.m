//
//  JKAutolayoutSliderViewController.m
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/15/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKAutolayoutSliderViewController.h"
#import "AutolayoutedExpandableView.h"
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
    NSDictionary* subHeaderViews = @{@"first_header": @[@"1", @"2", @"1", @"2", @"1", @"2", @"1", @"2", @"1", @"2", @"1", @"2"], @"second_header": @[@"2", @"4"]};
    CGFloat padding = 10.0;
    NSDictionary* metrics = @{@"padding": @(padding)};
    id topLayout = self.topLayoutGuide;
    NSInteger outerIndexTracker = 0, innerIndexTracker;
    UIView* previousSubHeadersCollectionView = nil;
    for (NSString* header in headerViews) {
        innerIndexTracker = 0;
        UIView* headerLabelView = [UIView new];
        UILabel* headerLabel = [UILabel new];
        [headerLabelView addSubview:headerLabel];
        [headerLabelView setBackgroundColor:[UIColor redColor]];
        headerLabel.text = header;
        [autoLayoutScrollView.contentView addSubview:headerLabelView];
        
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[headerLabelView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(headerLabelView)]];
        if (outerIndexTracker == 0) {
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[headerLabelView]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(topLayout, headerLabelView)]];
        } else {
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousSubHeadersCollectionView]-padding-[headerLabelView]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(previousSubHeadersCollectionView, headerLabelView)]];
        }
        
        [headerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[headerLabel]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        [headerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[headerLabel]-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(headerLabel)]];
        
        NSArray* subHeadersCollection = subHeaderViews[header];
        AutolayoutedExpandableView* subHeaderView = [AutolayoutedExpandableView new];
        [autoLayoutScrollView.contentView addSubview:subHeaderView];
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[subHeaderView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(subHeaderView)]];
        [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabelView]-padding-[subHeaderView(>=0)]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(headerLabelView, subHeaderView)]];
        
        UIView* innerLabelViewRef = nil;
        
        for (NSString* subHeader in subHeadersCollection) {
            
            UIView* innerLabelView = [UIView new];
            innerLabelView.clipsToBounds = YES;
            [innerLabelView setBackgroundColor:[UIColor yellowColor]];
            [innerLabelView bk_whenTapped:^{
                NSLog(@"Section %ld and Row %ld pressed", outerIndexTracker, innerIndexTracker);
//                [innerLabelView addConstraint:[NSLayoutConstraint constraintWithItem:innerLabelView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0]];
            }];
            
            UIView* bottomBorderView = [UIView new];
            [innerLabelView addSubview:bottomBorderView];
            bottomBorderView.backgroundColor = [UIColor lightGrayColor];
            
            UILabel* innerLabel = [UILabel new];
            innerLabel.text = subHeader;
            innerLabel.numberOfLines = 0;
            [subHeaderView addSubview:innerLabelView];
            [subHeaderView setBackgroundColor:[UIColor blueColor]];
            [innerLabelView addSubview:innerLabel];
            
            [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[innerLabelView]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabelView)]];
            if (innerIndexTracker == 0) {
                [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[innerLabelView]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabelView)]];
            } else {
                if (innerIndexTracker == subHeadersCollection.count - 1) {
                    [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerLabelViewRef][innerLabelView]|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabelViewRef, innerLabelView)]];
                } else {
                    [autoLayoutScrollView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[innerLabelViewRef][innerLabelView]" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(innerLabelViewRef, innerLabelView)]];
                }
            }
            
            [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[innerLabel]-padding-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabel)]];
            [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding@500-[innerLabel]-padding@500-|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(innerLabel)]];
            
            [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomBorderView]|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(bottomBorderView)]];
            [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomBorderView(1)]|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(bottomBorderView)]];
            
            
            if (innerIndexTracker == 0) {
                UIView* subHeaderViewTopBorder = [UIView new];
                [innerLabelView addSubview:subHeaderViewTopBorder];
                subHeaderViewTopBorder.backgroundColor = [UIColor lightGrayColor];
                [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subHeaderViewTopBorder]|" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(subHeaderViewTopBorder)]];
                [innerLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subHeaderViewTopBorder(1)]" options:kNilOptions metrics:metrics views:NSDictionaryOfVariableBindings(subHeaderViewTopBorder)]];
            }
            
            innerLabelViewRef = innerLabelView;
            innerIndexTracker++;
        }
        
        __block NSLayoutConstraint* con;
        
        [headerLabelView bk_whenTapped:^{
            //NSLog(@"Section %ld Pressed and SubheaderView frame is %@", (long)outerIndexTracker,subHeaderView);
            //NSLog(@"%f height", subHeaderView.frame.size.height);
            
            if (!subHeaderView.isExpanded) {
                if (!con) {
                    subHeaderView.originalViewHeight = subHeaderView.frame.size.height;
                    con = [NSLayoutConstraint constraintWithItem:subHeaderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
                    [subHeaderView addConstraint:con];
                } else {
                    con.constant = 0;
                }
            } else {
                con.constant = subHeaderView.originalViewHeight;
            }
            
            subHeaderView.isExpanded = !subHeaderView.isExpanded;
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
            
            for (UIView* subV in subHeaderView.subviews) {
                //NSLog(@"%@\n\n", subV);
                //[subV addConstraint:[NSLayoutConstraint constraintWithItem:subV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0]];
                for (NSLayoutConstraint* con in subV.constraints) {
                    //NSLog(@"%ld -- %ld -- %f\n\n", (long)con.firstAttribute, (long)con.secondAttribute, con.constant);
                    if (con.firstAttribute == NSLayoutAttributeHeight && !con.secondAttribute) {
                        //con.constant = 0;
                        //NSLog(@"%ld -- %ld -- %f\n\n", (long)con.firstAttribute, (long)con.secondAttribute, con.constant);
                    }
                }
            }
        }];
        
        previousSubHeadersCollectionView = subHeaderView;
        if (outerIndexTracker == headerViews.count - 1) {
            [autoLayoutScrollView addBottomSpaceConstraintToLastView:subHeaderView withBottomPadding:20.0f];
        }
        outerIndexTracker++;
    }
}

@end
