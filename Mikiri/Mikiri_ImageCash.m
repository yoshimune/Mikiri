//
//  Mikiri_ImageCash.m
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/08.
//  Copyright 2013年 Yoshimune. All rights reserved.
//

#import "Mikiri_ImageCash.h"

@implementation Mikiri_ImageCash

@synthesize imageIndex;
@synthesize aryImageName;

/******************************************************************************************/
/*　　画像ファイル名をセットする（初期処理）　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(id) setImageName:(NSArray *)ary{
    if (self = [super init]) {
        self.aryImageName = ary;
        self.imageIndex = 0;
    }
    return self;
}

/******************************************************************************************/
/*　　画像を非同期でキャッシュする　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
-(void) ImageLoaded :(CCTexture2D *)Tex{
    //画像ファイルを全てキャッシュする
    NSString *strFileName = nil;
    
    //全てキャッシュしたら処理終了
    if (self.imageIndex >= self.aryImageName.count) {
        return;
    }
    
    strFileName = [self.aryImageName objectAtIndex:self.imageIndex];
    self.imageIndex++;
    
    [[CCTextureCache sharedTextureCache] addImageAsync:strFileName target:self selector:@selector(ImageLoaded:)];
}


/******************************************************************************************/
/*　　キャッシュしたファイルを消去する　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　*/
/******************************************************************************************/
+(void) cashRemove{
    [[CCDirector sharedDirector] purgeCachedData];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
}

@end
