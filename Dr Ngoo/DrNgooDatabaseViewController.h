//
//  DrNgooDatabaseViewController.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrNgooDatabaseViewController : UIViewController 
<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) NSArray *snakes;
@property (strong, nonatomic) NSMutableArray *filteredListContent;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (assign, nonatomic) BOOL searchWasActive;

@end