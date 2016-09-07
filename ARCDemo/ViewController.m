//
//  ViewController.m
//  ARCDemo
//
//  Created by MengLong Wu on 16/8/26.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

/*
 ARC是iOS 5推出的新功能，全称叫 ARC(Automatic Reference Counting)。简单地说，就是代码中自动加入了retain/release，原先需要手动添加的用来处理内存管理的引用计数的代码可以自动地由编译器完成了。该机能在 iOS 5/ Mac OS X 10.7 开始导入，利用 Xcode4.2 可以使用该机能。简单地理解ARC，就是通过指定的语法，让编译器(LLVM 3.0)在编译代码时，自动生成实例的引用计数管理部分代码。有一点，ARC并不是GC，它只是一种代码静态分析（Static Analyzer）工具。
 */

/*
 ARC基本规则
 retain，release，autorelease，dealloc由编译器自动插入，不能在代码中调用，dealloc虽然可以被重载，但是不能调用功能[super dealloc]
 */

/*
代码中不能使用retain, release, autorelease
不重载dealloc（如果是释放对象内存以外的处理，是可以重载该函数的，但是不能调用[super dealloc]）
不能在C结构体中使用对象指针
id与void *间的如果cast时需要用特定的方法（__bridge关键字）
不能使用NSAutoReleasePool、而需要@autoreleasepool块
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     在ARC 中，NSObject的autorelease，release，retain已经被废弃掉了
     copy没有被废弃掉，可以查看NSObject的头文件，找到方法的定义看修饰词
     - (instancetype)retain OBJC_ARC_UNAVAILABLE;
     - (oneway void)release OBJC_ARC_UNAVAILABLE;
     - (instancetype)autorelease OBJC_ARC_UNAVAILABLE;
     - (NSUInteger)retainCount OBJC_ARC_UNAVAILABLE;
     */
    
    NSString *hello = @"Hello world";
    
//    这个宏可以消除未使用的变量的警告
#pragma unused(hello)
    
//    [hello copy];可以用
//    [hello autorelease];不可用
//    [hello retain];不可用
//    [hello release];不可用
    
    _people1 = [[People alloc]initWithName:@"张三"];
    _people2 = [[People alloc]initWithName:@"李四"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    
//    [button addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self testPartVariable];
    
    [self testCircleReference];
}
//测试对象释放时，成员变量对象可以跟着一块释放
- (void)buttonClick1
{
//    当一个对象释放时，他的成员变量也会跟着释放
//    当ViewController释放时，它的成员变量_people1、_people2对象也跟着释放了
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    app.window.rootViewController = nil;
}
//测试怎么手动释放对象
- (void)buttonClick2
{
//    在ARC中不能调用release，需要将对象的指针置为nil
    
//    置为nil即可释放
    _people1 = nil;
    
//    让一个强引用的指针_people3指向_people2的对象，接着将_people2置为nil，这个时候对象不会释放，因为还有一个强引用的指针指向对象李四
    _people3 = _people2;
    _people2 = nil;
}
//测试局部变量的内存管理
- (void)testPartVariable
{
    /*
     方法中的局部变量
     在MRC中直接创建对象会产生内存泄漏
     在ARC中直接创建对象则不会产生内存泄漏
     
     strong：强引用 weak：弱引用
     当一个对象没有strong指向它时，会立即释放
     */
    
    People *p = [[People alloc]initWithName:@"孤独的人"];
#pragma unused(p)
    
//    强引用的对象不会立即释放
    __strong People *strongPeople = [[People alloc]initWithName:@"强引用"];
    [strongPeople sayHello];
    
//    弱引用的对象当他指向的对象释放时会自动置为nil
    __weak People *weakPeople = [[People alloc]initWithName:@"弱引用"];
    [weakPeople sayHello];
}
//测试互相作为属性时可能产生循环引用的情况
- (void)testCircleReference
{
//    ARC中依然要做内存管理，需要注意循环引用
//    内存的循环引用会造成内存泄漏，对象很难释放掉
    
    People *people = [[People alloc]initWithName:@"土豪"];
    
    Car *bmw = [[Car alloc]init];
    
    people.car = bmw;
    bmw.owner = people;
    
//    都是互相强引用的情况下，很容易忽略掉两个对象释放不掉
//    但并不是帧的就一定释放不了，将其中任意一个的属性置为nil也可以释放
//    people.car = nil;
//    bmw.owner = nil;
    
//    所以一般情况下，在公司里不会让两个对象互相强引用
//    让其中的一个使用弱引用是一个好习惯，根据从属关系，最好让car的owner属性为weak
}
- (void)dealloc
{
    /*
    dealloc,方法是当前对象即将释放时调用的
    在arc中dealloc方法可以在子类中重写
    但是[super dealloc]方法已经不能被调用了
    在dealloc方法中，我们依然可以做一些操作
    比如：移除kvo、移除通知、取消发出的请求、使定时器失效
     */
    NSLog(@"%@ %s",self,__FUNCTION__);
}


@end
