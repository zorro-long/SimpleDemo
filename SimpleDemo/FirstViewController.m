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
#import "ASIHTTPRequest.h"
#import "Stock.h"
#import "AppDefine.h"

@interface FirstViewController ()

@end

static NSString *searchUrl = @"http://hq.sinajs.cn/list=";

#define SORT_KEY_LAP                @"lap"
#define SORT_KEY_LAP_PERCENT        @"lapPercent"
#define SORT_KEY_CURRENT_PRICE      @"currentPrice"

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
    
    self.arrDatasource = [[NSMutableArray alloc] initWithCapacity:0];
  }
    
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.btnLap.btnName = @"Lap";
  self.btnLapPercent.btnName = @"Lap Percent";
  self.btnNewPrice.btnName = @"Current Price";
  
  self.btnLap.sortKey = SORT_KEY_LAP;
  self.btnLapPercent.sortKey = SORT_KEY_LAP_PERCENT;
  self.btnNewPrice.sortKey = SORT_KEY_CURRENT_PRICE;
  
  self.refreshDatasourceTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(refreshDatasource) userInfo:nil repeats:YES];
  self.refreshTableTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(refreshTable) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated {
  [self initDatasource];
  [self.tvList reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)onRefresh {
  for (Stock *stock in self.arrDatasource) {
    NSURL *url = [NSURL URLWithString:[searchUrl stringByAppendingString:stock.queryCode]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error) {
      NSString *response = [request responseString];
      
      NSString* newString =[[response componentsSeparatedByString:@"\""] objectAtIndex:1];
      
      NSArray *arrStock = [newString componentsSeparatedByString:@","];
      
      stock.yesterdayPrice = [arrStock objectAtIndex:2];
      stock.currentPrice = [arrStock objectAtIndex:3];
      stock.highestPrice = [arrStock objectAtIndex:4];
      stock.lowestPrice = [arrStock objectAtIndex:5];
      
    } else {
      NSLog(@"Error - %@", error);
    }
  }
  
  [self.tvList reloadData];
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
  
  Stock *stock = [self.arrDatasource objectAtIndex:indexPath.row];
  
  cell.lblName.text = stock.name;
  cell.lblCode.text = stock.code;
  cell.lblCurrentPrice.text = stock.currentPrice;
  cell.lblLapPercent.text = [stock lapPercent];
  cell.lblLap.text = [stock lap];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ChartViewController *chartVC = [[ChartViewController alloc] initWithNibName:@"ChartViewController" bundle:nil];
  chartVC.queryCode = [[self.arrDatasource objectAtIndex:indexPath.row] queryCode];
  ChartKViewController *chartKVC = [[ChartKViewController alloc] initWithNibName:@"ChartKViewController" bundle:nil];
  chartKVC.queryCode = [[self.arrDatasource objectAtIndex:indexPath.row] queryCode];
  
  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  tabBarController.viewControllers = @[chartVC, chartKVC];
  
  [self presentViewController:tabBarController animated:YES completion:nil];
}

- (void)sortDatasource:(NSString *)key andIsAscending:(BOOL)isAscending {
  if ([key isEqualToString:SORT_KEY_CURRENT_PRICE]) {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"currentPrice" ascending:isAscending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.arrDatasource = (NSMutableArray *)[self.arrDatasource sortedArrayUsingDescriptors:sortDescriptors];
    
  } else if ([key isEqualToString:SORT_KEY_LAP]) {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lap" ascending:isAscending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.arrDatasource = (NSMutableArray *)[self.arrDatasource sortedArrayUsingDescriptors:sortDescriptors];
    
  } else if ([key isEqualToString:SORT_KEY_LAP_PERCENT]) {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lapPercent" ascending:isAscending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.arrDatasource = (NSMutableArray *)[self.arrDatasource sortedArrayUsingDescriptors:sortDescriptors];
  }
}

#pragma mark - Get Data

- (void)initDatasource {
  [self.arrDatasource removeAllObjects];
  
  NSData *customObjectData = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_STOCKS];
  NSMutableArray *arrStock = [NSKeyedUnarchiver unarchiveObjectWithData:customObjectData];
  
  if (arrStock != nil && [arrStock count] != 0) {
    self.arrDatasource = arrStock;
  }
  
  for (Stock *stock in self.arrDatasource) {
    NSURL *url = [NSURL URLWithString:[searchUrl stringByAppendingString:stock.queryCode]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error) {
      NSString *response = [request responseString];
      
      NSString* newString =[[response componentsSeparatedByString:@"\""] objectAtIndex:1];
      
      NSArray *arrStock = [newString componentsSeparatedByString:@","];
      
      stock.yesterdayPrice = [arrStock objectAtIndex:2];
      stock.currentPrice = [arrStock objectAtIndex:3];
      stock.highestPrice = [arrStock objectAtIndex:4];
      stock.lowestPrice = [arrStock objectAtIndex:5];
      
    } else {
      NSLog(@"Error - %@", error);
    }
  }
}

- (void)refreshDatasource {
  for (Stock *stock in self.arrDatasource) {
    NSURL *url = [NSURL URLWithString:[searchUrl stringByAppendingString:stock.queryCode]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
  }
}

- (void) requestFinished:(ASIHTTPRequest *)request {
  NSString *response = [request responseString];
  
  // parse response
  NSString* newString =[[response componentsSeparatedByString:@"\""] objectAtIndex:1];
  
  NSArray *arrStock = [newString componentsSeparatedByString:@","];
  NSString *name = [arrStock objectAtIndex:0];
  
  NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.name == %@", name];
  NSArray* subArray = [self.arrDatasource filteredArrayUsingPredicate:predicate];
  
  if (subArray != nil && [subArray count] > 0) {
    Stock *stock = [subArray objectAtIndex:0];
    
    stock.yesterdayPrice = [arrStock objectAtIndex:2];
    stock.currentPrice = [arrStock objectAtIndex:3];
    stock.highestPrice = [arrStock objectAtIndex:4];
    stock.lowestPrice = [arrStock objectAtIndex:5];
  }
}

- (void) requestFailed:(ASIHTTPRequest *)request {
  NSLog(@"Error - %@", [request error]);
}

- (void)refreshTable {
  [self.tvList reloadData];
}

@end
