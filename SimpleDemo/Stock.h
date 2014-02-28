//
//  Stock.h
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *latestPrice;
@property (nonatomic, strong) NSString *lapPercent;
@property (nonatomic, strong) NSString *lap;

@end
