//
//  Stock.m
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "Stock.h"

@implementation Stock

- (double)doubleLap {
  double currentPrice = [self.currentPrice doubleValue];
  double yesterdayPrice = [self.yesterdayPrice doubleValue];
  
  double lap = currentPrice - yesterdayPrice;
  
  return abs(lap);
}

- (NSString *)lap {
  return [NSString stringWithFormat:@"%.2lf", [self doubleLap]];
}

- (NSString *)lapPercent {
  double yesterdayPrice = [self.yesterdayPrice doubleValue];
  
  double lapPercent = [self doubleLap] / yesterdayPrice;
  
  return [NSString stringWithFormat:@"%.2lf%@", lapPercent, @"%"];
}

#pragma mark - Compare

- (NSComparisonResult)compareCurrentPrice:(Stock *)otherObject {
  return [self.currentPrice compare:otherObject.currentPrice];
}

- (NSComparisonResult)compareLap:(Stock *)otherObject {
  return [[self lap] compare:[otherObject lap]];
}

- (NSComparisonResult)compareLapPercent:(Stock *)otherObject {
  return [[self lapPercent] compare:[otherObject lapPercent]];
}

#pragma mark - NSCoding support

-(void)encodeWithCoder:(NSCoder*)encoder {
  [encoder encodeObject:self.name forKey:@"name"];
  [encoder encodeObject:self.nickName forKey:@"nickName"];
  [encoder encodeObject:self.code forKey:@"code"];
  [encoder encodeObject:self.queryCode forKey:@"queryCode"];
  [encoder encodeObject:self.currentPrice forKey:@"currentPrice"];
  [encoder encodeObject:self.yesterdayPrice forKey:@"yesterdayPrice"];
  [encoder encodeObject:self.highestPrice forKey:@"highestPrice"];
  [encoder encodeObject:self.lowestPrice forKey:@"lowestPrice"];
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if (self) {
    self.name = [decoder decodeObjectForKey:@"name"];
    self.nickName = [decoder decodeObjectForKey:@"nickName"];
    self.code = [decoder decodeObjectForKey:@"code"];
    self.queryCode = [decoder decodeObjectForKey:@"queryCode"];
    self.currentPrice = [decoder decodeObjectForKey:@"currentPrice"];
    self.yesterdayPrice = [decoder decodeObjectForKey:@"yesterdayPrice"];
    self.highestPrice = [decoder decodeObjectForKey:@"highestPrice"];
    self.lowestPrice = [decoder decodeObjectForKey:@"lowestPrice"];
  }
  return self;
}

@end
