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
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"


#define kFileDBname             @"data.sqlite3"
#define kFileSettingname        @"setting.plist"

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

    self.colors = [[NSArray alloc] initWithObjects:@"",@"น้ำตาล",@"เขียว",@"ดำ",@"เหลือง",nil];
    self.bodyShapes = [[NSArray alloc] initWithObjects:@"",@"เพรียว",@"อ้วน",@"สามเหลี่ยม",nil];
    self.headShapes = [[NSArray alloc] initWithObjects:@"",@"แม่เบี้ย",@"เรียว",@"สามเหลี่ยม", nil];
    self.bodyTextiles = [[NSArray alloc] initWithObjects:@"",@"ไม่มีลาย",@"ปล้อง",@"ลายวงกลม",@"ลายสามเหลี่ยม",@"เรียบ",@"ลายเป็นทางยาว",@"ลายกากบาท",@"ลายวงแต้มขนาดใหญ่", nil];
    self.specials = [[NSArray alloc] initWithObjects:@"",@"เกล็ดท้ายทอยขนาดใหญ่",@"ลายดอกจัน",@"ปลายหางทู่มน",@"ส่งเสียงขู่",@"หางสีน้ำตาลแดง",@"ตากลมโตสีเหลืองขนาดใหญ่",@"เกล็ดลำตัวเรียบเป็นเงาแวววาว",@"ตากลมโต",@"หัวสีเหลือง", nil];
    self.color = @"";
    self.bodyShape = @"";
    self.headShape = @"";
    self.bodyTextile = @"";
    self.special = @"";
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
    //if (childResult == nil) {
    childResult = [[DrNgooResultViewController alloc] initWithNibName:@"DrNgooResultViewController" bundle:nil];
    //}
    childResult.title = @"ผลการค้นหา";
    
    childResult.snakes = [self querySearch];
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
        if (row == 0) {
            if ([self.color isEqualToString:@""]) {
                cell.detailTextLabel.text = @"ไม่ถูกเลือก";
            } 
            else cell.detailTextLabel.text = self.color;
        }
        else if (row == 1) {
            if ([self.bodyShape isEqualToString:@""]) {
                cell.detailTextLabel.text = @"ไม่ถูกเลือก";
            } 
            else cell.detailTextLabel.text = self.bodyShape;
        }
        else if (row == 2) {
            if ([self.headShape isEqualToString:@""]) {
                cell.detailTextLabel.text = @"ไม่ถูกเลือก";
            } 
            else cell.detailTextLabel.text = self.headShape;
        }
        else if (row == 3) {
            if ([self.bodyTextile isEqualToString:@""]) {
                cell.detailTextLabel.text = @"ไม่ถูกเลือก";
            } 
            else cell.detailTextLabel.text = self.bodyTextile;
        }
        else if (row == 4) {
            if ([self.special isEqualToString:@""]) {
                cell.detailTextLabel.text = @"ไม่ถูกเลือก";
            }
            else cell.detailTextLabel.text = self.special;
        }
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
    }     
    if (rowfound != NSNotFound) {
        childController.lastIndexPath = [NSIndexPath indexPathForRow:rowfound inSection:0];
    } else {
        childController.lastIndexPath = nil;
    }

    [self.navigationController pushViewController:childController
                                         animated:YES];

}

- (NSString *)dataFileDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileDBname];
}


- (NSMutableArray*)querySearch
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.dataFileDBPath];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        
        return 0;
    }
    NSString *query = @"SELECT * FROM SnakeDB";
    if (![self.color isEqualToString:@""] || ![self.bodyShape isEqualToString:@""] || ![self.headShape isEqualToString:@""] || ![self.bodyTextile isEqualToString:@""] || ![self.special isEqualToString:@""]) {
        query = [query stringByAppendingString:@" WHERE "];
        if (![self.color isEqualToString:@""]) {
            query = [query stringByAppendingFormat:@"Color LIKE '%%%@%%' AND ",self.color];
        }
        if (![self.bodyShape isEqualToString:@""]) {
            query = [query stringByAppendingFormat:@"BodyShape LIKE '%%%@%%' AND ",self.bodyShape];
        }
        if (![self.headShape isEqualToString:@""]) {
            query = [query stringByAppendingFormat:@"HeadShape LIKE '%%%@%%' AND ",self.headShape];
        }
        if (![self.bodyTextile isEqualToString:@""]) {
            query = [query stringByAppendingFormat:@"BodyTextile LIKE '%%%@%%' AND ",self.bodyTextile];
        }
        if (![self.special isEqualToString:@""]) {
            query = [query stringByAppendingFormat:@"SpecialChar LIKE '%%%@%%'",self.special];
        }
        
        if ([query rangeOfString:@"AND" options:NSCaseInsensitiveSearch range:NSMakeRange([query length] - 4, 4)].location != NSNotFound) {
            NSMutableString *string = [query mutableCopy];
            [string replaceCharactersInRange:NSMakeRange([query length] - 4, 4) withString:@""];
            query = [string copy];
        }
    }
    
    NSLog(@"%@",query);
    FMResultSet *rs = [db executeQuery:query];
    
    NSMutableArray *snakes = [[NSMutableArray alloc] init];
    NSString *snake_ico_file = @"snake_ico_";
    NSString *snake_img_file = @"snake_img_";
    int i = 0;
    while ([rs next]) {        
        DrNgooSnake *snake = [[DrNgooSnake alloc] init];
        snake.ident = [[rs stringForColumn:@"ID"] intValue];
        
        NSString *new_file_name = [snake_ico_file stringByAppendingFormat:@"%d.jpg",snake.ident];
        NSString *new_file_img_name = [snake_img_file stringByAppendingFormat:@"%d.jpg",snake.ident];
        snake.name = [rs stringForColumn:@"ThaiName"];
        snake.picPath = new_file_name;
        snake.snakeName = [rs stringForColumn:@"Name"];
        snake.snakeThaiName = [rs stringForColumn:@"ThaiName"];
        snake.picPathSnake = new_file_img_name;
        snake.snakeImage = [self getImagewithName:new_file_img_name];
        snake.science = [rs stringForColumn:@"ScienceName"];
        snake.family = [rs stringForColumn:@"Family"];
        snake.otherName = [rs stringForColumn:@"OtherName"];
        snake.geography = [rs stringForColumn:@"Geography"];
        snake.poisonous = [rs stringForColumn:@"Poisonous"];
        snake.serum = [rs stringForColumn:@"Serum"];
        snake.color = [rs stringForColumn:@"Color"];
        snake.size = [rs stringForColumn:@"Size"];
        snake.characteristice = [rs stringForColumn:@"Characteristics"];
        snake.reproduction = [rs stringForColumn:@"Reproduction"];
        snake.food = [rs stringForColumn:@"Food"];
        snake.location = [rs stringForColumn:@"Location"];
        snake.distribution = [rs stringForColumn:@"Distribution"];
        [snakes addObject:snake];
        i++;
    }
    return snakes;
}

- (UIImage *) getImagewithName:(NSString*) imagepath
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage *gimage = [UIImage imageWithContentsOfFile: [NSString stringWithFormat:@"%@/%@",docDir,imagepath]];
    
    //NSLog(@"%@/%@",docDir,imagepath);
    
    return gimage;
}

@end
