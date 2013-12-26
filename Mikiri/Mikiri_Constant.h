//
//  Mikiri_Constant.h
//  Mikiri
//
//  Created by (｀･ω･´) on 2013/12/08.
//  Copyright (c) 2013年 Yoshimune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mikiri_property.h"

@interface Mikiri_Constant : NSObject
+(NSArray *)getImageNameMenu;
+(NSArray *)getImageNameMain;
+(NSArray *)getImageNameSyokyu;
+(NSArray *)getImageNameSyokyuWin;
+(levelStruct)getLevelSyokyu;
+(NSArray *)getImageNameChukyu;
+(NSArray *)getImageNameChukyuWin;
+(levelStruct)getLevelChukyu;
+(NSArray *)getImageNameJokyu;
+(NSArray *)getImageNameJokyuWin;
+(levelStruct)getLevelJokyu;
+(NSArray *)getImageNameEscape;
+(NSString *)getSoundBgm;
+(NSString *)getSoundStrike;
+(NSString *)getSoundExclamation;
+(NSString *)getSoundSwipe;
+(NSString *)getSoundPrestart;
+(NSString *)getSoundButton;
@end
