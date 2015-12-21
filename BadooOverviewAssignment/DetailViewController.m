//
//  DetailViewController.m
//  BadooOverviewAssignment
//
//  Created by Valeriy Van on 19.12.15.
//  Copyright (c) 2015 Badoo. All rights reserved.
//

#import "DetailViewController.h"
#import "BADConvertionRates.h"

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
    // TODO: user viewForHeader and move this to background
    double total = 0;
    for (NSDictionary<NSString*, NSString*> *transaction in self.transactions) {
        NSString *currency = transaction[@"currency"];
        double amount = [transaction[@"amount"] doubleValue];
        total += amount * [self.convertionRates rateFrom:currency to:@"GBP"];
    }
    return [NSString stringWithFormat:@"Total: £%.2lf", total];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell detail" forIndexPath:indexPath];
    NSDictionary<NSString*, NSString*> *transaction = self.transactions[indexPath.row];
    NSString *currency = transaction[@"currency"];
    double amount = [transaction[@"amount"] doubleValue];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%.2lf", [self currencySymbolFor:currency], amount];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"£%.2lf", amount * [self.convertionRates rateFrom:currency to:@"GBP"]];
    return cell;
}

-(NSString*)currencySymbolFor:(NSString*)s {
    NSDictionary *d = @{ @"GBP" : @"£", @"USD" : @"$", @"CAD" : @"CA$", @"AUD" : @"A$", @"EUR" : @"€"};
    return d[s] ?: @"$$$";
}

@end
