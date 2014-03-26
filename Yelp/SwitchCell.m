//
//  SwitchCell.m
//  Yelp
//
//  Created by David Ladowitz on 3/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()

- (void)didChangeValue:(id)sender;

@end

@implementation SwitchCell

- (void)awakeFromNib
{
    // Initialization code
    [self.onSwitch addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didChangeValue:(id)sender{
    [self.delegate sender:self didChangeValue:self.onSwitch.on];
}
@end
