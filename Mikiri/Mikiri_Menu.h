//
//  Mikiri_Menu.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/11/24.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import "Mikiri_property.h"

@interface Mikiri_Menu : CCLayer {
    
    //プロパティ
    Mikiri_property *mikiri_property;
    
    //スプライト
    CCSprite *sprBackGround;    //背景
    CCSprite *sprStartButton;   //スタートボタン
    CCSprite *sprSyokyuButton;  //初級ボタン
    CCSprite *sprChukyuButton;  //中級ボタン
    CCSprite *sprJokyuButton;   //上級ボタン
    int intSceneFlg;            //シーンフラグ
    int intLevelFlg;            //レベルフラグ
    NSArray *aryImageName;      //画像ファイル名を格納する配列
    int imageIndex;             //画像ファイルのインデックス
    
    //画面フラグの値
    enum{
        intSceneFlg_Menu_init,
        intSceneFlg_Menu_start1,
        intSceneFlg_Menu_start2,
        intSceneFlg_Menu_start3
    };
    
    enum{
        intLevelFlg_Menu_init,      //初期状態
        intLevelFlg_Menu_Syokyu,    //初級
        intLevelFlg_Menu_Chukyu,    //中級
        intLevelFlg_Menu_Jokyu      //上級
    };
}

//プロパティの設定
@property(retain, atomic) Mikiri_property *mikiri_property;
@property(retain, atomic) CCSprite *sprBackGround;
@property(retain, atomic) CCSprite *sprStartButton;
@property(retain, atomic) CCSprite *sprSyokyuButton;
@property(retain, atomic) CCSprite *sprChukyuButton;
@property(retain, atomic) CCSprite *sprJokyuButton;
@property(retain, atomic) NSArray *aryImageName;
@property(assign, atomic) int intSceneFlg;
@property(assign, atomic) int imageIndex;
@property(assign, atomic) int intLevelFlg;


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
