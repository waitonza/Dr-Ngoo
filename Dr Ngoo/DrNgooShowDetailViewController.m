//
//  DrNgooShowDetailViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooShowDetailViewController.h"

@interface DrNgooShowDetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DrNgooShowDetailViewController

@synthesize snakeNameLabel;
@synthesize snakeImageView;
@synthesize colorLabel;
@synthesize minMaxSizeLabel;
@synthesize bodyShapeLabel;
@synthesize headShapeLabel;
@synthesize bodyTextileLabel;
@synthesize specialLabel;
@synthesize posionLabel;
@synthesize serumLabel;

@synthesize snakeName;
@synthesize snakeImage;
@synthesize color;
@synthesize minSize;
@synthesize maxSize;
@synthesize bodyShape;
@synthesize headShape;
@synthesize bodyTextile;
@synthesize special;
@synthesize posion;
@synthesize serum;

@synthesize scrollView;

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
    self.scrollView.contentSize = CGSizeMake(320, 500);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.snakeNameLabel.text = snakeName;
    self.snakeImageView.image = snakeImage;
    self.colorLabel.text = color;
    NSString *newStr = [minSize stringByAppendingString:@" - "];
    self.minMaxSizeLabel.text = [newStr stringByAppendingString:maxSize];
    self.bodyShapeLabel.text = bodyShape;
    self.headShapeLabel.text = headShape;
    self.bodyTextileLabel.text = bodyTextile;
    self.specialLabel.text = special;
    self.posionLabel.text = posion;
    self.serumLabel.text = serum;
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

@end
