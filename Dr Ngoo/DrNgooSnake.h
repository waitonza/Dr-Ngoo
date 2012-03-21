//
//  DrNgooSnake.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/16/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrNgooSnake : NSObject

@property (assign, nonatomic) int ident;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *picPath;
@property (strong, nonatomic) NSString *picPathSnake;

@property (strong, nonatomic) NSString *snakeName;
@property (strong, nonatomic) NSString *snakeThaiName;
@property (strong, nonatomic) UIImage *snakeImage;
@property (strong, nonatomic) NSString *science;
@property (strong, nonatomic) NSString *family;
@property (strong, nonatomic) NSString *otherName;
@property (strong, nonatomic) NSString *geography;
@property (strong, nonatomic) NSString *poisonous;
@property (strong, nonatomic) NSString *serum;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *characteristice;
@property (strong, nonatomic) NSString *reproduction;
@property (strong, nonatomic) NSString *food;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *distribution;

-(id)initWithName:(NSString*)n andPicPath:(NSString*)p;

@end
