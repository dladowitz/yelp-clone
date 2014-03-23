//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
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
    
        // Sets height of custom cells
            // self.tableView.rowHeight = 130;

        // Seting dataSource and delegates for tableView
        self.tableView.dataSource = self;
        self.tableView.delegate   = self;

    // Navigation Bar Settings
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpListing *listing = self.yelpListings[indexPath.row];
    
    NSString *text = listing.name;
    UIFont *fontText = [UIFont systemFontOfSize:17.0];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(165, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontText}
                                     context:nil];
    CGFloat heightOffset = 90;
    return rect.size.height + heightOffset;
}

// Changes Carrier Status Bar to White Text
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
