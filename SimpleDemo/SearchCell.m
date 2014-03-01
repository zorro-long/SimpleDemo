//
//  SearchCell.m
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "SearchCell.h"
#import "AppDefine.h"
#import "Stock.h"

#define STR_BTN_ADD         @"Add"
#define STR_BTN_REMOVE      @"Remove"

@implementation SearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }

  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (IBAction)onAddRemove:(id)sender {
  self.isSelected = !self.isSelected;
  [self showAddRemoveTitle];
  
  NSData *customObjectData = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_STOCKS];
  NSMutableDictionary *dicStock = [NSKeyedUnarchiver unarchiveObjectWithData:customObjectData];
  if (dicStock == nil) {
    dicStock = [[NSMutableDictionary alloc] initWithCapacity:0];
  }
  
  if ([dicStock objectForKey:self.queryCode] != nil) {
    [dicStock removeObjectForKey:self.queryCode];
  } else {
    Stock *stock = [[Stock alloc] init];
    stock.name = self.lblName.text;
    stock.nickName = self.lblNickName.text;
    stock.code = self.lblCode.text;
    stock.queryCode = self.queryCode;
    
    [dicStock setObject:stock forKey:stock.queryCode];
  }
  
  NSData *newObjectData = [NSKeyedArchiver archivedDataWithRootObject:dicStock];
  [[NSUserDefaults standardUserDefaults] setObject:newObjectData forKey:UD_KEY_STOCKS];
}



- (void)showAddRemoveTitle {
  if (self.isSelected) {
    [self.btnAddRemove setTitle:STR_BTN_REMOVE forState:UIControlStateNormal];
  } else {
    [self.btnAddRemove setTitle:STR_BTN_ADD forState:UIControlStateNormal];
  }
}

@end
