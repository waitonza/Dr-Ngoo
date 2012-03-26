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
    //self.scrollView.contentSize = CGSizeMake(320, 1783);
}

- (void)setLabelOnTop:(NSString*)text andLabel:(UILabel*)label andSize:(int)s {
    CGSize maximumSize = CGSizeMake(280, 9999);
    UIFont *dateFont = [UIFont fontWithName:@"Helvetica" size:s];
    CGSize dateStringSize = [text sizeWithFont:dateFont 
                                   constrainedToSize:maximumSize 
                                       lineBreakMode:label.lineBreakMode];
    
    CGRect dateFrame = CGRectMake(label.frame.origin.x, label.frame.origin.y, 280, dateStringSize.height);
    dateFrame.size.height = dateStringSize.height;
    label.frame = dateFrame;
}

- (void)autoAlignmentVertical {
    int offset_x = 20;
    int offset_y = 20;
    int between_line = 8;
    int count = 0;
    UILabel *label = (UILabel*)[self.scrollView viewWithTag:1];
    CGRect labelFrame = CGRectMake(offset_x, offset_y, 280, label.frame.size.height);
    labelFrame.size.height = label.frame.size.height;
    label.frame = labelFrame;
    offset_y += label.frame.size.height + between_line;
    for (int i = 2; i < 30; i++) {
        UILabel *label = (UILabel*)[self.scrollView viewWithTag:i];
        if (label.frame.size.width == 280) {
            CGRect labelFrame = CGRectMake(offset_x, offset_y, 280, label.frame.size.height);
            labelFrame.size.height = label.frame.size.height;
            label.frame = labelFrame;
            offset_y += label.frame.size.height + between_line;
        } else {
            CGRect labelFrame = CGRectMake(label.frame.origin.x, offset_y, label.frame.size.width, label.frame.size.height);
            labelFrame.size.height = label.frame.size.height;
            label.frame = labelFrame;
            count++;
            if (count%2 == 0) {
                offset_y += label.frame.size.height + between_line;
            }
        }
    }
    self.scrollView.contentSize = CGSizeMake(320, offset_y + 20);
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
    
    
    [self setLabelOnTop:self.scienceLabel.text andLabel:self.scienceLabel andSize:17];
    [self setLabelOnTop:self.geographyLabel.text andLabel:self.geographyLabel andSize:17];
    [self setLabelOnTop:self.serumLabel.text andLabel:self.serumLabel andSize:17];
    [self setLabelOnTop:self.sizeLabel.text andLabel:self.sizeLabel andSize:17];
    [self setLabelOnTop:self.characteristiceLabel.text andLabel:self.characteristiceLabel andSize:17];
    [self setLabelOnTop:self.reproductionLabel.text andLabel:self.reproductionLabel andSize:17];
    [self setLabelOnTop:self.foodLabel.text andLabel:self.foodLabel andSize:17];
    [self setLabelOnTop:self.locationLabel.text andLabel:self.locationLabel andSize:17];
    [self setLabelOnTop:self.distributionLabel.text andLabel:self.distributionLabel andSize:17];
    
    [self autoAlignmentVertical];
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
