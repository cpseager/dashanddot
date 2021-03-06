//
//  RobotControlViewController.m
//  playground
//
//  Created by Kevin Liang on 11/17/14.
//  Copyright (c) 2014 Wonder Workshop. All rights reserved.
//

#import "RobotControlViewController.h"
//
//@interface RobotControlViewController ()
//
//@end

@implementation RobotControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshConnectedRobots];
    self.refreshRobotsTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                             target:self selector:@selector(refreshConnectedRobots) userInfo:nil repeats:YES];

}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.refreshRobotsTimer invalidate];
}

- (void) refreshConnectedRobots
{
    self.connectedRobots = [[WWRobotManager manager] allConnectedRobots];
    for (WWRobot *robot in self.connectedRobots) {
        robot.delegate = self;
    }
}

- (void) sendCommandSetToRobots:(WWCommandSet *)cmd
{
    for (WWRobot *robot in self.connectedRobots) {
        [robot sendRobotCommandSet:cmd];
    }
}

- (void) sendCommandSetToRobot:(NSArray *)objects {
    WWCommandSet *cmd = objects[0];
    WWRobot *robot = objects[1];
    
    [robot sendRobotCommandSet:cmd];
    NSLog(@"sent sound to %@", robot.name);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

@end
