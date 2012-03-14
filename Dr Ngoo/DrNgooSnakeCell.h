//
//  DrNgooSnakeCell.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrNgooSnakeCell : UITableViewCell

@property (copy, nonatomic) NSString *snakeName;
@property (copy, nonatomic) UIImage *image;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *snakeNameLabel;

@end
