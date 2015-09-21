//
//  HistoryData.h
//  ContractionApp
//
//  Created by Muasir on 9/20/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryData : NSObject <NSCoding>

@property (copy, nonatomic) NSDate * startTime;
@property (copy, nonatomic) NSDate * endTime;
@property (copy, nonatomic) NSString * duration;
@property (copy, nonatomic) NSString * frequency;

@end
