//
//  FirstViewController.m
//  dashanddot
//
//  Created by Shell Shrader on 12/6/14.
//  Copyright (c) 2014 Shell Shrader. All rights reserved.
//

#import "SoundViewController.h"

@interface SoundViewController ()

@end

@implementation SoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    for (WWRobot *robot in self.connectedRobots) {
        robot.delegate = nil;
    }
    
    NSLog(@"first view unloaded");
}

- (IBAction)playSound:(id)sender {
    
    self.connectedRobots = [[WWRobotManager manager] allConnectedRobots];

    int x = 0;
    
    for (WWRobot *robot in self.connectedRobots) {
        if (robot.delegate == nil) robot.delegate = self;
        
        WWCommandSet *speakerCommand = [WWCommandSet new];
        WWCommandSpeaker *speaker;
        if (x == 0) {
            speaker = [[WWCommandSpeaker alloc] initWithDefaultSound:WW_SOUNDFILE_LION];
        } else {
            speaker = [[WWCommandSpeaker alloc] initWithDefaultSound:WW_SOUNDFILE_UH_OH];
        }
        
        speaker.volume = 1;
        [speakerCommand setSound:speaker];

        NSArray * objects = [NSArray arrayWithObjects: speakerCommand, robot, nil];
        [self performSelector:@selector(sendCommandSetToRobot:) withObject:objects afterDelay:x * 4];
        x++;
    }
}

- (void) sendCommandSetToRobot:(NSArray *)objects {
    WWCommandSet *cmd = objects[0];
    WWRobot *robot = objects[1];
    
    [robot sendRobotCommandSet:cmd];
    NSLog(@"sent sound to %@", robot.name);
}

@end