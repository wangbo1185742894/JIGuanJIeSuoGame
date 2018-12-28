//
//  PlayViewController.m
//  JiGuanjiesuo
//
//  Created by 王博 on 2017/8/9.
//  Copyright © 2017年 aoli. All rights reserved.
// 光源 1000
// 光线 2000
// 接受器 3000
// 改变方向 4000
#import "PlayViewController.h"
#import "LightSource.h"
#import "UIView+MJExtension.h"
#import "BtnAcceptor.h"
#import "LightGrain.h"
#import "BtnPassLine.h"
#import "PassAllLight.h"
#define widthm  [UIScreen mainScreen].bounds.size.height / 6
#define heightm  [UIScreen mainScreen].bounds.size.height / 6

typedef enum : NSUInteger {
    LightPassStateNoPass = 0,
    LightPassStatePass,
    LightPassStateWithDir,
} LightPassState;

@interface PlayViewController (){
    
    
    NSInteger lujingIndex;

    NSMutableArray *luJingArray;
    NSMutableArray *paiChuLujingArray;
    
}

@property (weak, nonatomic) IBOutlet UIView *playContentView;
@property (strong,nonatomic)NSMutableArray *stateArray;
@property (strong,nonatomic)NSMutableArray *lineArray;
@property (strong,nonatomic) NSMutableArray *lightSource;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    luJingArray = [NSMutableArray arrayWithCapacity:0];
    self.stateArray = [NSMutableArray arrayWithCapacity:60];
    self.lineArray = [NSMutableArray arrayWithCapacity:60];
    paiChuLujingArray = [NSMutableArray arrayWithCapacity:0];
    for ( int i = 0; i <60 ; i++ ) {
        [self.lineArray addObject:@(LightPassStatePass)];
        [self.stateArray addObject:@YES];
    }
    
    self.lightSource = [NSMutableArray arrayWithCapacity:0];
    [self setBack2];
}

-(void)setBack2{
//        _passLightBtns = @[@{@"index":@0,@"imgName":@"2_disable_nomal_1",@"imgNameSelect":@"2_disable_select_1",@"tag":@4000,@"dirs":@[@(LightDirBottom),@(LightDirRight)]},@{@"index":@9,@"imgName":@"2_disable_nomal_0",@"imgNameSelect":@"2_disable_select_0",@"tag":@4000,@"dirs":@[@(LightDirLeft),@(LightDirBottom)]},@{@"index":@50,@"imgName":@"2_disable_nomal_2",@"imgNameSelect":@"2_disable_select_2",@"tag":@4000,@"dirs":@[@(LightDirRight),@(LightDirTop)]},@{@"index":@59,@"imgName":@"2_disable_nomal_3",@"imgNameSelect":@"2_disable_select_3",@"tag":@4000,@"dirs":@[@(LightDirTop),@(LightDirLeft)]}];
//        _accipters = @[ @{@"index":@25 ,@"numLines":@3,@"tag":@3000}]; //
//        _lightSources = @[@{@"index":@20,@"lightdir":@-10,@"tag":@1000}]; //
//        _moveArrat = @[];//
//    
//        _movePass = @[@{@"index":@26,@"tag":@4000,@"imgName":@"2_nomal_1",@"imgNameSelect":@"2_select_1",@"dirs":@[@(LightDirBottom),@(LightDirRight)]},@{@"index":@36,@"tag":@4000,@"imgName":@"2_nomal_2",@"imgNameSelect":@"2_select_2",@"dirs":@[@(LightDirRight),@(LightDirTop)]},@{@"index":@38,@"tag":@4000,@"imgName":@"1_nomal_0",@"imgNameSelect":@"1_select_0",@"dirs":@[@(LightDirLeft),@(LightDirRight)]},@{@"index":@39,@"tag":@4000,@"imgName":@"4_pass_nomal",@"imgNameSelect":@"4_pass_select",@"dirs":@[@(LightDirBottom),@(LightDirLeft),@(LightDirRight),@(LightDirTop)]}];
//
//    _kongbaiArray = @[@0,@9,@20,@25,@26,@30,@35,@36,@38,@39,@50,@59];
//    _disables = @[@30,@35];
//    NSArray *pathAllLight = @[@{@"index":@25,@"tag":@5000,@"imageName":@"4_pass_line_0"},@{@"index":@26,@"tag":@5000,@"imageName":@"4_pass_line_0"},@{@"index":@33,@"tag":@5000,@"imageName":@"4_pass_line_0"},@{@"index":@34,@"tag":@5000,@"imageName":@"4_pass_line_0"}];
 
    for (int i  = 0; i < 60; i++) {
        BOOL isMove = NO;
        LightPassState linePassState = LightPassStateNoPass;
        UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveHuokuai:)];
        
        CGFloat curX = i%10 * widthm;
        CGFloat curY = i/10 * heightm;
        UIButton *itemImg = [[UIButton alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
        itemImg.tag = 1000+ i;
        NSString *imgName;
        NSInteger lightindex;
        
        for (NSDictionary *pathAllDic in _pathAllLight) {
            if ([pathAllDic[@"index"] integerValue] == i) {
                PassAllLight *lightSource = [[PassAllLight alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
                if ([pathAllDic[@"isMove"] boolValue] == YES) {
                    [lightSource addGestureRecognizer:pangesture];
                }
                lightSource.isMove =[pathAllDic[@"isMove"] boolValue];
                itemImg = lightSource;
                imgName = pathAllDic[@"imageName"];
                linePassState = LightPassStateWithDir;
                itemImg.tag = [pathAllDic[@"tag"] integerValue]+i;
                [self.playContentView addSubview:itemImg];
            }
        }
        
        for (NSDictionary *lightDic in _lightSources) {
            if ([lightDic[@"index"] integerValue] == i) {
                lightindex = i;
                BtnLightSource *lightSource = [[BtnLightSource alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
                itemImg = lightSource;
                itemImg.tag = [lightDic[@"tag"] integerValue]+i;
                lightSource.lightDir =[lightDic[@"lightdir"] integerValue];
                switch ([lightDic[@"lightdir"] integerValue]) {
                    case 10:
                        imgName = @"lightsource_1";
                        
                        break;
                    case -10:
                        imgName = @"lightsource_3";
                        
                        
                        break;
                    case 1:
                        imgName = @"lightsource_2";
                        
                        
                        break;
                    case -1:
                        imgName = @"lightsource_0";
                        
                        break;
                }
                [self.playContentView addSubview:itemImg];
                
            }
        }
        
        for (NSDictionary *acciptDic in _accipters) {
            if ([acciptDic[@"index"] integerValue] == i) {
                BtnAcceptor* lightSource = [[BtnAcceptor alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
                
                itemImg = lightSource;
                lightSource.numLines = [acciptDic[@"numLines"] integerValue];
                itemImg.tag = [acciptDic[@"tag"] integerValue]+i;;
                imgName = [NSString stringWithFormat:@"recive_%@",acciptDic[@"numLines"]];
                [self.playContentView addSubview:itemImg];
            }
        }
     
        for (NSDictionary *passDic in _passLightBtns) {
            if ([passDic[@"index"] integerValue] == i) {
                BtnPassLine  *passBtn = [[BtnPassLine alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
                passBtn.isMove = NO;
                passBtn.lineDirs =[NSMutableArray arrayWithArray:passDic[@"dirs"]] ;
                imgName = passDic[@"imgName"];
                
                linePassState = LightPassStateWithDir;
                [passBtn setBackgroundImage:[UIImage imageNamed:passDic[@"imgNameSelect"]] forState:UIControlStateSelected];
                itemImg = passBtn;
                passBtn.tag  = [passDic[@"tag"] integerValue] + i;
                [self.playContentView addSubview:passBtn];
            }
            
        }
        
        for (NSDictionary *moveDic in _movePass) {
            if ([moveDic[@"index"] integerValue] == i) {
                BtnPassLine  *passBtn = [[BtnPassLine alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
                passBtn.isMove = YES;
                [passBtn addGestureRecognizer:pangesture];
                
                passBtn.lineDirs =[NSMutableArray arrayWithArray:moveDic[@"dirs"]] ;
                imgName = moveDic[@"imgName"];
                [passBtn setBackgroundImage:[UIImage imageNamed:moveDic[@"imgNameSelect"]] forState:UIControlStateSelected];
                
                
                
                linePassState = LightPassStateWithDir;
                
                itemImg = passBtn;
                passBtn.tag  = [moveDic[@"tag"] integerValue] + i;
                [self.playContentView addSubview:passBtn];
            }
           
        }
     
        
        if ([_kongbaiArray containsObject:@(i)]){
            isMove  = YES;
            linePassState = LightPassStatePass;
        }else if([_moveArrat containsObject:@(i)]){
            imgName = @"0";
            [itemImg addGestureRecognizer:pangesture];
            
            [self.playContentView addSubview:itemImg];
        }else if([_disables containsObject :@(i)]){
            imgName = @"0_disable";
            [self.playContentView addSubview:itemImg];
        }
        [itemImg setBackgroundImage:[UIImage imageNamed:imgName] forState:0];
        [self.stateArray setObject:@(isMove) atIndexedSubscript:i];
        [self.lineArray setObject:@(linePassState) atIndexedSubscript:i];
    }
    
    
    [self showState];
    for (NSDictionary *lightDic in _lightSources) {
        [self showLine:[lightDic[@"index"] integerValue] andDir: [lightDic[@"lightdir"] integerValue]];
    }
    
}

-(void)showLine:(NSInteger) lightSource andDir:(LightDir)dir{
    
    if (lightSource + dir > 59 || lightSource + dir <0) {
        return;
    }
    
    if (dir == LightDirLeft && lightSource %10 == 0) {
        return;
    }
    if (dir == LightDirRight && lightSource %10 == 9) {
        return;
    }
    
    if ([self.lineArray[lightSource + dir] integerValue] == LightPassStateNoPass) {
        return;
    }else if([self.lineArray[lightSource + dir] integerValue] == LightPassStateWithDir){
        BtnPassLine *passLine = [self.view viewWithTag:4000 + lightSource + dir];
        if (passLine != nil) {
            NSArray *dirs = [passLine getLineOutPutDir:dir * -1];
            
            for (NSNumber *itemDir in passLine.lineDirs) {
                if ([itemDir integerValue] == -dir) {
                    passLine.selected = YES;
                }
            }
            
            
            
            for (NSNumber * itemDir in dirs) {
                [self showLine:lightSource + dir  andDir:[itemDir integerValue]];
            }
        }
        
        PassAllLight *pathAllLight =[self.view viewWithTag:5000 + lightSource + dir];
        if (pathAllLight != nil) {
            
            if (pathAllLight.isMove == YES) {
                if (pathAllLight.passLightNum == 0) {
                    
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_1"] forState:0];
                        pathAllLight.passLightNum = 1;
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_1l"] forState:0];
                        pathAllLight.passLightNum = 2;
                    }
                    
                    
                }else if (pathAllLight.passLightNum == 1){
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_1"] forState:0];
                        pathAllLight.passLightNum = 1;
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_2"] forState:0];
                        pathAllLight.passLightNum = 3;
                    }
                }else if (pathAllLight.passLightNum == 2){
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_2"] forState:0];
                        pathAllLight.passLightNum = 2;
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_1l"] forState:0];
                        pathAllLight.passLightNum = 3;
                    }
                }else if (pathAllLight.passLightNum == 3){
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_2"] forState:0];
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_2"] forState:0];
                    }
                    pathAllLight.passLightNum = 3;
                }

            }else{
                if (pathAllLight.passLightNum == 0) {
                    
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_1"] forState:0];
                        pathAllLight.passLightNum = 1;
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_1l"] forState:0];
                        pathAllLight.passLightNum = 2;
                    }
                    
                    
                }else if (pathAllLight.passLightNum == 1){
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_1"] forState:0];
                        pathAllLight.passLightNum = 1;
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_2"] forState:0];
                        pathAllLight.passLightNum = 3;
                    }
                }else if (pathAllLight.passLightNum == 2){
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_2"] forState:0];
                        pathAllLight.passLightNum = 2;
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_1l"] forState:0];
                        pathAllLight.passLightNum = 3;
                    }
                }else if (pathAllLight.passLightNum == 3){
                    if (abs(dir) == 1) {
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_2"] forState:0];
                    }else if (abs(dir) == 10){
                        [pathAllLight setBackgroundImage:[UIImage imageNamed:@"4_pass_line_2"] forState:0];
                    }
                    pathAllLight.passLightNum = 3;
                }

            }
            
            
            
            [self showLine:lightSource + dir  andDir:dir];
            
        }
       
    }else{
        CGFloat curX = (lightSource + dir)%10 * widthm;
        CGFloat curY = (lightSource + dir)/10 * heightm;
        LightGrain *itemImg = [self.playContentView viewWithTag:lightSource + 2000 + dir];
        if (itemImg == nil) {
            itemImg = [[LightGrain alloc]initWithFrame:CGRectMake(curX, curY, widthm, heightm)];
            itemImg.tag = lightSource + 2000 + dir;
            if (dir == LightDirBottom || dir == LightDirTop) {
                [itemImg setBackgroundImage:[UIImage imageNamed:@"line_1"] forState:0];
            }else{
                [itemImg setBackgroundImage:[UIImage imageNamed:@"line_0"] forState:0];
            }
        }else
        {
        
            if (abs(itemImg.dir) == abs(dir)) {
                if (dir == LightDirBottom || dir == LightDirTop) {
                    [itemImg setBackgroundImage:[UIImage imageNamed:@"line_1"] forState:0];
                }else{
                    [itemImg setBackgroundImage:[UIImage imageNamed:@"line_0"] forState:0];
                }
            }else{
                [itemImg setBackgroundImage:[UIImage imageNamed:@"line_2"] forState:0] ;
            }
            
        }
       
        itemImg.dir = dir;
        [self.playContentView addSubview:itemImg];
        
        
        [self showLine:lightSource + dir andDir:dir];
    }
    
    for (NSDictionary *accipterDic in _accipters) {
        [self isSuccessPass:[accipterDic[@"index"] integerValue]];
    }
    
}
-(void)showState{
    printf("**************\n");
    for ( int i = 0; i <60 ; i++ ) {
        printf("%d,",[self.stateArray[i] boolValue]);
        if ((i+1) %10 ==0) {
            printf("\n");
        }
    }
}


-(void)moveHuokuai:(UIPanGestureRecognizer *)recognizer{
    NSInteger baseTag =recognizer.view.tag/1000 * 1000;
    [self.view bringSubviewToFront:recognizer.view];
    NSInteger index = recognizer.view.tag %1000;
    CGPoint panPoint = [recognizer locationInView:self.playContentView];
    NSInteger curX = panPoint.x/(widthm) ;
    NSInteger curY = panPoint.y/(widthm) ;
    NSInteger indexNew = curY * 10  + curX;
    
    if (indexNew > 59 || indexNew < 0) {
        return;
    }
    if ([self.stateArray[indexNew]  boolValue] == NO) {
        return;
    }
    
    [luJingArray removeAllObjects];
    [paiChuLujingArray removeAllObjects]
    ;    if (![self isCanFrom:index to:indexNew]) {
        return;
    }
    recognizer.view.tag = indexNew + baseTag;
    [UIView animateWithDuration:0 animations:^{
        recognizer.view.center = CGPointMake(curX * widthm + widthm/2, curY * heightm + heightm/2);
    }];
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    [self.stateArray setObject:@NO atIndexedSubscript:indexNew];
    [self.stateArray setObject:@YES atIndexedSubscript:index];
    [self.lineArray setObject:@(LightPassStatePass) atIndexedSubscript:index];
    if (baseTag == 4000 || baseTag == 5000) {
        [self.lineArray setObject:@(LightPassStateWithDir) atIndexedSubscript:indexNew];
    }else{
        [self.lineArray setObject:@(LightPassStateNoPass) atIndexedSubscript:indexNew];
    }
    
    
    for (int i = 0; i < 60; i++) {
        UIView *lineView = [self.playContentView viewWithTag:2000 + i];
        if (lineView != nil) {
            
            [lineView removeFromSuperview];
        }
        
        UIButton *passLine = [self.playContentView viewWithTag:4000 + i];
        if (passLine != nil) {
            passLine.selected = NO;
        }
        PassAllLight *passAll = [self.playContentView viewWithTag:5000 + i];
        if (passAll != nil) {
            passAll.passLightNum = 0;
            if (passAll.isMove == YES) {
                [passAll setBackgroundImage:[UIImage imageNamed:@"4_pass_0"] forState:0];
            }else{
            
                [passAll setBackgroundImage:[UIImage imageNamed:@"4_pass_line_0"] forState:0];
            }
        }
    }
    
    
    for (NSDictionary *lightDic in _lightSources) {
        [self showLine:[lightDic[@"index"] integerValue] andDir: [lightDic[@"lightdir"] integerValue]];
    }
    for (NSDictionary *accipterDic in _accipters) {
        [self isSuccessPass:[accipterDic[@"index"] integerValue]];
    }
    
    [self showState];
}

-(BOOL)isCanFrom:(NSInteger)start to:(NSInteger)end{

    [luJingArray addObject:@(start)];
    
    if (start == end) {
        return YES;
    }else{
        if (start + 1 <=59 && [self.stateArray[start + 1] boolValue] == YES &&![luJingArray containsObject:@(start+1)]&&![paiChuLujingArray containsObject:@(start+1)]) {
           
            return [self isCanFrom:start + 1 to:end];
        }else if (start + 10 <=59 && [self.stateArray[start + 10] boolValue] == YES &&![luJingArray containsObject:@(start+10)]&&![paiChuLujingArray containsObject:@(start+10)]) {
                
                return [self isCanFrom:start + 10 to:end];
        }else if (start - 1 >= 0 && [self.stateArray[start - 1] boolValue] == YES &&![luJingArray containsObject:@(start - 1)]&&![paiChuLujingArray containsObject:@(start - 1)]) {
           
           return [self isCanFrom:start - 1 to:end];
        }else if (start - 10 >=0 && [self.stateArray[start - 10] boolValue] == YES &&![luJingArray containsObject:@(start-10)]&&![paiChuLujingArray containsObject:@(start-10)]) {
            
           return [self isCanFrom:start - 10 to:end];
        }else{
            [paiChuLujingArray addObject:[luJingArray lastObject]];
            [luJingArray removeObject:[luJingArray lastObject]];
            if (luJingArray.count ==0) {
                return NO;
            }
           return [self isCanFrom:[[luJingArray lastObject] integerValue] to:end];
        }
    }
    return NO;
}



-(void)isSuccessPass:(NSInteger )acceptor{
    
    LightGrain *top ;
    if (acceptor/10 > 0) {
        top  =[self.playContentView viewWithTag:2000+ acceptor + LightDirTop] ;
    }
    LightGrain * bottom;
    if (acceptor /10<5) {
        bottom = [self.playContentView viewWithTag:2000+acceptor + LightDirBottom];
    }
    LightGrain* right;
    if (acceptor % 10 != 9) {
        right =[self.playContentView viewWithTag:2000+acceptor + LightDirRight] ;
    }
    LightGrain * left ;
    if (acceptor %10 != 0) {
        left =[self.playContentView viewWithTag:2000+acceptor + LightDirLeft] ;
    }
    
    BtnPassLine *topbtn ;
    if (acceptor/10 > 0 && top == nil) {
        topbtn  =[self.playContentView viewWithTag:4000+ acceptor + LightDirTop] ;
    }
    BtnPassLine * bottombtn;
    if (acceptor /10<5 && bottom== nil) {
        bottombtn = [self.playContentView viewWithTag:4000+acceptor + LightDirBottom];
    }
    BtnPassLine* rightbtn;
    if (acceptor % 10 != 9 && right== nil) {
        rightbtn =[self.playContentView viewWithTag:4000+acceptor + LightDirRight] ;
    }
    BtnPassLine * leftbtn ;
    if (acceptor %10 != 0 && left == nil) {
        leftbtn =[self.playContentView viewWithTag:4000+acceptor + LightDirLeft] ;
    }
    
    PassAllLight *topPassAll ;
    if (acceptor/10 > 0 && top == nil) {
        topPassAll  =[self.playContentView viewWithTag:5000+ acceptor + LightDirTop] ;
    }
    PassAllLight *bottomPassAll ;
    if (acceptor /10<5 && bottom== nil) {
        bottomPassAll = [self.playContentView viewWithTag:5000+acceptor + LightDirBottom];
    }
    PassAllLight* rightPassAll;
    if (acceptor % 10 != 9 && right== nil) {
        rightPassAll =[self.playContentView viewWithTag:5000+acceptor + LightDirRight] ;
    }
    PassAllLight * leftPassAll ;
    if (acceptor %10 != 0 && left == nil) {
        leftPassAll =[self.playContentView viewWithTag:5000+acceptor + LightDirLeft] ;
    }
    
    NSInteger numLine =0;
    numLine += [self numLightLine:top andDir:LightDirTop];
    numLine += [self numLightLine:left andDir:LightDirLeft];
    numLine += [self numLightLine:bottom andDir:LightDirBottom];
    numLine += [self numLightLine:right andDir:LightDirRight];
    numLine += [self numLightPassBtn:topbtn andDir:LightDirTop];
    numLine += [self numLightPassBtn:leftbtn andDir:LightDirLeft];
    numLine += [self numLightPassBtn:bottombtn andDir:LightDirBottom];
    numLine += [self numLightPassBtn:rightbtn andDir:LightDirRight];
    numLine += [self numLightPassAll:topPassAll andDir:LightDirTop];
    numLine += [self numLightPassAll:leftPassAll andDir:LightDirLeft];
    numLine += [self numLightPassAll:bottomPassAll andDir:LightDirBottom];
    numLine += [self numLightPassAll:rightPassAll andDir:LightDirRight];
 
    BtnAcceptor *lightSource = [self.view viewWithTag:3000+acceptor];
    
    [lightSource setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"recive_%ld",lightSource.numLines + numLine >4?4:lightSource.numLines + numLine]] forState:0];
    ;
    NSLog(@"%d",numLine);
    
}

-(NSInteger)numLightPassAll:(PassAllLight*)btnPassAll andDir:(LightDir)dir{
    
    if (btnPassAll.passLightNum == 1 && abs(dir)== 1) {
        return 1;
    }else if (btnPassAll.passLightNum == 2 && abs(dir) == 10) {
        return 1;
    }else if (btnPassAll.passLightNum == 3) {
        return 1;
    }else{
        return 0;
    }
}

-(NSInteger)numLightPassBtn:(BtnPassLine*)btnPass andDir:(LightDir)dir{

    if (btnPass.selected == YES) {
        for (NSNumber *itemDir in btnPass.lineDirs) {
            if ([itemDir integerValue] == -1 * dir) {
                return 1;
            }
        }
        
        return 0;
        
    }else{
    
        return 0;
    }
}

-(NSInteger)numLightLine:(LightGrain*)line andDir:(LightDir)dir{
    
    if (line == nil) {
        return 0;
    }
    if (abs(line.dir) == abs(dir)) {
        return 1;
    }else{
        
        return 0;
    }
}


- (IBAction)acitionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
