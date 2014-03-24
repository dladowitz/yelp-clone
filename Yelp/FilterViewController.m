//
//  FilterViewController.m
//  Yelp
//
//  Created by David Ladowitz on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"

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
        } else {
            return @"General Features";
        }
    }

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)] ;
//    headerView.backgroundColor=[UIColor redColor];
//    
//    UILabel *headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
//    headerLabel.backgroundColor=[UIColor clearColor];
//    headerLabel.textColor = [UIColor yellowColor];
//    
//    if (section == 1) {
//        headerLabel.text=@"Price";
//    } else if (section == 2) {
//        headerLabel.text=@"Most Popular";
//    } else {
//        headerLabel.text=@"Distance";
//    }
//    
//    [headerView addSubview:headerLabel];
//    
//    return headerView;
//}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    for (id category in self.categories) {
        
        if ([category[@"type"] isEqual: @"switches"]) {
            
            cell.textLabel.text = category[@"list"][indexPath.row];
            cell.accessoryView = [[UISwitch alloc] init];
        }
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
