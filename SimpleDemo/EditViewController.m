//
//  EditViewController.m
//  SimpleDemo
//
//  Created on 2/27/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = @"Edit";
    NSLog(@"zorro - %@", self.navigationController);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onCancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSave:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
