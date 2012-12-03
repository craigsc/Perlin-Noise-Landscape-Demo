//
//  LandScape.m
//  LandScapeTest
//
//  Created by Craig Campbell on 4/27/09.
//  Copyright 2009 Georgia Institute of Technology. All rights reserved.
//

#import "LandScape.h"


@implementation LandScape
@synthesize yincrease;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib{
	//double ran = arc4random()%10000;
	self.backgroundColor = [UIColor blackColor];
	[self setNeedsDisplay];
	[NSTimer scheduledTimerWithTimeInterval: .03 target:self selector:@selector(loop) userInfo:nil repeats:YES];
}

-(void) loop{
	[self setNeedsDisplay];
	yincrease += .2;
}

-(double)noise:(int)x{
	x = (x<<13) ^ x;
	return (double)( 1.000 - ( (x * (x * x * 15731 + 789221) +
						1376312589) & 0x7FFFFFFF) / 1073741824.0);
}
-(double)noise2:(int)x with:(int)y{
	int n = x+y * 57;
	n = (n<<13) ^ n;
	return (double)( 1.000 - ( (n * (n * n * 15731 + 789221) +
								1376312589) & 0x7FFFFFFF) / 1073741824.0);
}

-(double) smoothedNoise:(int)x{
	return [self noise:x]/2.0  +  [self noise:(x-1)]/4.0  +  [self noise:(x+1)]/4.0;
}

-(double) smoothedNoise2:(int)x withY:(int)y{
	double corners = ([self noise2:x-1 with:y-1] + [self noise2:x+1 with:y-1]+
					  [self noise2:x-1 with:y+1]+[self noise2:x+1 with:y+1]) / 16.0;
    double sides   = ([self noise2: x-1 with:y] + [self noise2:x+1 with:y] + 
					  [self noise2:x with:y-1] + [self noise2:x with:y+1]) /  8.0;
    double center  =  [self noise2:x with:y] / 4.0;
    return corners + sides + center;
}
-(double) interpolate:(double)a with:(double)b with:(double)x{
	return  a*(1-x) + b*x;
}

-(double) interpolatedNoise:(double)x{
	int floorx = (int)x;
	double v1 = [self smoothedNoise: floorx];
	double v2 = [self smoothedNoise: floorx+1];
	return [self interpolate:v1 with:v2 with:x-floorx];
}

-(double) interpolatedNoise2:(double)x with:(double)y{
	int floorx = (int)x;
	int floory = (int)y;
	
	double v1 = [self smoothedNoise2:floorx withY:floory];
	double v2 = [self smoothedNoise2:floorx+1 withY:floory];
	
	double v3 = [self smoothedNoise2:floorx withY:floory+1];
	double v4 = [self smoothedNoise2:floorx+1 withY:floory+1];
	
	v1 = [self interpolate:v1 with:v2 with:x-floorx];
	v2 = [self interpolate:v3 with:v4 with:x-floorx];
	return [self interpolate:v1 with:v2 with:y-floory];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);

	[[UIColor blackColor] setFill];
	[[UIColor greenColor] setStroke];
	for(int k=50; k>=0; k--){
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, -100, 330);
		for(int i=-100; i<480;i+=1){
			CGContextAddLineToPoint(context, i, 270-([self interpolatedNoise2:(.015*i) with:(.1*k+yincrease)]*300));
		}
		CGContextAddLineToPoint(context, 1000, 330);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);		
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
