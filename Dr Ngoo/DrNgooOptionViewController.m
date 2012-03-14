//
//  DrNgooOptionViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooOptionViewController.h"
#import "DrNgooCreditViewController.h"
#import "DrNgooKnowledgeViewController.h"

#define kFileSettingname        @"setting.plist"

@interface DrNgooOptionViewController ()

@property (strong, nonatomic) DrNgooCreditViewController *childCredit;
@property (strong, nonatomic) DrNgooKnowledgeViewController *childKnow;

@end

@implementation DrNgooOptionViewController
@synthesize allNames;
@synthesize names;
@synthesize keys;
@synthesize dbVer;
@synthesize progVer;
@synthesize childKnow;
@synthesize childCredit;


- (NSString *)dataFileSettingPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileSettingname];
}

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OptionList"
                                                     ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    self.allNames = dict;
    
    self.names = [self.allNames copy];
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObjectsFromArray:[[self.allNames allKeys]
                                   sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keyArray;
    
    self.progVer = @"V. 0.1 Beta";
    
    dbVer = @"V. ";
    NSString *filePath = [self dataFileSettingPath];
    NSMutableDictionary *settingInfo = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    self.dbVer = [dbVer stringByAppendingString:[settingInfo objectForKey:@"DBVersion"]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.allNames = nil;
    self.names = nil;
    self.keys = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return ([keys count] > 0) ? [keys count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([keys count] == 0)
        return 0;
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:SectionsTableIdentifier];
    }
    
    cell.textLabel.text = [nameSection objectAtIndex:row];
    if (section == 0) {
        if (row == 0) {
            cell.detailTextLabel.text = progVer;
        } else if (row == 1) {
            cell.detailTextLabel.text = dbVer;
        } else if (row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } 
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    if ([keys count] == 0)
        return nil;
    
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
    if (childCredit == nil) {
        childCredit = [[DrNgooCreditViewController alloc] initWithNibName:@"DrNgooCreditViewController" bundle:nil];
    }
    if (childKnow == nil) {
        childKnow = [[DrNgooKnowledgeViewController alloc] initWithNibName:@"DrNgooKnowledgeViewController" bundle:nil];
    }
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    childCredit.title = @"เกี่ยวกับผู้จัดทำ";
    childKnow.title = @"ความรู้เกี่ยวกับงู";
    if (section == 0) {
        if (row == 2) {
            [self.navigationController pushViewController:childCredit animated:YES];
        }
    } else {
        [self.navigationController pushViewController:childKnow animated:YES];
    }
}

@end
