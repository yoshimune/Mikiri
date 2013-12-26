//
//  Mikiri_Gameover.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/01.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_Gameover.h"
#import "Mikiri_Main.h"
#import "AppDelegate.h"

@implementation Mikiri_Gameover

//プロパティの設定
@synthesize lblG;
@synthesize lblA;
@synthesize lblM;
@synthesize lblE_1;
@synthesize lblO;
@synthesize lblV;
@synthesize lblE_2;
@synthesize lblR;
@synthesize actG;
@synthesize actA;
@synthesize actM;
@synthesize actE_1;
@synthesize actO;
@synthesize actV;
@synthesize actE_2;
@synthesize actR;

-(id) initWithWinSize:(CGSize)winSize {
    
    if (self = [super init]) {
        //文字の設定
        self.lblG = [CCLabelTTF labelWithString:@"G" fontName:@"Marker Felt" fontSize:64];
        self.lblA = [CCLabelTTF labelWithString:@"A" fontName:@"Marker Felt" fontSize:64];
        self.lblM = [CCLabelTTF labelWithString:@"M" fontName:@"Marker Felt" fontSize:64];
        self.lblE_1 = [CCLabelTTF labelWithString:@"E" fontName:@"Marker Felt" fontSize:64];
        self.lblO = [CCLabelTTF labelWithString:@"O" fontName:@"Marker Felt" fontSize:64];
        self.lblV = [CCLabelTTF labelWithString:@"V" fontName:@"Marker Felt" fontSize:64];
        self.lblE_2 = [CCLabelTTF labelWithString:@"E" fontName:@"Marker Felt" fontSize:64];
        self.lblR = [CCLabelTTF labelWithString:@"R" fontName:@"Marker Felt" fontSize:64];
        
        //位置の設定
        float bacic_x = 50;
        float bacic_y = 30;
        self.lblG.position = ccp(winSize.width/2 - (bacic_x*2),   winSize.height + (bacic_y*2));    //G
        self.lblA.position = ccp(winSize.width/2 - (bacic_x),     winSize.height + (bacic_y*2));    //A
        self.lblM.position = ccp(winSize.width/2,                 winSize.height + (bacic_y*2));    //M
        self.lblE_1.position = ccp(winSize.width/2 + (bacic_x),   winSize.height + (bacic_y*2));    //E_1
        self.lblO.position = ccp(winSize.width/2 - (bacic_x),     winSize.height + bacic_y);      //O
        self.lblV.position = ccp(winSize.width/2,                 winSize.height + bacic_y);      //V
        self.lblE_2.position = ccp(winSize.width/2 + (bacic_x),   winSize.height + bacic_y);      //E_2
        self.lblR.position = ccp(winSize.width/2 + (bacic_x*2),   winSize.height + bacic_y);      //R
        
        //色の指定（黒）
        self.lblG.color = ccc3(0,0,0);
        self.lblA.color = ccc3(0,0,0);
        self.lblM.color = ccc3(0,0,0);
        self.lblE_1.color = ccc3(0,0,0);
        self.lblO.color = ccc3(0,0,0);
        self.lblV.color = ccc3(0,0,0);
        self.lblE_2.color = ccc3(0,0,0);
        self.lblR.color = ccc3(0,0,0);
        
        //アクション定義
        self.actG = [CCSequence actions:
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2 - (bacic_x*2), winSize.height/2 + (bacic_y*2))],
                     [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                     nil];
        self.actA = [CCSequence actions:
                     [CCMoveTo actionWithDuration:0.1f position:ccp(winSize.width/2 - (bacic_x), winSize.height + (bacic_y*2))],
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2 - (bacic_x), winSize.height/2 + (bacic_y*2))],
                     [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                     nil];
        self.actM = [CCSequence actions:
                     [CCMoveTo actionWithDuration:0.2f position:ccp(winSize.width/2, winSize.height + (bacic_y*2))],
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height/2 + (bacic_y*2))],
                     [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                     nil];
        self.actE_1 = [CCSequence actions:
                       [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2 + (bacic_x), winSize.height + (bacic_y*2))],
                       [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2 + (bacic_x), winSize.height/2 + (bacic_y*2))],
                       [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                       nil];
        self.actO = [CCSequence actions:
                     [CCMoveTo actionWithDuration:0.4f position:ccp(winSize.width/2 - (bacic_x), winSize.height + bacic_y)],
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2 - (bacic_x), winSize.height/2 - bacic_y)],
                     [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                     nil];
        self.actV = [CCSequence actions:
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height + bacic_y)],
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height/2 - bacic_y)],
                     [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                     nil];
        self.actE_2 = [CCSequence actions:
                       [CCMoveTo actionWithDuration:0.6f position:ccp(winSize.width/2 + (bacic_x), winSize.height + bacic_y)],
                       [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2 + (bacic_x), winSize.height/2 - bacic_y)],
                       [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                       nil];
        self.actR = [CCSequence actions:
                     [CCMoveTo actionWithDuration:0.7f position:ccp(winSize.width/2 + (bacic_x*2), winSize.height + bacic_y*2)],
                     [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2 + (bacic_x*2), winSize.height/2 - bacic_y)],
                     [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1],
                     nil];
        
    }
    
    return self;
}
@end
