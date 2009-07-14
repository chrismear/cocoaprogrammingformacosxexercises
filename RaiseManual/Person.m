//
//  Person.m
//  RaiseManual
//
//  Created by Chris Mear on 16/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "Person.h"


@implementation Person

- (id)init
{
	[super init];
	expectedRaise = 5.0;
	personName = @"New Person";
	return self;
}

- (void)dealloc
{
	[personName release];
	[super dealloc];
}

@synthesize personName;
@synthesize expectedRaise;

@end
