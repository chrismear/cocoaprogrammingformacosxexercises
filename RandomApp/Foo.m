//
//  Foo.m
//  RandomApp
//
//  Created by Chris Mear on 04/02/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "Foo.h"

@implementation Foo

- (void)awakeFromNib
{
	NSCalendarDate *now;
	now = [NSCalendarDate calendarDate];
	[textField setObjectValue:now];
}

- (IBAction)generate:(id)sender
{
	int generated;
	generated = (random() % 100) + 1;
	NSLog(@"generated = %d", generated);
	[textField setIntValue:generated];
}

- (IBAction)seed:(id)sender
{
	srandom(time(NULL));
	[textField setStringValue:@"Generator seeded"];
}

@end
