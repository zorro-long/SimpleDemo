//
//  EditViewController.h
//  SimpleDemo
//
//  Created on 2/27/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvEdit;
@property (strong, nonatomic) NSMutableArray *arrDataSource;

- (IBAction)onCancel:(id)sender;
- (IBAction)onSave:(id)sender;

@end
