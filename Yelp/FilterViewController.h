//
//  FilterViewController.h
//  Yelp
//
//  Created by David Ladowitz on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceCell.h"
#import "SwitchCell.h"

@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

- (void)addFiltersViewController:(FilterViewController *)controller didFinishSaving:(NSMutableArray *)filters;
@end

@interface FilterViewController : UIViewController <PriceCellDelegate, SwitchCellDelegate >

@property (nonatomic, weak) id <FilterViewControllerDelegate> delegate;

@end
