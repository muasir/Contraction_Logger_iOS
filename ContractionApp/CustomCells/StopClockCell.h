//
//  StopClockCell.h
//  ContractionApp
//
//  Created by Muasir on 9/20/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StopClockDelegate
@required
-(void) timerStarted: (NSDate *) startTime AndEnded: (NSDate *) endTime;
@end

@interface StopClockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainTimer;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickButton;
- (IBAction)ActionButtonClicked:(id)sender;
@property (nonatomic, weak) id<StopClockDelegate> delegate;
-(void) resetScreen;

@end
