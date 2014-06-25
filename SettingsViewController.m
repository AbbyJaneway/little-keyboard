//
//  SettingsViewController.m
//  LittleKeyboard
//
//  Created by Brown, Melissa on 4/17/14.
//  Copyright (c) 2014 Heartland Community College. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "RecordViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, weak) IBOutlet UIButton *createNew;
@property (nonatomic, weak) IBOutlet UISlider *redVol;
@property (nonatomic, weak) IBOutlet UISlider *orangeVol;
@property (nonatomic, weak) IBOutlet UISlider *yellowVol;
@property (nonatomic, weak) IBOutlet UISlider *greenVol;
@property (nonatomic, weak) IBOutlet UISlider *blueVol;
@property (nonatomic, weak) IBOutlet UISlider *purpleVol;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Settings";
    [_redVol setValue:[[_appDelegate preferenceForKey:_appDelegate.redVolKey] floatValue] animated:NO];
    [_orangeVol setValue:[[_appDelegate preferenceForKey:_appDelegate.orangeVolKey] floatValue] animated:NO];
    [_yellowVol setValue:[[_appDelegate preferenceForKey:_appDelegate.yellowVolKey] floatValue] animated:NO];
    [_greenVol setValue:[[_appDelegate preferenceForKey:_appDelegate.greenVolKey] floatValue] animated:NO];
    [_blueVol setValue:[[_appDelegate preferenceForKey:_appDelegate.blueVolKey] floatValue] animated:NO];
    [_purpleVol setValue:[[_appDelegate preferenceForKey:_appDelegate.purpleVolKey] floatValue] animated:NO];
}

- (IBAction)pushRecordVC {
    [self.navigationController pushViewController:[[RecordViewController alloc]initWithNibName:@"RecordViewController" bundle:nil] animated:YES];
}

#pragma mark - Volume Sliders

- (IBAction)redSliderValueChanged {
    [_appDelegate setPreference:[NSNumber numberWithFloat:_redVol.value] forKey:_appDelegate.redVolKey];
    
}

- (IBAction)orangeSliderValueChanged {
    [_appDelegate setPreference:[NSNumber numberWithFloat:_orangeVol.value] forKey:_appDelegate.orangeVolKey];
    
}

- (IBAction)yellowSliderValueChanged {
    [_appDelegate setPreference:[NSNumber numberWithFloat:_yellowVol.value] forKey:_appDelegate.yellowVolKey];
}

- (IBAction)greenSliderValueChanged {
    [_appDelegate setPreference:[NSNumber numberWithFloat:_greenVol.value] forKey:_appDelegate.greenVolKey];
}

- (IBAction)blueSliderValueChanged {
    [_appDelegate setPreference:[NSNumber numberWithFloat:_blueVol.value] forKey:_appDelegate.blueVolKey];
}

- (IBAction)purpleSliderValueChanged {
    [_appDelegate setPreference:[NSNumber numberWithFloat:_purpleVol.value] forKey:_appDelegate.purpleVolKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
