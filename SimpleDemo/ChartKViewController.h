//
//  ChartKViewController.h
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Chart;

@interface ChartKViewController : UIViewController

@property (nonatomic, strong) Chart *candleChart;
@property (nonatomic, assign) int chartMode;
@property (nonatomic, strong) NSString *queryCode;

@end
