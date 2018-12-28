//
//  SelectViewController.m
//  JiGuanjiesuo
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 aoli. All rights reserved.
//

#import "SelectViewController.h"
#import "PlayViewController.h"

@interface SelectViewController ()



@property(nonatomic,strong)NSArray *allPlayGuan;
@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allPlayGuan = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"playConfig" ofType:@"plist"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionSelectedItem:(UIButton *)sender {
    NSInteger playGuan = sender.tag -5000;
    NSDictionary *guanDic = self.allPlayGuan[playGuan];
    
     PlayViewController *playVC = [[PlayViewController alloc]init];
    playVC.kongbaiArray = guanDic[@"kongbaiArray"];
    playVC.accipters = guanDic[@"accipters"];
    playVC.lightSources = guanDic[@"lightSources"];
    playVC.disables = guanDic[@"disables"];
    playVC.moveArrat = guanDic[@"moveArrat"];
    playVC.movePass = guanDic[@"movePass"];
    playVC.passLightBtns = guanDic[@"passLightBtns"];
    playVC.pathAllLight = guanDic[@"pathAllLigth"];
    
    [self presentViewController:playVC animated:YES completion:nil];
}


- (IBAction)actionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
