//
//  ViewController.m
//  NSObject-runtime
//
//  Created by JackyLee on 2017/4/7.
//  Copyright © 2017年 Jacky Lee. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+swizz.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // NSArray test
    [NSArray printIvarList];
    [NSArray printMethodList];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
