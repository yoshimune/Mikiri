//
//  Mikiri_Escape.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/04.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_Escape.h"
#import "Mikiri_Menu.h"
#import "AppDelegate.h"
#import "Mikiri_Constant.h"
#import "Mikiri_ImageCash.h"

#pragma mark - Mikiri_Escape

@implementation Mikiri_Escape
@synthesize sprBackGround;
@synthesize sprMessage;
@synthesize aryImageName;

// Helper class method that creates a Scene with the Mikiri_Menu as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Mikiri_Escape *layer = [Mikiri_Escape node];
	
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
        // create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Enemy Escape" fontName:@"Marker Felt" fontSize:64];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        //画像をキャッシュ
        self.aryImageName = [Mikiri_Constant getImageNameEscape];
        Mikiri_ImageCash *imageCash = [[Mikiri_ImageCash alloc]setImageName:self.aryImageName];
        [imageCash ImageLoaded:nil];
        
        //画像を表示
        CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
        NSString *strImageName = [self.aryImageName objectAtIndex:0];
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
        self.sprBackGround = [CCSprite spriteWithTexture:tex];
        self.sprBackGround.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:sprBackGround];
        
        //メッセージ表示
        [self addMessage];
        
        //タッチイベント追加
        UITapGestureRecognizer *singleFingerTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        singleFingerTap.numberOfTapsRequired = 1;
        [[[CCDirector sharedDirector] view]addGestureRecognizer:singleFingerTap];
    }
    return self;
}

/**********************************************************************************************/
/* タッチイベント（画面遷移）　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 */
/**********************************************************************************************/
- (void)handleSingleTap:(UIPanGestureRecognizer *)recognizer{
    
    //タッチイベント非活性
    [[[CCDirector sharedDirector] view]release];
    
    //画像キャッシュを削除
    [Mikiri_ImageCash cashRemove];
    
    //画面遷移
    CCScene *scene = [Mikiri_Menu scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:scene]];
}

/**********************************************************************************************/
/* メッセージ表示　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 */
/**********************************************************************************************/
-(void) addMessage{
    
    CGSize winSize = [CCDirector sharedDirector].winSize;   //画面サイズ
    
    NSString *strImageName = [self.aryImageName objectAtIndex:1];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:strImageName];
    self.sprMessage = [CCSprite spriteWithTexture:tex];
    self.sprMessage.position = ccp(winSize.width/2, winSize.height - self.sprMessage.contentSize.height);
    self.sprMessage.opacity = 0;
    [self addChild:sprMessage];
    
    CCDelayTime *actionDelay = [CCDelayTime actionWithDuration:1.0f];
    CCFadeIn *actionFadein = [CCFadeIn actionWithDuration:2.0f];
    [self.sprMessage runAction:[CCSequence actions:actionDelay, actionFadein, nil]];
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
