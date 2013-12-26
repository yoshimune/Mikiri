//
//  Mikiri_Win.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/04.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Mikiri_property.h"
#import <GameKit/GameKit.h>

@interface Mikiri_Win : CCLayer {
    
    //プロパティ
    Mikiri_property *mikiri_property;
    
    CCSprite *sprCharacter;     //敵キャラ
    CCSprite *sprSerif;         //セリフ
    CCSprite *sprWinLogo;       //勝利ロゴ
    NSArray *aryImageName;      //画像ファイル名
}
@property(retain, atomic) Mikiri_property *mikiri_property;
@property(retain, atomic) CCSprite *sprCharacter;
@property(retain, atomic) CCSprite *sprSerif;
@property(retain, atomic) CCSprite *sprWinLogo;
@property(retain, atomic) NSArray *aryImageName;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@end
