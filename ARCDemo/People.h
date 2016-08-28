//
//  People.h
//  ARCDemo
//
//  Created by MengLong Wu on 16/8/26.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Car;
@interface People : NSObject
//对象的管理权：管理对象什么时候释放的权限
//strong强指针，可以拥有对象的管理权
@property (nonatomic,strong)Car *car;

//编译器在编译时，会将retain替换为strong
@property (nonatomic,retain)NSString *name;
@property (nonatomic,strong)NSString *name2;

//编译器在编译时，会将assign替换为weak
@property (nonatomic,assign)int  age;

//unsafe_unretained不安全的不拥有管理权指针，一般不常用，
//unsafe_unretained指针指向的对象释放之后，objPtr指针不会被置为nil，
//objPtr指针会变成野指针，如果再调用原来对象的方法的时候会崩溃
@property (nonatomic,unsafe_unretained) NSString *place;

//copy依然保留原本的功能
@property (nonatomic,copy)NSString *favourite;

//关键字weak，用来修饰指针指向对象的所有权
//weak代表弱引用，strong代表强引用
//weak弱指针，只能够访问对象，不能控制对象的释放
//weak指针指向的对象释放的时候，指针会被置为nil，相对安全，但是提高调试bug的难度
@property (nonatomic,weak)Car *pubCar;

- (id)initWithName:(NSString *)name;
- (void)sayHello;
@end
