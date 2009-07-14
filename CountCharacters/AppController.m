//
//  AppController.m
//  CountCharacters
//
//  Created by Chris Mear on 14/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (IBAction)performCount:(id)sender
{
	NSString *string = [inputField stringValue];
	int length = [string length];
	NSString *outputString = [NSString stringWithFormat:@"\"%@\" has %i characters.", string, length];
	[resultField setStringValue:outputString];
}

@end
