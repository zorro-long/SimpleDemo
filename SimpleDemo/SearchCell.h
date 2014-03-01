//
//  SearchCell.h
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *queryCode;

@property (weak, nonatomic) IBOutlet UIButton *btnAddRemove;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;

- (void)showAddRemoveTitle;

@end
