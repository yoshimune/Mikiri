//
//  Mikiri_ImageCash.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/08.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Mikiri_ImageCash : CCLayer {
    
    NSArray *aryImageName;      //画像ファイル名を格納する配列
    int imageIndex;             //画像ファイルのインデックス
}

-(id) setImageName:(NSArray *)ary;
-(void) ImageLoaded :(CCTexture2D *)Tex;
+(void) cashRemove;

@property(retain, atomic) NSArray *aryImageName;
@property(assign, atomic) int imageIndex;

@end
