//
//  YelpListing.m
//  Yelp
//
//  Created by David Ladowitz on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpListing.h"


@implementation YelpListing

// Initializing YelpListing with a dictionary returned from Yelp API
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name            = dictionary[@"name"];
        self.ratingImgUrl    = dictionary[@"rating_img_url"];
        self.reviewCount     = dictionary[@"review_count"];
        self.streetAddress   = dictionary[@"location"][@"display_address"][0];
        self.neighborhood    = dictionary[@"location"][@"display_address"][2];
        self.listingImageUrl = dictionary[@"image_url"];
        self.category        = dictionary[@"categories"][0][0];
    }
    
    return self;
}

// Creates an array of listings from an array of dictionarys of Yelp API results
+ (NSArray *)yelpListingsWithArray:(NSArray *)array {
    NSLog(@"Starting yelpListingsWithArray");
    NSMutableArray *yelpListings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        YelpListing *yelpListing = [[YelpListing alloc] initWithDictionary:dictionary];
        NSLog(@"name: %@, reviews: %@, address: %@", yelpListing.name, yelpListing.reviewCount, yelpListing.streetAddress);

        [yelpListings addObject:yelpListing];
    }
    NSLog(@"Finishing yelpListingsWithArray");
    return yelpListings;
}

@end
