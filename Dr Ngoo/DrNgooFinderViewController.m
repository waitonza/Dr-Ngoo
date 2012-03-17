//
//  DrNgooFinderViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/12/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooFinderViewController.h"
#import "DrNgooCheckListViewController.h"
#import "DrNgooResultViewController.h"
#import "DrNgooSnake.h"

@interface DrNgooFinderViewController ()
@property (strong, nonatomic) DrNgooCheckListViewController *childController;
@property (strong, nonatomic) DrNgooResultViewController *childResult;
@end

@implementation DrNgooFinderViewController

@synthesize allNames;
@synthesize names;
@synthesize keys;
@synthesize colors;
@synthesize bodyShapes;
@synthesize headShapes;
@synthesize bodyTextiles;
@synthesize specials;
@synthesize color;
@synthesize bodyShape;
@synthesize headShape;
@synthesize bodyTextile;
@synthesize special;
@synthesize childController;
@synthesize childResult;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FinderList"
                                                     ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    self.allNames = dict;
    
    self.names = [self.allNames copy];
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObjectsFromArray:[[self.allNames allKeys]
                                   sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keyArray;

    self.colors = [[NSArray alloc] initWithObjects:@"น้ำตาล",@"เขียว",@"ดำ",@"เหลือง",nil];
    self.bodyShapes = [[NSArray alloc] initWithObjects:@"เพรียว",@"อ้วน",@"สามเหลี่ยม",nil];
    self.headShapes = [[NSArray alloc] initWithObjects:@"แม่เบี้ย",@"เรียว",@"สามเหลี่ยม", nil];
    self.bodyTextiles = [[NSArray alloc] initWithObjects:@"ไม่มีลาย",@"Segments",@"Spots",@"Triangles",@"Smooth",@"Long Stripes",@"Cross",@"Large Spots", nil];
    self.specials = [[NSArray alloc] initWithObjects:@"Occipital scales",@"Asterisk textile",@"Blunt tail",@"Hissing",@"Brown-red tail",@"Big yellow eyes",@"Glossy",@"Big eyed",@"Yellow head", nil];
    self.color = @"ไม่ถูกเลือก";
    self.bodyShape = @"ไม่ถูกเลือก";
    self.headShape = @"ไม่ถูกเลือก";
    self.bodyTextile = @"ไม่ถูกเลือก";
    self.special = @"ไม่ถูกเลือก";
    
    //UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG.png"]];
    
    //[self.view addSubview:backgroundImage];
    //[self.view sendSubviewToBack:backgroundImage];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BG.png"]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.allNames = nil;
    self.names = nil;
    self.keys = nil;

    self.colors = nil;
    self.bodyShapes = nil;
    self.headShapes = nil;
    self.bodyTextiles = nil;
    self.specials = nil;
    self.color = nil;
    self.bodyShape = nil;
    self.headShape = nil;
    self.bodyTextile = nil;
    self.special = nil;
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (childController != nil) {
        NSIndexPath *index = childController.lastIndexPath;
        NSUInteger row = [index row];
        if (childController.list == self.colors)
            self.color = [colors objectAtIndex:row];
        else if (childController.list == self.bodyShapes)
            self.bodyShape = [bodyShapes objectAtIndex:row];
        else if (childController.list == self.headShapes)
            self.headShape = [headShapes objectAtIndex:row];
        else if (childController.list == self.bodyTextiles)
            self.bodyTextile = [bodyTextiles objectAtIndex:row];
        else if (childController.list == self.specials)
            self.special = [specials objectAtIndex:row];
        UITableView *table = [self tableView];
        [table reloadData];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (IBAction)searchAction:(id)sender {
    NSLog(@"Work");
    if (childResult == nil) {
        childResult = [[DrNgooResultViewController alloc] initWithNibName:@"DrNgooResultViewController" bundle:nil];
    }
    childResult.title = @"ผลการค้นหา";
    
    DrNgooSnake *row1 = [[DrNgooSnake alloc] initWithName:@"MacBook Air" andPicPath:@"thumb_s1.png"];
    DrNgooSnake *row2 = [[DrNgooSnake alloc] initWithName:@"MacBook Pro" andPicPath:@"thumb_s1.png"];
    DrNgooSnake *row3 = [[DrNgooSnake alloc] initWithName:@"iMac" andPicPath:@"thumb_s1.png"];
    DrNgooSnake *row4 = [[DrNgooSnake alloc] initWithName:@"Mac Mini" andPicPath:@"thumb_s1.png"];
    DrNgooSnake *row5 = [[DrNgooSnake alloc] initWithName:@"Mac Pro" andPicPath:@"thumb_s1.png"];
    
    childResult.snakes = [[NSArray alloc] initWithObjects:row1, row2 ,row3, row4, row5, nil];
    [self.navigationController pushViewController:childResult
                                     animated:YES];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return ([keys count] > 0) ? [keys count] + 1: 1;	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([keys count] == 0)
        return 0;
    if (section == [keys count]) {
        return 1;
    }
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = nil;
    NSArray *nameSection = nil;
    if (section == 0) {
        key = [keys objectAtIndex:section];
        nameSection = [names objectForKey:key];
    }
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:SectionsTableIdentifier];
    }
    if (section == 0) {
        cell.textLabel.text = [nameSection objectAtIndex:row];
        if (row == 0) 
            cell.detailTextLabel.text = self.color;
        else if (row == 1) 
            cell.detailTextLabel.text = self.bodyShape;
        else if (row == 2) 
            cell.detailTextLabel.text = self.headShape;
        else if (row == 3) 
            cell.detailTextLabel.text = self.bodyTextile;
        else if (row == 4) 
            cell.detailTextLabel.text = self.special;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(-1,-1,300,50);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:@"ค้นหา" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        button.titleLabel.textColor = [UIColor blueColor];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [button setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [button setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        // add to a view
        [cell.contentView addSubview:button];
        return cell;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    if ([keys count] == 0)
        return nil;
            
    if (section == 1) {
        return nil;
    }
    
    NSString *key = [keys objectAtIndex:section];
    if (key == UITableViewIndexSearch)
        return nil;
    return key;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (childController == nil) {
        childController = [[DrNgooCheckListViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    childController.title = [nameSection objectAtIndex:row];
    int rowfound;
    if (section == 0) {
        if (row == 0) {
            childController.list = self.colors;
            rowfound = [self.colors indexOfObject:self.color];        
        }
        else if (row == 1) {
            childController.list = self.bodyShapes;
            rowfound = [self.bodyShapes indexOfObject:self.bodyShape];
        }
        else if (row == 2) {
            childController.list = self.headShapes;
            rowfound = [self.headShapes indexOfObject:self.headShape];
        }
        else if (row == 3) {
            childController.list = self.bodyTextiles;
            rowfound = [self.bodyTextiles indexOfObject:self.bodyTextile];
        }
        else if (row == 4) {
            childController.list = self.specials;
            rowfound = [self.specials indexOfObject:self.special];
        }
    } else {
        NSLog(@"555");
    }
    
    if (rowfound != NSNotFound) {
        childController.lastIndexPath = [NSIndexPath indexPathForRow:rowfound inSection:0];
    } else {
        childController.lastIndexPath = nil;
    }

    [self.navigationController pushViewController:childController
                                         animated:YES];

}

@end
