//
//  HistoryData.m
//  ContractionApp
//
//  Created by Muasir on 9/20/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import "HistoryData.h"

@implementation HistoryData 

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.startTime forKey:@"START_TIME"];
    [aCoder encodeObject:self.endTime forKey:@"END_TIME"];
    [aCoder encodeObject:self.duration forKey:@"DURATION"];
    [aCoder encodeObject:self.frequency forKey:@"FREQUENCY"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.startTime = [aDecoder decodeObjectForKey:@"START_TIME"];
        self.endTime = [aDecoder decodeObjectForKey:@"END_TIME"];
        self.duration = [aDecoder decodeObjectForKey:@"DURATION"];
        self.frequency = [aDecoder decodeObjectForKey:@"FREQUENCY"];
    }
    return self;
}

@end
