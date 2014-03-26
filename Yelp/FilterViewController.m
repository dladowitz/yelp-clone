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

@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *priceStates;
@property (nonatomic, strong) NSMutableArray *mostPopularStates;
@property (nonatomic, strong) NSMutableArray *distanceStates;
@property (nonatomic, strong) NSMutableArray *sortByStates;
@property (nonatomic, strong) NSMutableArray *generalFeaturesStates;
@property (nonatomic, strong) NSMutableArray *categoriesStates;
@property (nonatomic, assign) BOOL generalFeaturesExpanded;
@property (nonatomic, assign) BOOL sortByExpanded;
@property (nonatomic, assign) BOOL distanceExpanded;
@property (nonatomic, assign) BOOL categoriesExpanded;
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

    UINavigationBar *headerView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    
    //The UINavigationItem is neede as a "box" that holds the Buttons or other elements
    UINavigationItem *buttonCarrier = [[UINavigationItem alloc]initWithTitle:@"Filter"];
    
    //Creating some buttons:
    UIBarButtonItem *barBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    UIBarButtonItem *barSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveFilters)];
    
    //Putting the Buttons on the Carrier
    [buttonCarrier setLeftBarButtonItem:barBackButton];
    [buttonCarrier setRightBarButtonItem:barSaveButton];
    
    //The NavigationBar accepts those "Carrier" (UINavigationItem) inside an Array
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonCarrier,nil];
    
    // Attaching the Array to the NavigationBar
    [headerView setItems:barItemArray];
    
    // Adding the NavigationBar to the TableView
    [self.tableView setTableHeaderView:headerView];
    
    [headerView setBarTintColor:[UIColor redColor]];
    [headerView setTintColor:[UIColor whiteColor]];
//    [headerView setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)}];
    
    
    
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
    
    // Arrays for mutable values
        self.mostPopularStates = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), nil];
        self.priceStates = [NSMutableArray arrayWithObjects: @(0), nil];
        self.distanceStates = [NSMutableArray arrayWithObjects: @(YES), @(NO), @(NO), @(NO), @(NO), nil];
        self.sortByStates = [NSMutableArray arrayWithObjects: @(YES), @(NO), @(NO), @(NO), nil];
        self.generalFeaturesStates = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO), @(NO), @(YES), @(NO), nil];
        self.categoriesStates = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO), nil];
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
        } else if ( [self.categories[section][@"name"]  isEqual: @"Categories"] ){
            if(!self.categoriesExpanded){
                return 4;
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
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Categories"] && !self.categoriesExpanded && indexPath.row == 3) {
            SeeAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAllCell" forIndexPath:indexPath];
            return cell;
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Price"] ) {
            PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell" forIndexPath:indexPath];
//            cell.delegate = self;
            return cell;
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"] || [self.categories[indexPath.section][@"name"]  isEqual: @"General Features"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Categories"]) {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];

            cell.delegate = self;
            cell.switchLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
            
            if([self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"]){
                cell.onSwitch.on = [self.mostPopularStates[indexPath.row] boolValue];
                return cell;
            } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"]) {
                cell.onSwitch.on = [self.generalFeaturesStates[indexPath.row] boolValue];
                return cell;
            } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Categories"]) {
                cell.onSwitch.on = [self.categoriesStates[indexPath.row] boolValue];
                return cell;
            } else {
                cell.onSwitch.on = [self.categories[indexPath.section][@"values"][indexPath.row] boolValue];
                return cell;
            }

        } else {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
            
            if ([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"]){
                if ([self.distanceStates[indexPath.row] boolValue]){
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]){
                if ([self.sortByStates[indexPath.row] boolValue]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
            

            return cell;
        }
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"row: %d", indexPath.row);
    NSLog(@"section: %d", indexPath.section);
    
    if([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"]){
        if(!self.distanceExpanded){
            self.distanceExpanded = YES;
        }
        
        NSLog(@"Value in distance.states: %@", self.distanceStates[indexPath.row]);
        
        // Trying to reset the array each time. Doesn't seem to work properly though
        // self.distanceStates = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), @(NO), nil];
        if ([self.distanceStates[indexPath.row] boolValue]){
            self.distanceStates[indexPath.row] = @(NO);
        } else {
            self.distanceStates[indexPath.row] = @(YES);
        }
        
        
    } else if([self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]){
        self.sortByExpanded = !self.sortByExpanded;
        self.sortByStates[indexPath.row] = @(YES);
        
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]) {
        self.sortByExpanded = !self.sortByExpanded;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"] && indexPath.row == 3 && !self.generalFeaturesExpanded) {
        self.generalFeaturesExpanded = !self.generalFeaturesExpanded;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Categories"] && indexPath.row == 3 && !self.categoriesExpanded) {
        self.categoriesExpanded = !self.categoriesExpanded;
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
    if (indexPath.section == 1) {
        self.mostPopularStates[indexPath.row] = @(value);
    } else if (indexPath.section == 4) {
        self.generalFeaturesStates[indexPath.row] = @(value);
    } else if (indexPath.section == 5) {
        self.categoriesStates[indexPath.row] = @(value);
    }
}



#pragma mark - FilterViewController Delegate Methods

-(void)processFilterSettingsData:(NSMutableDictionary *)data {
    if ([self.delegate respondsToSelector:@selector(processFilterSettingsData:)]) {
        [self.delegate processFilterSettingsData:data];
    }
}

#pragma mark - Buttons

- (void)saveFilters {
    NSLog(@"Save Button Pressed");
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    
        [filters setObject:self.mostPopularStates forKey:@"mostPopular"];
        [filters setObject:self.distanceStates forKey:@"distance"];
        [filters setObject:self.sortByStates forKey:@"sortBy"];
        [filters setObject:self.generalFeaturesStates forKey:@"generalFeaturesPopular"];
        [filters setObject:self.categoriesStates forKey:@"categoriesPopular"];
//    [filters setObject:[NSNumber numberWithInt:self.sortByCurrentIndex] forKey:@"sortByCurrentIndex"];
//    [filters setObject:self.mostPopularSwitchStates forKey:@"mostPopularSwitchStates"];
//    [filters setObject:self.categoriesSwitchStates forKey:@"categoriesSwitchStates"];
//    [filters setObject:self.categories[5][@"values"] forKey:@"categories"];
//    [filters setObject:self.categories[2][@"values"] forKey:@"distances"];
    
    
    [self processFilterSettingsData:filters];
    [self dismissViewControllerAnimated:YES completion:^{}];
}


//- (void)saveFilter:(UIBarButtonItem *)button
//{
//    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
//    
//    [self filterSettings:filters];
//    [self dismissViewControllerAnimated:YES completion:^{}];
//    return;
//}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
