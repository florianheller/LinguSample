//
//  LSViewController.m
//  LinguSample
//
//  Created by Florian Heller on 10/25/11.
//  Copyright (c) 2011 RWTH Aachen University. All rights reserved.
//

#import "LSViewController.h"

@interface LSViewController () {

}


//Should be one of the schemes defined in NSLinguisticTagger.h
@property (strong, nonatomic) NSString *currentLexicalScheme;

@end

@implementation LSViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Link the UISegmentedControl events to us
	[_typeSelector addTarget:self action:@selector(segmentedControlSelectionChanged:) forControlEvents:UIControlEventValueChanged];
	
	self.mainTextView.text = @"Alice and Bob go out for a walk. In the forest, they meet the little brown squirrel Felix.";
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark - UI event handlers
- (void)segmentedControlSelectionChanged:(id)sender;
{
	switch ([(UISegmentedControl*) sender selectedSegmentIndex]) {
		case 0:
			self.currentLexicalScheme = NSLinguisticTagNoun;
			break;
		case 1:
			self.currentLexicalScheme = NSLinguisticTagVerb;
			break;
		case 2:
			self.currentLexicalScheme = NSLinguisticTagAdjective;
			break;
		default:
			break;
	}
	[self updateLinguisticMarkup];
}

#pragma mark - Linguistic handling
- (void)updateLinguisticMarkup;
{
	NSString *textToAnalyse = self.mainTextView.text;
	
	// This range contains the entire string, since we want to parse it completely
	NSRange stringRange = NSMakeRange(0, textToAnalyse.length);
	
	// Dictionary with a language map
	NSArray *language = [NSArray arrayWithObjects:@"en",@"de",@"fr",nil];
	NSDictionary* languageMap = [NSDictionary dictionaryWithObject:language forKey:@"Latn"];
	
    // Mark the currently selected entities
    NSMutableAttributedString *formattedString = [[NSMutableAttributedString alloc] initWithString:textToAnalyse];
    
	[textToAnalyse enumerateLinguisticTagsInRange:stringRange 
												scheme:NSLinguisticTagSchemeLexicalClass 
											   options:NSLinguisticTaggerOmitWhitespace
										   orthography:[NSOrthography orthographyWithDominantScript:@"Latn" languageMap:languageMap]
											usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                                               if ([tag isEqualToString:self.currentLexicalScheme])
                                               {
                                                [formattedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:tokenRange];
                                               }
												NSString *currentEntity = [textToAnalyse substringWithRange:tokenRange];
												NSLog(@"%@ is a %@, tokenRange (%d,%d)",currentEntity,tag,tokenRange.length,tokenRange.location);
											}];
    self.mainTextView.attributedText = formattedString;
}
@end

