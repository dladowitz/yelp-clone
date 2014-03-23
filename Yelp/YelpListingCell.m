//
//  YelpListingCell.m
//  Yelp
//
//  Created by David Ladowitz on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpListingCell.h"
#import "UIImageView+AFNetworking.h"

@interface YelpListingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel     *addressAndNeighborhoodLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel     *categoryLabel;

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
    // Sets listing object from cell to a local instance
    _yelpListing = yelpListing;
    
    // Sets the cells IU elements from local instance properties
    self.nameLabel.text                   = [NSString stringWithFormat:@"%@. %@", yelpListing.index, yelpListing.name];
    self.addressAndNeighborhoodLabel.text = [NSString stringWithFormat:@"%@, %@", yelpListing.streetAddress, yelpListing.neighborhood];
    self.reviewCountLabel.text            = [NSString stringWithFormat: @"%@ reviews", yelpListing.reviewCount];
    
    [self.mainImageView   setImageWithURL: [NSURL URLWithString:yelpListing.listingImageUrl]];
    [self.ratingImageView setImageWithURL: [NSURL URLWithString:yelpListing.ratingImgUrl]];
}
@end
