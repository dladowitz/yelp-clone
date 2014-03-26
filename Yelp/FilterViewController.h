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

@protocol FilterViewDelegate <NSObject>

-(void)processFilterSettingsData:(NSMutableDictionary *)data;

@end

@interface FilterViewController : UIViewController <SwitchCellDelegate >

@property (nonatomic, assign) id<FilterViewDelegate> delegate;

@end
