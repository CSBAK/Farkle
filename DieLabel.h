//
//  DieLabel.h
//  Farkle
//
//  Created by Brittany Kimbrough on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DieLabel;

////////////////
@protocol DieDelegation <NSObject>

-(void)dieDelegation:(id)die;

//-(void)anotherMethod;

@end

//////////////// gets implemented in THIS class's .m file
@interface DieLabel : UILabel

@property (nonatomic, assign) id <DieDelegation> delegate;

-(void)rollDice;

@end
