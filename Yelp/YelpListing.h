//
//  YelpListing.h
//  Yelp
//
//  Created by David Ladowitz on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpListing : NSObject


// Instance Variables
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratingImgUrl;
@property (nonatomic, strong) NSString *reviewCount;
@property (nonatomic, strong) NSString *streetAddress;
@property (nonatomic, strong) NSString *neighborhood;
@property (nonatomic, strong) NSString *listingImageUrl;
@property (nonatomic, strong) NSString *category;

//should really make this an int
@property (nonatomic, strong) NSString *index;

// Instance Methods
- (id)initWithDictionary:(NSDictionary *)dictionary;

// Class Methods
+ (NSArray *)yelpListingsWithArray:(NSArray *)array;

@end
