//
//  ViewController.h
//  ESignature
//
//  Created by Suraj on 23/01/14.
//  Copyright (c) 2014 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CGPoint lastPoint;
	UIImageView *drawImage;
	BOOL mouseSwiped;
	int mouseMoved;
    UIButton *btnDone;
}

@end
