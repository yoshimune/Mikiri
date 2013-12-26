//
//  Mikiri_Win.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/04.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_Win.h"
#import "Mikiri_Menu.h"
#import "AppDelegate.h"
#import "Mikiri_Constant.h"
#import "Mikiri_ImageCash.h"
#import "Mikiri_property.h"

#pragma mark - Mikiri_Win

@implementation Mikiri_Win
@synthesize mikiri_property;
@synthesize sprCharacter;
@synthesize sprSerif;
@synthesize sprWinLogo;
@synthesize aryImageName;

// Helper class method that creates a Scene with the Mikiri_Menu as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Mikiri_Win *layer = [Mikiri_Win node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


/******************************************************************************************/
/*　　初期化関数（init）　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 */
/******************************************************************************************/
-(id) init{
    if(self = [super init]){
        
        //変数を初期化
        self.mikiri_property = [Mikiri_property sharedCenter];

        //背景色を白にする
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:background];
        
        //難易度により処理を振り分け
        if ( self.mikiri_property.getLevel.level == intLevel_syokyu ) {
            //初級
            [self actionSyokyu];
        }
        else if ( self.mikiri_property.getLevel.level == intLevel_chukyu ) {
            //中級
            [self actionChukyu];
        }
        else{
            //上級
            [self actionJokyu];
        }
    }
    return self;
}


/****************************************************************************************************/
/*　初級　　　　　                                                                                   　*/
/****************************************************************************************************/
- (void)actionSyokyu{
    
    //画像をキャッシュ
    self.aryImageName = [Mikiri_Constant getImageNameSyokyuWin];
    Mikiri_ImageCash *imageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryImageName];
    [imageCash ImageLoaded:nil];
    
    //画像を追加
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    //敵キャラ
    NSString *strImageName = [self.aryImageName objectAtIndex:0];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprCharacter = [CCSprite spriteWithTexture:tex];
    self.sprCharacter.anchorPoint = ccp(0.6f, 1.0f);
    self.sprCharacter.position = ccp(winSize.width/2, winSize.height + self.sprCharacter.contentSize.height);
    [self addChild:sprCharacter];
    //セリフ
    strImageName = [self.aryImageName objectAtIndex:1];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprSerif = [CCSprite spriteWithTexture:tex];
    self.sprSerif.position = ccp(winSize.width/3, -self.contentSize.height);
    [self addChild:sprSerif];
    //勝利ロゴ
    strImageName = [self.aryImageName objectAtIndex:2];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprWinLogo = [CCSprite spriteWithTexture:tex];
    self.sprWinLogo.position = ccp(winSize.width/4, winSize.height - self.sprWinLogo.contentSize.height*1.5);
    self.sprWinLogo.opacity = 0;
    [self addChild:sprWinLogo];
    
    //アクションの設定（キャラ）
    CCDelayTime *actDelay = [CCDelayTime actionWithDuration:0.5f];
    CCMoveTo *actChar_1 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height+10)];
    CCRotateTo *actCharRotate_1 = [CCRotateTo actionWithDuration:1.0f angle:10];
    CCRotateTo *actCharRotate_2 = [CCRotateTo actionWithDuration:1.0f angle:-10];
    CCDelayTime *actCharRotate_delay_1 = [CCDelayTime actionWithDuration:0.05f];
    CCDelayTime *actCharRotate_delay_2 = [CCDelayTime actionWithDuration:0.05f];
    CCRepeatForever *actChar_2 = [CCRepeatForever actionWithAction:[CCSequence actions:actCharRotate_1, actCharRotate_delay_1, actCharRotate_2, actCharRotate_delay_2, nil]];
    CCSequence *seqChar = [CCSequence actions:actDelay, actChar_1, nil];
    
    //アクションの設定（セリフ）
    CCMoveTo *actSerif_1 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/3, self.sprSerif.contentSize.height/2)];
    CCRotateTo *actSerifRotate_1 = [CCRotateTo actionWithDuration:0.05f angle:20];
    CCRotateTo *actSerifRotate_2 = [CCRotateTo actionWithDuration:0.05f angle:-20];
    CCRotateTo *actSerifRotate_3 = [CCRotateTo actionWithDuration:0.05f angle:0];
    CCRepeat *actSerif_2 = [CCRepeat actionWithAction:[CCSequence actions:actSerifRotate_1, actSerifRotate_2, nil] times:3];
    CCSequence *seqSerif = [CCSequence actions:actSerif_1, actSerif_2, actSerifRotate_3, nil];
    
    //アクションの設定（WINロゴ）
    CCFadeIn *actWinlogo = [CCFadeIn actionWithDuration:1.0f];
    
    //タッチイベント追加
    CCCallBlock *callTap = [CCCallBlock actionWithBlock:^{
        UITapGestureRecognizer *singleFingerTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        singleFingerTap.numberOfTapsRequired = 1;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:singleFingerTap];
    }];
    
    CCCallBlock *callActWinlogo = [CCCallBlock actionWithBlock:^{ [self.sprWinLogo runAction: [CCSequence actions:actWinlogo, callTap,  nil] ]; }];
    CCCallBlock *callActSerif = [CCCallBlock actionWithBlock:^{
        [self.sprSerif runAction:[CCSequence actions:seqSerif, callActWinlogo, nil]];
        [self.sprCharacter runAction:actChar_2];
    }];
    
    [self.sprCharacter runAction:[CCSequence actions:seqChar, callActSerif, nil]];
    
}


/****************************************************************************************************/
/*　中級　　　　　                                                                                   　*/
/****************************************************************************************************/
- (void)actionChukyu{
    
    //画像をキャッシュ
    self.aryImageName = [Mikiri_Constant getImageNameChukyuWin];
    Mikiri_ImageCash *imageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryImageName];
    [imageCash ImageLoaded:nil];
    
    //画像を追加
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    //敵キャラ
    NSString *strImageName = [self.aryImageName objectAtIndex:0];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprCharacter = [CCSprite spriteWithTexture:tex];
    self.sprCharacter.position = ccp(winSize.width/2, -self.sprCharacter.contentSize.height);
    [self addChild:sprCharacter];
    //セリフ
    strImageName = [self.aryImageName objectAtIndex:1];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprSerif = [CCSprite spriteWithTexture:tex];
    self.sprSerif.position = ccp(winSize.width/3, winSize.height + self.sprSerif.contentSize.height);
    [self addChild:sprSerif];
    //勝利ロゴ
    strImageName = [self.aryImageName objectAtIndex:2];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprWinLogo = [CCSprite spriteWithTexture:tex];
    self.sprWinLogo.position = ccp(winSize.width - self.sprWinLogo.contentSize.width/2, winSize.height - self.sprWinLogo.contentSize.height*1.5);
    self.sprWinLogo.opacity = 0;
    [self addChild:sprWinLogo];
    
    //アクションの設定（キャラ）
    CCDelayTime *actDelay = [CCDelayTime actionWithDuration:3.0f];
    CCMoveTo *actChar_1 = [CCMoveTo actionWithDuration:2.0f position:ccp(winSize.width/2, -self.sprSerif.contentSize.height/3)];
    CCDelayTime *actChar_Delay1 = [CCDelayTime actionWithDuration:0.5f];
    CCMoveTo *actChar_2 = [CCMoveTo actionWithDuration:0.2f position:ccp(winSize.width/2, -winSize.height)];
    CCDelayTime *actChar_Delay2 = [CCDelayTime actionWithDuration:3.0f];
    CCMoveTo *actChar_3 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height/2)];
    CCSequence *seqChar = [CCSequence actions:actDelay, actChar_1, actChar_Delay1, actChar_2, actChar_Delay2, actChar_3, nil];
    
    //アクションの設定（セリフ）
    CCMoveTo *actSerif_1 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/3, winSize.height - self.sprSerif.contentSize.height/2)];
    CCRotateTo *actSerifRotate_1 = [CCRotateTo actionWithDuration:0.05f angle:20];
    CCRotateTo *actSerifRotate_2 = [CCRotateTo actionWithDuration:0.05f angle:-20];
    CCRotateTo *actSerifRotate_3 = [CCRotateTo actionWithDuration:0.05f angle:0];
    CCRepeat *actSerif_2 = [CCRepeat actionWithAction:[CCSequence actions:actSerifRotate_1, actSerifRotate_2, nil] times:3];
    CCSequence *seqSerif = [CCSequence actions:actSerif_1, actSerif_2, actSerifRotate_3, nil];
    
    //アクションの設定（WINロゴ）
    CCFadeIn *actWinlogo = [CCFadeIn actionWithDuration:1.0f];
    
    //タッチイベント追加
    CCCallBlock *callTap = [CCCallBlock actionWithBlock:^{
        UITapGestureRecognizer *singleFingerTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        singleFingerTap.numberOfTapsRequired = 1;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:singleFingerTap];
    }];
    
    CCCallBlock *callActWinlogo = [CCCallBlock actionWithBlock:^{ [self.sprWinLogo runAction:[CCSequence actions:actWinlogo, callTap, nil]]; }];
    CCCallBlock *callActSerif = [CCCallBlock actionWithBlock:^{[self.sprSerif runAction:[CCSequence actions:seqSerif, callActWinlogo, nil]];}];
    
    [self.sprCharacter runAction:[CCSequence actions:seqChar, callActSerif, nil]];
}

/****************************************************************************************************/
/*　上級　　　　　                                                                                   　*/
/****************************************************************************************************/
- (void)actionJokyu{
    
    //画像をキャッシュ
    self.aryImageName = [Mikiri_Constant getImageNameJokyuWin];
    Mikiri_ImageCash *imageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryImageName];
    [imageCash ImageLoaded:nil];
    
    //画像を追加
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    //敵キャラ
    NSString *strImageName = [self.aryImageName objectAtIndex:0];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprCharacter = [CCSprite spriteWithTexture:tex];
    self.sprCharacter.anchorPoint = ccp(0.5f, 0);
    self.sprCharacter.position = ccp(winSize.width/2, -self.sprCharacter.contentSize.height);
    [self addChild:sprCharacter];
    //セリフ
    strImageName = [self.aryImageName objectAtIndex:1];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprSerif = [CCSprite spriteWithTexture:tex];
    self.sprSerif.position = ccp(winSize.width/3, winSize.height + self.sprSerif.contentSize.height);
    [self addChild:sprSerif];
    //勝利ロゴ
    strImageName = [self.aryImageName objectAtIndex:2];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprWinLogo = [CCSprite spriteWithTexture:tex];
    self.sprWinLogo.position = ccp(winSize.width - self.sprWinLogo.contentSize.width/2, winSize.height - self.sprWinLogo.contentSize.height*1.5);
    self.sprWinLogo.opacity = 0;
    [self addChild:sprWinLogo];
    
    //アクションの設定（キャラ）
    CCDelayTime *actDelay = [CCDelayTime actionWithDuration:0.5f];
    CCMoveTo *actChar_move1 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, 0)];
    CCScaleTo *actChar_scale1 = [CCScaleTo actionWithDuration:0.5f scaleX:1.0f scaleY:1.5f];
    CCSpawn *actChar_1 = [CCSpawn actions:actChar_move1, actChar_scale1, nil];
    CCScaleTo *actChar_scale2 = [CCScaleTo actionWithDuration:0.2f scaleX:1.0f scaleY:0.8f];
    CCScaleTo *actChar_scale3 = [CCScaleTo actionWithDuration:0.2f scaleX:1.0f scaleY:1.2f];
    CCScaleTo *actChar_scale4 = [CCScaleTo actionWithDuration:0.2f scaleX:1.0f scaleY:1.0f];
    
    CCSequence *seqChar = [CCSequence actions:actDelay, actChar_1, actChar_scale2, actChar_scale3, actChar_scale4, nil];
    //CCSequence *seqChar = [CCSequence actions:actDelay, actChar_move1, actChar_scale2, actChar_scale3, actChar_scale4, nil];
    
    //アクションの設定（セリフ）
    CCMoveTo *actSerif_1 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/3, winSize.height - self.sprSerif.contentSize.height/2)];
    CCRotateTo *actSerifRotate_1 = [CCRotateTo actionWithDuration:0.05f angle:20];
    CCRotateTo *actSerifRotate_2 = [CCRotateTo actionWithDuration:0.05f angle:-20];
    CCRotateTo *actSerifRotate_3 = [CCRotateTo actionWithDuration:0.05f angle:0];
    CCRepeat *actSerif_2 = [CCRepeat actionWithAction:[CCSequence actions:actSerifRotate_1, actSerifRotate_2, nil] times:3];
    CCSequence *seqSerif = [CCSequence actions:actSerif_1, actSerif_2, actSerifRotate_3, nil];
    
    //アクションの設定（WINロゴ）
    CCFadeIn *actWinlogo = [CCFadeIn actionWithDuration:1.0f];
    
    //タッチイベント追加
    CCCallBlock *callTap = [CCCallBlock actionWithBlock:^{
        UITapGestureRecognizer *singleFingerTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        singleFingerTap.numberOfTapsRequired = 1;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:singleFingerTap];
    }];
    
    CCCallBlock *callActWinlogo = [CCCallBlock actionWithBlock:^{ [self.sprWinLogo runAction:[CCSequence actions:actWinlogo, callTap, nil]]; }];
    CCCallBlock *callActSerif = [CCCallBlock actionWithBlock:^{[self.sprSerif runAction:[CCSequence actions:seqSerif, callActWinlogo, nil]];}];
    
    [self.sprCharacter runAction:[CCSequence actions:seqChar, callActSerif, nil]];
}

/****************************************************************************************************/
/*　タッチイベント                                                                                   　*/
/****************************************************************************************************/
- (void)handleSingleTap:(UIPanGestureRecognizer *)recognizer{
    
    //タッチイベントを削除
    for ( UIGestureRecognizer *gesture in [[[CCDirector sharedDirector] view] gestureRecognizers] ){
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:gesture];
    }
    
    //画像キャッシュを削除
    [Mikiri_ImageCash cashRemove];
    
    //画面遷移
    CCScene *scene = [Mikiri_Menu scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
