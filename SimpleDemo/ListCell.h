//
//  ListCell.h
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblLapPercent;
@property (weak, nonatomic) IBOutlet UILabel *lblLap;

@end
