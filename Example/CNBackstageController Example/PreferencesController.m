//
//  PreferenceController.m
//  Days
//
//  Created by cocoanaut.com on 20.05.12.
//  Copyright (c) 2012 cocoa:naut. All rights reserved.
//

#import "PreferencesController.h"
#import "CNBackstageController.h"


typedef enum {
    toolbarItemTagGeneral       = 10,
    toolbarItemTagAppBehavior   = 20,
} toolbarItemTag;

// ---------------------------------------------------------------------------------------------------------------------
#pragma mark - Private method declaration
// ---------------------------------------------------------------------------------------------------------------------

@interface PreferencesController()
- (void)calculateSizeForView:(NSView *)subView;
- (void)restorePreferences;
- (void)defaultsChangedNotification;
@end



@implementation PreferencesController


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark - Initialization
// ---------------------------------------------------------------------------------------------------------------------
-(id)init {
    self = [super initWithWindowNibName:@"Preferences"];
    if (self != nil) {
        [[self window] center];
    }
    return self;
}

-(void)awakeFromNib {
    [self changeView:toolbarItemAppBehavior];
    [[[self window] toolbar] setSelectedItemIdentifier:CNPrefsToolbarItemBehaviorItenfier];

    // application behavior
    {
        self.toggleEdgeLabel.stringValue = NSLocalizedString(@"Toggle application on", @"");
        [self.toggleEdgePopupButton removeAllItems];
        [self.toggleEdgePopupButton addItemsWithTitles:[NSArray arrayWithObjects:
                                                        NSLocalizedString(@"Top Edge", @""),
                                                        NSLocalizedString(@"Bottom Edge", @""),
                                                        NSLocalizedString(@"Left Edge", @""),
                                                        NSLocalizedString(@"Right Edge", @""),
                                                        nil]];


        self.toggleDisplayLabel.stringValue = NSLocalizedString(@"Show application on", @"");
        [self.toggleDisplayPopupButton removeAllItems];
        __block NSMutableArray *screens = [NSMutableArray array];
        [[NSScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [screens addObject:[NSString stringWithFormat:@"Display %li", idx]];
        }];
        [self.toggleDisplayPopupButton addItemsWithTitles:screens];

        self.visualEffectLabel.stringValue = NSLocalizedString(@"Finder Snapshot should", @"");
        [self.visualEffectPopupButton removeAllItems];
        [self.visualEffectPopupButton addItemsWithTitles:[NSArray arrayWithObjects:
                                                          NSLocalizedString(@"kept untouched", @""),
                                                          NSLocalizedString(@"have a black overlay", @""),
                                                          nil]];

        self.animationEffectLabel.stringValue = NSLocalizedString(@"Content of Application view", @"");
        [self.animationEffectPopupButton removeAllItems];
        [self.animationEffectPopupButton addItemsWithTitles:[NSArray arrayWithObjects:
                                                             NSLocalizedString(@"should be static", @""),
                                                             NSLocalizedString(@"should fade in", @""),
                                                             NSLocalizedString(@"should slide in", @""),
                                                             nil]];

        self.alphaValueLabel.stringValue = NSLocalizedString(@"Opacity of Finder Snapshot Overlay", @"");

    }

    [self restorePreferences];
}



// ---------------------------------------------------------------------------------------------------------------------
#pragma mark - Helper
// ---------------------------------------------------------------------------------------------------------------------

- (void)restorePreferences {
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self.toggleEdgePopupButton selectItemAtIndex:[self.userDefaults integerForKey:CNToggleEdgePreferencesKey]];
    [self.toggleDisplayPopupButton selectItemAtIndex:[self.userDefaults integerForKey:CNToggleDisplayPreferencesKey]];
    [self.visualEffectPopupButton selectItemAtIndex:[self.userDefaults integerForKey:CNToggleVisualEffectPreferencesKey]];
    [self.animationEffectPopupButton selectItemAtIndex:[self.userDefaults integerForKey:CNToggleAnimationEffectPreferencesKey]];
    self.alphaValueSlider.integerValue = [self.userDefaults integerForKey:CNToggleAlphaValuePreferencesKey];
}

- (void)defaultsChangedNotification
{
}



// ---------------------------------------------------------------------------------------------------------------------
#pragma mark - Actions
// ---------------------------------------------------------------------------------------------------------------------

- (IBAction)preferencesChangedAction:(id)sender
{
    if (sender == self.toggleEdgePopupButton) {
        [self.userDefaults setInteger:[self.toggleEdgePopupButton indexOfSelectedItem] forKey:CNToggleEdgePreferencesKey];
    }
    if (sender == self.toggleDisplayPopupButton) {
        [self.userDefaults setInteger:[self.toggleDisplayPopupButton indexOfSelectedItem] forKey:CNToggleDisplayPreferencesKey];
    }
    if (sender == self.visualEffectPopupButton) {
        [self.userDefaults setInteger:[self.visualEffectPopupButton indexOfSelectedItem] forKey:CNToggleVisualEffectPreferencesKey];
    }
    if (sender == self.animationEffectPopupButton) {
        [self.userDefaults setInteger:[self.animationEffectPopupButton indexOfSelectedItem] forKey:CNToggleAnimationEffectPreferencesKey];
    }
    if (sender == self.alphaValueSlider) {
        [self.userDefaults setInteger:self.alphaValueSlider.integerValue forKey:CNToggleAlphaValuePreferencesKey];
    }
    [self.userDefaults synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:kDefaultsChangedNotificationKey object:nil];
}

- (IBAction)changeView:(id)sender {
    NSView *aView = nil;
    switch ([sender tag])
    {
        case toolbarItemTagAppBehavior: aView = viewAppBehavior; break;
    }
    [[self window] setTitle: [sender paletteLabel]];
    [self calculateSizeForView: aView];
}




// ---------------------------------------------------------------------------------------------------------------------
#pragma mark - Private Methods
// ---------------------------------------------------------------------------------------------------------------------

- (void)calculateSizeForView:(NSView *)subView {
    NSRect windowFrame = [[self window] frame];
    NSRect contentViewFrame = [[[self window] contentView] frame];
    windowFrame.size.height = NSHeight([subView frame]) + (NSHeight(windowFrame) - NSHeight(contentViewFrame));
    windowFrame.size.width = NSWidth([subView frame]);
    windowFrame.origin.y = NSMinY(windowFrame) - (NSHeight([subView frame]) - NSHeight(contentViewFrame));

    if ([[contentView subviews] count] != 0) {
        [[[contentView subviews] objectAtIndex:0] removeFromSuperview];
    }

    [[self window] setFrame: windowFrame display: YES animate: YES];
    [contentView setFrame: [subView frame]];
    [contentView addSubview: subView];
}

@end