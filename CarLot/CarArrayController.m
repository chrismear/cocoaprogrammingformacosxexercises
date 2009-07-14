//
//  CarArrayController.m
//  CarLot
//
//  Created by Chris Mear on 05/06/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "CarArrayController.h"


@implementation CarArrayController

- (id)newObject
{
	id newObj = [super newObject];
	NSDate *now = [NSDate date];
	[newObj setValue:now forKey:@"datePurchased"];
	return newObj;
}

@end
