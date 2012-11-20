//
//  LSViewController.h
//  LinguSample
//
//  Created by Florian Heller on 10/25/11.
//  Copyright (c) 2011 RWTH Aachen University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSViewController : UIViewController <UITextViewDelegate>


@property (strong) IBOutlet UITextView *mainTextView;
@property (strong) IBOutlet UISegmentedControl *typeSelector;

- (IBAction)doneEditing:(id)sender;
- (void)segmentedControlSelectionChanged:(id)sender;
@end
