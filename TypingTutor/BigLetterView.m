//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "BigLetterView.h"
#import "FirstLetter.h"


@implementation BigLetterView

- (void)prepareAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	[attributes setObject:[NSFont fontWithName:@"Helvetica" size:75]
				   forKey:NSFontAttributeName];
	[attributes setObject:[NSColor redColor]
				   forKey:NSForegroundColorAttributeName];
	
	NSShadow *shadow = [[NSShadow alloc] init];
	[shadow setShadowOffset:NSMakeSize(3.0, -3.0)];
	[shadow setShadowBlurRadius:3.0];
	[shadow setShadowColor:[NSColor blackColor]];
	[attributes setObject:shadow
				   forKey:NSShadowAttributeName];
	[shadow release];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		NSLog(@"initializing view");
		[self prepareAttributes];
		bgColor = [[NSColor yellowColor] retain];
		string = @" ";
		[self registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];
    }
    return self;
}

- (void)dealloc
{
	[bgColor release];
	[string release];
	[attributes release];
	[super dealloc];
}

#pragma mark Accessors

- (void)setBgColor:(NSColor *)c
{
	[c retain];
	[bgColor release];
	bgColor = c;
	[self setNeedsDisplay:YES];
}

- (NSColor *)bgColor
{
	return bgColor;
}

- (void)setString:(NSString *)c
{
	c = [c copy];
	[string release];
	string = c;
	NSLog(@"The string is now %@", string);
	[self setNeedsDisplay:YES];
}

- (NSString *)string
{
	return string;
}


#pragma mark Drawing

- (void)drawStringCenteredIn:(NSRect)r
{
	NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
	strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
	[string drawAtPoint:strOrigin withAttributes:attributes];
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	// Draw gradient background if highlighted
	if (highlighted) {
		NSGradient *gr;
		gr = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor] endingColor:bgColor];
		[gr drawInRect:bounds relativeCenterPosition:NSZeroPoint];
		[gr release];
	} else {
		[bgColor set];
		[NSBezierPath fillRect:bounds];
	}
	[self drawStringCenteredIn:bounds];
	
	// Am I the window's first responder?
	if (([[self window] firstResponder] == self) && [NSGraphicsContext currentContextDrawingToScreen]) {
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
}

- (BOOL)isOpaque
{
	return YES;
}

#pragma mark ResponderChain

- (BOOL)acceptsFirstResponder
{
	NSLog(@"Accepting");
	return YES;
}

- (BOOL)resignFirstResponder
{
	NSLog(@"Resigning");
	[self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
	return YES;
}

- (BOOL)becomeFirstResponder
{
	NSLog(@"Becoming");
	[self setNeedsDisplay:YES];
	return YES;
}

#pragma mark KeyEvents

- (void)keyDown:(NSEvent *)event
{
	[self interpretKeyEvents:[NSArray arrayWithObject:event]];
}

- (void)insertText:(NSString *)input{
	// Set string to be what the user typed
	[self setString:input];
}

- (void)insertTab:(id)sender
{
	[[self window] selectKeyViewFollowingView:self];
}

- (void)insertBacktab:(id)sender
{
	[[self window] selectKeyViewPrecedingView:self];
}

- (void)deleteBackward:(id)sender
{
	[self setString:@" "];
}

#pragma mark PDF

- (IBAction)savePDF:(id)sender
{
	NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setRequiredFileType:@"pdf"];
	[panel beginSheetForDirectory:nil
							 file:nil
				   modalForWindow:[self window]
					modalDelegate:self
				   didEndSelector:@selector(didEnd:returnCode:contextInfo:)
					  contextInfo:NULL];
}

- (void)didEnd:(NSSavePanel *)sheet
	returnCode:(int)code
   contextInfo:(void *)contextInfo
{
	if (code != NSOKButton) {
		return;
	}
	
	NSRect r = [self bounds];
	NSData *data = [self dataWithPDFInsideRect:r];
	NSString *path = [sheet filename];
	NSError *error;
	BOOL successful = [data writeToFile:path
								options:0
								  error:&error];
	if (!successful) {
		NSAlert *a = [NSAlert alertWithError:error];
		[a runModal];
	}
}


#pragma mark Pasteboard

- (void)writeToPasteboard:(NSPasteboard *)pb
{
	// Declare types
	[pb declareTypes:[NSArray arrayWithObjects:NSStringPboardType, NSPDFPboardType, nil]
			   owner:self];
	
	// Copy string data to the pasteboard
	[pb setString:string forType:NSStringPboardType];
	
	// Copy PDF data to the pasteboard
	NSRect bounds = [self bounds];
	NSData *pdfData = [self dataWithPDFInsideRect:bounds];
	[pb setData:pdfData forType:NSPDFPboardType];
}

- (BOOL)readFromPasteboard:(NSPasteboard *)pb
{
	// Is there a string on the pasteboard?
	NSArray *types = [pb types];
	if ([types containsObject:NSStringPboardType]) {
		// Read the string from the pasteboard
		NSString *value = [pb stringForType:NSStringPboardType];
		
		[self setString:[value BNR_firstLetter]];
		return YES;
	}
	return NO;
}

- (IBAction)cut:(id)sender
{
	[self copy:sender];
	[self setString:@""];
}

- (IBAction)copy:(id)sender
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[self writeToPasteboard:pb];
}

- (IBAction)paste:(id)sender;
{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	if(![self readFromPasteboard:pb]) {
		NSBeep();
	}
}

#pragma mark DragAndDrop

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
	return NSDragOperationCopy | NSDragOperationDelete;
}

- (void)mouseDown:(NSEvent *)event
{
	[event retain];
	[mouseDownEvent release];
	mouseDownEvent = event;
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint down = [mouseDownEvent locationInWindow];
	NSPoint drag = [event locationInWindow];
	float distance = hypot(down.x - drag.x, down.y - drag.y);
	if (distance < 3) {
		return;
	}
	
	// Is the string of zero-length?
	if ([string length] == 0) {
		return;
	}
	
	// Get the size of the string
	NSSize s = [string sizeWithAttributes:attributes];
	
	// Create the image that will be dragged
	NSImage *anImage = [[NSImage alloc] initWithSize:s];
	
	// Create a rect in which you will draw the letter image
	NSRect imageBounds;
	imageBounds.origin = NSZeroPoint;
	imageBounds.size = s;
	
	// Draw the letter on the image
	[anImage lockFocus];
	[self drawStringCenteredIn:imageBounds];
	[anImage unlockFocus];
	
	// Get the location of the mouseDown event
	NSPoint p = [self convertPoint:down fromView:nil];
	
	// Drag from the center of the image
	p.x = p.x - s.width/2;
	p.y = p.y - s.height/2;
	
	// Get the pasteboard
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
	
	// Put the string on the pasteboard
	[self writeToPasteboard:pb];
	
	// Start the drag
	[self dragImage:anImage at:p offset:NSMakeSize(0, 0) event:mouseDownEvent pasteboard:pb source:self slideBack:YES];
	[anImage release];
}

- (void)draggedImage:(NSImage *)image
			 endedAt:(NSPoint)screenPoint
		   operation:(NSDragOperation)operation
{
	if (operation == NSDragOperationDelete) {
		[self setString:@""];
	}
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	NSLog(@"draggingEntered:");
	if ([sender draggingSource] == self) {
		return NSDragOperationNone;
	}
	
	highlighted = YES;
	[self setNeedsDisplay:YES];
	return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	NSLog(@"draggingExited:");
	highlighted = NO;
	[self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
	return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard *pb = [sender draggingPasteboard];
	if(![self readFromPasteboard:pb]) {
		NSLog(@"Error: Could not read from dragging pasteboard");
		return NO;
	}
	return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
	NSLog(@"concludeDragOperation:");
	highlighted = NO;
	[self setNeedsDisplay:YES];
}

@end

