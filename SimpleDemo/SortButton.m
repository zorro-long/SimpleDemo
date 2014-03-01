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
    [self setTitle:[self.btnName stringByAppendingString:ARROW_UP] forState: UIControlStateNormal];
  } else {
    [self setTitle:[self.btnName stringByAppendingString:ARROW_DOWN] forState: UIControlStateNormal];
  }
  
  self.isAscending = !self.isAscending;
}

- (void)showNormalButton {
  [self setTitle:self.btnName forState: UIControlStateNormal];
}

@end
