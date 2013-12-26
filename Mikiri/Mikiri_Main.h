//
//  Mikiri_Main.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/11/25.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "Mikiri_property.h"

@interface Mikiri_Main : CCLayer {
    //共通で使う変数
    Mikiri_property *mikiri_property;   //プロパティ
    CCSprite *icon;             //タップするタイミングを知らせるアイコン
    CCSprite *startButton;      //スタートボタン
    CCSprite *background;       //背景
    CCSprite *resultlogo;       //結果
    CCSprite *winCount;         //勝ち回数
    CCSprite *loseCount;        //負け回数
    CCSprite *wincounticon;     //勝ちカウントアイコン
    CCSprite *losecounticon;    //負けカウントアイコン
    CCSprite *enemycharacter;   //敵キャラ
    CCSprite *enemylife;        //敵ライフ
    CCSprite *timebar;          //制限時間
    CCSprite *hiticon;          //ヒットアイコン
    CCSprite *todome;           //とどめロゴ
    CCSprite *swipe;            //スワイプロゴ
    CCSprite *enemylifebarshell; //敵ライフゲージ殻
    CCSprite *timebarshell;     //制限時間殻
    levelStruct structLevel;   //難易度に応じた設定値を格納
    NSArray *aryImageName;      //画像ファイル名を格納する配列
    NSArray *aryEnemyImageName; //画像ファイル名を格納する配列
    double resultTime;          //結果時間
    BOOL boolButtonFlg;         //ボタンフラグ
    int intSceneFlg;            //状態フラグ
    int resultFlg;              //勝敗フラグ
    double enemywaittime;       //敵の待ち時間
    NSDate *mikiristartdate;    //ミキリ開始時間
    NSDate *mikirifinishdate;   //ミキリ終了時間
    int imageIndex;             //画像ファイルのインデックス
    int enemyimageIndex;        //画像ファイルのインデックス
    int charengecount;          //挑戦回数
    int wincount;               //勝ち回数
    int losecount;              //負け回数
    int todomeresultFlg;        //とどめの結果
    float limittime;            //とどめモード時の制限時間
    
    //シーンフラグの定数
    enum {
        intSceneFlg_init,       //初期状態
        intSceneFlg_wait,       //待ち状態
        intSceneFlg_game,       //ミキリ状態
        intSceneFlg_prefinish,  //とどめ準備状態
        intSceneFlg_finishstart,//とどめ開始
        intSceneFlg_finish,     //とどめ状態
        intSceneFlg_gameover,   //ゲームオーバー
        intSceneFlg_restart,    //リスタート
        intSceneFlg_nil         //無状態（入力を受け付けない）
    };
    
    //勝敗フラグの定数
    enum {
        intInit,                //初期状態
        intWin,                 //勝ち
        intLose,                //負け
        intPrestart             //フライング
    };
    
    //とどめの結果フラグの定数
    enum {
        intTodome_init,         //初期状態
        intTodome_win,          //勝ち
        intTodome_lose          //負け
    };
}

//プロパティの設定…めんどい
@property(retain, atomic) Mikiri_property *mikiri_property;
@property(retain, atomic) CCSprite *icon;
@property(retain, atomic) CCSprite *startButton;
@property(retain, atomic) CCSprite *background;
@property(retain, atomic) CCSprite *resultlogo;
@property(retain, atomic) CCSprite *winCount;
@property(retain, atomic) CCSprite *loseCount;
@property(retain, atomic) CCSprite *wincounticon;
@property(retain, atomic) CCSprite *losecounticon;
@property(retain, atomic) CCSprite *enemycharacter;
@property(retain, atomic) CCSprite *enemylife;
@property(retain, atomic) CCSprite *timebar;
@property(retain, atomic) CCSprite *hiticon;
@property(retain, atomic) CCSprite *todome;
@property(retain, atomic) CCSprite *swipe;
@property(retain, atomic) CCSprite *enemylifebarshell;
@property(retain, atomic) CCSprite *timebarshell;
@property(retain, atomic) NSArray *aryImageName;
@property(retain, atomic) NSArray *aryEnemyImageName;
@property(assign, atomic) levelStruct structLevel;
@property(assign, atomic) double resultTime;
@property(assign, atomic) BOOL boolButtonFlg;
@property(assign, atomic) int intSceneFlg;
@property(assign, atomic) int resultFlg;
@property(assign, atomic) int todomeresultFlg;
@property(assign, atomic) double enemywaittime;
@property(retain, atomic) NSDate *mikiristartdate;
@property(retain, atomic) NSDate *mikirifinishdate;
@property(assign, atomic) int charengecount;
@property(assign, atomic) int wincount;
@property(assign, atomic) int losecount;
@property(assign, atomic) int imageIndex;
@property(assign, atomic) int enemyimageIndex;
@property(assign, atomic) float limittime;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
