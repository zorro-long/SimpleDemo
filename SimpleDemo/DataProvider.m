//
//  DataProvider.m
//  SimpleDemo
//
//  Created by zorro on 14-2-27.
//  Copyright (c) 2014年 zorro. All rights reserved.
//

#import "DataProvider.h"
#import "ASIHTTPRequest.h"

@implementation DataProvider

#pragma mark - Asynchronous

- (void) getSearchResult {
  NSURL *url = [NSURL URLWithString:@"http://hq.sinajs.cn/list=sh600677"];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  
  [request setDelegate:self];
  
  [request startAsynchronous];
}

- (void) requestFinished:(ASIHTTPRequest *)request {
  NSString *responseString = [request responseString];
  NSLog(@"Response - %@", responseString);
}

- (void) requestFailed:(ASIHTTPRequest *)request {
  NSError *error = [request error];
  NSLog(@"Error - %@", error);
}


#pragma mark - Synchronous

- (void)getListInfo {
  NSURL *url = [NSURL URLWithString:@"http://suggest3.sinajs.cn/suggest/key=0020"];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  
  [request startSynchronous];
  
  NSError *error = [request error];
  
  if (!error) {
    NSString *response = [request responseString];
    NSLog(@"Response - %@", response);
  } else {
    NSLog(@"Error - %@", error);
  }
  
}

+ (void)getSearchResultFromUrl:(NSString *)searchKey {
  static NSString *searchUrl = @"http://suggest3.sinajs.cn/suggest/key=";
  
  NSString *trimmedString = [searchKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSURL *url = [NSURL URLWithString:[searchUrl stringByAppendingString:trimmedString]];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  
  [request startSynchronous];
  
  NSError *error = [request error];
  
  if (!error) {
    NSString *response = [request responseString];
    NSLog(@"Response - %@", response);
    
    NSString* newString =[[response componentsSeparatedByString:@"\""] objectAtIndex:1];
    NSLog(@"newString - %@", newString);
    
    //NSArray *arrSplit = [newString componentsSeparatedByString:@","];
    
    
  } else {
    NSLog(@"Error - %@", error);
  }
  
}

@end
