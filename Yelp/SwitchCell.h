//
//  SwitchCell.h
//  Yelp
//
//  Created by David Ladowitz on 3/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;
@protocol SwitchCellDelegate <NSObject>

@optional
- (void)sender:(SwitchCell *)sender didChangeValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *onSwitch;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

@end
