//
//  ViewController.m
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/15/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "KeyboardViewController.h"
#import "SettingsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UISegmentedControl *scCollection;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSFileManager *fm;
@property (nonatomic, strong) NSMutableArray *soundCollectionArray; //array of sound collections (arrays of file urls)


@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.appDelegate = [UIApplication sharedApplication].delegate;
        // piano sounds (from GarageBand)
        NSArray *piano = [[NSArray alloc] initWithObjects:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"D3" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"F3" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"A3" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"C4" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"E4" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"G4" ofType:@"mp3"]], nil];
        //SciFi sounds (from http://www.trekcore.com/audio/)
        NSArray *scifi = [[NSArray alloc] initWithObjects:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tos_chirp_2" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"alert02" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"denybeep1" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"force_field_hit" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tng_transporter3_clean" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tng_torpedo_clean" ofType:@"mp3"]], nil];
        //vox sounds from freesound.org
        NSArray *vox = [[NSArray alloc] initWithObjects:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zero" ofType:@"aiff"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"anders" ofType:@"aiff"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"aiff"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"wow" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"disgusted" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"no" ofType:@"mp3"]], nil];
        //funny sounds from freesound.org and soundbible.com
        NSArray *funny = [[NSArray alloc] initWithObjects:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Bike_Horn" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Killdeer_Bird_Call" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"splattt" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Snorting_Pig" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"water-drop" ofType:@"mp3"]], [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"whistling" ofType:@"mp3"]], nil];
        
        //init array of sound collections
        _soundCollectionArray = [[NSMutableArray alloc] initWithObjects:piano, scifi, vox, funny, nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _fm = [NSFileManager defaultManager];
}

- (void)viewDidAppear:(BOOL)animated {
    if (_appDelegate.customSoundsLoaded == NO) {
    NSError *error = nil;
    BOOL isDir;
    //check for user-created collection(s) and add segment(s) to segmented control
    NSString *filePathBase = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *docContents = [_fm contentsOfDirectoryAtPath:filePathBase error:&error];
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    for (int i = 0; i < docContents.count; i++) {
        if ([_fm fileExistsAtPath:[filePathBase stringByAppendingPathComponent:docContents[i]] isDirectory:&isDir] && isDir) {
            //get the name of the directory (sound collection name)
            NSString *title = docContents[i];
            NSLog(@"title = %@", title);
            //store sound file paths in an array
            NSArray *sounds = [[NSArray alloc] initWithObjects:[[NSURL alloc] initFileURLWithPath:[[filePathBase stringByAppendingPathComponent:docContents[i]] stringByAppendingPathComponent:@"red.caf"]], [[NSURL alloc] initFileURLWithPath:[[filePathBase stringByAppendingPathComponent:docContents[i]] stringByAppendingPathComponent:@"orange.caf"]], [[NSURL alloc] initFileURLWithPath:[[filePathBase stringByAppendingPathComponent:docContents[i]] stringByAppendingPathComponent:@"yellow.caf"]], [[NSURL alloc] initFileURLWithPath:[[filePathBase stringByAppendingPathComponent:docContents[i]] stringByAppendingPathComponent:@"green.caf"]], [[NSURL alloc] initFileURLWithPath:[[filePathBase stringByAppendingPathComponent:docContents[i]] stringByAppendingPathComponent:@"blue.caf"]], [[NSURL alloc] initFileURLWithPath:[[filePathBase stringByAppendingPathComponent:docContents[i]] stringByAppendingPathComponent:@"purple.caf"]], nil];
            if(error) {
                NSLog(@"%@", [error localizedDescription]);
            }
            NSLog(@"dir contents length = %lu", (unsigned long)sounds.count);
            //add the array to _soundCollectionArray
            [_soundCollectionArray addObject:sounds];
            //add a segmented control
            [_scCollection insertSegmentWithTitle:title atIndex:[_scCollection numberOfSegments] animated:NO];
            [_scCollection sizeToFit];
        }
    }
        [_appDelegate soundsLoaded:YES]; //notify delegate to update boolean
    }
}

- (IBAction)launchKeyboard {
    KeyboardViewController *kvc = [[KeyboardViewController alloc] initWithNibName:@"KeyboardViewController" bundle:nil];
    [kvc setSoundCollection: _soundCollectionArray[_scCollection.selectedSegmentIndex]];
    [self.navigationController pushViewController:kvc animated:YES];
}

- (IBAction)launchSettings {
    [self.navigationController pushViewController:[[SettingsViewController alloc]initWithNibName:@"SettingsView" bundle:nil] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
