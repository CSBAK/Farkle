//
//  DieLabel.m
//  Farkle
//
//  Created by Brittany Kimbrough on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DieLabel.h"
#include <stdlib.h>

@implementation DieLabel

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped)];

        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)labelTapped {
    [self.delegate dieDelegation:self];
}

-(void)rollDice {
    int randomNum = arc4random_uniform(6) + 1;
    self.text = [NSString stringWithFormat:@"%i", randomNum];
}

@end
