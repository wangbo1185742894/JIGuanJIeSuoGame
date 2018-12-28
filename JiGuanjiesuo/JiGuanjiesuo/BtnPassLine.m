//
//  BtnPassLine.m
//  JiGuanjiesuo
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 aoli. All rights reserved.
//

#import "BtnPassLine.h"

@implementation BtnPassLine

-(NSMutableArray *)getLineOutPutDir:(LightDir)inputDir{
    
    
    NSMutableArray *itemDirs = [self.lineDirs mutableCopy];
    BOOL isCons = NO;
    for (NSNumber *itemDir in self.lineDirs) {
        if ([itemDir integerValue]  == inputDir) {
            [itemDirs removeObject:itemDir];
            isCons = YES;
            return itemDirs;
        }
    }
    return  nil;

}

@end
