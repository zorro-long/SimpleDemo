//
//  Stock.h
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *queryCode;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *yesterdayPrice;
@property (nonatomic, strong) NSString *highestPrice;
@property (nonatomic, strong) NSString *lowestPrice;
//@property (nonatomic, strong) NSMutableArray *arrChartData;

- (NSString *)lap;
- (NSString *)lapPercent;

@end
