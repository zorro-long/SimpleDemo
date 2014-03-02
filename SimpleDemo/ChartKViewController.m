//
//  ChartKViewController.m
//  SimpleDemo
//
//  Created on 2/28/14.
//  Copyright (c) 2014 zorro. All rights reserved.
//

#import "ChartKViewController.h"
#import "Chart.h"
#import "ASIHTTPRequest.h"

@interface ChartKViewController ()

@end

@implementation ChartKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = NSLocalizedString(@"ChartK", @"ChartK");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
    self.chartMode = 1;
  }
  return self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  //candleChart
  self.candleChart = [[Chart alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height - 140)];
	[self.view addSubview:self.candleChart];
  
  //init chart
  [self initChart];
  
  [self getSearchResultFromUrl];
}

-(void)initChart{
	NSMutableArray *padding = [NSMutableArray arrayWithObjects:@"5",@"5",@"5",@"5",nil];
	[self.candleChart setPadding:padding];
	NSMutableArray *secs = [[NSMutableArray alloc] init];
	[secs addObject:@"1"];
  [secs addObject:@"1"];
  
	[self.candleChart addSections:2 withRatios:secs];
  
	[[[self.candleChart sections] objectAtIndex:0] addYAxis:0];
	[[[self.candleChart sections] objectAtIndex:1] addYAxis:0];
	
	[self.candleChart getYAxis:0 withIndex:0].ext = 0.05;
	NSMutableArray *series = [[NSMutableArray alloc] init];
	NSMutableArray *secOne = [[NSMutableArray alloc] init];
	NSMutableArray *secTwo = [[NSMutableArray alloc] init];
	
	//price
	NSMutableDictionary *serie = [[NSMutableDictionary alloc] init];
	NSMutableArray *data = [[NSMutableArray alloc] init];
	[serie setObject:@"price" forKey:@"name"];
	[serie setObject:@"Price" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"candle" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"0" forKey:@"section"];
	[serie setObject:@"249,222,170" forKey:@"color"];
	[serie setObject:@"249,222,170" forKey:@"negativeColor"];
	[serie setObject:@"249,222,170" forKey:@"selectedColor"];
	[serie setObject:@"249,222,170" forKey:@"negativeSelectedColor"];
	[serie setObject:@"176,52,52" forKey:@"labelColor"];
	[serie setObject:@"77,143,42" forKey:@"labelNegativeColor"];
	[series addObject:serie];
	[secOne addObject:serie];
	
	//VOL
	serie = [[NSMutableDictionary alloc] init];
	data = [[NSMutableArray alloc] init];
	[serie setObject:@"vol" forKey:@"name"];
	[serie setObject:@"VOL" forKey:@"label"];
	[serie setObject:data forKey:@"data"];
	[serie setObject:@"column" forKey:@"type"];
	[serie setObject:@"0" forKey:@"yAxis"];
	[serie setObject:@"1" forKey:@"section"];
	[serie setObject:@"0" forKey:@"decimal"];
	[serie setObject:@"176,52,52" forKey:@"color"];
	[serie setObject:@"77,143,42" forKey:@"negativeColor"];
	[serie setObject:@"176,52,52" forKey:@"selectedColor"];
	[serie setObject:@"77,143,42" forKey:@"negativeSelectedColor"];
	[series addObject:serie];
	[secTwo addObject:serie];
	
	//candleChart init
  [self.candleChart setSeries:series];
	
	[[[self.candleChart sections] objectAtIndex:0] setSeries:secOne];
	[[[self.candleChart sections] objectAtIndex:1] setSeries:secTwo];
  
  CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  pathAnimation.duration = 10.0;
  pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
  pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
  [(CALayer *)self.candleChart addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
  
}

-(void)setOptions:(NSDictionary *)options ForSerie:(NSMutableDictionary *)serie;{
	[serie setObject:[options objectForKey:@"name"] forKey:@"name"];
	[serie setObject:[options objectForKey:@"label"] forKey:@"label"];
	[serie setObject:[options objectForKey:@"type"] forKey:@"type"];
	[serie setObject:[options objectForKey:@"yAxis"] forKey:@"yAxis"];
	[serie setObject:[options objectForKey:@"section"] forKey:@"section"];
	[serie setObject:[options objectForKey:@"color"] forKey:@"color"];
	[serie setObject:[options objectForKey:@"negativeColor"] forKey:@"negativeColor"];
	[serie setObject:[options objectForKey:@"selectedColor"] forKey:@"selectedColor"];
	[serie setObject:[options objectForKey:@"negativeSelectedColor"] forKey:@"negativeSelectedColor"];
}

-(void)setData:(NSDictionary *)dic{
	[self.candleChart appendToData:[dic objectForKey:@"price"] forName:@"price"];
	[self.candleChart appendToData:[dic objectForKey:@"vol"] forName:@"vol"];
	
	NSMutableDictionary *serie = [self.candleChart getSerie:@"price"];
	if(serie == nil)
		return;
  
	if(self.chartMode == 1){
		[serie setObject:@"candle" forKey:@"type"];
	}else{
		[serie setObject:@"line" forKey:@"type"];
	}
}

- (void)getSearchResultFromUrl {
  static NSString *searchUrl = @"http://hq.sinajs.cn/list=";
  NSMutableArray *data =[[NSMutableArray alloc] init];
  
  NSURL *url = [NSURL URLWithString:[searchUrl stringByAppendingString:self.queryCode]];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  
  [request startSynchronous];
  
  NSError *error = [request error];
  
  if (!error) {
    NSString *response = [request responseString];
    
    NSString* newString =[[response componentsSeparatedByString:@"\""] objectAtIndex:1];
    
    NSArray *arrStock = [newString componentsSeparatedByString:@","];
    
    NSMutableArray *item =[[NSMutableArray alloc] init];
    [item addObject:[arrStock objectAtIndex:1]];//open
    [item addObject:[arrStock objectAtIndex:6]];//close
    [item addObject:[arrStock objectAtIndex:4]];//high
    [item addObject:[arrStock objectAtIndex:5]];//low
    [item addObject:[arrStock objectAtIndex:8]];//vol
    
    [data addObject:item];
    
    NSMutableArray *item1 =[[NSMutableArray alloc] init];
    [item1 addObject:[arrStock objectAtIndex:1]];//open
    [item1 addObject:[arrStock objectAtIndex:6]];//close
    [item1 addObject:[arrStock objectAtIndex:4]];//high
    [item1 addObject:[arrStock objectAtIndex:5]];//low
    [item1 addObject:[arrStock objectAtIndex:8]];//vol
    
    [data addObject:item1];

    [self.candleChart reset];
    [self.candleChart clearData];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [self generateData:dic From:data];
    [self setData:dic];
    
    [self.candleChart setNeedsDisplay];
    
  } else {
    NSLog(@"Error - %@", error);
  }
  
}

-(void)generateData:(NSMutableDictionary *)dic From:(NSArray *)data{
  //price
  NSMutableArray *price = [[NSMutableArray alloc] init];
  for(int i = 0;i < data.count;i++){
    [price addObject: [data objectAtIndex:i]];
  }
  [dic setObject:price forKey:@"price"];
  
  
  //VOL
  NSMutableArray *vol = [[NSMutableArray alloc] init];
  for(int i = 0;i < data.count;i++){
    NSMutableArray *item = [[NSMutableArray alloc] init];
    [item addObject:[@"" stringByAppendingFormat:@"%f",[[[data objectAtIndex:i] objectAtIndex:0] floatValue]/100]];
    [vol addObject:item];
    
  }
  [dic setObject:vol forKey:@"vol"];
  
}

@end
