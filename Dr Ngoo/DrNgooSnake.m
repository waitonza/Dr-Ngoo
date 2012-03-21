//
//  DrNgooSnake.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/16/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooSnake.h"

@implementation DrNgooSnake

@synthesize ident;
@synthesize name;
@synthesize picPath;
@synthesize picPathSnake;

@synthesize snakeName;
@synthesize snakeThaiName;
@synthesize snakeImage;
@synthesize science;
@synthesize family;
@synthesize otherName;
@synthesize geography;
@synthesize poisonous;
@synthesize serum;
@synthesize color;
@synthesize size;
@synthesize characteristice;
@synthesize reproduction;
@synthesize food;
@synthesize location;
@synthesize distribution;

-(id)initWithName:(NSString*)n andPicPath:(NSString*)p {
    self = [super init];
    if (self) {
        [self setName:n];
        [self setPicPath:p];
    }
    return self;
}

@end
