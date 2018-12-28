//
//  BtnPassLine.h
//  JiGuanjiesuo
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 aoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightGrain.h"
#import "LightSource.h"

@interface BtnPassLine : UIButton

@property(nonatomic,assign)BOOL isMove;
@property(nonatomic,strong)NSMutableArray *lineDirs;

-(NSMutableArray *)getLineOutPutDir:(LightDir)inputDir;

@end
