//
//  DrNgooShowDetailViewController.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrNgooShowDetailViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UILabel *snakeNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *snakeImageView;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;
@property (strong, nonatomic) IBOutlet UILabel *minMaxSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyShapeLabel;
@property (strong, nonatomic) IBOutlet UILabel *headShapeLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyTextileLabel;
@property (strong, nonatomic) IBOutlet UILabel *specialLabel;
@property (strong, nonatomic) IBOutlet UILabel *posionLabel;
@property (strong, nonatomic) IBOutlet UILabel *serumLabel;

@property (copy, nonatomic) NSString *snakeName;
@property (copy, nonatomic) UIImage *snakeImage;
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *minSize;
@property (copy, nonatomic) NSString *maxSize;
@property (copy, nonatomic) NSString *bodyShape;
@property (copy, nonatomic) NSString *headShape;
@property (copy, nonatomic) NSString *bodyTextile;
@property (copy, nonatomic) NSString *special;
@property (copy, nonatomic) NSString *posion;
@property (copy, nonatomic) NSString *serum;

@end
