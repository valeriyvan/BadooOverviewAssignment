//
//  DetailViewController.h
//  BadooOverviewAssignment
//
//  Created by Valeriy Van on 19.12.15.
//  Copyright (c) 2015 Badoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BADConvertionRates;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) NSArray<NSDictionary<NSString*, NSString*>*> *transactions;
@property (strong, nonatomic) BADConvertionRates *convertionRates;

@end

