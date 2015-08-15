//
//  ScrollViewAutolayoutCreator.h
//  JKAutolayoutReadyScrollView
//
//  Created by Jayesh Kawli Backup on 7/16/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScrollViewAutolayoutCreator : NSObject

@property (strong, nonatomic) UIView* contentView;

- (instancetype)initWithSuperView:(UIView*)superView;
- (void)addBottomSpaceConstraintToLastView:(UIView*)lastView withBottomPadding:(CGFloat)bottomPadding;

@end
