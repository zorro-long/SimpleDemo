//
//  SortButton.m
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "SortButton.h"

#define ARROW_DOWN      @"↓"
#define ARROW_UP        @"↑"


@implementation SortButton

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)showSortButton {
  if (self.isAscending) {
    self.titleLabel.text = [self.btnName stringByAppendingString:ARROW_UP];
  } else {
    self.titleLabel.text = [self.btnName stringByAppendingString:ARROW_DOWN];
  }
  
  self.isAscending = !self.isAscending;
}

- (void)showNormalButton {
  self.titleLabel.text = self.btnName;
}

@end
