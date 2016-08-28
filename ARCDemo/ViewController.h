//
//  ViewController.h
//  ARCDemo
//
//  Created by MengLong Wu on 16/8/26.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
#import "Car.h"
@interface ViewController : UIViewController
{
//    在默认定义的成员变量中，会用__strong修饰
    People *_people1;
    __strong People *_people2;
    __strong People *_people3;
}

@end

