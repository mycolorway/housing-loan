//
//  HouseTypeView.m
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HouseTypeView.h"


@implementation HouseTypeView

@synthesize typeId = _typeId;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		CGRect imageFrame = CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10);
        _typeImageView = [[UIImageView alloc] initWithFrame:imageFrame];
		[self addSubview:_typeImageView];
		
		UIView *textBg = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 200, 50)];
		[textBg setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
		[self addSubview:textBg];
		
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, 180, 20)];
		[_nameLabel setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
		[_nameLabel setBackgroundColor:[UIColor clearColor]];
		[_nameLabel setFont:[UIFont systemFontOfSize:16]];
		[self addSubview:_nameLabel];
		
		_descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 175, 180, 20)];
		[_descLabel setTextColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
		[_descLabel setBackgroundColor:[UIColor clearColor]];
		[_descLabel setFont:[UIFont systemFontOfSize:12]];
		[self addSubview:_descLabel];
		
		self.selected = NO;
    }
    return self;
}

- (NSString *)typeName {
	return [_nameLabel text];
}

- (void)setTypeName:(NSString *)typeName {
	[_nameLabel setText:typeName];
}

- (NSString *)typeDesc {
	return _typeDesc;
}

- (void)setTypeDesc:(NSString *)typeDesc {
	if (_typeDesc) {
		[_typeDesc release];
		_typeDesc = nil;
	}
	
	_typeDesc = [typeDesc retain];
	[_descLabel setText:[typeDesc stringByAppendingFormat:@"(%dM\u00B2)", _typeArea]];
}

- (NSInteger)typeArea {
	return _typeArea;
}

- (void)setTypeArea:(NSInteger)typeArea {
	_typeArea = typeArea;
	[_descLabel setText:[_typeDesc stringByAppendingFormat:@"(%dM\u00B2)", _typeArea]];
}

- (UIImage *)typeImage {
	return [_typeImageView image];
}

- (void)setTypeImage:(UIImage *)typeImage {
	[_typeImageView setImage:typeImage];
}

- (Boolean)selected {
	return _selected;
}

- (void)setSelected:(Boolean)selected {
	if (selected) {
		[self setBackgroundColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
	} else {
		[self setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
	}
	
	_selected = selected;
}

- (void)dealloc {
	[_typeImageView release];
	[_nameLabel release];
	[_descLabel release];
	[_typeDesc release];
    [super dealloc];
}


@end
