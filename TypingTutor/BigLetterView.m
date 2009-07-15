//
//  BigLetterView.m
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "BigLetterView.h"


@implementation BigLetterView

- (NSFont *)font
{
	NSFont *font = [NSFont fontWithName:@"Helvetica" size:75];
	if (bold || italic) {
		NSFontManager *fontManager = [NSFontManager sharedFontManager];
		if (bold) {
			NSLog(@"adding bold to font");
			NSFont *newFont = [fontManager convertFont:font toHaveTrait:NSBoldFontMask];
			font = newFont;
		}
		if (italic) {
			NSLog(@"adding italic to font");
			NSFont *newFont = [fontManager convertFont:font toHaveTrait:NSItalicFontMask];
			font = newFont;
		}
	}
	return font;
}

- (void)prepareAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	[attributes setObject:[self font]
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

- (void)setBold:(BOOL)newBold
{
	NSLog(@"setting bold");
	bold = newBold;
	[self setNeedsDisplay:YES];
}

- (BOOL)bold
{
	return bold;
}

- (void)setItalic:(BOOL)newItalic
{
	NSLog(@"setting italic");
	italic = newItalic;
	[self setNeedsDisplay:YES];
}

- (BOOL)italic
{
	return italic;
}

#pragma mark Drawing

- (void)drawStringCenteredIn:(NSRect)r
{
	[self prepareAttributes];
	NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
	strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
	[string drawAtPoint:strOrigin withAttributes:attributes];
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	[bgColor set];
	[NSBezierPath fillRect:bounds];
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

#pragma mark FormattingButtons

- (IBAction)boldButtonChanged:(id)sender
{
	NSLog(@"bold changed");
	if ([boldButton state] == NSOnState) {
		[self setBold:YES];
	} else {
		[self setBold:NO];
	}
}

- (IBAction)italicButtonChanged:(id)sender
{
	NSLog(@"italic changed");
	if ([italicButton state] == NSOnState) {
		[self setItalic:YES];
	} else {
		[self setItalic:NO];
	}	
}


#pragma mark Pasteboard

- (void)writeToPasteboard:(NSPasteboard *)pb
{
	// Declare types
	[pb declareTypes:[NSArray arrayWithObject:NSStringPboardType]
			   owner:self];
	
	// Copy data to the pasteboard
	[pb setString:string forType:NSStringPboardType];
}

- (BOOL)readFromPasteboard:(NSPasteboard *)pb
{
	// Is there a string on the pasteboard?
	NSArray *types = [pb types];
	if ([types containsObject:NSStringPboardType]) {
		// Read the string from the pasteboard
		NSString *value = [pb stringForType:NSStringPboardType];
		
		// Our view can handle only one letter
		if ([value length] == 1) {
			[self setString:value];
			return YES;
		}
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
@end

