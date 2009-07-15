//
//  AppController.m
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "AppController.h"
#import "BigLetterView.h"

#define MAX_COUNT (100)

@implementation AppController

- (id)init
{
	[super init];
	
	// Create an array of letters
	letters = [[NSArray alloc] initWithObjects:@"a", @"s", @"d", @"f", @"j", @"k", @"k", @"l", @";", nil];
	
	// Seed the random number generator
	srandom(time(NULL));
	
	stepSize = 5;
	
	return self;
}

- (void)awakeFromNib
{
	[self showAnotherLetter];
}

- (void)resetCount
{
	[self willChangeValueForKey:@"count"];
	count = 0;
	[self didChangeValueForKey:@"count"];
}

- (void)incrementCount
{
	[self willChangeValueForKey:@"count"];
	count = count + stepSize;
	if (count > MAX_COUNT) {
		count = MAX_COUNT;
	}
	[self didChangeValueForKey:@"count"];
}

- (void)showAnotherLetter
{
	// Choose random numbers until you get a different number than last time
	int x = lastIndex;
	while (x == lastIndex) {
		x = random() % [letters count];
	}
	lastIndex = x;
	[outLetterView setString:[letters objectAtIndex:x]];
	
	// Start the count again
	[self resetCount];
}

- (IBAction)stopGo:(id)sender
{
	if (timer == nil) {
		NSLog(@"starting");
		
		// Create a timer
		timer = [[NSTimer scheduledTimerWithTimeInterval:0.1
												  target:self
												selector:@selector(checkThem)
												userInfo:nil 
												 repeats:YES] retain];
	} else {
		NSLog(@"stopping");
		
		// Invalidate and release the timer
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

- (void)checkThem
{
	if ([[inLetterView string] isEqual:[outLetterView string]]) {
		[self showAnotherLetter];
	}
	if (count == MAX_COUNT) {
		NSBeep();
		[self resetCount];
	} else {
		[self incrementCount];
	}
}

- (IBAction)showSpeedSheet:(id)sender
{
	[NSApp beginSheet:speedSheet
	   modalForWindow:[inLetterView window]
		modalDelegate:nil
	   didEndSelector:NULL
		  contextInfo:NULL];
}

- (IBAction)endSpeedSheet:(id)sender
{
	// Return to normal event handling
	[NSApp endSheet:speedSheet];
	
	// Hide the sheet
	[speedSheet orderOut:sender];
}

- (BOOL)control:(NSControl *)control
	didFailToFormatString:(NSString *)string
         errorDescription:(NSString *)error
{
	NSLog(@"AppController told that formatting of %@ failed: %@", string, error);
	return NO;
}

@end
