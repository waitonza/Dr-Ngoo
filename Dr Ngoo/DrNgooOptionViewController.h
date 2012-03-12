//
//  DrNgooOptionViewController.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrNgooOptionViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *allNames;
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableArray *keys;

@property (strong, nonatomic) NSString *progVer;
@property (strong, nonatomic) NSString *dbVer;

@end
