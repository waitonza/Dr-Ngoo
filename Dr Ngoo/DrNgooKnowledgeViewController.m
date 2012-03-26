//
//  DrNgooKnowledgeViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooKnowledgeViewController.h"
#import "DrNgooZoomViewController.h"

@interface DrNgooKnowledgeViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) DrNgooZoomViewController *childController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DrNgooKnowledgeViewController

@synthesize scrollView;
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
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(320, 3738);
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

- (IBAction)performButtonZoom:(id)sender {
    if (childController == nil) {
        childController = [[DrNgooZoomViewController alloc] initWithNibName:@"DrNgooZoomViewController" bundle:nil];
    }
    
    UIButton *button = (UIButton*)sender;
    childController.title = [@"หน้าที่ " stringByAppendingString:button.currentTitle];
    childController.imageView.image = button.currentImage;
    
    [self.navigationController pushViewController:childController
                                         animated:YES];
}


@end
