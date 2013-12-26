//
//  Mikiri_Gameover.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/01.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>

@interface Mikiri_Gameover : CCLayer {
    
    //文字
    CCLabelTTF *lblG;
    CCLabelTTF *lblA;
    CCLabelTTF *lblM;
    CCLabelTTF *lblE_1;
    CCLabelTTF *lblO;
    CCLabelTTF *lblV;
    CCLabelTTF *lblE_2;
    CCLabelTTF *lblR;
    
    //アニメーション
    CCSequence *actG;
    CCSequence *actA;
    CCSequence *actM;
    CCSequence *actE_1;
    CCSequence *actO;
    CCSequence *actV;
    CCSequence *actE_2;
    CCSequence *actR;
}

-(id)initWithWinSize:(CGSize)winSize;

//プロパティの設定…めんどい
@property(retain, atomic) CCLabelTTF *lblG;
@property(retain, atomic) CCLabelTTF *lblA;
@property(retain, atomic) CCLabelTTF *lblM;
@property(retain, atomic) CCLabelTTF *lblE_1;
@property(retain, atomic) CCLabelTTF *lblO;
@property(retain, atomic) CCLabelTTF *lblV;
@property(retain, atomic) CCLabelTTF *lblE_2;
@property(retain, atomic) CCLabelTTF *lblR;
@property(assign, atomic) CCSequence *actG;
@property(assign, atomic) CCSequence *actA;
@property(assign, atomic) CCSequence *actM;
@property(assign, atomic) CCSequence *actE_1;
@property(assign, atomic) CCSequence *actO;
@property(assign, atomic) CCSequence *actV;
@property(assign, atomic) CCSequence *actE_2;
@property(assign, atomic) CCSequence *actR;

@end
