//
//  FloorPriceView.m
//  HousingLoan
//
//  Created by farthinker on 2/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "FloorPriceView.h"


@implementation FloorPriceView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {		
		_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
		_bg.image = [UIImage imageNamed:@"btn1.png"];
		_bg.highlightedImage = [UIImage imageNamed:@"btn1-down.png"];
		[self addSubview:_bg];
		
		_floorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
		[_floorLabel setTextColor:[UIColor colorWithRed:0.67 green:0.49 blue:0.44 alpha:1]];
		[_floorLabel setHighlightedTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
		[_floorLabel setBackgroundColor:[UIColor clearColor]];
		[_floorLabel setFont:[UIFont systemFontOfSize:16]];
		[_floorLabel setTextAlignment:UITextAlignmentCenter];
		[self addSubview:_floorLabel];		
		
		self.selected = NO;
    }
    return self;
}

- (NSInteger)floorNum {
	return _floorNum;
}

- (void)setFloorNum:(NSInteger)floorNum {
	_floorNum = floorNum;
	NSString *title = [[NSString alloc] initWithFormat:@"%d楼(%d元/M\u00B2)", _floorNum, _price];
	[_floorLabel setText:title];
	[title release];
}

- (NSInteger)price {
	return _price;
}

- (void)setPrice:(NSInteger)price {
	_price = price;
	NSString *title = [[NSString alloc] initWithFormat:@"%d楼(%d元/M\u00B2)", _floorNum, _price];
	[_floorLabel setText:title];
	[title release];
}

- (Boolean)selected {
	return _selected;
}

- (void)setSelected:(Boolean)selected {
	if (selected) {
		_bg.highlighted = YES;
		_floorLabel.highlighted = YES;
	} else {
		_bg.highlighted = NO;
		_floorLabel.highlighted = NO;
	}
}

- (void)dealloc {
	[_floorLabel release];
	[_bg release];
    [super dealloc];
}


@end
