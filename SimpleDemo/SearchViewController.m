//
//  SearchViewController.m
//  SimpleDemo
//
//  Created on 2/27/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "ASIHTTPRequest.h"
#import "Stock.h"
#import "AppDefine.h"

@interface SearchViewController ()

@property (nonatomic, strong) UIButton *btnCancelSearch;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = @"Search";
    self.searchResults = [[NSMutableArray alloc] initWithCapacity:0];
  }
    
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:NO];
  [self.searchDisplayController.searchBar setKeyboardType:UIKeyboardTypeNamePhonePad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.searchResults count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SearchCell *cell = (SearchCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
  
  if (cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchCell"
                                                 owner:nil
                                               options:nil];
    
    for (id oneObject in nib) {
      if ([oneObject isKindOfClass:[SearchCell class]]) {
        cell = (SearchCell *)oneObject;
      }
    }
  }
  
  /* Configure the cell. */
  Stock *stock = [self.searchResults objectAtIndex:[indexPath row]];
  
  cell.lblName.text = stock.name;
  cell.lblCode.text = stock.code;
  cell.lblNickName.text = stock.nickName;
  cell.queryCode = stock.queryCode;
  cell.isSelected = [self isSelected:stock.queryCode];
  [cell showAddRemoveTitle];
  
  return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
  [self getSearchResultFromUrl:searchText];
}

#pragma mark – UISearchDisplayController delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
  [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];

  return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption {
  [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
  
  return YES;
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
  [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions

- (BOOL)isSelected:(NSString *)stockQueryCode {
  NSData *customObjectData = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_STOCKS];
  NSMutableArray *arrStock = [NSKeyedUnarchiver unarchiveObjectWithData:customObjectData];
  
  NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.queryCode == %@", stockQueryCode];
  NSArray* subArray = [arrStock filteredArrayUsingPredicate:predicate];
  
  return (subArray != nil && [subArray count] > 0);
}

#pragma mark - Get Data

- (void)getSearchResultFromUrl:(NSString *)searchKey {
  static NSString *searchUrl = @"http://suggest3.sinajs.cn/suggest/key=";
  
  [self.searchResults removeAllObjects];
  
  NSString *trimmedString = [searchKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if ([trimmedString length] == 0) {
    return;
  }
  
  NSURL *url = [NSURL URLWithString:[searchUrl stringByAppendingString:trimmedString]];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  
  [request startSynchronous];
  
  NSError *error = [request error];
  
  if (!error) {
    NSString *response = [request responseString];
    
    NSString* newString =[[response componentsSeparatedByString:@"\""] objectAtIndex:1];
    
    NSArray *arrSplit = [newString componentsSeparatedByString:@";"];
    
    for (NSString *str in arrSplit) {
      NSArray *arrStock = [str componentsSeparatedByString:@","];
      
      Stock *stock = [[Stock alloc] init];
      stock.code = [arrStock objectAtIndex:2];
      stock.queryCode = [arrStock objectAtIndex:3];
      stock.name = [arrStock objectAtIndex:4];
      stock.nickName = [arrStock objectAtIndex:5];
      
      [self.searchResults addObject:stock];
    }
    
  } else {
    NSLog(@"Error - %@", error);
  }
  
}

@end
