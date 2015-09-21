//
//  ViewController.m
//  ContractionApp
//
//  Created by Muasir on 9/18/15.
//  Copyright © 2015 ATX Learning. All rights reserved.
//

#import "ViewController.h"
#import "HistoryData.h"
#import "HistoryDataCell.h"

@interface ViewController ()

@end

NSMutableArray *historyData;
bool clearRow = false;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadHistoryData];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self saveHistoryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else if(section == 1)
        return [historyData count];
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
        return 360;
    else
        return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stopClockIdentifier = @"StopClockCell";
    static NSString *historyIdentifier = @"HistoryDataCell";
    UITableViewCell *cell;
    
    if(indexPath.section == 0 && indexPath.row == 0){
        StopClockCell *scCell = [tableView dequeueReusableCellWithIdentifier:stopClockIdentifier];
        scCell.delegate = self;
        if(clearRow){
            [scCell resetScreen];
        }
        cell = scCell;
    }else{
        //It's the history section.
        HistoryDataCell *hCell = [tableView dequeueReusableCellWithIdentifier:historyIdentifier];
        // use your own custom menu view
        /*
        UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160.0, 44.0)];
        menuView.backgroundColor = [UIColor redColor];
        
        hCell.rightMenuView = menuView;
        hCell.textLabel.text = @"Delete";
        */
        
        [hCell populateCellWithHistoryData:[historyData objectAtIndex:indexPath.row] ];
        return hCell;
    }

    return cell;
}

- (void) timerStarted:(NSDate *)startTime AndEnded:(NSDate *)endTime
{
    NSString *str = [self getTimeDifferenceBetween:endTime And:startTime];
    
    HistoryData *hData = [[HistoryData alloc] init];
    hData.startTime = startTime;
    hData.endTime = endTime;
    hData.duration = str;
    hData.frequency = [self frequencySinceLast:endTime];
    //always insert at front
    if(historyData == nil){
        historyData = [[NSMutableArray alloc] init];
    }
    //always insert at 0
    [historyData insertObject:hData atIndex:0];
    [self.tableView reloadData];
    [self saveHistoryData];
}

-(NSString *) frequencySinceLast: (NSDate *) endTime
{
    NSDate *lastEndTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"LastEndTime"];
    if(lastEndTime){
        NSString *diff = [NSString stringWithFormat:@"%@ ago", [self getTimeDifferenceBetween:endTime And:lastEndTime]];
        [[NSUserDefaults standardUserDefaults] setObject:endTime forKey:@"LastEndTime"];
        return diff;
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:endTime forKey:@"LastEndTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return @"N/A";
    }
}

//color alternate rows
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
 
    if(indexPath.section != 0){
        if(indexPath.row % 2 == 0)
            cell.backgroundColor = [UIColor colorWithRed:(249/255.0) green:(249/255.0) blue:(249/255.0) alpha:1];
        else
            cell.backgroundColor = [UIColor whiteColor];
    }
}

- (NSString *) getTimeDifferenceBetween: (NSDate *) endTime And: (NSDate *) startTime
{
    int time = (int)[endTime timeIntervalSinceDate:startTime];
    int seconds = time % 60;
    int minutes = (time / 60) % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (void) saveHistoryData
{
    //serialized in the format required for saving
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:historyData];
    
    //store for future
    //TODO: maybe this needs to be done in a different method.  We don't need to store each time. and maybe put a limit
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"HistoryData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) loadHistoryData
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryData"];
    historyData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (IBAction)deleteHistory:(id)sender {
    //removing history data, and lastEndTime
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HistoryData"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LastEndTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //reset the ArrayList
    [historyData removeAllObjects];
    clearRow = true;
    [self.tableView reloadData];
}
@end
