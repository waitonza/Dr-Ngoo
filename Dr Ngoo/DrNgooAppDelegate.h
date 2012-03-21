//
//  DrNgooAppDelegate.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/7/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrNgooDatabaseViewController.h"

@interface DrNgooAppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *rootViewController;
@property (strong, nonatomic) NSMutableDictionary *settingInfo;

@end
