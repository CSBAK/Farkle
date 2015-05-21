//
//  ViewController.m
//  Farkle
//
//  Created by Brittany Kimbrough on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieDelegation>
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labelCollection;
@property NSMutableArray *dice;

@end

@implementation ViewController
- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.labelCollection) {
        [label rollDice];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *label in self.labelCollection) {
        label.delegate = self;
    }
}

-(void)dieDelegation:(id)die {
    DieLabel *dieLabel = die;
    dieLabel.backgroundColor = [UIColor blueColor];
}



@end
