//
//  YelpListingCell.m
//  Yelp
//
//  Created by David Ladowitz on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpListingCell.h"

@interface YelpListingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressAndNeighborhoodLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation YelpListingCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


# pragma mark - Public Methods
- (void)setYelpListing:(YelpListing *)yelpListing {
    _yelpListing = yelpListing;
    
    self.nameLabel.text = yelpListing.name;
    self.addressAndNeighborhoodLabel.text = yelpListing.neighborhood;
    self.reviewCountLabel.text = [NSString stringWithFormat: @"%@", yelpListing.reviewCount];
}
@end
