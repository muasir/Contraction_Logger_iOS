//
//  StopClockCell.m
//  ContractionApp
//
//  Created by Muasir on 9/20/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import "StopClockCell.h"

NSDate *startDate;
NSTimer *stopWatchTimer;

@implementation StopClockCell

bool currentState = 0; //0 meaning stop while 1 meaning running.

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ActionButtonClicked:(id)sender {
    if (currentState == 0) {
        NSDateFormatter *formatter;
        formatter = [[NSDateFormatter alloc] init];
        startDate = [NSDate date];
        [formatter setDateFormat:@"hh:mm:ss a"];
        self.startTime.text = [formatter stringFromDate:startDate];
        self.startTimeLabel.hidden = false;
        self.startTime.hidden = false;
        [self.clickButton setTitle:@"Stop" forState:UIControlStateNormal];
        //set the state to running
        currentState = 1;
        [self runTimer];
    }else{
        //call delegate with current time
        [self.delegate timerStarted:startDate AndEnded:[NSDate date]];
        [self resetScreen];
    }
}

- (void) runTimer
{
    stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/15.0
                                                      target:self
                                                    selector:@selector(updateMainTimer)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void) updateMainTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss:SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    self.mainTimer.text = [dateFormatter stringFromDate:timerDate];
}

-(void) resetScreen
{
    //set the state to stop
    currentState = 0;
    [stopWatchTimer invalidate];
    self.mainTimer.text = @"00:00:00";
    self.startTime.hidden = true;
    self.startTimeLabel.hidden = true;
    [self.clickButton setTitle:@"Start" forState:UIControlStateNormal];
}

@end
