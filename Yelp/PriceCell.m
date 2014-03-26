//
//  PriceCell.m
//  Yelp
//
//  Created by David Ladowitz on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PriceCell.h"

//@interface PriceCell ()
//
//-(void)didChangeValue:(id)sender;
//
//@end


@implementation PriceCell

- (void)awakeFromNib
{
    // Initialization code
    [self.segmentControl addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
}


//- (void)didChangeValue:(id)sender {
//    [self.delegate sender:self didChangeValue:self.segmentControl.selectedSegmentIndex];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
