//
//  DetailViewController.h
//  BadooOverviewAssignment
//
//  Created by Valeriy Van on 19.12.15.
//  Copyright (c) 2015 Badoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

