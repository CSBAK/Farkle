//
//  ViewController.m
//  Farkle
//
//  Created by Brittany Kimbrough on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieDelegation, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labelCollection;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *userTwoScore;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property UIDynamicAnimator *dynamicAnimator;
@property BOOL areButtonsFanned;

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
        label.layer.cornerRadius = label.bounds.size.width / 10;
        label.layer.masksToBounds = YES;
        label.dieSelected = NO;
        label.userInteractionEnabled = YES;
        [label rollDice];
    }
    self.rollButton.layer.cornerRadius = self.rollButton.bounds.size.width / 10;
    self.rollButton.layer.borderWidth = 1.0;
    self.rollButton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.playerOneScoring = YES;
    self.playerLabel.layer.cornerRadius = self.playerLabel.bounds.size.width / 10;
    self.playerLabel.layer.masksToBounds = YES;
    self.playerLabel.layer.borderWidth = 1.0;
    self.playerLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    self.imageView.image = [UIImage imageNamed:@"dark_green_felt"];
    self.playerLabel.backgroundColor = [UIColor greenColor];
    // Gesture stuff
//    [self.rollButton addTarget:self action:@selector(fanButtons:) forControlEvents:UIControlEventTouchUpInside];
//    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//    self.areButtonsFanned = NO;
}


- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.labelCollection) {
        if (!label.dieSelected) {
            [label rollDice];
        }
    }
    self.rollButton.enabled = NO;
}

// Tapping on die labels
-(void)dieDelegation:(id)die {
    DieLabel *label = die;
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"DieValue%@Reverse",label.text]];
    label.backgroundColor = [UIColor colorWithPatternImage:img];
    label.dieSelected = YES;
    self.rollButton.enabled = YES;
//    [self.rollButton setTitle:@"Gather Dice" forState:UIControlStateDisabled];
//    [self.rollButton setTitle:@"Roll" forState:UIControlStateNormal];
    [self updateScore];
}

-(void)updateScore {
    self.selectedCount = 0;
    self.roundScore = 0;
    for (DieLabel *label in self.labelCollection) {
        if ([label.text isEqualToString:@"1"] && label.dieSelected) {
            self.roundScore = self.roundScore + 100;
        } else if ([label.text isEqualToString:@"5"] && label.dieSelected) {
            self.roundScore = self.roundScore + 50;
        }
    }
    if (self.playerOneScoring) {
        self.userScore.text = [NSString stringWithFormat:@"P1 Score: %i", self.roundScore + self.playerOneScore];
    } else {
        self.userTwoScore.text = [NSString stringWithFormat:@"P2 Score: %i", self.roundScore + self.playerTwoScore];
    }
    [self allSelected];
    [self checkForWinner];
}

-(void)checkForWinner {
    UIAlertView *alert = [UIAlertView new];
    [alert addButtonWithTitle:@"New Game"];
    alert.delegate = self;
    if (self.playerOneScore >= 5000) {
        alert.title = @"Player One Wins!";
        [alert show];
    } else if (self.playerTwoScore >= 5000) {
        alert.title = @"Player Two Wins!";
        [alert show];
    }
}

// Starts new game at alert view button pressed
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        self.userScore.text = [NSString stringWithFormat:@"P1 Score: 0"];
        self.userTwoScore.text = [NSString stringWithFormat:@"P2 Score: 0"];
        self.playerOneScore = 0;
        self.playerTwoScore = 0;
    }
}

// Method just determines if all labels are selected. If so, dice are rolled and switches the scoring player
-(void)allSelected {
    for (DieLabel *label in self.labelCollection) {
        if (label.dieSelected) {
            self.selectedCount = self.selectedCount + 1;
        }
        if (self.selectedCount == 6) {
            if (self.playerOneScoring) {
                self.playerOneScore = self.roundScore + self.playerOneScore;
                self.playerLabel.text = @"Player 2 is up";
                self.imageView.image = [UIImage imageNamed:@"blue_felt"];
                self.playerLabel.backgroundColor = [UIColor blueColor];
                self.playerLabel.textColor = [UIColor whiteColor];
            } else {
                self.playerTwoScore = self.roundScore + self.playerTwoScore;
                self.playerLabel.text = @"Player 1 is up";
                self.imageView.image = [UIImage imageNamed:@"dark_green_felt"];
                self.playerLabel.backgroundColor = [UIColor greenColor];
                self.playerLabel.textColor = [UIColor blackColor];
            }
            self.playerOneScoring = !self.playerOneScoring;
            for (DieLabel *label in self.labelCollection) {
                label.dieSelected = NO;
                [label rollDice];
            }
            self.rollButton.enabled = NO;
        }
    }
}

// /////////////////////////////////// Gestures //////////////////////////////////////////////////


//-(void)fanButtons:(id)sender {
//    [self.dynamicAnimator removeAllBehaviors];
//    if (self.areButtonsFanned) {
//        [self fanIn];
//    } else {
//        [self fanOut];
//    }
//    self.areButtonsFanned = !self.areButtonsFanned;
//}
//
//-(void)fanOut {
//    CGPoint point;
//    UISnapBehavior *snapBehavior;
//
//    point = CGPointMake(self.rollButton.frame.origin.x - 50, self.rollButton.frame.origin.y + 20);
//    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.rollButton snapToPoint:point];
//    //                                              (supposed to be label)
//    [self.dynamicAnimator addBehavior:snapBehavior];
//}
//
//-(void)fanIn {
//    UISnapBehavior *snapBehavior;
//    //                                               (supposed to be label)
//    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.rollButton snapToPoint:self.rollButton.center];
//    [self.dynamicAnimator addBehavior:snapBehavior];
//}
//
@end
