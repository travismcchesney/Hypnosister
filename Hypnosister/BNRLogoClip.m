//
//  BNRLogoClip.m
//  Hypnosister
//
//  Created by Travis McChesney on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BNRLogoClip.h"

@implementation BNRLogoClip

@synthesize image;

- (id)init
{
    [self setImage:[[UIImage alloc] initWithContentsOfFile:@"/Users/travis/Downloads/Solutions/00. Resources/Icon.png"]];
    
    CGRect rect = CGRectMake(10.0, 10.0, image.size.width+20, image.size.height+20);
    
    self = [super initWithFrame:rect];
    
    if (self){
        // All HypnosisViews start with a clear background color
        [self setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self){
        // All HypnosisViews start with a clear background color
        [self setBackgroundColor:[UIColor clearColor]];
        [self setImage:[[UIImage alloc] initWithContentsOfFile:@"/Users/travis/Downloads/Solutions/00. Resources/Icon.png"]];
    }
    return self;
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    CGPoint imageCenter = center;
    imageCenter.x -= image.size.width / 2.0;
    imageCenter.y -= image.size.height / 2.0;
    
    // The radius of the circle should be nearly as big as the image
    float maxRadius = image.size.width / 2.0;

    CGContextSaveGState(ctx);
    
    // Add a path to the context for clipping
    CGContextAddArc(ctx, center.x, center.y,
                    maxRadius, 0.0, M_PI * 2, YES);
    
    CGContextClip(ctx);

    // Perform drawing instruction; removes path
    CGContextStrokePath(ctx);
    
    [image drawAtPoint:imageCenter];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB ();
    CGFloat locations[2] = { 0.0, 1.0 };
    NSArray *colors = [NSMutableArray arrayWithObjects:(id)[[UIColor blueColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint topCenter = CGPointMake(CGRectGetMidX(bounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    CGContextDrawLinearGradient(ctx, gradient, topCenter, midCenter, 0);
    
    CGContextRestoreGState(ctx);

    // The thickness of the line should be 1 point wide
    CGContextSetLineWidth(ctx, 1);
    
    [[UIColor blackColor] setStroke];
    
    // Add a path to the context for clipping
    CGContextAddArc(ctx, center.x, center.y,
                    maxRadius, 0.0, M_PI * 2, YES);
    
    CGSize offset = CGSizeMake(1, 1);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
            CGContextStrokePath(ctx);
}

@end
