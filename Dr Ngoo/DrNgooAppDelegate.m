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

@implementation DrNgooAppDelegate

@synthesize window = _window;
@synthesize rootViewController;
@synthesize settingInfo;

- (void)setupViewControllers
{
    rootViewController = [[UITabBarController alloc] init];
    UIImage *gradientImage44 = [[UIImage imageNamed:@"navBg.png"] 
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 
                                       forBarMetrics:UIBarMetricsDefault];
    
    // Customize back button items differently
    UIImage *buttonBack30 = [[UIImage imageNamed:@"button_back_textured_30.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    UIImage *buttonBack24 = [[UIImage imageNamed:@"button_back_textured_24.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], UITextAttributeTextColor, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, [UIFont fontWithName:@"AmericanTypewriter" size:0.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    DrNgooHomeViewController *mainViewController = [[DrNgooHomeViewController alloc] initWithNibName:@"DrNgooHomeViewController" bundle:nil];
    UINavigationController *firstNavController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Head.png"]];
    mainViewController.title = @"Dr Ngoo";
    mainViewController.navigationItem.titleView = img;
     
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
    
    // Customize UIBarButtonItems 
    UIImage *button30 = [[UIImage imageNamed:@"button_textured_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
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

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

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
