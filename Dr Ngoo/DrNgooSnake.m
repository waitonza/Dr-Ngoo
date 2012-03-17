//
//  DrNgooSnake.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/16/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooSnake.h"

@implementation DrNgooSnake

@synthesize name;
@synthesize picPath;

-(id)initWithName:(NSString*)n andPicPath:(NSString*)p {
    self = [super init];
    if (self) {
        [self setName:n];
        [self setPicPath:p];
    }
    return self;
}

@end
