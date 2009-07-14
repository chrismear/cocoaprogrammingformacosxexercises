//
//  LotteryEntry.m
//  lottery
//
//  Created by Chris Mear on 07/02/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "LotteryEntry.h"

@implementation LotteryEntry

- (id)initWithEntryDate:(NSCalendarDate *)theDate
{
	if (![super init])
		return nil;
	
	NSAssert(theDate != nil, @"Argument must be non-nil");
	entryDate = [theDate retain];
	[entryDate setCalendarFormat:@"%a %e %B %Y"];
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
	return self;
}

- (id)init
{
	return [self initWithEntryDate:[NSCalendarDate calendarDate]];
}

- (void)setEntryDate:(NSCalendarDate *)date;
{
	[date retain];
	[entryDate release];
	entryDate = date;
}

- (NSCalendarDate *)entryDate
{
	return entryDate;
}

- (int)firstNumber
{
	return firstNumber;
}

- (int)secondNumber
{
	return secondNumber;
}

- (NSString *)description
{
	NSString *result;
	result = [[NSString alloc] initWithFormat:@"%@ = %d and %d",
			  [entryDate description],
			  firstNumber, secondNumber];
	[result autorelease];
	return result;
}

- (void)dealloc
{
	NSLog(@"deallocing %@", self);
	[entryDate release];
	[super dealloc];
}

@end
