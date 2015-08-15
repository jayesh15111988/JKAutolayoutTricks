//
//  NSObject+NameTags.h
//  JKAutolayoutSamples
//
//  Created by Jayesh Kawli Backup on 8/15/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NameTags)

- (id)nametag;
- (void)setNametag:(NSString*)theNametag;
- (NSString*)objectIdentifier;

@end
