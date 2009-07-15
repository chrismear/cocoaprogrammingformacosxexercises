//
//  PolynomialView.m
//  Polynomials
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "PolynomialView.h"
#import "Polynomial.h"
#import <QuartzCore/QuartzCore.h>

#define MARGIN (10)

@implementation PolynomialView

- (id)initWithFrame:(NSRect)frame {
	[super initWithFrame:frame];
	polynomials = [[NSMutableArray alloc] init];
	blasted = NO;
	return self;
}

- (NSPoint)randomOffViewPosition
{
	NSRect bounds = [self bounds];
	float radius = hypot(bounds.size.width, bounds.size.height);
	
	float angle = 2.0 * M_PI * (random() % 360 / 360.0);
	NSPoint p;
	p.x = radius * cos(angle);
	p.y = radius * sin(angle);
	return p;
}

- (IBAction)blastem:(id)sender
{
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:3.0];
	NSArray *polynomialLayers = [[self layer] sublayers];
	
	for (CALayer *layer in polynomialLayers) {
		CGPoint p;
		if (blasted) {
			p = CGPointMake(MARGIN,MARGIN);
		} else {
			NSPoint r = [self randomOffViewPosition];
			// Convert from NSPoint to CGPoint
			p = *(CGPoint *)&r;
		}
		[layer setPosition:p];
	}
	[NSAnimationContext endGrouping];
	blasted = !blasted;
}

- (IBAction)createNewPolynomial:(id)sender
{
	Polynomial *p = [[Polynomial alloc] init];
	[polynomials addObject:p];
	
	CALayer *layer = [CALayer layer];
	CGRect b = [[self layer] bounds];
	b = CGRectInset(b, MARGIN, MARGIN);
	[layer setAnchorPoint:CGPointMake(0,0)];
	[layer setFrame:b];
	[layer setCornerRadius:12];
	[layer setBorderColor:[p color]];
	[layer setBorderWidth:3.5];
	
	[layer setDelegate:p];
	
	[[self layer] addSublayer:layer];
	
	[layer display];
	
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
	[anim setFromValue:[NSValue valueWithPoint:[self randomOffViewPosition]]];
	[anim setToValue:[NSValue valueWithPoint:NSMakePoint(MARGIN,MARGIN)]];
	[anim setDuration:1.0];
	CAMediaTimingFunction *f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[anim setTimingFunction:f];
	
	[layer addAnimation:anim forKey:@"whatever"];
}

- (IBAction)deleteRandomPolynomial:(id)sender
{
	NSArray *polynomialLayers = [[self layer] sublayers];
	
	if ([polynomialLayers count] == 0) {
		NSBeep();
		return;
	}
	int i = random() % [polynomialLayers count];
	CALayer *layerToPull = [polynomialLayers objectAtIndex:i];
	
	NSPoint randPoint = [self randomOffViewPosition];
	
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
	
	[anim setValue:layerToPull forKey:@"representedPolynomialLayer"];
	[anim setFromValue:[NSValue valueWithPoint:NSMakePoint(MARGIN,MARGIN)]];
	[anim setToValue:[NSValue valueWithPoint:randPoint]];
	[anim setDuration:1.0];
	CAMediaTimingFunction *f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[anim setTimingFunction:f];
	
	[anim setDelegate:self];
	[layerToPull addAnimation:anim forKey:@"whatever"];
	
	[layerToPull setPosition:CGPointMake(randPoint.x, randPoint.y)];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	CALayer *layerToPull = [anim valueForKey:@"representedPolynomialLayer"];
	Polynomial *p = [layerToPull delegate];
	[polynomials removeObjectIdenticalTo:p];
	[layerToPull removeFromSuperlayer];
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect:bounds];
}

- (void)resizeAndRedrawPolynomialLayers
{
	NSLog(@"redrawing polynomials");
	
	CGRect b = [[self layer] bounds];
	b = CGRectInset(b, MARGIN, MARGIN);
	
	NSArray *polynomialLayers = [[self layer] sublayers];
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:0];
	for (CALayer *layer in polynomialLayers) {
		b.origin = [layer frame].origin;
		[layer setFrame:b];
		[layer setNeedsDisplay];
	}
	[NSAnimationContext endGrouping];
}

- (void)setFrameSize:(NSSize)newSize;
{
	[super setFrameSize:newSize];
	NSLog(@"resizing");
	if (![self inLiveResize]) {
		[self resizeAndRedrawPolynomialLayers];
	}
}

- (void)viewDidEndLiveResize
{
	NSLog(@"ending resize");
	[self resizeAndRedrawPolynomialLayers];
}

@end
