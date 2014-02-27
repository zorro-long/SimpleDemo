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

@end
