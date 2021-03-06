//
//  PreferenceController.h
//  Days
//
//  Created by cocoanaut.com on 20.05.12.
//  Copyright (c) 2012 cocoa:naut. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesController : NSWindowController <NSToolbarDelegate> {
    IBOutlet NSView         *contentView;
    IBOutlet NSToolbarItem  *toolbarItemAppBehavior;
    IBOutlet NSView         *viewAppBehavior;
}

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@property (nonatomic, strong) IBOutlet NSTextField *toggleEdgeLabel;
@property (nonatomic, strong) IBOutlet NSPopUpButton *toggleEdgePopupButton;

@property (nonatomic, strong) IBOutlet NSTextField *toggleDisplayLabel;
@property (nonatomic, strong) IBOutlet NSPopUpButton *toggleDisplayPopupButton;

@property (nonatomic, strong) IBOutlet NSTextField *toggleSizeWidthLabel;
@property (nonatomic, strong) IBOutlet NSPopUpButton *toggleSizeWidthPopupButton;

@property (nonatomic, strong) IBOutlet NSTextField *toggleSizeHeightLabel;
@property (nonatomic, strong) IBOutlet NSPopUpButton *toggleSizeHeightPopupButton;

@property (nonatomic, strong) IBOutlet NSButton *useShadowsCheckbox;

@property (nonatomic, strong) IBOutlet NSTextField *visualEffectLabel;
@property (nonatomic, strong) IBOutlet NSButton *visualEffectBlackOverlayCheckbox;
@property (nonatomic, strong) IBOutlet NSButton *visualEffectGaussianBlurCheckbox;

@property (nonatomic, strong) IBOutlet NSTextField *alphaValueLabel;
@property (nonatomic, strong) IBOutlet NSSlider *alphaValueSlider;

@property (nonatomic, strong) IBOutlet NSTextField *animationEffectLabel;
@property (nonatomic, strong) IBOutlet NSPopUpButton *animationEffectPopupButton;

- (IBAction)changeView:(id)sender;
- (IBAction)preferencesChangedAction:(id)sender;

@end
