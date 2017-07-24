//
//  ViewController.m
//  THDropListDemo
//
//  Created by eddy on 2017/7/24.
//  Copyright © 2017年 eddy. All rights reserved.
//

#import "ViewController.h"
#import "THDropListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - private
- (IBAction)showDropList:(id)sender{
    NSArray *titles = @[@"首页",@"设置"];
    THDropListView *dropList = [[THDropListView alloc] initWithData:titles];
    [self.view addSubview:dropList];
}
@end
