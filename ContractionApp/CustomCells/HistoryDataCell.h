//
//  HistoryDataCell.h
//  ContractionApp
//
//  Created by Muasir on 9/20/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMenuTableViewCell.h"
#import "HistoryData.h"

@interface HistoryDataCell : ABMenuTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *frequency;

-(void) populateCellWithHistoryData: (HistoryData *)hData;
@end
