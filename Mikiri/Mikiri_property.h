//
//  Mikiri_property.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/09.
//  Copyright (c) 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    int level;              //難易度
    float enemyWaitTime;    //敵待ち時間
    int winCount;           //勝ち回数
    int loseCount;          //負け回数
    float damagepoint;      //与ダメージポイント
    float timepoint;        //制限時間減少量
} levelStruct;

@interface Mikiri_property : NSObject{
    NSArray *aryEnemyImageName; //敵画像ファイル名を格納する配列
    levelStruct structLevel;    //難易度に応じた設定値
    
    //難易度定数
    enum{
        intLevel_syokyu,
        intLevel_chukyu,
        intLevel_jokyu
    };
}
@property(retain, atomic) NSArray *aryEnemyImageName;
@property(assign, atomic) levelStruct structLevel;

+(Mikiri_property *)sharedCenter;
-(void)setEnemyImageName:(NSArray *)ary;
-(NSArray *)getEnemyImageName;
-(void)setLevel:(levelStruct)value;
-(levelStruct)getLevel;
@end
