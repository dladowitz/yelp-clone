//
//  FilterViewController.m
//  Yelp
//
//  Created by David Ladowitz on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "SeeAllCell.h"
#import "PriceCell.h"

@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, assign) BOOL generalFeaturesExpanded;
@property (nonatomic, assign) BOOL sortByExpanded;
@property (nonatomic, assign) BOOL distanceExpanded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic, strong) NSMutableDictionary *options;
//@property (nonatomic, strong) NSMutableDictionary *expandedCategories;


@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set dataSource and delegate
        self.tableView.dataSource = self;
        self.tableView.delegate = self;

    // Registering Custom Cells
    UINib *seeAllNib = [UINib nibWithNibName:@"SeeAllCell" bundle:nil];
    [self.tableView registerNib:seeAllNib forCellReuseIdentifier:@"SeeAllCell"];
    
    UINib *pricelNib = [UINib nibWithNibName:@"PriceCell" bundle:nil];
    [self.tableView registerNib:pricelNib forCellReuseIdentifier:@"PriceCell"];
    
    // Set up filter categories
        [self setupOptions];
    
}

// Thanks Nick H!
- (void)setupOptions {
//    self.options = [[NSMutableDictionary alloc] initWithCapacity:20];
//    self.expandedCategories = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    self.categories = [NSMutableArray arrayWithObjects:
  @{
    @"name":@"Price",
    @"type":@"segmented",
    @"list":@[@"$",@"$$",@"$$$",@"$$$$"]
    },
  @{
    @"name":@"Most Popular",
    @"type":@"switches",
    @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
    },
  @{
    @"name":@"Distance",
    @"type":@"expandable",
    @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
    },
  @{
    @"name":@"Sort By",
    @"type":@"expandable",
    @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
    },
  @{
    @"name":@"General Features",
    @"type":@"switches",
    @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"]
    },
                       nil
                       ];
}


#pragma mark - Table View Methods

// Sections Methods
    - (int)numberOfSectionsInTableView:(UITableView *)tableView {
        return [self.categories count];
    }

    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        
        if (section == 0) {
            return @"Price";
        } else if (section == 1) {
            return @"Most Popular";
        } else if (section == 2){
            return @"Distance";
        } else if (section == 3){
            return @"Sort By";
        } else {
            return @"General Features";
        }
    }

    // Should probably clean up and make a case method
    - (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        if( [self.categories[section][@"name"]  isEqual: @"Distance"] ){
            if(!self.distanceExpanded){
                return 1;
            } else {
                return ((NSArray *)self.categories[section][@"list"]).count;
            }
        } else if( [self.categories[section][@"name"]  isEqual: @"Sort By"] ){
            if(!self.sortByExpanded){
                return 1;
            } else {
                return ((NSArray *)self.categories[section][@"list"]).count;
            }
        } else if([self.categories[section][@"name"]  isEqual: @"General Features"]) {
            if(!self.generalFeaturesExpanded){
                return 4;
            } else {
                // Adds one for the colapse cell
                return ((NSArray *)self.categories[section][@"list"]).count;
            }
        } else if ([self.categories[section][@"name"]  isEqual: @"Price"]){
            return 1;
        } else {
            return ((NSArray *)self.categories[section][@"list"]).count;
        }
    }


// Cell Methods
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        
        if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"] && !self.generalFeaturesExpanded && indexPath.row == 3) {
            SeeAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAllCell" forIndexPath:indexPath];
            return cell;
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Price"] ) {
            PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell" forIndexPath:indexPath];
            return cell;

        } else {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
            
            if ([self.categories[indexPath.section][@"name"] isEqual: @"Price"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"] || [self.categories[indexPath.section][@"name"]  isEqual: @"General Features"]){
                cell.accessoryView = [[UISwitch alloc] init];
            } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            return cell;
        }
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"row: %d", indexPath.row);
    NSLog(@"section: %d", indexPath.section);
    
    if([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"]){
        self.distanceExpanded = !self.distanceExpanded;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]) {
        self.sortByExpanded = !self.sortByExpanded;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"]) {
        self.generalFeaturesExpanded = !self.generalFeaturesExpanded;
    }
       
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
