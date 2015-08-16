//
//  ViewController.m
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/12/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <EDColor/EDColor.h>
#import <JKAutolayoutReadyScrollView/ScrollViewAutolayoutCreator.h>
#import "NSObject+JKNameTags.h"

#import "JKAllAutolayoutDemos.h"

#pragma mark - Cross Platform
#if TARGET_OS_IPHONE
#define VIEW_CLASS UIView
#elif TARGET_OS_MAC
#define VIEW_CLASS NSView #endif
#endif

@interface JKAllAutolayoutDemos ()

@end

@implementation JKAllAutolayoutDemos

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Autolayout Demos";
	ScrollViewAutolayoutCreator *alCreator = [[ScrollViewAutolayoutCreator alloc] initWithSuperView:self.view];

	UIView *autolayoutContentView = alCreator.contentView;
	autolayoutContentView.tag = 100;
	UILabel *lab = [UILabel new];
	lab.numberOfLines = 0;
	lab.textAlignment = NSTextAlignmentCenter;
	lab.text =
	    @"This is very long text\nAnd this is second line\nAll Created with Autolayout\nAnd now this is last line";
	lab.backgroundColor = [UIColor lightGrayColor];
	[autolayoutContentView addSubview:lab];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lab]-10-|"
								   options:kNilOptions
								   metrics:nil
								     views:NSDictionaryOfVariableBindings (lab)]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[lab(>=10)]"
								   options:kNilOptions
								   metrics:nil
								     views:NSDictionaryOfVariableBindings (lab)]];

	UIButton *button = [UIButton new];
	[button setBackgroundColor:[UIColor darkGrayColor]];
	button.contentEdgeInsets = UIEdgeInsetsMake (10, 10, 10, 10);
	[button setTitle:@"this is pretty big button Bro!" forState:UIControlStateNormal];
	[autolayoutContentView addSubview:button];
	[autolayoutContentView addConstraint:[NSLayoutConstraint constraintWithItem:button
									  attribute:NSLayoutAttributeCenterX
									  relatedBy:NSLayoutRelationEqual
									     toItem:autolayoutContentView
									  attribute:NSLayoutAttributeCenterX
									 multiplier:1.0
									   constant:0.0]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:@"V:[lab]-10-[button]"
						   options:kNilOptions
						   metrics:nil
						     views:NSDictionaryOfVariableBindings (button, lab)]];

	UIView *centerFiddling = [UIView new];
	centerFiddling.backgroundColor = [UIColor blueColor];
	[autolayoutContentView addSubview:centerFiddling];
	[autolayoutContentView addConstraint:[NSLayoutConstraint constraintWithItem:centerFiddling
									  attribute:NSLayoutAttributeWidth
									  relatedBy:NSLayoutRelationEqual
									     toItem:nil
									  attribute:NSLayoutAttributeNotAnAttribute
									 multiplier:1.0
									   constant:200.0]];
	[autolayoutContentView addConstraint:[NSLayoutConstraint constraintWithItem:centerFiddling
									  attribute:NSLayoutAttributeHeight
									  relatedBy:NSLayoutRelationEqual
									     toItem:nil
									  attribute:NSLayoutAttributeNotAnAttribute
									 multiplier:1.0
									   constant:44.0]];
	[autolayoutContentView addConstraint:[NSLayoutConstraint constraintWithItem:centerFiddling
									  attribute:NSLayoutAttributeTop
									  relatedBy:NSLayoutRelationEqual
									     toItem:button
									  attribute:NSLayoutAttributeBottom
									 multiplier:1.0
									   constant:10]];
	[autolayoutContentView addConstraint:[NSLayoutConstraint constraintWithItem:centerFiddling
									  attribute:NSLayoutAttributeCenterX
									  relatedBy:NSLayoutRelationEqual
									     toItem:autolayoutContentView
									  attribute:NSLayoutAttributeCenterX
									 multiplier:1.0
									   constant:-50.0]];

	UIView *v1 = [UIView new];
	UIView *v2 = [UIView new];
	NSDictionary *views = NSDictionaryOfVariableBindings (v1, v2, centerFiddling);
	[v1 setBackgroundColor:[UIColor blackColor]];
	[v2 setBackgroundColor:[UIColor lightGrayColor]];
	[autolayoutContentView addSubview:v1];
	[autolayoutContentView addSubview:v2];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[centerFiddling]-10-[v1(30)]"
								   options:kNilOptions
								   metrics:nil
								     views:views]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[centerFiddling]-10-[v2(30)]"
								   options:kNilOptions
								   metrics:nil
								     views:views]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[v1(v2)]-30-[v2]-30-|"
								   options:kNilOptions
								   metrics:nil
								     views:views]];

	// Alternative designs.
	//[autolayoutContentView addConstraints:[NSLayoutConstraint
	// constraintsWithVisualFormat:@"H:|-30-[v1(v2)]-(>=0)-[v2(100)]-30-|" options:kNilOptions metrics:nil
	// views:views]];
	//[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v1]-[v2]|"
	// options:kNilOptions metrics:nil views:views]];
	//[autolayoutContentView addConstraints:[NSLayoutConstraint
	// constraintsWithVisualFormat:@"H:|-30-[v1(v2)][v2]-30-|" options:kNilOptions metrics:nil views:views]];

	UIView *v3 = [UIView new];
	UIView *v4 = [UIView new];
	UIView *v5 = [UIView new];
	NSDictionary *views1 = NSDictionaryOfVariableBindings (v3, v4, v5, v1);
	[v3 setBackgroundColor:[UIColor blackColor]];
	[v4 setBackgroundColor:[UIColor lightGrayColor]];
	[v5 setBackgroundColor:[UIColor yellowColor]];
	[autolayoutContentView addSubview:v3];
	[autolayoutContentView addSubview:v4];
	[autolayoutContentView addSubview:v5];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v1]-10-[v3(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views1]];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v1]-10-[v4(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views1]];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v1]-10-[v5(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views1]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[v3(<=50)]-[v4]-[v5(v3)]-10-|"
								   options:NSLayoutFormatAlignAllTop
								   metrics:nil
								     views:views1]];

	UIView *v6 = [UIView new];
	UIView *v7 = [UIView new];
	UIView *v8 = [UIView new];
	UIView *v9 = [UIView new];
	UIView *v10 = [UIView new];
	NSDictionary *views2 = NSDictionaryOfVariableBindings (v5, v6, v7, v8, v9, v10);
	[v6 setBackgroundColor:[UIColor blackColor]];
	[v7 setBackgroundColor:[UIColor lightGrayColor]];
	[v8 setBackgroundColor:[UIColor redColor]];
	[v9 setBackgroundColor:[UIColor greenColor]];
	[v10 setBackgroundColor:[UIColor darkGrayColor]];
	[autolayoutContentView addSubview:v6];
	[autolayoutContentView addSubview:v7];
	[autolayoutContentView addSubview:v8];
	[autolayoutContentView addSubview:v9];
	[autolayoutContentView addSubview:v10];

	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v5]-10-[v6(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views2]];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v5]-10-[v7(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views2]];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v5]-10-[v8(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views2]];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v5]-10-[v9(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views2]];
	[autolayoutContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v5]-10-[v10(30)]"
										      options:kNilOptions
										      metrics:nil
											views:views2]];

	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
						   @"H:|-10-[v6]-10-[v7(v6)]-10-[v8(v7)]-10-[v9(v8)]-[v10(v9)]-10-|"
								   options:NSLayoutFormatAlignAllTop
								   metrics:nil
								     views:views2]];
	//[autolayoutContentView addConstraints:[NSLayoutConstraint
	// constraintsWithVisualFormat:@"H:|-10-[v6(<=20)]-10-[v7(v6)]-10-[v8]-10-[v9(v6)]-[v10(v7)]-10-|"
	// options:NSLayoutFormatAlignAllTop metrics:nil views:views2]];

	UIView *superView1 = [UIView new];
	UIView *superView2 = [UIView new];
	UIView *superView3 = [UIView new];
	UIView *superView4 = [UIView new];

	NSDictionary *views3 = NSDictionaryOfVariableBindings (superView1, superView2, superView3, superView4, v10);
	NSDictionary *metrics = @{ @"padding" : @(10) };
	[autolayoutContentView addSubview:superView1];
	[superView1 addSubview:superView2];
	[superView2 addSubview:superView3];
	[superView3 addSubview:superView4];
	superView1.backgroundColor = [UIColor lightGrayColor];
	superView2.backgroundColor = [UIColor yellowColor];
	superView3.backgroundColor = [UIColor greenColor];
	superView4.backgroundColor = [UIColor blueColor];

	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v10]-padding-[superView1(100)]"
								   options:kNilOptions
								   metrics:metrics
								     views:views3]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[superView1]-padding-|"
								   options:kNilOptions
								   metrics:metrics
								     views:views3]];

	NSArray *viewsCollection = @[ @"superView2", @"superView3", @"superView4" ];

	for (NSString *v in viewsCollection) {
		NSString *hVisualConstraintLayoutString = [NSString stringWithFormat:@"H:|-padding-[%@]-padding-|", v];
		NSString *vVisualConstraintLayoutString = [NSString stringWithFormat:@"V:|-padding-[%@]-padding-|", v];
		[autolayoutContentView
		    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hVisualConstraintLayoutString
									   options:kNilOptions
									   metrics:metrics
									     views:views3]];
		[autolayoutContentView
		    addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vVisualConstraintLayoutString
									   options:kNilOptions
									   metrics:metrics
									     views:views3]];
	}

	UIView *horizontalCenterView = [UIView new];
	horizontalCenterView.backgroundColor = [UIColor iOS7greenGradientStartColor];
	[autolayoutContentView addSubview:horizontalCenterView];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:@"H:|-(>=20)-[horizontalCenterView(100)]-(>=20)-|"
						   options:NSLayoutFormatAlignAllCenterY
						   metrics:nil
						     views:NSDictionaryOfVariableBindings (superView1,
											   horizontalCenterView)]];
	[autolayoutContentView
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:@"V:[superView1]-20-[horizontalCenterView(100)]"
						   options:NSLayoutFormatAlignAllCenterX
						   metrics:nil
						     views:NSDictionaryOfVariableBindings (superView1,
											   horizontalCenterView)]];
	//    NSLayoutConstraint* verticalOffsetConstraint = [NSLayoutConstraint constraintWithItem:horizontalCenterView
	//    attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView1
	//    attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
	//    [autolayoutContentView addConstraint:verticalOffsetConstraint];
	//    [autolayoutContentView addConstraint:[NSLayoutConstraint constraintWithItem:horizontalCenterView
	//    attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil
	//    attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100]];

	UIView *sampleObject = [UIView new];
	[sampleObject setNametag:@"Steve"];
	[alCreator addBottomSpaceConstraintToLastView:horizontalCenterView withBottomPadding:20.0f];
}

@end
