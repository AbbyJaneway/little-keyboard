//
//  AppDelegate.m
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/15/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate {
    @private
    NSMutableDictionary *preferences;
    NSString *preferencesFile;
}

#pragma mark - Private methods

- (void)soundsLoaded:(BOOL)loaded {
    _customSoundsLoaded = &loaded;
}

- (void)savePreferences {
    [preferences writeToFile:preferencesFile atomically:YES];
}

- (void)loadPreferences {
    if(!preferencesFile) {
        preferencesFile = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@"user_prefs.plist"];
    }
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    if([fm fileExistsAtPath:preferencesFile]) {
        preferences = [NSMutableDictionary dictionaryWithContentsOfFile:preferencesFile];
    } else {
        preferences = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"plist" ofType:@"plist"]];
    }
    
    if (!preferences) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Preferences file not loaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        preferences = [[NSMutableDictionary alloc] init];
    }
}

#pragma mark - Preferences

- (void)setPreference:(id)preference forKey:(NSString *)key {
    [preferences setObject:preference forKey:key];
    //[preferences writeToFile:preferencesFile atomically:YES];
    [self savePreferences];
}

- (id)preferenceForKey:(NSString *)key {
    return [preferences valueForKey:key];
}

- (NSString *)recordKey {
    return @"record";
}

- (NSString *)redVolKey {
    return @"redVolume";
}

- (NSString *)orangeVolKey {
    return @"orangeVolume";
}

- (NSString *)yellowVolKey {
    return @"yellowVolume";
}

- (NSString *)greenVolKey {
    return @"greenVolume";
}

- (NSString *)blueVolKey {
    return @"blueVolume";
}

- (NSString *)purpleVolKey {
    return @"purpleVolume";
}

#pragma mark - App Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _customSoundsLoaded = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self loadPreferences];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

/*
 notes to self:
 
 use AVAudioRecorder to record custom sound collection
 call recordAtTime:forDuration: with a one second duration (possibly shorter)
 then allow user to play back, save, or delete. Repeat until 6 sounds are saved. Prompt user for each like "record red key" etc.
 */
