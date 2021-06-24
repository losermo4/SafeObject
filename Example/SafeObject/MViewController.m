//
//  MViewController.m
//  SafeObject
//
//  Created by gaomin on 06/24/2021.
//  Copyright (c) 2021 gaomin. All rights reserved.
//

#import "MViewController.h"
#import <objc/runtime.h>

@interface MViewController ()

@end

@implementation MViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    SEL sel = NSSelectorFromString(@"hhhaha");
    SEL sel = NSSelectorFromString(@"11");
    [self performSelector:sel];
}



- (void)hhhaha {
    NSLog(@"hhhaha");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
