//
//  ChartKViewController.m
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "ChartKViewController.h"

@interface ChartKViewController ()

@end

@implementation ChartKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = NSLocalizedString(@"Second", @"Second");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
