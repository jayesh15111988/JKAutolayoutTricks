//
//  UIView+autolayoutEnabled.m
//  Sample
//
//  Created by Jayesh Kawli Backup on 8/14/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+autolayoutEnabled.h"

@implementation UIView (autolayoutEnabled)

- (void) autoLayoutEnabled_init {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self autoLayoutEnabled_init];
}

+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL regularInitSelector = @selector(init);
        SEL customInitSelector = @selector(autoLayoutEnabled_init);
        Method originalInitializer = class_getInstanceMethod(self, regularInitSelector);
        Method customInitializer = class_getInstanceMethod(self, customInitSelector);
        method_exchangeImplementations(originalInitializer, customInitializer);
    });
}

@end
