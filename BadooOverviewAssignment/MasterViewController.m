//
//  MasterViewController.m
//  BadooOverviewAssignment
//
//  Created by Valeriy Van on 19.12.15.
//  Copyright (c) 2015 Badoo. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#define kTransactionsFilename @"transactions1.plist"

@interface MasterViewController ()

@property NSArray *skus;
@property NSArray *transactions;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    // TODO: move this background
    NSString *transactionsPathname = [[NSBundle mainBundle] pathForResource:kTransactionsFilename ofType:nil];
    // TODO: if file exists at path
    NSArray *transactionsList = [NSArray arrayWithContentsOfFile:transactionsPathname];
    self.skus = [transactionsList valueForKeyPath:@"@distinctUnionOfObjects.sku"];
    NSMutableArray *transactionsMutable = [NSMutableArray arrayWithCapacity:self.skus.count];
    for (NSString *sku in self.skus) {
        NSArray *transactionsForSku = [transactionsList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.sku == %@", sku]];
        [transactionsMutable addObject:transactionsForSku];
    }
    self.transactions = [transactionsMutable copy];
    // TODO: add count to title
    [self.tableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        //[controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.skus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDictionary *dic = self.transactions[indexPath.row];
    //cell.textLabel.text = dic[@"sku"];
    
    cell.textLabel.text = self.skus[indexPath.row];
    NSArray *transactionsForSKU = self.transactions[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu transactions", (unsigned long)transactionsForSKU.count];
    return cell;
}

@end
