//
//  AppDelegate.h
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/15/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *recordKey;
@property (nonatomic, strong) NSString *redVolKey;
@property (nonatomic, strong) NSString *orangeVolKey;
@property (nonatomic, strong) NSString *yellowVolKey;
@property (nonatomic, strong) NSString *greenVolKey;
@property (nonatomic, strong) NSString *blueVolKey;
@property (nonatomic, strong) NSString *purpleVolKey;
@property (nonatomic) BOOL *customSoundsLoaded; //flag so user collections are only loaded once

- (void)setPreference:(id)preference forKey:(NSString *)key;
- (id)preferenceForKey:(NSString *)key;
- (void)soundsLoaded:(BOOL)loaded;

@end
