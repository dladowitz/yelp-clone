//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "FilterViewController.h"
#import "YelpClient.h"
#import "YelpListing.h"
#import "YelpListingCell.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *yelpListings;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    
    // tableView settings
        // Creates Nib for Custom Cell and registers with tableView for reuse
        UINib *yelpListingCellNib = [UINib nibWithNibName:@"YelpListingCell" bundle:nil];
        [self.tableView registerNib:yelpListingCellNib forCellReuseIdentifier:@"YelpListingCell"];

        // Seting dataSource and delegates for tableView
        self.tableView.dataSource = self;
        self.tableView.delegate   = self;

    // Navigation Bar Settings - Should try to move this all to a method
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];

        // Add Search Bar to Navigation Bar
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40.0, 0.0, 280.0, 44.0)];
        searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        searchBar.barTintColor = [UIColor redColor];
        UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
        searchBarView.autoresizingMask = 0;
        searchBar.delegate = self;
        [searchBarView addSubview:searchBar];
        self.navigationItem.titleView = searchBarView;
    
    
    // Yelp API Settings
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
        // Pulling results from Yelp API.
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            // NSLog(@"response: %@", response);
            // Passing API results to the YelpListing model for creation
            self.yelpListings = [YelpListing yelpListingsWithArray:response[@"businesses"]];
            [self.tableView reloadData];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    
}

#pragma mark -Table View Methods

// Setting the number of cells to show in tableView
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yelpListings.count;
}

// Setting the data on individual cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpListingCell" forIndexPath:indexPath];
    
    YelpListing *listing = self.yelpListings[indexPath.row];

    // Used to set search position on listing name
    NSInteger searchPosition = indexPath.row + 1;
    listing.index    = [NSString stringWithFormat: @"%i", searchPosition];
    
    cell.yelpListing = listing;
    
    return cell;
}

// TODO Why does this change on lower rows????
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpListing *listing = self.yelpListings[indexPath.row];
    
    NSString *text = listing.name;
    UIFont *fontText = [UIFont boldSystemFontOfSize:17.0];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(165, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontText}
                                     context:nil];
    CGFloat heightOffset = 90;
    return rect.size.height + heightOffset;
}

# pragma mark - Color Methods

// Changes Carrier Status Bar to White Text
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Navigation Control Methods

- (void)onFilterButton {
    NSLog(@"push the button");
    [self.navigationController pushViewController:[[FilterViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
