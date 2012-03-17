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
@property (strong, nonatomic) IBOutlet UILabel *snakeNameThaiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *snakeImageView;

@property (strong, nonatomic) IBOutlet UILabel *scienceLabel;
@property (strong, nonatomic) IBOutlet UILabel *familyLabel;
@property (strong, nonatomic) IBOutlet UILabel *otherNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *geographyLabel;
@property (strong, nonatomic) IBOutlet UILabel *poisonousLabel;
@property (strong, nonatomic) IBOutlet UILabel *serumLabel;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;

@property (strong, nonatomic) IBOutlet UILabel *characteristiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *reproductionLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *distributionLabel;

@property (copy, nonatomic) NSString *snakeName;
@property (copy, nonatomic) NSString *snakeThaiName;
@property (copy, nonatomic) UIImage *snakeImage;
@property (copy, nonatomic) NSString *science;
@property (copy, nonatomic) NSString *family;
@property (copy, nonatomic) NSString *otherName;
@property (copy, nonatomic) NSString *geography;
@property (copy, nonatomic) NSString *poisonous;
@property (copy, nonatomic) NSString *serum;
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *size;
@property (copy, nonatomic) NSString *characteristice;
@property (copy, nonatomic) NSString *reproduction;
@property (copy, nonatomic) NSString *food;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *distribution;

@end
