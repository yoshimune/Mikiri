//
//  Mikiri_Escape.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/04.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>

@interface Mikiri_Escape : CCLayer {
    
    CCSprite *sprBackGround;
    CCSprite *sprMessage;
    NSArray *aryImageName;      //画像ファイル名を格納する配列
}
@property(retain, atomic) CCSprite *sprBackGround;
@property(retain, atomic) CCSprite *sprMessage;
@property(retain, atomic) NSArray *aryImageName;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
