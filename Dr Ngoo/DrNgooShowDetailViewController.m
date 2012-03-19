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
@synthesize snakeNameThaiLabel;
@synthesize snakeImageView;
@synthesize scienceLabel;
@synthesize familyLabel;
@synthesize otherNameLabel;
@synthesize geographyLabel;
@synthesize poisonousLabel;
@synthesize serumLabel;
@synthesize colorLabel;
@synthesize sizeLabel;
@synthesize characteristiceLabel;
@synthesize reproductionLabel;
@synthesize foodLabel;
@synthesize locationLabel;
@synthesize distributionLabel;

@synthesize snakeName;
@synthesize snakeThaiName;
@synthesize snakeImage;
@synthesize science;
@synthesize family;
@synthesize otherName;
@synthesize geography;
@synthesize poisonous;
@synthesize serum;
@synthesize color;
@synthesize size;
@synthesize characteristice;
@synthesize reproduction;
@synthesize food;
@synthesize location;
@synthesize distribution;

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
    self.scrollView.contentSize = CGSizeMake(320, 1763);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.snakeNameLabel.text = snakeName;
    self.snakeNameThaiLabel.text = snakeThaiName;
    self.snakeImageView.image = snakeImage;
    self.scienceLabel.text = science;
    self.familyLabel.text = family;
    self.otherNameLabel.text = otherName;
    self.geographyLabel.text = geography;
    self.poisonousLabel.text = poisonous;
    self.serumLabel.text = serum;
    self.colorLabel.text = color;
    self.sizeLabel.text = size;
    self.characteristiceLabel.text = characteristice;
    self.reproductionLabel.text = reproduction;
    self.foodLabel.text = food;
    self.locationLabel.text = location;
    self.distributionLabel.text = distribution;
    
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
