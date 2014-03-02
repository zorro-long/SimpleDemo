//
//  EditViewController.m
//  SimpleDemo
//
//  Created on 2/27/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "EditViewController.h"
#import "AppDefine.h"
#import "Stock.h"
#import "EditCell.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization

    self.arrDataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSData *customObjectData = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_STOCKS];
    NSMutableArray *arrStock = [NSKeyedUnarchiver unarchiveObjectWithData:customObjectData];
    
    if (arrStock != nil && [arrStock count] != 0) {
      self.arrDataSource = arrStock;
    }
  }
    
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
  
  [self.tvEdit setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onCancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSave:(id)sender {
  NSData *newObjectData = [NSKeyedArchiver archivedDataWithRootObject:self.arrDataSource];
  [[NSUserDefaults standardUserDefaults] setObject:newObjectData forKey:UD_KEY_STOCKS];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.arrDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  EditCell *cell = (EditCell *)[tableView dequeueReusableCellWithIdentifier:@"EditCell"];
  
  if (cell == nil) {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditCell" owner:nil options:nil];
    
    for (id oneObject in nib) {
      if ([oneObject isKindOfClass:[EditCell class]]) {
        cell = (EditCell *)oneObject;
      }
    }
  }
  
  /* Configure the cell. */
  Stock *stock = [self.arrDataSource objectAtIndex:[indexPath row]];
  
  cell.lblName.text = stock.name;
  cell.lblCode.text = stock.code;
  
  return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.arrDataSource removeObjectAtIndex:indexPath.row];
    [self.tvEdit deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  Stock *oldStock = [self.arrDataSource objectAtIndex:sourceIndexPath.row];
  [self.arrDataSource removeObject: oldStock];
  [self.arrDataSource insertObject:oldStock atIndex:destinationIndexPath.row];
  
}


@end
