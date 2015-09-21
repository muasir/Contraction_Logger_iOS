//
//  ViewController.h
//  ContractionApp
//
//  Created by Muasir on 9/18/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopClockCell.h"
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, StopClockDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)deleteHistory:(id)sender;


@end

