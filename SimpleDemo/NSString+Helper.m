//
//  NSString+Helper.m
//  SimpleDemo
//
//  Created by zorro on 14-3-1.
//  Copyright (c) 2014年 zorro. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

-(NSString *)toUTF8String{
  CFStringRef nonAlphaNumValidChars = CFSTR("![DISCUZ_CODE_1]’()*+,-./:;=?@_~");
  NSString *preprocessedString = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
  NSString *newStr = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8) autorelease];
  [preprocessedString release];
  return newStr;
}

@end
