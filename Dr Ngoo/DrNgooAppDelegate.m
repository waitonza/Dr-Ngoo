//
//  DrNgooAppDelegate.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/7/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooAppDelegate.h"
#import "DrNgooHomeViewController.h"
#import "DrNgooFinderViewController.h"
#import "DrNgooDatabaseViewController.h"
#import "DrNgooCureViewController.h"
#import "DrNgooOptionViewController.h"
#import <sqlite3.h>
//#import "Reachability.h"

#define kFileDBname             @"data.sqlite3"
#define kFileSettingname        @"setting.plist"

@implementation DrNgooAppDelegate

@synthesize window = _window;
@synthesize rootViewController;
@synthesize settingInfo;
@synthesize hostActive;
@synthesize internetActive;
//@synthesize internetReachable;
//@synthesize hostReachable;

- (NSString *)dataFileDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileDBname];
}

- (NSString *)dataFileSettingPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileSettingname];
}

- (int)createDataBase:(int)ver {
    NSString *path = @"http://exitosus.no.de/drngoo?version=";
    path = [path stringByAppendingFormat:@"%d",ver];
    path = [path stringByAppendingString:@"&type=database"];
    NSURL *url = [NSURL URLWithString:path];
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:1 error:nil];
    
    NSArray *listItems = [urlString componentsSeparatedByString:@"\n"];
    
    sqlite3 *database;
    if (sqlite3_open([[self dataFileDBPath] UTF8String], &database)
        != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *createSQL = [listItems objectAtIndex:1];
    char *errorMsg;
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    for (int i = 2; i < [listItems count]; i++) {
        if (sqlite3_exec (database, [[listItems objectAtIndex:i] UTF8String],
                          NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Error updating table: %s", errorMsg);
        }
    }
    NSString *dbver = [listItems objectAtIndex:0];
    return [dbver intValue];
}

- (int)updateDataBase:(int)ver {
    NSString *path = @"http://exitosus.no.de/drngoo?version=";
    path = [path stringByAppendingFormat:@"%d",ver];
    path = [path stringByAppendingString:@"&type=database"];
    NSURL *url = [NSURL URLWithString:path];
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:1 error:nil];
    
    NSArray *listItems = [urlString componentsSeparatedByString:@"\n"];
    char *errorMsg;
    sqlite3 *database;
    if (sqlite3_open([[self dataFileDBPath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    for (int i = 1; i < [listItems count]; i++) {
        if (sqlite3_exec (database, [[listItems objectAtIndex:i] UTF8String],
                          NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Error updating table: %s", errorMsg);
        }
    }
    NSString *dbver = [listItems objectAtIndex:0];
    return [dbver intValue];

}

- (void)setupViewControllers
{
    rootViewController = [[UITabBarController alloc] init];
    
    DrNgooHomeViewController *mainViewController = [[DrNgooHomeViewController alloc] initWithNibName:@"DrNgooHomeViewController" bundle:nil];
    UINavigationController *firstNavController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    mainViewController.title = @"Doctor Ngoo";
    
    DrNgooFinderViewController *finderController = [[DrNgooFinderViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *secondNavController = [[UINavigationController alloc] initWithRootViewController:finderController];
    //currentLocationController.useCurrentLocation = YES;
    finderController.title = @"ค้นหาตามลักษณะ";
    
    DrNgooDatabaseViewController *dataBaseController = [[DrNgooDatabaseViewController alloc] initWithNibName:@"DrNgooDatabaseViewController" bundle:nil];
    //favouriteController.bFavorites = YES;
    UINavigationController *thirdNavController = [[UINavigationController alloc] initWithRootViewController:dataBaseController];
    dataBaseController.title = @"ฐานข้อมูลงู";
    
    DrNgooCureViewController *cureController = [[DrNgooCureViewController alloc] initWithNibName:@"DrNgooCureViewController" bundle:nil];
    UINavigationController *fourthNavController = [[UINavigationController alloc] initWithRootViewController:cureController];
    cureController.title = @"ปฐมพยาบาล";
    
    DrNgooOptionViewController *optionController = [[DrNgooOptionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *fifthNavController = [[UINavigationController alloc] initWithRootViewController:optionController];
    optionController.title = @"เพิ่มเติม";
        
    
    rootViewController.viewControllers = [NSArray arrayWithObjects:firstNavController, secondNavController, thirdNavController,fourthNavController,fifthNavController, nil];
    firstNavController.tabBarItem.image = [UIImage imageNamed:@"01-home.png"];
    firstNavController.tabBarItem.title = @"หน้าหลัก";
    
    secondNavController.tabBarItem.image = [UIImage imageNamed:@"02-magnify.png"];
    secondNavController.tabBarItem.title = @"ค้นหางู";
    
    thirdNavController.tabBarItem.image = [UIImage imageNamed:@"96-book.png"];
    thirdNavController.tabBarItem.title = @"รายชื่องู";
    
    fourthNavController.tabBarItem.image = [UIImage imageNamed:@"04-medical-bag.png"];
    fourthNavController.tabBarItem.title = @"ปฐมพยาบาล";
    
    fifthNavController.tabBarItem.image = [UIImage imageNamed:@"info_30.png"];
    fifthNavController.tabBarItem.title = @"เพิ่มเติม";
    NSLog(@"Prepare Sucessful");
    [self.window addSubview:rootViewController.view];
    //[[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:tabBarController.view];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //[[NSBundle mainBundle] loadNibNamed:@"TabBarController" owner:self options:nil];
    //[self.window addSubview:rootViewController.view];
    [self setupViewControllers];
    /*
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [Reachability reachabilityWithHostName: @"www.apple.com"];
    [hostReachable startNotifier];
    
    // now patiently wait for the notification
    */
    NSString *filePath = [self dataFileSettingPath];
    int version;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.settingInfo = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        NSString *ver = [self.settingInfo objectForKey:@"DBVersion"];
        version = [ver intValue];
    } else {
        self.settingInfo = [[NSMutableDictionary alloc] init];
        [self.settingInfo setObject:[NSString stringWithFormat:@"%d",-1] forKey:@"DBVersion"];
        [self.settingInfo writeToFile:filePath atomically:YES];
        version = -1;
    }
    //[self checkNetworkStatus:nil];

    int updatedVer = 0;
    if (version == -1) {
        updatedVer = [self createDataBase:0];
    } else {
        updatedVer = [self updateDataBase:version];
    }

    [self.settingInfo setObject:[NSString stringWithFormat:@"%d",updatedVer] forKey:@"DBVersion"];
    [self.settingInfo writeToFile:filePath atomically:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

/*
-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            self.internetActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            self.internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            self.internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            self.hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self.hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self.hostActive = YES;
            
            break;
        }
    }
}
*/
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
