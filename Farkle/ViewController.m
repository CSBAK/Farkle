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
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;

@property BOOL playerOneScoring;
@property int playerOneScore;
@property int playerOneTotal;
@property int playerTwoScore;
@property int roundScore;
@property int selectedCount;

@end

@implementation ViewController

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
    self.view.backgroundColor = [UIColor yellowColor];
}


- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.labelCollection) {
        if ([label.backgroundColor isEqual:[UIColor redColor]]) {
            [label rollDice];
        }
    }
}


-(void)dieDelegation:(id)die {
    DieLabel *label = die;
    label.backgroundColor = [UIColor lightGrayColor];
    [self updateScore];
}

-(void)updateScore {
    self.selectedCount = 0;
    self.roundScore = 0;

    for (DieLabel *label in self.labelCollection) {
        if ([label.text isEqualToString:@"1"] && label.backgroundColor == [UIColor lightGrayColor]) {
            self.roundScore = self.roundScore + 100;
        } else if ([label.text isEqualToString:@"5"] && label.backgroundColor == [UIColor lightGrayColor]) {
            self.roundScore = self.roundScore + 50;
        }
    }
    if (self.playerOneScoring) {
        self.userScore.text = [NSString stringWithFormat:@"P1 Score: %i", self.roundScore + self.playerOneScore];
    } else {
        self.userTwoScore.text = [NSString stringWithFormat:@"P2 Score: %i", self.roundScore + self.playerTwoScore];
    }
    [self allSelected];
}


// Method just determines if all labels are selected, then changes them back to red and switches the scoring player
-(void)allSelected {
    for (DieLabel *label in self.labelCollection) {
        if (label.backgroundColor == [UIColor lightGrayColor]) {
            self.selectedCount = self.selectedCount + 1;
        }
        if (self.selectedCount == 6) {
            if (self.playerOneScoring) {
                self.playerOneScore = self.roundScore + self.playerOneScore;
                self.playerLabel.text = @"Player 2 is up";
                self.view.backgroundColor = [UIColor greenColor];
            } else {
                self.playerTwoScore = self.roundScore + self.playerTwoScore;
                self.playerLabel.text = @"Player 1 is up";
                self.view.backgroundColor = [UIColor yellowColor];
            }
            self.playerOneScoring = !self.playerOneScoring;
            for (DieLabel *label in self.labelCollection) {
                label.backgroundColor = [UIColor redColor];
                [label rollDice];
            }
        }
    }
}

//-(void)determineWinner {
//
//}

// Need to enable and disable the roll button until they select one label

// Need to display whose turn it is

@end
