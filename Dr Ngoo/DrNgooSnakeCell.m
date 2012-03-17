//
//  DrNgooSnakeCell.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooSnakeCell.h"

@implementation DrNgooSnakeCell
@synthesize snakeName;
@synthesize image;
@synthesize imageView;
@synthesize snakeNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [[UIColor alloc] initWithRed:240.0 green:233.0 blue:193.0 alpha:1.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSnakeName:(NSString *)n {
    if (![n isEqualToString:snakeName]) {
        snakeName = [n copy];
        snakeNameLabel.text = snakeName;
    }
}

- (void)setImage:(UIImage *)img
{
    if (![img isEqual:image]) {
        image = [img copy];
        imageView.image = image;
    }
}

@end