//
//  DrNgooSnake.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/16/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrNgooSnake : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *picPath;

-(id)initWithName:(NSString*)n andPicPath:(NSString*)p;

@end
