//
//  AppController.m
//  DoubleTall
//
//  Created by Chris Mear on 14/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (NSSize)windowWillResize:(NSWindow *)sender
					toSize:(NSSize)frameSize
{
	NSSize newSize;
	newSize.width = frameSize.width;
	newSize.height = frameSize.width * 2.0;
	return newSize;
}
@end
