//
//  DetailViewController.m
//  BadooOverviewAssignment
//
//  Created by Valeriy Van on 19.12.15.
//  Copyright (c) 2015 Badoo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.transactions.count > 0) {
        self.title = [NSString stringWithFormat:@"Transactions for %@ (%lu)", self.transactions.firstObject[@"sku"]?:@"no sku", (unsigned long)self.transactions.count];
    }
    [self.tableView reloadData];
}

#pragma mark - Segues

#pragma mark - Table View

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Total: *****.*****"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell detail" forIndexPath:indexPath];
    NSDictionary *transaction = self.transactions[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%.2f", transaction[@"currency"], [transaction[@"amount"] floatValue]]; // TODO: currency symbol
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu transactions", (unsigned long)transactionsForSKU.count];
    return cell;
}


@end
