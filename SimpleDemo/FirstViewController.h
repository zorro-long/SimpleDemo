//
//  FirstViewController.h
//  SimpleDemo
//
//  Created by zorro on 14-2-26.
//  Copyright (c) 2014年 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortButton;

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrDatasource;
@property (nonatomic, strong) NSTimer *refreshDatasourceTimer;
@property (nonatomic, strong) NSTimer *refreshTableTimer;

@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet SortButton *btnNewPrice;
@property (weak, nonatomic) IBOutlet SortButton *btnLapPercent;
@property (weak, nonatomic) IBOutlet SortButton *btnLap;

- (IBAction)onNewPrice:(id)sender;
- (IBAction)onLapPercent:(id)sender;
- (IBAction)onLap:(id)sender;

@end

