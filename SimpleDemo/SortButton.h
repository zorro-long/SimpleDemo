//
//  SortButton.h
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortButton : UIButton

@property (nonatomic, assign) BOOL isAscending;
@property (nonatomic, strong) NSString *sortKey;
@property (nonatomic, strong) NSString *btnName;

- (void)showSortButton;
- (void)showNormalButton;

@end
