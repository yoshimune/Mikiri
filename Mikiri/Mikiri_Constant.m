//
//  Mikiri_Constant.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/08.
//  Copyright (c) 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_Constant.h"
#import "Mikiri_property.h"

@implementation Mikiri_Constant

//難易度レベルに応じた設定値を格納

/*************************************************************************/
/***　メニュー画面のイメージファイル名を返す　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameMenu{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                         @"startbutton_ON.png",     //0
                         @"startbutton_OFF.png",    //1
                         @"syokyu_ON.png",          //2
                         @"syokyu_OFF.png",         //3
                         @"chukyu_ON.png",          //4
                         @"chukyu_OFF.png",         //5
                         @"jokyu_ON.png",           //6
                         @"jokyu_OFF.png",          //7
                         @"start.png",              //8
                         nil];
    return aryImageName;
}

/*************************************************************************/
/***　メイン画面のイメージファイル名を返す　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameMain{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"logo_win.png",           //0
                             @"logo_lose.png",          //1
                             @"logo_prestart.png",      //2
                             @"startbutton_ON.png",     //3
                             @"startbutton_OFF.png",    //4
                             @"background.png",         //5
                             @"mikiriicon.png",         //6
                             @"winCount.png",           //7
                             @"loseCount.png",          //8
                             @"sakura_basic_stand.png", //9
                             @"sakura_damage_stand.png",//10
                             @"enemy_life_bar.png",     //11
                             @"time_bar.png",           //12
                             @"hit.png",                //13
                             @"slash.png",              //14
                             @"todome.png",             //15
                             @"swipe.png",              //16
                             @"enemy_life_bar_shell.png", //17
                             @"time_bar_shell.png",     //18
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　初級敵イメージファイル　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameSyokyu{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                         @"bear_stand_normal.png",  //0
                         @"bear_stand_damage.png",  //1
                         @"bear_up_damage.png",     //2
                         @"bear_up_damage2.png",    //3
                         @"back_syokyu.png",        //4
                         nil];
    return aryImageName;
}

/*************************************************************************/
/***　初級勝利時イメージファイル　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameSyokyuWin{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"bear_win.png",               //0
                             @"defeat_serif_syokyu.png",    //1
                             @"win.png",                    //3
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　初級の規定勝利回数、規定敗北回数、敵ゲージ、制限時間　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(levelStruct)getLevelSyokyu{
    levelStruct structLevel;
    structLevel.level = intLevel_syokyu;
    structLevel.enemyWaitTime = 0.6;
    structLevel.damagepoint = 4;
    structLevel.timepoint = 1;
    structLevel.winCount = 2;
    structLevel.loseCount = 5;
    return structLevel;
}


/*************************************************************************/
/***　中級敵イメージファイル　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameChukyu{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"elen_stand_normal.png",  //0
                             @"elen_stand_damage.png",  //1
                             @"elen_up_damage1.png",    //2
                             @"elen_up_damage2.png",    //3
                             @"back_chukyu.png",        //4
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　中級勝利時イメージファイル　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameChukyuWin{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"elen_win.png",               //0
                             @"defeat_serif_chukyu.png",    //1
                             @"win.png",                    //3
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　中級の規定勝利回数、規定敗北回数、敵ゲージ、制限時間　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(levelStruct)getLevelChukyu{
    levelStruct structLevel;
    structLevel.level = intLevel_chukyu;
    structLevel.enemyWaitTime = 0.36;
    structLevel.damagepoint = 4;
    structLevel.timepoint = 2.5;
    structLevel.winCount = 3;
    structLevel.loseCount = 3;
    return structLevel;
}


/*************************************************************************/
/***　上級敵イメージファイル　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameJokyu{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"samson_stand_normal.png",  //0
                             @"samson_stand_damage.png",  //1
                             @"samson_up_damage1.png",    //2
                             @"samson_up_damage2.png",    //3
                             @"back_Jokyu.png",           //4
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　上級勝利時イメージファイル　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameJokyuWin{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"samson_win.png",               //0
                             @"defeat_serif_jokyu.png",       //1
                             @"win.png",                    //3
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　上級の規定勝利回数、規定敗北回数、敵ゲージ、制限時間　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(levelStruct)getLevelJokyu{
    levelStruct structLevel;
    structLevel.level = intLevel_jokyu;
    structLevel.enemyWaitTime = 0.3;
    structLevel.damagepoint = 1.9;
    structLevel.timepoint = 1.1;
    structLevel.winCount = 1;
    structLevel.loseCount = 2;
    return structLevel;
}

/*************************************************************************/
/***　敵が逃亡した場合の画像ファイル　　　　　　　　　　 　　　　　　　　　　　　　 ***/
/*************************************************************************/
+(NSArray *)getImageNameEscape{
    NSArray *aryImageName = [NSArray arrayWithObjects:
                             @"enemy_escape_back.png",  //0
                             @"enemy_escape.png",  //1
                             nil];
    return aryImageName;
}

/*************************************************************************/
/***　効果音　　　　　　　　　　　　　　　　　　　　　　 　　　　　　　　　　　　　 ***/
/*************************************************************************/
//BGM
+(NSString *)getSoundBgm{
    NSString *strBgm = @"BGM.mp3";
    return strBgm;
}
//打撃
+(NSString *)getSoundStrike{
    NSString *strSound = @"strike.mp3";
    return strSound;
}
//「!!」マーク
+(NSString *)getSoundExclamation{
    NSString *strSound = @"exclamation.mp3";
    return strSound;
}
//スワイプ
+(NSString *)getSoundSwipe{
    NSString *strSound = @"swipe.mp3";
    return strSound;
}
//フライング
+(NSString *)getSoundPrestart{
    NSString *strSound = @"prestart.mp3";
    return strSound;
}
//ボタン
+(NSString *)getSoundButton{
    NSString *strSound = @"button.mp3";
    return strSound;
}

@end
