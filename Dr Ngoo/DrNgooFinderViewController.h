//
//  DrNgooFinderViewController.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/12/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrNgooFinderViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *allNames;
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableArray *keys;

@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSArray *bodyShapes;
@property (strong, nonatomic) NSArray *headShapes;
@property (strong, nonatomic) NSArray *bodyTextiles;
@property (strong, nonatomic) NSArray *specials;

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *bodyShape;
@property (strong, nonatomic) NSString *headShape;
@property (strong, nonatomic) NSString *bodyTextile;
@property (strong, nonatomic) NSString *special;

- (IBAction)searchAction:(id)sender;

@end
