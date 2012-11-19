//
//  LSAppDelegate.h
//  LinguSample
//
//  Created by Florian Heller on 10/25/11.
//  Copyright (c) 2011 RWTH Aachen University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSViewController;

@interface LSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LSViewController *viewController;

@end
