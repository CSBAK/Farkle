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
//@property NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *userTwoScore;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property BOOL playerOneScoring;
@property int score;

@end

@implementation ViewController

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.labelCollection) {
        if ([label.backgroundColor isEqual:[UIColor redColor]]) {
            [label rollDice];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *label in self.labelCollection) {
        label.delegate = self;
        label.layer.cornerRadius = label.bounds.size.width / 6;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 1.0;
        label.layer.borderColor = [[UIColor grayColor]CGColor];
        label.backgroundColor = [UIColor redColor];
    }
    self.rollButton.layer.cornerRadius = self.rollButton.bounds.size.width / 10;
    self.rollButton.layer.borderWidth = 1.0;
    self.rollButton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.playerOneScoring = YES;
}

-(void)dieDelegation:(id)die {
    DieLabel *label = die;
    label.backgroundColor = [UIColor lightGrayColor];
    [self updateScore];
}

-(void)updateScore {
    self.score = 0;
    for (DieLabel *label in self.labelCollection) {
        if ([label.text isEqualToString:@"1"] && label.backgroundColor == [UIColor lightGrayColor]) {
            self.score = self.score + 100;
        } else if ([label.text isEqualToString:@"5"] && label.backgroundColor == [UIColor lightGrayColor]) {
            self.score = self.score + 50;
        }
    }
    if (self.playerOneScoring == YES) {
        self.userScore.text = [NSString stringWithFormat:@"P1 Score: %i", self.score];
    } else {
        self.userTwoScore.text = [NSString stringWithFormat:@"P2 Score: %i", self.score];
    }
}

@end
