//
//  NSObject+NameTags.m
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/15/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "NSObject+JKNameTags.h"
#import <objc/objc-runtime.h>

@implementation NSObject (JKNameTags)

- (id)nametag {
	return objc_getAssociatedObject (self, @selector (nametag));
}

- (void)setNametag:(NSString *)theNametag {
	objc_setAssociatedObject (self, @selector (nametag), theNametag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)objectIdentifier {
	return [NSString stringWithFormat:@"%@ -> %@:0x%0x", self.nametag, self.class.description, (int)self];
}

@end
