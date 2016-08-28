//
//  Car.h
//  ARCDemo
//
//  Created by MengLong Wu on 16/8/26.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class People;
@interface Car : NSObject

//为了防止循环引用我们可以将其中一个改为weak
//根据`人`和`车`的从属关系，这里让人对车强引用，车对人弱引用
//@property (nonatomic,strong)People *owner;

@property (nonatomic,weak)People *owner;

@end
