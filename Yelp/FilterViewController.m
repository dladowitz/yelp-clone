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
#import "SwitchCell.h"

@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *mostPopularStates;
@property (nonatomic, assign) BOOL generalFeaturesExpanded;
@property (nonatomic, assign) BOOL sortByExpanded;
@property (nonatomic, assign) BOOL distanceExpanded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

//    self.mostPopularStates = [[NSMutableArray alloc] init];
    self.mostPopularStates = [NSMutableArray arrayWithObjects: @(YES), @(NO), @(NO), @(NO), nil];
    
    
    
    // Registering Custom Cells
        UINib *seeAllNib = [UINib nibWithNibName:@"SeeAllCell" bundle:nil];
        [self.tableView registerNib:seeAllNib forCellReuseIdentifier:@"SeeAllCell"];
        
        UINib *pricelNib = [UINib nibWithNibName:@"PriceCell" bundle:nil];
        [self.tableView registerNib:pricelNib forCellReuseIdentifier:@"PriceCell"];
        
        UINib *switchNib = [UINib nibWithNibName:@"SwitchCell" bundle:nil];
        [self.tableView registerNib:switchNib forCellReuseIdentifier:@"SwitchCell"];
    
    // Set up filter categories
        [self setupOptions];
    

    
}

-(void)viewDidAppear:(BOOL)animated {
    // Delegate info
        FilterViewController *filterViewController = [FilterViewController alloc];
        filterViewController.delegate = self;
//        [[self navigationController] pushViewController:filterViewController animated:YES];
}

// Thanks Nick H!
- (void)setupOptions {
//    self.options = [[NSMutableDictionary alloc] initWithCapacity:20];
//    self.expandedCategories = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    self.categories = [NSMutableArray arrayWithObjects:
  @{
    @"name":@"Price",
    @"type":@"segmented",
    @"list":@[@"$",@"$$",@"$$$",@"$$$$"],
    @"values":@1
    },
  @{
    @"name":@"Most Popular",
    @"type":@"switches",
    @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
    },
  @{
    @"name":@"Distance",
    @"type":@"expandable",
    @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"],
    @"values":@[@(NO), @(NO), @(NO), @(NO), @(NO)]
    },
  @{
    @"name":@"Sort By",
    @"type":@"expandable",
    @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"],
    @"values":@[@(NO), @(NO), @(NO), @(NO)]
    },
  @{
    @"name":@"General Features",
    @"type":@"switches",
    @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"],
    @"values":@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)]
    },
    @{
     @"name":@"Categories",
     @"type":@"switches",
     @"list":@[@"All",@"Active Live",@"Arts & Entertainment",@"Automotive",@"Beauty & Spas",@"Education",@"Event Planning & Services"],
     @"values":@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)]
     },
    nil];
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
        } else if (section == 4){
            return @"General Features";
        } else {
            return @"Categories";
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
            cell.delegate = self;
            return cell;
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"] || [self.categories[indexPath.section][@"name"]  isEqual: @"General Features"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Categories"]) {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];

            cell.delegate = self;
            cell.switchLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
            
            if([self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"]){
                cell.onSwitch.on = [self.mostPopularStates[indexPath.row] boolValue];
                return cell;
            } else {
                cell.onSwitch.on = [self.categories[indexPath.section][@"values"][indexPath.row] boolValue];
                return cell;
            }

            
        } else {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

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


#pragma mark - Price Cell Delegate Methods
//
//-(void)sender:(PriceCell *)sender didChangeValue:(int)value{
//    NSLog(@"Segment Control Pressed");
//}


#pragma mark - Switch Cell Delegate Methods

// On switch change the new value is pushed back to the mostPopularStates array
- (void)sender:(SwitchCell *)sender didChangeValue:(BOOL)value{

    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    self.mostPopularStates[indexPath.row] = @(value);
}


#pragma mark - FilterViewController Delegate Methods
- (void)addFiltersViewController:(FilterViewController *)controller didFinishSaving:(NSMutableArray *)filters {
    
    NSMutableArray *testFilters = [NSMutableArray arrayWithObjects: @(YES), @(NO), @(NO), @(NO), nil];
    [self.delegate addFiltersViewController:self didFinishSaving:testFilters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
