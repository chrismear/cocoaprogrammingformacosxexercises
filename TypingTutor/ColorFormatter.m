//
//  ColorFormatter.m
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "ColorFormatter.h"

@interface ColorFormatter ()
- (NSString *)firstColorKeyForPartialString:(NSString *)string;
@end

@implementation ColorFormatter

- (id)init
{
	[super init];
	colorList = [[NSColorList colorListNamed:@"Apple"] retain];
	return self;
}

- (void)dealloc
{
	[colorList release];
	[super dealloc];
}

- (NSString *)firstColorKeyForPartialString:(NSString *)string
{
	if ([string length] == 0) {
		return nil;
	}
	
	for (NSString *key in [colorList allKeys]) {
		NSRange whereFound = [key rangeOfString:string
										options:NSCaseInsensitiveSearch];
		if ((whereFound.location == 0) && (whereFound.length > 0)) {
			return key;
		}
	}
	return nil;
}

- (NSString *)stringForObjectValue:(id)obj
{
	if (![obj isKindOfClass:[NSColor class]]) {
		return nil;
	}
	
	NSColor *color;
	color = [obj colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	
	CGFloat red, green, blue;
	[color getRed:&red
			green:&green
			 blue:&blue
			alpha:NULL];
	
	float minDistance = 3.0;
	NSString *closestKey = nil;
	
	for (NSString *key in [colorList allKeys]) {
		NSColor *c = [colorList colorWithKey:key];
		CGFloat r, g, b;
		[c getRed:&r
			green:&g
			 blue:&b
			alpha:NULL];
		
		float dist;
		dist = pow(red - r, 2) + pow(green - g, 2) + pow(blue - b, 2);
		if (dist < minDistance) {
			minDistance = dist;
			closestKey = key;
		}
	}
	return closestKey;
}

- (BOOL)getObjectValue:(id *)obj
			 forString:(NSString *)string
	  errorDescription:(NSString **)errorString
{
	NSString *matchingKey = [self firstColorKeyForPartialString:string];
	if (matchingKey) {
		*obj = [colorList colorWithKey:matchingKey];
		return YES;
	} else {
		if (errorString != NULL) {
			*errorString = [NSString stringWithFormat:@"'%@' is not a color", string];
		}
		return NO;
	}
}

//- (BOOL)isPartialStringValid:(NSString *)partial
//			newEditingString:(NSString **)newString
//			errorDescription:(NSString **)error
//{
//	if ([partial length] == 0) {
//		return YES;
//	}
//	NSString *match = [self firstColorKeyForPartialString:partial];
//	if (match) {
//		return YES;
//	} else {
//		if (error) {
//			*error = @"No such color";
//		}
//		return NO;
//	}
//}

- (BOOL)isPartialStringValid:(NSString **)partial
	   proposedSelectedRange:(NSRange *)selPtr
			  originalString:(NSString *)origString
	   originalSelectedRange:(NSRange)origSel
			errorDescription:(NSString **)error
{
	if ([*partial length] == 0) {
		return YES;
	}
	NSString *match = [self firstColorKeyForPartialString:*partial];
	if (!match) {
		return NO;
	}
	if (origSel.location == selPtr->location) {
		return YES;
	}
	if ([match length] != [*partial length]) {
		selPtr->location = [*partial length];
		selPtr->length = [match length] - selPtr->location;
		*partial = match;
		return NO;
	}
	return YES;
}

@end
