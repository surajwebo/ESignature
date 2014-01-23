//
//  ViewController.m
//  ESignature
//
//  Created by Suraj on 23/01/14.
//  Copyright (c) 2014 Suraj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	drawImage = [[UIImageView alloc] initWithImage:nil];
	drawImage.frame = self.view.frame;
	[self.view addSubview:drawImage];
	self.view.backgroundColor = [UIColor lightGrayColor];
	mouseMoved = 0;
    
    btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnDone setFrame:CGRectMake(0, 0, 320, 30)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(captureSignature:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
		return;
	}
    
	lastPoint = [touch locationInView:self.view];
	lastPoint.y -= 20;
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20;
	
	
	UIGraphicsBeginImageContext(self.view.frame.size);
	[drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
    
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
		return;
	}
	
	if(!mouseSwiped) {
		UIGraphicsBeginImageContext(self.view.frame.size);
		[drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)captureSignature:(id)sender {
    //Convert UIImage to NSData
    NSData *dataFromSignature = UIImageJPEGRepresentation(drawImage.image,1.0);
    // This NSdata can be sent to API call
    
    // Set ImageView to nil
    drawImage.image = nil;
    [[[UIAlertView alloc] initWithTitle:@"Thank you" message:@"ESignature captured successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
