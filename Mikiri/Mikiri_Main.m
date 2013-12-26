//
//  Mikiri_Main.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/11/25.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_Main.h"
#import "AppDelegate.h"
#import "Mikiri_Gameover.h"
#import "Mikiri_Menu.h"
#import "Mikiri_Escape.h"
#import "Mikiri_Win.h"
#import "Mikiri_Constant.h"
#import "Mikiri_ImageCash.h"
#import "SimpleAudioEngine.h"

#pragma mark - Mikiri_Main

@implementation Mikiri_Main

//プロパティの実装
@synthesize mikiri_property;
@synthesize icon;
@synthesize startButton;
@synthesize background;
@synthesize resultlogo;
@synthesize winCount;
@synthesize loseCount;
@synthesize wincounticon;
@synthesize losecounticon;
@synthesize enemycharacter;
@synthesize aryImageName;
@synthesize aryEnemyImageName;
@synthesize resultTime;
@synthesize boolButtonFlg;
@synthesize intSceneFlg;
@synthesize resultFlg;
@synthesize todomeresultFlg;
@synthesize enemywaittime;
@synthesize mikiristartdate;
@synthesize mikirifinishdate;
@synthesize charengecount;
@synthesize wincount;
@synthesize losecount;
@synthesize imageIndex;
@synthesize enemyimageIndex;
@synthesize limittime;
@synthesize enemylife;
@synthesize timebar;
@synthesize hiticon;
@synthesize todome;
@synthesize swipe;
@synthesize enemylifebarshell;
@synthesize timebarshell;
@synthesize structLevel;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Mikiri_Main *layer = [Mikiri_Main node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

/******************************************************************************************/
/*　　初期化関数（init）　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 */
/******************************************************************************************/
-(id) init
{
    if( (self=[super init]) ) {
        
        //各値を初期化
        self.mikiri_property = [Mikiri_property sharedCenter];
        self.intSceneFlg = intSceneFlg_init;    //シーンフラグ
        self.resultFlg = intInit;               //勝敗フラグ
        self.resultTime = 0;                    //結果時間
        self.wincount = 0;                      //勝ち回数
        self.losecount = 0;                     //負け回数
        self.charengecount = 0;                 //挑戦回数
        self.imageIndex = 0;                    //画像インデックス
        self.limittime = 150;                   //制限時間
        self.todomeresultFlg = intTodome_init;  //とどめの結果
        CCTexture2D *tex = nil;
        
        //難易度レベルに応じた設定
        self.structLevel = [self.mikiri_property getLevel];
        
        //画像ファイル名を設定
        self.aryImageName = [Mikiri_Constant getImageNameMain];
        
        //画像をキャッシュに読み込み（非同期）
        Mikiri_ImageCash *imageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryImageName];
        [imageCash ImageLoaded:nil];
        
        //敵キャラ画像インデックスを初期化
        self.enemyimageIndex = 0;
        
        //敵キャラ画像ファイル名を設定
        self.aryEnemyImageName = [self.mikiri_property getEnemyImageName];
        
        //敵キャラ画像をキャッシュに読み込み（非同期）
        Mikiri_ImageCash *enemyimageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryEnemyImageName];
        [enemyimageCash ImageLoaded:nil];
        
        //ウィンドウサイズを取得
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        //背景画像を追加
        NSString *strBackground = [self.aryEnemyImageName objectAtIndex:4];
        tex = [[CCTextureCache sharedTextureCache] addImage:strBackground];
        self.background = [CCSprite spriteWithTexture:tex];
        self.background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:self.background];
        
        //敵キャラを追加
        [self selectEnemyCharacterAdd];
        
        //開始ボタンを追加
        NSString *strStartbutton_OFF = [self.aryImageName objectAtIndex:4];
        tex = [[CCTextureCache sharedTextureCache] addImage:strStartbutton_OFF];
        self.startButton = [CCSprite spriteWithTexture:tex];
        self.startButton.position = ccp(winSize.width/2, self.startButton.contentSize.height);
        [self addChild:self.startButton];
        
        //タッチイベント追加
        UITapGestureRecognizer *singleFingerTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        singleFingerTap.numberOfTapsRequired = 1;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:singleFingerTap];
        
        //スワイプイベント追加
        UISwipeGestureRecognizer *swipeLeftGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)] autorelease];
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:swipeLeftGesture];
        UISwipeGestureRecognizer *swipeRightGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)] autorelease];
        swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:swipeRightGesture];
        UISwipeGestureRecognizer *swipeUpGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)] autorelease];
        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:swipeUpGesture];
        UISwipeGestureRecognizer *swipeDownGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)] autorelease];
        swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:swipeDownGesture];
    }
    
    return self;
}

/******************************************************************************************/
/*　　敵キャラ選択、追加　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
- (void)selectEnemyCharacterAdd{
    
    //ウィンドウサイズを取得
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    //敵キャラを追加
    NSString *strImageFileName;
    strImageFileName = [self.aryEnemyImageName objectAtIndex:0];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
    self.enemycharacter = [CCSprite spriteWithTexture:tex];
    self.enemycharacter.anchorPoint = ccp(0.5f, 0);
    self.enemycharacter.position = ccp(winSize.width/2, -(self.enemycharacter.contentSize.height/10));
    [self addChild:self.enemycharacter];
}

/******************************************************************************************/
/*　　タップされた際に呼び出される　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
- (void)handleSingleTap:(UIPanGestureRecognizer *)recognizer{
    
    NSString *strImageFileName = nil;
    CCTexture2D *tex = nil;
    
    //シーンフラグが初期状態の場合
    if (self.intSceneFlg == intSceneFlg_init) {
        
        //タップされた場所を特定
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        
        //スタートボタンをタップした場合
        if (CGRectContainsPoint(self.startButton.boundingBox, touchLocation)) {
            
            //画面表示を初期化
            [self refreshImage];
            
            //スタートボタンをONの状態に表示変更
            strImageFileName = [self.aryImageName objectAtIndex:3];
            CCTexture2D *tex_startbutton = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
            [self.startButton setTexture:tex_startbutton];
            
            //シーンフラグを待ち状態に変更
            self.intSceneFlg = intSceneFlg_wait;
            
            //待ち時間をランダムに決定
            double t = ((random() % 50) + 20);
            t = t/10;
            
            //ランダム生成した待ち時間の後、シーンフラグをミキリ状態に更新するメソッドを呼び出す
            [self scheduleOnce:@selector(changeSceneFlgMikiri) delay:t];
        }
    }
    
    //シーンフラグが待ち状態の場合
    else if (self.intSceneFlg == intSceneFlg_wait){
        
        //勝敗フラグをフライングに設定
        self.resultFlg = intPrestart;
        
        //結果判定処理へ
        [self resultAction];
    }
    
    //シーンフラグがミキリ状態の場合
    else if (self.intSceneFlg == intSceneFlg_game){
        
        //タップされた場所を特定
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        
        //ヒットアイコンを表示
        NSString *strImageFileName;
        strImageFileName = [self.aryImageName objectAtIndex:13];
        tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.hiticon = [CCSprite spriteWithTexture:tex];
        self.hiticon.position = touchLocation;
        [self addChild:self.hiticon];
        
        //ヒットアイコンのアクションを設定
        CCMoveBy *action1 = [CCMoveBy actionWithDuration:1.0f position:ccp(0, 0)];
        CCCallBlockN *actionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
            [node removeFromParentAndCleanup:YES];
        }];
        CCSequence *sequence = [CCSequence actions:action1, actionDone, nil];
        [self.hiticon runAction:sequence];
        
        //勝敗フラグを勝ちに設定
        self.resultFlg = intWin;
        
        //結果判定処理へ
        [self resultAction];
    }
    
    //シーンフラグがリスタートの場合
    else if (self.intSceneFlg == intSceneFlg_restart){
        
        //メニュー画面へ遷移
        [self returnMenu];
    }
}

/******************************************************************************************/
/*　　画面表示初期化（結果ロゴをリムーブ、敵キャラの表情を初期化　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) refreshImage{
    
    //変数初期化
    NSString *strImageFileName = nil;
    
    //敵キャラの表情を初期状態にする
    strImageFileName = [self.aryEnemyImageName objectAtIndex:0];
    CCTexture2D *tex_enemy = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
    [self.enemycharacter setTexture:tex_enemy];
    
    //結果ロゴを画面外に移動
    [self removeResultLogo];
}


/******************************************************************************************/
/*　　結果ロゴをリムーブ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) removeResultLogo{
    
    //変数初期化
    CGSize winSize = [CCDirector sharedDirector].winSize;        //画面サイズ取得
    
    //結果ロゴを画面外に移動
    CCMoveTo *resultlogoAction = [CCMoveTo actionWithDuration:0.2 position:ccp(winSize.width/2,
                                                                               winSize.height + self.resultlogo.contentSize.height)];
    CCCallBlockN *resultActionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
        [node removeFromParentAndCleanup:YES];
    }];
    [self.resultlogo runAction:[CCSequence actions:resultlogoAction, resultActionDone, nil]];
}

/******************************************************************************************/
/*　　シーンフラグをミキリに更新する　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) changeSceneFlgMikiri{
    
    //シーンフラグが待ち状態の時のみシーンフラグを更新する
    if (self.intSceneFlg == intSceneFlg_wait) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;        //画面サイズ取得
        NSString *strIcon = [self.aryImageName objectAtIndex:6];     //ファイル名取得
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strIcon];
        self.icon = [CCSprite spriteWithTexture:tex];               //スプライトにファイルから画像を割り当て
        self.icon.position = ccp(winSize.width/2, winSize.height/2); //スプライトの位置を決定
        
        //敵の待ち時間を決定
        self.enemywaittime = 0.4;
        
        //ミキリアイコン追加
        [self addChild:self.icon];
        
        //効果音
        [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundExclamation]];
        
        //シーンフラグをミキリ状態に更新
        self.intSceneFlg = intSceneFlg_game;
        
        //ミキリアイコン表示開始時刻を取得
        self.mikiristartdate = [NSDate date];
        
        //勝敗フラグを負けに設定
        self.resultFlg = intLose;
        
        //一定時間後、結果判定画面へ処理繊維
        self.enemywaittime = 0.4;
        [self scheduleOnce:@selector(resultAction) delay:self.structLevel.enemyWaitTime];
    }
}


/******************************************************************************************/
/*　　結果判定　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void)resultAction{
    
    //結果フラグが初期状態の場合は処理終了
    if (self.resultFlg == intInit) {
        return;
    }
    
    //変数の初期化
    NSString *strImageFileName = nil;                       //イメージファイル名
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    CCTexture2D *tex_resultlogo = nil;                      //結果ロゴに反映させるテクスチャ
    CCMoveBy *resultlogoAction_1 = nil;                     //結果ロゴ表示時のアクション1
    CCJumpBy *resultlogoAction_2 = nil;                     //結果ロゴ表示時のアクション2
    CCSequence *resultlogoAction = nil;                     //結果ロゴアクション
    CCTexture2D *tex = nil;
    
    //ミキリアイコンをリムーブ
    [self removeChild:self.icon];
    
    //結果ロゴイメージを取得
    strImageFileName = [self.aryImageName objectAtIndex:0];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
    self.resultlogo = [CCSprite spriteWithTexture:tex];
    
    //勝ちアイコンのイメージを設定
    strImageFileName = [self.aryImageName objectAtIndex:7];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
    self.wincounticon = [CCSprite spriteWithTexture:tex];
    
    //負けアイコンのイメージを設定
    strImageFileName = [self.aryImageName objectAtIndex:8];
    tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
    self.losecounticon = [CCSprite spriteWithTexture:tex];
    
    //勝ちの場合
    if (self.resultFlg == intWin) {
        
        //イメージファイル名を取得
        strImageFileName = [self.aryImageName objectAtIndex:0];
        tex_resultlogo = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
        [self.self.resultlogo setTexture:tex_resultlogo];
        resultlogo.position = ccp(winSize.width/2 , winSize.height + resultlogo.contentSize.height/2);
        
        //表示時のアクション
        resultlogoAction_1 = [CCMoveBy actionWithDuration:0.2f position:ccp(0, -(resultlogo.contentSize.height))];
        resultlogoAction_2 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:10 jumps:1];
        resultlogoAction = [CCSequence actions:resultlogoAction_1, resultlogoAction_2, nil];
        
        //結果ロゴを追加
        [self addChild:self.resultlogo];
        [resultlogo runAction:resultlogoAction];
        
        //効果音
        [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundStrike]];
        
        //敵キャラの表情変更
        strImageFileName = [self.aryEnemyImageName objectAtIndex:1];
        CCTexture2D *tex_enemy = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
        [self.enemycharacter setTexture:tex_enemy];
        
        //敵キャラを揺らすエフェクト
        CCMoveBy *moveaction_1 = [CCMoveBy actionWithDuration:0.05f position:ccp(5, 0)];
        CCMoveBy *moveaction_2 = [CCMoveBy actionWithDuration:0.05f position:ccp(-5, 0)];
        CCSequence *moveSequence = [CCSequence actions:moveaction_1, moveaction_2, nil];
        [self.enemycharacter runAction:[CCRepeat actionWithAction:moveSequence times:3]];
        
        //勝ちカウントをインクリメント
        self.wincount++;
        
        //勝ちカウントアイコンを追加
        wincounticon.position = ccp(losecounticon.contentSize.width/1.5,
                                    (losecounticon.contentSize.height*0.8) * (self.wincount + self.losecount));
        [self addChild:self.wincounticon z:2 tag:self.charengecount];
        
        //挑戦回数をインクリメント
        self.charengecount++;
    }
    //負けの場合
    else if (self.resultFlg == intLose) {
        
        //イメージファイル名を取得
        strImageFileName = [self.aryImageName objectAtIndex:1];
        tex_resultlogo = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
        [self.self.resultlogo setTexture:tex_resultlogo];
        resultlogo.position = ccp(winSize.width/2 , winSize.height + resultlogo.contentSize.height/2);
        
        //表示時のアクション
        resultlogoAction_1 = [CCMoveBy actionWithDuration:0.2f position:ccp(0, -(resultlogo.contentSize.height))];
        resultlogoAction_2 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:10 jumps:1];
        resultlogoAction = [CCSequence actions:resultlogoAction_1, resultlogoAction_2, nil];
        
        //結果ロゴを追加
        [self addChild:self.resultlogo];
        [resultlogo runAction:resultlogoAction];
        
        //効果音
        [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundStrike]];
        
        //画面を揺らすエフェクト
        CCMoveBy *moveaction_1 = [CCMoveBy actionWithDuration:0.05f position:ccp(5, 0)];
        CCMoveBy *moveaction_2 = [CCMoveBy actionWithDuration:0.05f position:ccp(-5, 0)];
        CCSequence *moveSequence = [CCSequence actions:moveaction_1, moveaction_2, nil];
        [self.background runAction:[CCRepeat actionWithAction:moveSequence times:3]];
        
        //負けカウントをインクリメント
        self.losecount++;
        
        //負けカウントアイコンを追加
        losecounticon.position = ccp(losecounticon.contentSize.width/1.5,
                                     (losecounticon.contentSize.height*0.8) * (self.wincount + self.losecount));
        [self addChild:self.losecounticon z:2 tag:self.charengecount];
        
        //挑戦回数をインクリメント
        self.charengecount++;
    }
    
    //フライングの場合
    else if (self.resultFlg == intPrestart) {
        
        //イメージファイル名を取得
        strImageFileName = [self.aryImageName objectAtIndex:2];
        tex_resultlogo = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
        [self.self.resultlogo setTexture:tex_resultlogo];
        resultlogo.position = ccp(winSize.width/2 , winSize.height + resultlogo.contentSize.height/2);
        
        //表示時のアクション
        resultlogoAction_1 = [CCMoveBy actionWithDuration:0.2f position:ccp(0, -(resultlogo.contentSize.height))];
        resultlogoAction_2 = [CCJumpBy actionWithDuration:0.5f position:ccp(0, 0) height:10 jumps:1];
        resultlogoAction = [CCSequence actions:resultlogoAction_1, resultlogoAction_2, nil];

        //結果ロゴを追加
        [self addChild:self.resultlogo];
        [resultlogo runAction:resultlogoAction];
        
        //効果音
        [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundPrestart]];
    }
    
    //勝ち数が規定回数以上、かつ負け回数が規定回数以下の場合
    if ((self.wincount >= self.structLevel.winCount) && (self.losecount < self.structLevel.loseCount)) {
        
        //結果フラグを初期化
        self.resultFlg = intInit;
        //シーンフラグをとどめ準備状態に変更する
        self.intSceneFlg = intSceneFlg_prefinish;
        //とどめモードへ
        [self scheduleOnce:@selector(todomeMode) delay:2.0f];
        
    }
    //負け回数が規定回数以上の場合
    else if (self.losecount >= self.structLevel.loseCount){
        
        //画面状態を無状態にする（タップによる入力を受け付けない）
        self.intSceneFlg = intSceneFlg_nil;
        
        //ゲームオーバー画面へ遷移
        [self scheduleOnce:@selector(moveGameover) delay:1.0f];
    }
    //勝ち回数、負け回数ともに規定回数以下
    else{
        
        //結果フラグを初期化
        self.resultFlg = intInit;
        
        //開始ボタンをOFFの状態に表示変更
        strImageFileName = [self.aryImageName objectAtIndex:4];
        CCTexture2D *tex_startbutton = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
        [self.startButton setTexture:tex_startbutton];
        
        //シーンフラグを初期状態に変更する
        self.intSceneFlg = intSceneFlg_init;
    }
}


/******************************************************************************************/
/*　　とどめモードへ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) todomeMode{
    
    //変数の初期化
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    //画面暗転
    CCTintBy *tint = [CCTintBy actionWithDuration:1.0f red:-100 green:-100 blue:-100];
    [self.background runAction:tint];
    
    //開始ボタン、勝ちカウント、負けカウント、結果表示を画面外へ移動させた後、リムーブ
    //開始ボタン
    CCJumpBy *startButtonMoveAction1 = [CCJumpBy actionWithDuration:0.2f position:ccp(0, 0) height:20 jumps:1];
    CCMoveTo *startButtonMoveAction2 = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2, -(self.startButton.contentSize.height))];
    CCCallBlockN *startButtonMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node){[node removeFromParentAndCleanup:YES];}];
    [self.startButton runAction:[CCSequence actions:startButtonMoveAction1, startButtonMoveAction2, startButtonMoveDone, nil]];
    //結果表示
    [self removeResultLogo];
    //勝ちカウント、負けカウント
    int i = 0;
    for (i=0; i<self.charengecount; i++) {
        CCNode *node = [self getChildByTag:i];
        CCJumpBy *countMoveAction1 = [CCJumpBy actionWithDuration:0.2f position:ccp(0, 0) height:10 jumps:1];
        CCMoveTo *countMoveAction2 = [CCMoveTo actionWithDuration:0.3f position:ccp(node.contentSize.width/1.5, -(node.contentSize.height))];
        CCCallBlockN *countMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node){[node removeFromParentAndCleanup:YES];}];
        [node runAction:[CCSequence actions:countMoveAction1, countMoveAction2, countMoveDone, nil]];
    }
    
    //敵キャラを画面外に出した後、テクスチャをバストアップにして再表示
    CCJumpBy *enemyCharacterMoveAction1 = [CCJumpBy actionWithDuration:0.2f position:ccp(0, 0) height:10 jumps:1];
    CCMoveTo *enemyCharacterMoveAction2 = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2, -(self.enemycharacter.contentSize.height))];
    CCCallBlock *changeTexcure = [CCCallBlock actionWithBlock:^{
        //イメージファイル名を取得
        NSString *strImageFileName = [self.aryEnemyImageName objectAtIndex:2];
        CCTexture2D *tex_enemy = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
        [self.enemycharacter setTexture:tex_enemy];
        CGRect rect = CGRectMake(0, 0, tex_enemy.contentSize.width, tex_enemy.contentSize.height);
        [self.enemycharacter setTextureRect:rect];
        self.enemycharacter.anchorPoint = ccp(0.5f, 0);
    }];
    CCCallBlock *popupenemylife = [CCCallBlock actionWithBlock:^{
        //敵ライフゲージを表示
        
        NSString *strImageFileName = [self.aryImageName objectAtIndex:17];
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.enemylifebarshell = [CCSprite spriteWithTexture:tex];
        self.enemylifebarshell.anchorPoint = ccp(0.5f, 0);
        self.enemylifebarshell.position = ccp(winSize.width - (self.enemylifebarshell.contentSize.width/2), -self.enemylifebarshell.contentSize.height);
        
        strImageFileName = [self.aryImageName objectAtIndex:11];
        tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.enemylife = [CCSprite spriteWithTexture:tex];
        self.enemylife.anchorPoint = ccp(0.5f, 0);
        self.enemylife.position = ccp(winSize.width - (self.enemylifebarshell.contentSize.width/2), -self.enemylifebarshell.contentSize.height);
        
        [self addChild:self.enemylife];
        [self addChild:self.enemylifebarshell];
        
        CCMoveTo *enemyLifeMoveAction = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width - (self.enemylifebarshell.contentSize.width/2), winSize.height/20)];
        [self.enemylife runAction:enemyLifeMoveAction];
        CCMoveTo *enemyLifeBarShellMoveAction = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width - (self.enemylifebarshell.contentSize.width/2), winSize.height/20 -10)];
        [self.enemylifebarshell runAction:enemyLifeBarShellMoveAction];
        
        //制限時間表示
        strImageFileName = [self.aryImageName objectAtIndex:18];
        tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.timebarshell = [CCSprite spriteWithTexture:tex];
        self.timebarshell.anchorPoint = ccp(0.5f, 0);
        self.timebarshell.position = ccp(self.timebarshell.contentSize.width/2, -self.timebarshell.contentSize.height);
        
        strImageFileName = [self.aryImageName objectAtIndex:12];
        tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.timebar = [CCSprite spriteWithTexture:tex];
        self.timebar.anchorPoint = ccp(0.5f, 0);
        self.timebar.position = ccp(self.timebarshell.contentSize.width/2, -self.timebarshell.contentSize.height);
        
        [self addChild:self.timebar];
        [self addChild:self.timebarshell];
        
        CCMoveTo *timebarMoveAction = [CCMoveTo actionWithDuration:0.3f position:ccp(self.timebarshell.contentSize.width/2, winSize.height/20)];
        CCMoveTo *timebarshellMoveAction = [CCMoveTo actionWithDuration:0.3f position:ccp(self.timebarshell.contentSize.width/2, winSize.height/20 -10)];
        [self.timebar runAction:timebarMoveAction];
        [self.timebarshell runAction:timebarshellMoveAction];
    }];
    CCMoveTo *enemyCharacterMoveAction3 = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width/2, -(self.enemycharacter.contentSize.height/10))];
    //とどめロゴを表示
    CCCallBlock *addtodome = [CCCallBlock actionWithBlock:^{
        //変数の設定
        NSString *strImageFileName = nil;
        CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
        //トドメロゴを表示
        strImageFileName = [self.aryImageName objectAtIndex:15];
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.todome = [CCSprite spriteWithTexture:tex];
        self.todome.position = ccp(-self.todome.contentSize.width, winSize.height/2);
        [self addChild:self.todome];
        //トドメロゴアクション
        CCMoveBy *todomeAction0 = [CCMoveBy actionWithDuration:0.2f position:ccp(0, 0)];
        CCMoveTo *todomeAction1 = [CCMoveTo actionWithDuration:0.4f position:ccp((winSize.width/2)-10, winSize.height/2)];
        CCMoveTo *todomeAction2 = [CCMoveTo actionWithDuration:0.8f position:ccp((winSize.width/2)+10, winSize.height/2)];
        CCMoveTo *todomeAction3 = [CCMoveTo actionWithDuration:0.4f position:ccp(winSize.width + self.todome.contentSize.width, winSize.height/2)];
        CCCallBlockN *todomeActionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
            [node removeFromParentAndCleanup:YES];
        }];
        [self.todome runAction:[CCSequence actions:todomeAction0, todomeAction1, todomeAction2, todomeAction3, todomeActionDone, nil]];
    }];
    //スワイプロゴを表示
    CCCallBlock *addswipe = [CCCallBlock actionWithBlock:^{
        //変数の設定
        NSString *strImageFileName = nil;
        CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
        //スワイプロゴを表示
        strImageFileName = [self.aryImageName objectAtIndex:16];
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.swipe = [CCSprite spriteWithTexture:tex];
        self.swipe.position = ccp(winSize.width/2, self.swipe.contentSize.height/2);
        [self addChild:self.swipe];
        //スワイプロゴアクション
        CCFadeIn *swipeAction1 = [CCFadeIn actionWithDuration:1.0f];
        CCFadeOut *swipeAction2 = [CCFadeOut actionWithDuration:1.0f];
        [self.swipe runAction:[CCRepeatForever actionWithAction:[CCSequence actions:swipeAction1, swipeAction2, nil]]];
    }];
    CCCallBlock *enemyCharacterMoveActionDone =[CCCallBlock actionWithBlock:^{
        //シーンフラグをとどめ開始状態に変更する
        self.intSceneFlg = intSceneFlg_finishstart;
    }];
    [self.enemycharacter runAction:[CCSequence actions:enemyCharacterMoveAction1,
                                                        enemyCharacterMoveAction2,
                                                        changeTexcure,
                                                        enemyCharacterMoveAction3,
                                                        popupenemylife,
                                                        addtodome,
                                                        addswipe,
                                                        enemyCharacterMoveActionDone,
                                                        nil]];
}


/******************************************************************************************/
/*　　スワイプ時の動作（トドメモード時）　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void)handleSwipe:(UISwipeGestureRecognizer *)recognizer{
    
    //トドメ開始モードの場合
    if (self.intSceneFlg == intSceneFlg_finishstart) {
        
        //シーンフラグをとどめモードに変更
        self.intSceneFlg = intSceneFlg_finish;
        
        //制限時間を減らす
        if (self.timebar.contentSize.height > 0) {
            [self schedule:@selector(timebarUpdate) interval:0.01f];
        }
    }
    //トドメモードの場合、かつとどめの結果が初期状態である場合
    else if (self.intSceneFlg == intSceneFlg_finish && self.todomeresultFlg == intTodome_init){
        
        //タップされた場所を特定
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        
        //ヒットアイコンを表示
        NSString *strImageFileName;
        strImageFileName = [self.aryImageName objectAtIndex:14];
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageFileName];
        self.hiticon = [CCSprite spriteWithTexture:tex];
        self.hiticon.position = touchLocation;
        [self addChild:self.hiticon];
        
        //ヒットアイコンのアクションを設定
        CCMoveBy *action1 = [CCMoveBy actionWithDuration:0.5f position:ccp(0, 0)];
        CCCallBlockN *actionDone = [CCCallBlockN actionWithBlock:^(CCNode *node){
            [node removeFromParentAndCleanup:YES];
        }];
        CCSequence *sequence = [CCSequence actions:action1, actionDone, nil];
        [self.hiticon runAction:sequence];
        
        //効果音
        [[SimpleAudioEngine sharedEngine] playEffect:[Mikiri_Constant getSoundSwipe]];
        
        //敵キャラを揺らすエフェクト
        CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
        float ranx_1 = random()%20+1 -10;
        float rany_1 = random()%20+1 -10;
        float ranx_2 = random()%20+1 -10;
        float rany_2 = random()%20+1 -10;
        CCCallBlock *enemyexpressionchange1 =[CCCallBlock actionWithBlock:^{
            //敵キャラの表情変更
            NSString *strImageFileName = [self.aryEnemyImageName objectAtIndex:3];
            CCTexture2D *tex_enemy = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
            [self.enemycharacter setTexture:tex_enemy];
        }];
        CCMoveBy *enemymoveaction_1 = [CCMoveBy actionWithDuration:0.05f position:ccp(ranx_1, rany_1)];
        CCMoveBy *enemymoveaction_2 = [CCMoveBy actionWithDuration:0.05f position:ccp(ranx_2, rany_2)];
        CCCallBlock *enemymoveactionDone =[CCCallBlock actionWithBlock:^{
            //最初の位置に戻す
            self.enemycharacter.position = ccp(winSize.width/2, -(self.enemycharacter.contentSize.height/10));
        }];
        CCCallBlock *enemyexpressionchange2 =[CCCallBlock actionWithBlock:^{
            //敵キャラの表情戻す
            NSString *strImageFileName = [self.aryEnemyImageName objectAtIndex:2];
            CCTexture2D *tex_enemy = [[CCTextureCache sharedTextureCache] textureForKey:strImageFileName];
            [self.enemycharacter setTexture:tex_enemy];
        }];
        CCSequence *enemymoveSequence = [CCSequence actions:enemyexpressionchange1,
                                         enemymoveaction_1,
                                         enemymoveaction_2,
                                         enemymoveactionDone,
                                         enemyexpressionchange2, nil];
        [self.enemycharacter runAction:[CCRepeat actionWithAction:enemymoveSequence times:3]];
        
        //敵のライフゲージを減らす
        CCMoveBy *lifemoveaction_1 = [CCMoveBy actionWithDuration:0.05f position:ccp(5, 0)];
        CCMoveBy *lifemoveaction_2 = [CCMoveBy actionWithDuration:0.05f position:ccp(-5, 0)];
        CCMoveBy *lifemoveaction_3 = [CCMoveBy actionWithDuration:0.05f position:ccp(5, 0)];
        CCMoveBy *lifemoveaction_4 = [CCMoveBy actionWithDuration:0.05f position:ccp(-5, 0)];
        CCSequence *lifemoveSequence1 = [CCSequence actions:lifemoveaction_1, lifemoveaction_2, nil];
        CCSequence *lifemoveSequence2 = [CCSequence actions:lifemoveaction_3, lifemoveaction_4, nil];
        [self.enemylife runAction:[CCRepeat actionWithAction:lifemoveSequence1 times:3]];
        [self.enemylifebarshell runAction:[CCRepeat actionWithAction:lifemoveSequence2 times:3]];
        if (self.enemylife.contentSize.height > 0) {
            [self schedule:@selector(enemyLifeUpdate) interval:0.01f repeat:5 delay:0];
        }
    }
    
}
//敵のライフポイントを減らすアニメーション
-(void)enemyLifeUpdate{
    if (self.enemylife.contentSize.height > self.structLevel.damagepoint) {
        [self.enemylife setTextureRect:CGRectMake(0, self.structLevel.damagepoint,
                                                  self.enemylife.contentSize.width, self.enemylife.contentSize.height - (self.structLevel.damagepoint))];
    }
    else{
        
        [self.enemylife setTextureRect:CGRectMake(0, self.enemylife.contentSize.height,
                                                  self.enemylife.contentSize.width, 0)];
        self.todomeresultFlg = intTodome_win;   //勝利フラグを立てる
        [self scheduleOnce:@selector(todomeResult) delay:1.0];
        [self unschedule:_cmd];
    }
}
//タイマーを減らすアニメーション
-(void)timebarUpdate{
    if (self.todomeresultFlg == intTodome_win) {
        [self unschedule:_cmd];
    }
    else if (self.timebar.contentSize.height > self.structLevel.timepoint) {
        [self.timebar setTextureRect:CGRectMake(0, self.structLevel.timepoint,
                                                  self.timebar.contentSize.width, self.timebar.contentSize.height - (self.structLevel.timepoint))];
    }
    else{
        [self.timebar setTextureRect:CGRectMake(0, self.timebar.contentSize.height,
                                                  self.timebar.contentSize.width, 0)];
        self.todomeresultFlg = intTodome_lose;   //敗北フラグを立てる
        [self scheduleOnce:@selector(todomeResult) delay:1.0];
        [self unschedule:_cmd];
    }
}


/******************************************************************************************/
/*　　トドメの後の画面遷移判定　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) todomeResult{
    
    //タッチイベントを削除
    for ( UIGestureRecognizer *gesture in [[[CCDirector sharedDirector] view] gestureRecognizers] ){
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:gesture];
    }
    
    //とどめの結果が勝利なら、勝利画面へ遷移
    if (self.todomeresultFlg == intTodome_win) {
        
        //画像キャッシュを削除
        [Mikiri_ImageCash cashRemove];
        
        CCScene *scene = [Mikiri_Win scene];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];
    }
    //とどめの結果が敗北なら敵逃亡画面へ遷移
    else {
        
        //画像キャッシュを削除
        [Mikiri_ImageCash cashRemove];
        
        CCScene *scene = [Mikiri_Escape scene];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];
    }
}

/******************************************************************************************/
/*　　ゲームオーバー表示　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) moveGameover{
    
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    id callBlock = [CCCallBlock actionWithBlock:^{
        self.intSceneFlg = intSceneFlg_restart;
    }];
    Mikiri_Gameover *gameover = [[Mikiri_Gameover alloc]initWithWinSize:winSize];
    gameover.actR = [CCSequence actions:gameover.actR, callBlock, nil];
    
    [self addChild:gameover.lblG];
    [self addChild:gameover.lblA];
    [self addChild:gameover.lblM];
    [self addChild:gameover.lblE_1];
    [self addChild:gameover.lblO];
    [self addChild:gameover.lblV];
    [self addChild:gameover.lblE_2];
    [self addChild:gameover.lblR];
    [gameover.lblG   runAction:gameover.actG];
    [gameover.lblA   runAction:gameover.actA];
    [gameover.lblM   runAction:gameover.actM];
    [gameover.lblE_1 runAction:gameover.actE_1];
    [gameover.lblO   runAction:gameover.actO];
    [gameover.lblV   runAction:gameover.actV];
    [gameover.lblE_2 runAction:gameover.actE_2];
    [gameover.lblR   runAction:gameover.actR];
}


/******************************************************************************************/
/*　　メニュー画面へ遷移　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) returnMenu{
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
