//
//  KeyboardViewController.h
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/15/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface KeyboardViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic) NSArray *soundCollection;

@end
