//
//  People.m
//  ARCDemo
//
//  Created by MengLong Wu on 16/8/26.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "People.h"

@implementation People
- (id)initWithName:(NSString *)name
{
    if (self = [super init]) {
        self.name = name;
        //`%p`当前对象指针地址， __FUNCTION__是OC语言的关键词可以用%s来输出到控制台
        NSLog(@"<People对象 %@ %p> %s",self.name,self,__FUNCTION__);
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"<People对象 %@ %p> %s",self.name,self,__FUNCTION__);
}
- (void)sayHello
{
    NSLog(@"Hello %@ %p",self.name,self);
}
@end
