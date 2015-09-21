//
//  HistoryDataCell.m
//  ContractionApp
//
//  Created by Muasir on 9/20/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import "HistoryDataCell.h"

@implementation HistoryDataCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) populateCellWithHistoryData: (HistoryData *)hData
{
    self.startTime.text = [self getFormattedData:hData.startTime];
    self.endTime.text = [self getFormattedData:hData.endTime];
    self.duration.text = hData.duration;
    self.frequency.text = hData.frequency;
}

-(NSString *) getFormattedData: (NSDate *) date
{
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss a"];
    return [formatter stringFromDate:date];
}

@end
