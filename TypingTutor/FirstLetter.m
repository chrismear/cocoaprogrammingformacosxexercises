//
//  FirstLetter.m
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "FirstLetter.h"


@implementation NSString (FirstLetter)

- (NSString *)BNR_firstLetter
{
	if ([self length] < 2) {
		return self;
	}
	NSRange r;
	r.location = 0;
	r.length = 1;
	return [self substringWithRange:r];
}

@end
