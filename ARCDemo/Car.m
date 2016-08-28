//
//  Car.m
//  ARCDemo
//
//  Created by MengLong Wu on 16/8/26.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "Car.h"

@implementation Car
- (id)init
{
    if (self = [super init]) {
        NSLog(@"<Car对象 %p> %s",self,__FUNCTION__);
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"<Car对象 %p> %s",self,__FUNCTION__);
//    [super dealloc];
}
@end
