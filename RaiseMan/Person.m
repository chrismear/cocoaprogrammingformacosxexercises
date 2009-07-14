//
//  Person.m
//  RaiseMan
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

- (void)setNilValueForKey:(NSString *)key
{
	if ([key isEqual:@"expectedRaise"]) {
		[self setExpectedRaise:0.0];
	} else {
		[super setNilValueForKey:key];
	}
}

- (id)initWithCoder:(NSCoder *)coder
{
	[super init];
	personName = [[coder decodeObjectForKey:@"personName"] retain];
	expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:personName forKey:@"personName"];
	[coder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

@synthesize personName;
@synthesize expectedRaise;

@end
