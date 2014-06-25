//
//  RecordViewController.m
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/24/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import "RecordViewController.h"
#import "AppDelegate.h"

@interface RecordViewController ()
//UI elements
@property (nonatomic, weak) IBOutlet UIButton *redRecord;
@property (nonatomic, weak) IBOutlet UIButton *redPlay;
@property (nonatomic, weak) IBOutlet UIButton *redClear;
@property (nonatomic, weak) IBOutlet UIButton *orangeRecord;
@property (nonatomic, weak) IBOutlet UIButton *orangePlay;
@property (nonatomic, weak) IBOutlet UIButton *orangeClear;
@property (nonatomic, weak) IBOutlet UIButton *yellowRecord;
@property (nonatomic, weak) IBOutlet UIButton *yellowPlay;
@property (nonatomic, weak) IBOutlet UIButton *yellowClear;
@property (nonatomic, weak) IBOutlet UIButton *greenRecord;
@property (nonatomic, weak) IBOutlet UIButton *greenPlay;
@property (nonatomic, weak) IBOutlet UIButton *greenClear;
@property (nonatomic, weak) IBOutlet UIButton *blueRecord;
@property (nonatomic, weak) IBOutlet UIButton *bluePlay;
@property (nonatomic, weak) IBOutlet UIButton *blueClear;
@property (nonatomic, weak) IBOutlet UIButton *purpleRecord;
@property (nonatomic, weak) IBOutlet UIButton *purplePlay;
@property (nonatomic, weak) IBOutlet UIButton *purpleClear;
@property (nonatomic, strong) IBOutlet UILabel *recordingLabel;
//instance vars
@property (nonatomic, strong) NSString *collectionName;
@property (nonatomic, strong) NSFileManager *fm;
@property (nonatomic, strong) UIButton *selectedClearButton;
@property (nonatomic, strong) AppDelegate *appDelegate;
//temp file paths
@property (nonatomic, strong) NSURL *redTempFile;
@property (nonatomic, strong) NSURL *orangeTempFile;
@property (nonatomic, strong) NSURL *yellowTempFile;
@property (nonatomic, strong) NSURL *greenTempFile;
@property (nonatomic, strong) NSURL *blueTempFile;
@property (nonatomic, strong) NSURL *purpleTempFile;
//permanent file path for when user is finished recording
@property (nonatomic, strong) NSString *soundFilePathBase;
//recorders and players
@property (nonatomic, strong) AVAudioRecorder *redRecorder;
@property (nonatomic, strong) AVAudioRecorder *orangeRecorder;
@property (nonatomic, strong) AVAudioRecorder *yellowRecorder;
@property (nonatomic, strong) AVAudioRecorder *greenRecorder;
@property (nonatomic, strong) AVAudioRecorder *blueRecorder;
@property (nonatomic, strong) AVAudioRecorder *purpleRecorder;
@property (nonatomic, strong) AVAudioPlayer *redPlayer;
@property (nonatomic, strong) AVAudioPlayer *orangePlayer;
@property (nonatomic, strong) AVAudioPlayer *yellowPlayer;
@property (nonatomic, strong) AVAudioPlayer *greenPlayer;
@property (nonatomic, strong) AVAudioPlayer *bluePlayer;
@property (nonatomic, strong) AVAudioPlayer *purplePlayer;


@end

@implementation RecordViewController

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
    _appDelegate = [UIApplication sharedApplication].delegate;
    _fm = [NSFileManager defaultManager];
    //Set temp file paths
    _redTempFile = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"red.caf"]];
    _orangeTempFile = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"orange.caf"]];
    _yellowTempFile = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"yellow.caf"]];
    _greenTempFile = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"green.caf"]];
    _blueTempFile = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"blue.caf"]];
    _purpleTempFile = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"purple.caf"]];
    
    NSLog(@"%@", _redTempFile.description);
    
    //Init recorders
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    _redRecorder = [[AVAudioRecorder alloc] initWithURL:_redTempFile settings:nil error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    for (NSObject *o in [_redRecorder.settings allValues]) {
        NSLog(@"%@", o);
    }
    _redRecorder.delegate = self;
    _orangeRecorder = [[AVAudioRecorder alloc] initWithURL:_orangeTempFile settings:nil error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    _orangeRecorder.delegate = self;
    _yellowRecorder = [[AVAudioRecorder alloc] initWithURL:_yellowTempFile settings:nil error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    _yellowRecorder.delegate = self;
    _greenRecorder = [[AVAudioRecorder alloc] initWithURL:_greenTempFile settings:nil error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    _greenRecorder.delegate = self;
    _blueRecorder = [[AVAudioRecorder alloc] initWithURL:_blueTempFile settings:nil error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    _blueRecorder.delegate = self;
    _purpleRecorder = [[AVAudioRecorder alloc] initWithURL:_purpleTempFile settings:nil error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    _purpleRecorder.delegate = self;
}

- (IBAction)onSave {
    NSLog(@"%s", __FUNCTION__);
    //check that all files have been created
    NSError *error = nil;
    if ([_fm fileExistsAtPath:[_redTempFile path]]) {
        //red file exists, check for orange
        if ([_fm fileExistsAtPath:[_orangeTempFile path]]) {
            //orange file exists, check for yellow
            if ([_fm fileExistsAtPath:[_yellowTempFile path]]) {
                //yellow file exists, check for green
                if ([_fm fileExistsAtPath:[_greenTempFile path]]) {
                    //green file exists, check for blue
                    if ([_fm fileExistsAtPath:[_blueTempFile path]]) {
                        //blue file exists, check for purple
                        if ([_fm fileExistsAtPath:[_purpleTempFile path]]) {
                            //all files exist, ok to move sound files from tmp to new dir
                            //create new dir for collection
                            NSFileManager *fm = [[NSFileManager alloc] init];
                            NSError *error = nil;
                            _soundFilePathBase = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:_collectionName];
                            [fm createDirectoryAtPath:_soundFilePathBase withIntermediateDirectories:NO attributes:nil error:&error];
                            if(error) {
                                NSLog(@"%@", [error localizedDescription]);
                            }
                            [_fm copyItemAtPath:[_redTempFile path] toPath:[_soundFilePathBase stringByAppendingPathComponent:@"red.caf"] error:&error];
                            [_fm copyItemAtPath:[_orangeTempFile path] toPath:[_soundFilePathBase stringByAppendingPathComponent:@"orange.caf"] error:&error];
                            [_fm copyItemAtPath:[_yellowTempFile path] toPath:[_soundFilePathBase stringByAppendingPathComponent:@"yellow.caf"] error:&error];
                            [_fm copyItemAtPath:[_greenTempFile path] toPath:[_soundFilePathBase stringByAppendingPathComponent:@"green.caf"] error:&error];
                            [_fm copyItemAtPath:[_blueTempFile path] toPath:[_soundFilePathBase stringByAppendingPathComponent:@"blue.caf"] error:&error];
                            [_fm copyItemAtPath:[_purpleTempFile path] toPath:[_soundFilePathBase stringByAppendingPathComponent:@"purple.caf"] error:&error];
                            //notify user of successful save and viewcontroller to load new collection
                            _recordingLabel.text = @"Sound collection saved!";
                            _recordingLabel.hidden = NO;
                            NSLog(@"%hhd", [_fm fileExistsAtPath:[_soundFilePathBase stringByAppendingPathComponent:@"red.caf"]]);
                            [_appDelegate soundsLoaded:NO];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                    } else {
                        NSLog(@"Please record a sound for the blue key before saving");
                    }
                } else {
                    NSLog(@"Please record a sound for the green key before saving");
                }
            } else {
                NSLog(@"Please record a sound for the yellow key before saving");
            }
        } else {
            NSLog(@"Please record a sound for the orange key before saving");
        }
    } else {
        NSLog(@"Please record a sound for the red key before saving");
    }
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = textField.text.length + string.length - range.length;
    return (newLength > 12) ? NO : YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        _collectionName = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    NSLog(@"Collection name = %@", _collectionName);
    if (_collectionName !=nil) {
        
    [textField resignFirstResponder];
    [_redRecord setEnabled:YES];
    [_orangeRecord setEnabled:YES];
    [_yellowRecord setEnabled:YES];
    [_greenRecord setEnabled:YES];
    [_blueRecord setEnabled:YES];
    [_purpleRecord setEnabled:YES];
        
    }
    return YES;
}

#pragma mark - Record button methods

- (IBAction)recordRed:(id)sender {
    [_redRecord setEnabled:NO];
    _recordingLabel.hidden = NO;
    [_redRecorder recordForDuration:2];
}

- (IBAction)recordOrange:(id)sender {
    [_orangeRecord setEnabled:NO];
    _recordingLabel.hidden = NO;
    [_orangeRecorder recordForDuration:2];
}

- (IBAction)recordYellow:(id)sender {
    [_yellowRecord setEnabled:NO];
    _recordingLabel.hidden = NO;
    [_yellowRecorder recordForDuration:2];
}

- (IBAction)recordGreen:(id)sender {
    [_greenRecord setEnabled:NO];
    _recordingLabel.hidden = NO;
    [_greenRecorder recordForDuration:2];
}

- (IBAction)recordBlue:(id)sender {
    [_blueRecord setEnabled:NO];
    _recordingLabel.hidden = NO;
    [_blueRecorder recordForDuration:2];
}

- (IBAction)recordPurple:(id)sender {
    [_purpleRecord setEnabled:NO];
    _recordingLabel.hidden = NO;
    [_purpleRecorder recordForDuration:2];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
   NSLog(@"%s with flag %hhd", __FUNCTION__, flag);
    if (flag == YES) {
        if (recorder == _redRecorder) {
            [_redRecord setEnabled:YES];
            [_redClear setEnabled:YES];
            [_redPlay setEnabled:YES];
            [self initPlayerforColor:@"red"];
        } else if (recorder == _orangeRecorder) {
            [_orangeRecord setEnabled:YES];
            [_orangeClear setEnabled:YES];
            [_orangePlay setEnabled:YES];
            [self initPlayerforColor:@"orange"];
        } else if (recorder == _yellowRecorder) {
            [_yellowRecord setEnabled:YES];
            [_yellowClear setEnabled:YES];
            [_yellowPlay setEnabled:YES];
            [self initPlayerforColor:@"yellow"];
        } else if (recorder == _greenRecorder) {
            [_greenRecord setEnabled:YES];
            [_greenClear setEnabled:YES];
            [_greenPlay setEnabled:YES];
            [self initPlayerforColor:@"green"];
        } else if (recorder == _blueRecorder) {
            [_blueRecord setEnabled:YES];
            [_blueClear setEnabled:YES];
            [_bluePlay setEnabled:YES];
            [self initPlayerforColor:@"blue"];
        } else if (recorder == _purpleRecorder) {
            [_purpleRecord setEnabled:YES];
            [_purpleClear setEnabled:YES];
            [_purplePlay setEnabled:YES];
            [self initPlayerforColor:@"purple"];
        } else {
            NSLog(@"Reached end of recorder tree with no match");
        }
        _recordingLabel.hidden = YES;
    } else {
        NSLog(@"AudioRecorder reports unsuccessful recording");
    }
}

#pragma mark - Play and clear buttons methods

- (IBAction)playRed:(id)sender {
    [_redPlayer play];
}

- (IBAction)deleteRed:(id)sender {
    [self promptUser:sender];
    [_redPlay setEnabled:NO];
    [_redClear setEnabled:NO];
}

- (IBAction)playOrange:(id)sender {
    [_orangePlayer play];
}

- (IBAction)deleteOrange:(id)sender {
    [self promptUser:sender];
    [_orangePlay setEnabled:NO];
    [_orangeClear setEnabled:NO];
}

- (IBAction)playYellow:(id)sender {
    [_yellowPlayer play];
}

- (IBAction)deleteYellow:(id)sender {
    [self promptUser:sender];
    [_yellowPlay setEnabled:NO];
    [_yellowClear setEnabled:NO];
}

- (IBAction)playGreen:(id)sender {
    [_greenPlayer play];
}

- (IBAction)deleteGreen:(id)sender {
    [self promptUser:sender];
    [_greenPlay setEnabled:NO];
    [_greenClear setEnabled:NO];
}

- (IBAction)playBlue:(id)sender {
    [_bluePlayer play];
}

- (IBAction)deleteBlue:(id)sender {
    [self promptUser:sender];
    [_bluePlay setEnabled:NO];
    [_blueClear setEnabled:NO];
}

- (IBAction)playPurple:(id)sender {
    [_purplePlayer play];
}

- (IBAction)deletePurple:(id)sender {
    [self promptUser:sender];
    [_purplePlay setEnabled:NO];
    [_purpleClear setEnabled:NO];
}

- (void)initPlayerforColor:(NSString *)color {
    NSError *error = nil;
    if ([color isEqualToString: @"red"]) {
        if (_redPlayer == nil) {
            _redPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_redTempFile error:&error];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else if ([color isEqualToString: @"orange"]) {
        if (_orangePlayer == nil) {
            _orangePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_orangeTempFile error:&error];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else if ([color isEqualToString:@"yellow"]) {
        if (_yellowPlayer == nil) {
            _yellowPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_yellowTempFile error:&error];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else if ([color isEqualToString:@"green"]) {
        if (_greenPlayer == nil) {
            _greenPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_greenTempFile error:&error];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else if ([color isEqualToString:@"blue"]) {
        if (_bluePlayer == nil) {
            _bluePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_blueTempFile error:&error];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else if ([color isEqualToString:@"purple"]) {
        if (_purplePlayer == nil) {
            _purplePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_purpleTempFile error:&error];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else {
        NSLog(@"Reached end of initPlayer tree with no match");
    }
}

- (void)promptUser:(id)button {
    _selectedClearButton = button;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"This action cannot be undone. Are you sure you want to delete this recording?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSError *error = nil;
    switch (buttonIndex) {
        case 0:
            //clicked No
            //do nothing
            break;
        case 1:
            //clicked Yes so delete recording
            if (_selectedClearButton == _redClear) {
                [_fm removeItemAtPath:[_redTempFile path] error:&error];
                if(error) {
                    NSLog(@"%@", [error localizedDescription]);
                }
            } else if (_selectedClearButton == _orangeClear) {
                [_fm removeItemAtPath:[_orangeTempFile absoluteString] error:&error];
                if(error) {
                    NSLog(@"%@", [error localizedDescription]);
                }
            } else if (_selectedClearButton == _yellowClear) {
                [_fm removeItemAtPath:[_yellowTempFile absoluteString] error:&error];
                if(error) {
                    NSLog(@"%@", [error localizedDescription]);
                }
            } else if (_selectedClearButton == _greenClear) {
                [_fm removeItemAtPath:[_greenTempFile absoluteString] error:&error];
                if(error) {
                    NSLog(@"%@", [error localizedDescription]);
                }
            } else if (_selectedClearButton == _blueClear) {
                [_fm removeItemAtPath:[_blueTempFile absoluteString] error:&error];
                if(error) {
                    NSLog(@"%@", [error localizedDescription]);
                }
            } else if (_selectedClearButton == _purpleClear) {
                [_fm removeItemAtPath:[_purpleTempFile absoluteString] error:&error];
                if(error) {
                    NSLog(@"%@", [error localizedDescription]);
                }
            } else {
                NSLog(@"Error deleting file");
            }
        default:
            break;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    //set players and recorders to nil
    _redPlayer = nil;
    _redRecorder = nil;
    _orangePlayer = nil;
    _orangeRecorder = nil;
    _yellowPlayer = nil;
    _yellowRecorder = nil;
    _greenPlayer = nil;
    _greenRecorder = nil;
    _bluePlayer = nil;
    _blueRecorder = nil;
    _purplePlayer = nil;
    _purpleRecorder = nil;
    _recordingLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
