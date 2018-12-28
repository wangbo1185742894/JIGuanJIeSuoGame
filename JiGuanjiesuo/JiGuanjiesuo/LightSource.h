//
//  LightSource.h
//  JiGuanjiesuo
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 aoli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LightSource : NSObject
typedef enum : NSUInteger {
    LightDirTop = -10,
    LightDirLeft = -1,
    LightDirRight = 1,
    LightDirBottom = 10
} LightDir;

@end
