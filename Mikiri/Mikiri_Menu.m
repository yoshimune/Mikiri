//
//  Mikiri_Menu.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/11/24.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_Menu.h"
#import "AppDelegate.h"
#import "Mikiri_Main.h"
#import "Mikiri_ImageCash.h"
#import "Mikiri_Constant.h"
#import "SimpleAudioEngine.h"

#pragma mark - Mikiri_Menu

@implementation Mikiri_Menu

//プロパティの実装
@synthesize mikiri_property;
@synthesize sprBackGround;
@synthesize sprStartButton;
@synthesize sprSyokyuButton;
@synthesize sprChukyuButton;
@synthesize sprJokyuButton;
@synthesize intSceneFlg;
@synthesize aryImageName;
@synthesize imageIndex;
@synthesize intLevelFlg;

// Helper class method that creates a Scene with the Mikiri_Menu as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Mikiri_Menu *layer = [Mikiri_Menu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init{
    if(self = [super init]){
        
        //変数の初期化
        self.mikiri_property = [Mikiri_property sharedCenter];
        self.intSceneFlg = intSceneFlg_Menu_init;
        self.intLevelFlg = intLevelFlg_Menu_init;
        
        //画像をキャッシュ
        self.aryImageName = [Mikiri_Constant getImageNameMenu];
        Mikiri_ImageCash *imageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryImageName];
        [imageCash ImageLoaded:nil];
        
        //BGMを再生
        if(![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]){
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[Mikiri_Constant getSoundBgm] loop:YES];
        }
 
        
        //初期アクション実行
        [self startAction];
        
        //タッチイベント追加
        UITapGestureRecognizer *singleFingerTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        singleFingerTap.numberOfTapsRequired = 1;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:singleFingerTap];
    }
    return self;
}


/*******************************************************************************/
/***　開始時の処理　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　***/
/*******************************************************************************/
-(void)startAction{
    
    //変数の定義
    NSString *strImageName = nil;
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    
    //背景の表示
    strImageName = [self.aryImageName objectAtIndex:8];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprBackGround = [CCSprite spriteWithTexture:tex];
    self.sprBackGround.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:sprBackGround];
    
    //スタートボタン追加
    strImageName = [self.aryImageName objectAtIndex:1];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprStartButton = [CCSprite spriteWithTexture:tex];
    self.sprStartButton.position = ccp(winSize.width/2, winSize.height + self.sprStartButton.contentSize.height);
    [self addChild:self.sprStartButton];
    
    CCMoveBy *action1 = [CCMoveBy actionWithDuration:0.5f position:ccp(0, 0)];
    CCMoveTo *action2 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, self.sprStartButton.contentSize.height)];
    CCJumpBy *action3 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1];
    CCCallBlock *actionDone = [CCCallBlock actionWithBlock:^{
        self.intSceneFlg = intSceneFlg_Menu_start1;
    }];
    [self.sprStartButton runAction:[CCSequence actions:action1, action2, action3, actionDone, nil]];
}


/*******************************************************************************/
/***　タップした時の処理　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　***/
/*******************************************************************************/
- (void)handleSingleTap:(UIPanGestureRecognizer *)recognizer{
    
    //変数の初期化
    NSString *strImageName = nil;
    
    //タップされた場所を特定
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    //シーンフラグがstart1の場合
    if (self.intSceneFlg == intSceneFlg_Menu_start1) {
        
        //スタートボタンをタップした場合
        if (CGRectContainsPoint(self.sprStartButton.boundingBox, touchLocation)) {
            //効果音
            [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundButton]];
            //難易度レベルボタンの表示
            [self choiceLevel];
        }
    }
    
    //シーンフラグがstart2の場合
    else if (self.intSceneFlg == intSceneFlg_Menu_start2){
        
        //初級ボタンをタップした場合
        if (CGRectContainsPoint(self.sprSyokyuButton.boundingBox, touchLocation)) {
            
            //レベルフラグを初級にする
            self.intLevelFlg = intLevelFlg_Menu_Syokyu;
            
            //ボタンをオンにする
            strImageName = [self.aryImageName objectAtIndex:2];
            CCTexture2D *tex = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
            [self.sprSyokyuButton setTexture:tex];

            //効果音
            [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundButton]];

            //シーンフラグをstart3にする
            self.intSceneFlg = intSceneFlg_Menu_start3;
            
            //レベルボタンをリムーブ
            [self removeChoiceLevel];
        }
        //中級ボタンをタップした場合
        else if (CGRectContainsPoint(self.sprChukyuButton.boundingBox, touchLocation)){
            
            //レベルフラグを中級にする
            self.intLevelFlg = intLevelFlg_Menu_Chukyu;
            
            //ボタンをオンにする
            strImageName = [self.aryImageName objectAtIndex:4];
            CCTexture2D *tex = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
            [self.sprChukyuButton setTexture:tex];
            
            //効果音
            [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundButton]];
            
            //シーンフラグをstart3にする
            self.intSceneFlg = intSceneFlg_Menu_start3;

            //レベルボタンをリムーブ
            [self removeChoiceLevel];
            
        }
        //上級ボタンをタップした場合
        else if (CGRectContainsPoint(self.sprJokyuButton.boundingBox, touchLocation)){
            
            //レベルフラグを上級にする
            self.intLevelFlg = intLevelFlg_Menu_Jokyu;
            
            //ボタンをオンにする
            strImageName = [self.aryImageName objectAtIndex:6];
            CCTexture2D *tex = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
            [self.sprJokyuButton setTexture:tex];
            
            //効果音
            [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundButton]];
            
            //シーンフラグをstart3にする
            self.intSceneFlg = intSceneFlg_Menu_start3;
            
            //レベルボタンをリムーブ
            [self removeChoiceLevel];
        }
    }
}


/*******************************************************************************/
/***　スタートボタンをタップした際の処理　　　　　　　　　　　　　　　　　　　　　　　　　　***/
/*******************************************************************************/
- (void)choiceLevel {
    
    //変数の定義
    NSString *strImageName = nil;
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    CCTexture2D *tex = nil;
    
    //スタートボタンをオンにする
    strImageName = [self.aryImageName objectAtIndex:0];
    CCTexture2D *tex_startbutton = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
    [self.sprStartButton setTexture:tex_startbutton];
    CCJumpBy *startAction1 = [CCJumpBy actionWithDuration:0.2f position:ccp(0, 0) height:20 jumps:1];
    CCMoveTo *startAction2 = [CCMoveTo actionWithDuration:0.1f position:ccp(winSize.width/2, -self.sprSyokyuButton.contentSize.height)];
    CCCallBlockN *startActionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
        [node removeFromParentAndCleanup:YES];
    }];
    [self.sprStartButton runAction:[CCSequence actions:startAction1, startAction2, startActionDone, nil]];
    
    //初級ボタン
    strImageName = [self.aryImageName objectAtIndex:3];
    tex = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
    self.sprSyokyuButton = [CCSprite spriteWithTexture:tex];
    self.sprSyokyuButton.position = ccp(winSize.width/2, winSize.height + self.sprSyokyuButton.contentSize.height + ((winSize.height/3)*2));
    [self addChild:self.sprSyokyuButton];
    CCMoveBy *syokyuAction1 = [CCMoveBy actionWithDuration:0.6f position:ccp(0, 0)];
    CCMoveTo *syokyuAction2 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, (winSize.height/3)*2)];
    CCJumpBy *syokyuAction3 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1];
    CCCallBlock *actionDone = [CCCallBlock actionWithBlock:^{
        self.intSceneFlg = intSceneFlg_Menu_start2;
    }];
    [self.sprSyokyuButton runAction:[CCSequence actions:syokyuAction1, syokyuAction2, syokyuAction3, actionDone, nil]];
    //中級ボタン
    strImageName = [self.aryImageName objectAtIndex:5];
    tex = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
    self.sprChukyuButton = [CCSprite spriteWithTexture:tex];
    self.sprChukyuButton.position = ccp(winSize.width/2, winSize.height + self.sprChukyuButton.contentSize.height + (winSize.height/2));
    [self addChild:self.sprChukyuButton];
    CCMoveBy *chukyuAction1 = [CCMoveBy actionWithDuration:0.3f position:ccp(0, 0)];
    CCMoveTo *chukyuAction2 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height/2)];
    CCJumpBy *chukyuAction3 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1];
    [self.sprChukyuButton runAction:[CCSequence actions:chukyuAction1, chukyuAction2, chukyuAction3, nil]];
    //上級ボタン
    strImageName = [self.aryImageName objectAtIndex:7];
    tex = [[CCTextureCache sharedTextureCache] textureForKey:strImageName];
    self.sprJokyuButton = [CCSprite spriteWithTexture:tex];
    self.sprJokyuButton.position = ccp(winSize.width/2, winSize.height + self.sprJokyuButton.contentSize.height + (winSize.height/3));
    [self addChild:self.sprJokyuButton];
    CCMoveTo *jokyuAction1 = [CCMoveTo actionWithDuration:0.5f position:ccp(winSize.width/2, winSize.height/3)];
    CCJumpBy *jokyuAction2 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:20 jumps:1];
    [self.sprJokyuButton runAction:[CCSequence actions:jokyuAction1, jokyuAction2, nil]];
}


/*******************************************************************************/
/***　レベルボタンをリムーブ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　***/
/*******************************************************************************/
- (void)removeChoiceLevel {
    
    //変数の定義
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    
    //初級ボタン
    CCMoveBy *syokyuAction1 = [CCMoveBy actionWithDuration:1.2f position:ccp(0, 0)];
    CCMoveTo *syokyuAction2 = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2, -self.sprSyokyuButton.contentSize.height)];
    CCCallBlock *syokyuAction3 = [CCCallBlock actionWithBlock:^{
        [self moveMainScene];
    }];
    CCCallBlockN *syokyuActionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
        [node removeFromParentAndCleanup:YES];
    }];
    [self.sprSyokyuButton runAction:[CCSequence actions:syokyuAction1, syokyuAction2, syokyuAction3, syokyuActionDone, nil]];
    //中級ボタン
    CCMoveBy *chukyuAction1 = [CCMoveBy actionWithDuration:0.9f position:ccp(0, 0)];
    CCMoveTo *chukyuAction2 = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2, -self.sprChukyuButton.contentSize.height)];
    CCCallBlockN *chukyuActionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
        [node removeFromParentAndCleanup:YES];
    }];
    [self.sprChukyuButton runAction:[CCSequence actions:chukyuAction1, chukyuAction2, chukyuActionDone, nil]];
    //上級ボタン
    CCMoveBy *jokyuAction1 = [CCMoveBy actionWithDuration:0.6f position:ccp(0, 0)];
    CCMoveTo *jokyuAction2 = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2, -self.sprJokyuButton.contentSize.height)];
    CCCallBlockN *jokyuActionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
        [node removeFromParentAndCleanup:YES];
    }];
    [self.sprJokyuButton runAction:[CCSequence actions:jokyuAction1, jokyuAction2, jokyuActionDone, nil]];
}


/*******************************************************************************/
/***　メイン画面へ遷移　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　***/
/*******************************************************************************/
- (void)moveMainScene{
    
    
    //遷移先に敵画像ファイル名を渡す
    //初級
    if (self.intLevelFlg == intLevelFlg_Menu_Syokyu) {
        NSArray *aryEnemyImageFile = [Mikiri_Constant getImageNameSyokyu];
        [self.mikiri_property setEnemyImageName:aryEnemyImageFile];
        levelStruct levelValue = [Mikiri_Constant getLevelSyokyu];
        [self.mikiri_property setLevel:levelValue];
    }
    //中級
    else if (self.intLevelFlg == intLevelFlg_Menu_Chukyu){
        NSArray *aryEnemyImageFile = [Mikiri_Constant getImageNameChukyu];
        [self.mikiri_property setEnemyImageName:aryEnemyImageFile];
        levelStruct levelValue = [Mikiri_Constant getLevelChukyu];
        [self.mikiri_property setLevel:levelValue];
    }
    //上級
    else if (self.intLevelFlg == intLevelFlg_Menu_Jokyu){
        NSArray *aryEnemyImageFile = [Mikiri_Constant getImageNameJokyu];
        [self.mikiri_property setEnemyImageName:aryEnemyImageFile];
        levelStruct levelValue = [Mikiri_Constant getLevelJokyu];
        [self.mikiri_property setLevel:levelValue];
    }
    
    //画像キャッシュを削除
    [Mikiri_ImageCash cashRemove];
    
    //画面遷移
    CCScene *scene = [Mikiri_Main scene];
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
