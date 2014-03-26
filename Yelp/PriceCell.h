//
//  PriceCell.h
//  Yelp
//
//  Created by David Ladowitz on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PriceCell;

@protocol PriceCellDelegate <NSObject>

@optional
//Might need to change (NSInteger *) to (int)
- (void)sender:(PriceCell* )sender didChangeValue:(int)value;

@end

@interface PriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property  (nonatomic, weak) id<PriceCellDelegate> delegate;

@end
