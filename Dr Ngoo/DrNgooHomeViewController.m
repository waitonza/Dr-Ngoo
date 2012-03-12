//
//  DrNgooHomeViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/7/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooHomeViewController.h"

@interface DrNgooHomeViewController ()

@end

@implementation DrNgooHomeViewController

-(IBAction)buttonPressed:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    UITabBarController *tabbar = [super tabBarController];
    if (button.tag == 0) {
        [tabbar setSelectedIndex:1];
    } else if (button.tag == 1) {
        [tabbar setSelectedIndex:2];
    } else if (button.tag == 2) {
        [tabbar setSelectedIndex:3];
    } else {
        [tabbar setSelectedIndex:4];
    }
    
}

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
    
     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
