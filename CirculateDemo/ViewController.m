//
//  ViewController.m
//  CirculateDemo
//
//  Created by oliver on 2018/2/23.
//  Copyright © 2018年 oliver. All rights reserved.
//

#import "ViewController.h"
#import "WMCirculteAteanimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WMCirculteAteanimationView *circulteAteanimationView = [[WMCirculteAteanimationView alloc] initWithFrame:CGRectMake(0, 200, 375, 220)];
    [self.view addSubview:circulteAteanimationView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
