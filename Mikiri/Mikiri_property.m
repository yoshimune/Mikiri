//
//  Mikiri_property.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/09.
//  Copyright (c) 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_property.h"

@implementation Mikiri_property
@synthesize aryEnemyImageName;
@synthesize structLevel;

static Mikiri_property *_sharedInstance = nil;

+(Mikiri_property *)sharedCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Mikiri_property alloc] init];
    });
    return _sharedInstance;
}

/**********************************************************************/
/***　敵イメージファイル名を設定                                         ***/
/**********************************************************************/
-(void)setEnemyImageName:(NSArray *)ary {
    self.aryEnemyImageName = ary;
}

/**********************************************************************/
/***　敵イメージファイル名を取得                                         ***/
/**********************************************************************/
-(NSArray *)getEnemyImageName {
    return self.aryEnemyImageName;
}

/**********************************************************************/
/***　初級の規定勝利回数、規定敗北回数、敵ゲージ、制限時間設定                ***/
/**********************************************************************/
-(void)setLevel:(levelStruct)value {
    self.structLevel = value;
}

/**********************************************************************/
/***　初級の規定勝利回数、規定敗北回数、敵ゲージ、制限時間設定                ***/
/**********************************************************************/
-(levelStruct)getLevel {
    return self.structLevel;
}

@end
