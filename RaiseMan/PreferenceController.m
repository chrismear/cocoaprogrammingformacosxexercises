//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Chris Mear on 05/06/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "PreferenceController.h"

NSString * const BNRTableBgColorKey = @"TableBackgroundColor";
NSString * const BNREmptyDocKey = @"EmptyDocumentFlag";
NSString * const BNRColorChangedNotification = @"BNRColorChanged";

@implementation PreferenceController

- (id)init
{
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	return self;
}

- (NSColor *)tableBgColor
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *colorAsData = [defaults	objectForKey:BNRTableBgColorKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

- (BOOL)emptyDoc
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:BNREmptyDocKey];
}

- (void)windowDidLoad
{
	[colorWell setColor:[self tableBgColor]];
	[checkbox setState:[self emptyDoc]];
}

- (IBAction)changeBackgroundColor:(id)sender
{
	NSColor *color = [colorWell color];
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:colorAsData forKey:BNRTableBgColorKey];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	NSLog(@"Sending notification");
	NSDictionary *d = [NSDictionary dictionaryWithObject:color
												  forKey:@"color"];
	[nc postNotificationName:BNRColorChangedNotification
					  object:self
					userInfo:d];
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkbox state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state forKey:BNREmptyDocKey];
}

- (IBAction)resetToDefaults:(id)sender
{
	// Remove the user's defaults
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:BNRTableBgColorKey];
	[defaults removeObjectForKey:BNREmptyDocKey];
	
	// Reflect the new settings in the Preferences panel controls
	[colorWell setColor:[self tableBgColor]];
	[checkbox setState:[self emptyDoc]];
}

@end
