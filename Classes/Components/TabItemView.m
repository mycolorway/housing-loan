//
//  TabItemView.m
//  HousingLoan
//
//  Created by farthinker on 2/11/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "TabItemView.h"


@implementation TabItemView

@synthesize amount = _amount;
@synthesize panel = _panel;

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {
		[self setAmount:[NSNumber numberWithInt:0]];
	}
    return self;
}

- (NSString *)title {
	return _titleLabel.text;
}

- (void)setTitle:(NSString *)title {
	[_titleLabel setText:title];
}

- (void)setAmount:(NSNumber *)amount {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[_amountLabel setText:[formatter stringFromNumber:amount]];
	
	if (_amount) {
		[_amount release];
		_amount = nil;
	}
	_amount = [amount retain];
	
	[formatter release];
}

- (Boolean)selected {
	return _selected;
}
	 
- (void)setSelected:(Boolean)selected {
	_selected = selected;
	if (selected) {
		_bg.highlighted = YES;
		_titleLabel.highlighted = YES;
		_amountLabel.highlighted = YES;
		[_panel setHidden:NO];
		[[_panel superview] bringSubviewToFront:_panel];
	} else {
		_bg.highlighted = NO;
		_titleLabel.highlighted = NO;
		_amountLabel.highlighted = NO;
		[_panel setHidden:YES];
		[[_panel superview] sendSubviewToBack:_panel];
	}
}


- (void)dealloc {
	[_amount release];
	[_panel release];
    [super dealloc];
}


@end
