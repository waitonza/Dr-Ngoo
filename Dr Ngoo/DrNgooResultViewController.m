//
//  DrNgooResultViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooResultViewController.h"
#import "DrNgooSnakeCell.h"
#import "DrNgooShowDetailViewController.h"

@interface DrNgooResultViewController ()

@property (strong, nonatomic) DrNgooShowDetailViewController *childController;

@end
@implementation DrNgooResultViewController

@synthesize snakes;
@synthesize childController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"MacBook Air", @"Name", @"thumb_s1.png", @"PicPath", nil];
    NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"MacBook Pro", @"Name", @"thumb_s1.png", @"PicPath", nil];
    NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"iMac", @"Name", @"thumb_s1.png", @"PicPath", nil];
    NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Mac Mini", @"Name", @"thumb_s1.png", @"PicPath", nil];
    NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Mac Pro", @"Name", @"thumb_s1.png", @"PicPath", nil];
    
    self.snakes = [[NSArray alloc] initWithObjects:row1, row2,
                   row3, row4, row5, nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.snakes count];
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
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.snakes objectAtIndex:row];
    
    cell.snakeName = [rowData objectForKey:@"Name"];
    cell.imageView.image = [UIImage imageNamed:[rowData objectForKey:@"PicPath"]];
    
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
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.snakes objectAtIndex:row];
    childController.title = [rowData objectForKey:@"Name"];

    
    [self.navigationController pushViewController:childController
                                         animated:YES];
    
}
@end
