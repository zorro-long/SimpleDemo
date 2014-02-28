//
//  FirstViewController.m
//  SimpleDemo
//
//  Created by zorro on 14-2-26.
//  Copyright (c) 2014年 zorro. All rights reserved.
//

#import "FirstViewController.h"
#import "EditViewController.h"
#import "SearchViewController.h"
#import "ListCell.h"
#import "ChartViewController.h"
#import "ChartKViewController.h"
#import "SortButton.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"First", @"First");
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
    
    // init left bar buttons
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStyleBordered target:self action:@selector(onRefresh)];
    
    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:refresh, nil];
    
    // init right bar buttons
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(onSearch)];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(onEdit)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:search, edit, nil];
    
    // init data source
    self.arrDatasource = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
  }
    
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)onRefresh {
  NSLog(@"onRefresh");
}

- (void)onSearch {
  SearchViewController *searchVC = [[SearchViewController alloc] init];
  
  [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)onEdit {
  EditViewController *editVC = [[EditViewController alloc] init];

  [self presentViewController:editVC animated:YES completion:nil];
}

- (IBAction)onNewPrice:(id)sender {
  [self sortDatasource:self.btnNewPrice.sortKey andIsAscending:self.btnNewPrice.isAscending];
  
  [self.btnNewPrice showSortButton];
  [self.btnLapPercent showNormalButton];
  [self.btnLap showNormalButton];
  
  [self.tvList reloadData];
}

- (IBAction)onLapPercent:(id)sender {
  [self sortDatasource:self.btnLapPercent.sortKey andIsAscending:self.btnLapPercent.isAscending];
  
  [self.btnNewPrice showNormalButton];
  [self.btnLapPercent showSortButton];
  [self.btnLap showNormalButton];
  
  [self.tvList reloadData];
}

- (IBAction)onLap:(id)sender {
  [self sortDatasource:self.btnLap.sortKey andIsAscending:self.btnLap.isAscending];
  
  [self.btnNewPrice showNormalButton];
  [self.btnLapPercent showNormalButton];
  [self.btnLap showSortButton];
  
  [self.tvList reloadData];
}

#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.arrDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
  
  if (cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListCell"
                                                 owner:nil
                                               options:nil];
    
    for (id oneObject in nib) {
      if ([oneObject isKindOfClass:[ListCell class]]) {
        cell = (ListCell *)oneObject;
      }
    }
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *chartVC = [[ChartViewController alloc] initWithNibName:@"ChartViewController" bundle:nil];
  UIViewController *chartKVC = [[ChartKViewController alloc] initWithNibName:@"ChartKViewController" bundle:nil];
  
  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  tabBarController.viewControllers = @[chartVC, chartKVC];
  
  [self presentViewController:tabBarController animated:YES completion:nil];
}

- (void)sortDatasource:(NSString *)key andIsAscending:(BOOL)isAscending {
  
}

@end
