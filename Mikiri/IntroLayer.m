//
//  IntroLayer.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/11/24.
//  Copyright (｀･ω･´) 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "Mikiri_Menu.h"


#pragma mark - IntroLayer

// Mikiri_Menu implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the Mikiri_Menu as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"start.png"];
			//background = [CCSprite spriteWithFile:@"Default.png"];
			//background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [[CCDirector sharedDirector] setDisplayStats:NO];
    
	CCSprite* background = [CCSprite spriteWithFile:@"start.png"];
	background.position = ccp(size.width/2, size.height/2);
	[self addChild:background z:0];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Mikiri_Menu scene] ]];
}
@end
