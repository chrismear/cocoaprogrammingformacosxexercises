//
//  AppController.m
//  KVCFun
//
//  Created by Chris Mear on 15/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "AppController.h"


@implementation AppController
- (id)init
{
	[super init];
	[self setValue:[NSNumber numberWithInt:5]
			forKey:@"fido"];
	NSNumber *n = [self valueForKey:@"fido"];
	NSLog(@"fido = %@", n);
	return self;
}

@synthesize fido;

- (IBAction)incrementFido:(id)sender
{
	[self setFido:[self fido] + 1];
}
@end
