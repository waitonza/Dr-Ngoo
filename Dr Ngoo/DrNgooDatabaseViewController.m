//
//  DrNgooDatabaseViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooDatabaseViewController.h"
#import "DrNgooSnakeCell.h"
#import "DrNgooShowDetailViewController.h"
#import "NSDictionary+MutableDeepCopy.h"
#import "DrNgooSnake.h"

@interface DrNgooDatabaseViewController ()
@property (strong, nonatomic) DrNgooShowDetailViewController *childController;
@end

@implementation DrNgooDatabaseViewController

@synthesize snakes;
@synthesize childController;
@synthesize table;
@synthesize search;
@synthesize filteredListContent;
@synthesize savedSearchTerm;
@synthesize searchWasActive;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.snakes count]];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	[self.table reloadData];
}

- (void)viewDidUnload
{
	self.filteredListContent = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.snakes count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"DrNgooSnakeCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    DrNgooSnakeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"DrNgooSnakeCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        cell = [[DrNgooSnakeCell alloc] init];
    }
    
    DrNgooSnake *rowData = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        rowData = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        rowData = [self.snakes objectAtIndex:indexPath.row];
    }

    cell.snakeName = rowData.name;
    cell.imageView.image = [UIImage imageNamed:rowData.picPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0; // Same number we used in Interface Builder
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
        childController = [[DrNgooShowDetailViewController alloc] initWithNibName:@"DrNgooShowDetailViewController" bundle:nil];
    }
    
    //NSUInteger section = [indexPath section];
    DrNgooSnake *rowData = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        rowData = [self.filteredListContent objectAtIndex:indexPath.row];
        for (DrNgooSnakeCell *c in self.filteredListContent) {
            NSLog(@"%@",rowData.name);
        }
    }
	else
	{
        rowData = [self.snakes objectAtIndex:indexPath.row];
    }

    childController.title = rowData.name;
    childController.snakeName = rowData.name; 
    [self.navigationController pushViewController:childController
                                         animated:YES];
    
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (DrNgooSnake *snake in snakes)
	{
        NSComparisonResult result = [snake.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:snake];
        }
		
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
