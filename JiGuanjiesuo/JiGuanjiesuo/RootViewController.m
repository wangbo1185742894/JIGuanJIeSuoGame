//
//  RootViewController.m
//  JiGuanjiesuo
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 aoli. All rights reserved.
//

#import "RootViewController.h"
#import "SelectViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionFirst:(id)sender {
    SelectViewController * selectVC = [[SelectViewController alloc]init];
    [self presentViewController:selectVC animated:YES completion:nil];
}



@end
