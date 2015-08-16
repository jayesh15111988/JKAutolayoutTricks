//
//  JKAutoResizingCenterViewViewController.m
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/15/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKAutoResizingCenterViewViewController.h"

@interface JKAutoResizingCenterViewViewController ()

@end

@implementation JKAutoResizingCenterViewViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    self.title = @"Center View";
	UIView *hardCenterView = [UIView new];
	[hardCenterView setBackgroundColor:[UIColor colorWithRed:0.3 green:0.6 blue:0.9 alpha:1.0]];
	[self.view addSubview:hardCenterView];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:hardCenterView
							      attribute:NSLayoutAttributeCenterX
							      relatedBy:NSLayoutRelationEqual
								 toItem:self.view
							      attribute:NSLayoutAttributeCenterX
							     multiplier:1.0
							       constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:hardCenterView
							      attribute:NSLayoutAttributeCenterY
							      relatedBy:NSLayoutRelationEqual
								 toItem:self.view
							      attribute:NSLayoutAttributeCenterY
							     multiplier:1.0
							       constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:hardCenterView
							      attribute:NSLayoutAttributeWidth
							      relatedBy:NSLayoutRelationEqual
								 toItem:hardCenterView
							      attribute:NSLayoutAttributeHeight
							     multiplier:1.0
							       constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:hardCenterView
							      attribute:NSLayoutAttributeHeight
							      relatedBy:NSLayoutRelationLessThanOrEqual
								 toItem:self.view
							      attribute:NSLayoutAttributeHeight
							     multiplier:1.0
							       constant:-20.0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:hardCenterView
							      attribute:NSLayoutAttributeWidth
							      relatedBy:NSLayoutRelationLessThanOrEqual
								 toItem:self.view
							      attribute:NSLayoutAttributeWidth
							     multiplier:1.0
							       constant:-20.0]];

	NSLayoutConstraint *equalHeightConstraint = [NSLayoutConstraint constraintWithItem:hardCenterView
										 attribute:NSLayoutAttributeHeight
										 relatedBy:NSLayoutRelationEqual
										    toItem:self.view
										 attribute:NSLayoutAttributeHeight
										multiplier:1.0
										  constant:-20.0];
	equalHeightConstraint.priority = 500;
	[self.view addConstraint:equalHeightConstraint];

	NSLayoutConstraint *equalWidthConstraint = [NSLayoutConstraint constraintWithItem:hardCenterView
										attribute:NSLayoutAttributeWidth
										relatedBy:NSLayoutRelationEqual
										   toItem:self.view
										attribute:NSLayoutAttributeWidth
									       multiplier:1.0
										 constant:-20.0];
	equalWidthConstraint.priority = 500;
	[self.view addConstraint:equalWidthConstraint];
}

@end
