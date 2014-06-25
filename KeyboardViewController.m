//
//  KeyboardViewController.m
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/15/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import "KeyboardViewController.h"
#import "AppDelegate.h"


@interface KeyboardViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *redKey;
@property (nonatomic, strong) IBOutlet UIImageView *orangeKey;
@property (nonatomic, strong) IBOutlet UIImageView *yellowKey;
@property (nonatomic, strong) IBOutlet UIImageView *greenKey;
@property (nonatomic, strong) IBOutlet UIImageView *blueKey;
@property (nonatomic, strong) IBOutlet UIImageView *purpleKey;
@property (nonatomic, strong) IBOutlet UIView *container;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) AVAudioPlayer *redPlayer;
@property (nonatomic, strong) AVAudioPlayer *orangePlayer;
@property (nonatomic, strong) AVAudioPlayer *yellowPlayer;
@property (nonatomic, strong) AVAudioPlayer *greenPlayer;
@property (nonatomic, strong) AVAudioPlayer *bluePlayer;
@property (nonatomic, strong) AVAudioPlayer *purplePlayer;
@property (nonatomic) float redVolume;
@property (nonatomic) float orangeVolume;
@property (nonatomic) float yellowVolume;
@property (nonatomic) float greenVolume;
@property (nonatomic) float blueVolume;
@property (nonatomic) float purpleVolume;

@end

@implementation KeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _appDelegate = [UIApplication sharedApplication].delegate;
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    // Load custom or default volume settings
    _redVolume = [[_appDelegate preferenceForKey:_appDelegate.redVolKey] floatValue];
    _orangeVolume = [[_appDelegate preferenceForKey:_appDelegate.orangeVolKey] floatValue];
    _yellowVolume = [[_appDelegate preferenceForKey:_appDelegate.yellowVolKey] floatValue];
    _greenVolume = [[_appDelegate preferenceForKey:_appDelegate.greenVolKey] floatValue];
    _blueVolume = [[_appDelegate preferenceForKey:_appDelegate.blueVolKey] floatValue];
    _purpleVolume = [[_appDelegate preferenceForKey:_appDelegate.purpleVolKey] floatValue];
    //NSLog(@"%f, %f, %f, %f, %f, %f", _redVolume, _orangeVolume, _yellowVolume, _greenVolume, _blueVolume, _purpleVolume);
    //add tap gesture recognizers
    [_redKey addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playRed)]];
    [_orangeKey addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playOrange)]];
    [_yellowKey addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playYellow)]];
    [_greenKey addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playGreen)]];
    [_blueKey addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playBlue)]];
    [_purpleKey addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPurple)]];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    self.redPlayer = nil;
    self.orangePlayer = nil;
    self.yellowPlayer = nil;
    self.greenPlayer = nil;
    self.bluePlayer = nil;
    self.purplePlayer = nil;
}

- (void)setSoundCollection:(NSArray *)soundCollection {
    //init players with sounds from soundcollection passed by ViewController
    _soundCollection = soundCollection;
    
    NSError *error = nil;
    self.redPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_soundCollection[0] error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    self.redPlayer.volume = (_redVolume / 10.0);
    self.redPlayer.delegate = self;
    self.orangePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_soundCollection[1] error:&error];
    self.orangePlayer.volume = (_orangeVolume / 10.0);
    self.yellowPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_soundCollection[2] error:&error];
    self.yellowPlayer.volume = (_yellowVolume / 10.0);
    self.greenPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_soundCollection[3] error:&error];
    self.greenPlayer.volume = (_greenVolume / 10.0);
    self.bluePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_soundCollection[4] error:&error];
    self.bluePlayer.volume = (_blueVolume / 10.0);
    self.purplePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_soundCollection[5] error:&error];
    self.purplePlayer.volume = (_purpleVolume / 10.0);
    //tell players to buffer
    [self.redPlayer prepareToPlay];
    [self.orangePlayer prepareToPlay];
    [self.yellowPlayer prepareToPlay];
    [self.greenPlayer prepareToPlay];
    [self.bluePlayer prepareToPlay];
    [self.purplePlayer prepareToPlay];
}

# pragma mark - Player methods

- (void)playRed {
    [self.redPlayer play];
    NSLog(@"playRed");
}
- (void)playOrange {
  [self.orangePlayer play];
}
- (void)playYellow {
    [self.yellowPlayer play];
}
- (void)playGreen {
    [self.greenPlayer play];
}
- (void)playBlue {
    [self.bluePlayer play];
}
- (void)playPurple {
    [self.purplePlayer play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"%s with flag %hhd", __FUNCTION__, flag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
