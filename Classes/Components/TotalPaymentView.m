//
//  TotalAmountView.m
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "TotalPaymentView.h"
#import "HouseTypeView.h"
#import "FloorPriceView.h"
#import "HousingLoanUtils.h"


@implementation TotalPaymentView

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
	[self loadHouseTypes];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(resetAll:)
												 name:@"ResetAll" object:nil];
}

- (void)resetAll:(NSNotification *)notification {
	_selectedType.selected = NO;
	_selectedType = nil;
	_floorList.hidden = YES;
	_floorListTitle.hidden = YES;
	_floorTipLabel.hidden = NO;
	
	NSNumber *payment = [[NSNumber alloc] initWithInteger:0];
	NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:payment, @"payment", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPaymentChanged" object:self userInfo:userInfo];
	[payment release];
	[userInfo release];
}

- (void)loadHouseTypes {
	NSString *configPath = [[[HousingLoanUtils sharedUtils] documentPath] stringByAppendingPathComponent:@"HouseTypes.plist"];
	NSArray *types = [[NSArray alloc] initWithContentsOfFile:configPath];
	NSEnumerator *enumerator = [types objectEnumerator];
	NSDictionary *type;
	HouseTypeView *typeView;
	UITapGestureRecognizer *tapGesture;
	NSInteger position = 0;
	UIImage *typeImage;
	NSString *typeId;
	NSString *typePath;
	CGFloat originX;
	CGFloat originY;
	
	
	while (type = [enumerator nextObject]) {
		if (position % 3 == 0) {
			originX = 0;
		} else {
			originX = 220 * (position % 3);
		}
		originY = position / 3 * 220;
		
		typeId = [type objectForKey:@"id"];
		typePath = [[[HousingLoanUtils sharedUtils] typesPath] stringByAppendingPathComponent:typeId];
		typeImage = [[UIImage alloc] initWithContentsOfFile:[typePath stringByAppendingPathComponent:@"pic.jpg"]];

		typeView = [[HouseTypeView alloc] initWithFrame:CGRectMake(originX, originY, 200, 200)];
		typeView.typeId = typeId;
		typeView.typeName = [type objectForKey:@"name"];
		typeView.typeDesc = [type objectForKey:@"desc"];
		typeView.typeArea = [[type objectForKey:@"area"] intValue];
		typeView.typeImage = typeImage;
		[_houseTypeList addSubview:typeView];
		
		tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(houseTypeSelected:)];
		[typeView addGestureRecognizer:tapGesture];
		
		[tapGesture release];
		[typeImage release];
		[typeView release];
		position++;
	}
	
	[_houseTypeList setContentSize:CGSizeMake(650, position / 3 * 220 - 20)];
	
	[types release];
}

- (void)loadFloors:(NSString *)typeId {
	NSString *floorPath = [[[HousingLoanUtils sharedUtils] typesPath] stringByAppendingPathComponent:typeId];
	NSArray *floors = [[NSArray alloc] initWithContentsOfFile:[floorPath stringByAppendingPathComponent:@"floors.plist"]];
	NSEnumerator *enumerator = [floors objectEnumerator];
	NSDictionary *floor;
	FloorPriceView *floorView;
	UITapGestureRecognizer *tapGesture;
	NSInteger position = 0;
	CGFloat originY;
	
	[[_floorList subviews] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		if ([(NSObject *)object isKindOfClass:[FloorPriceView class]]) {
			[(UIView *)object removeFromSuperview];
		}
	}];
	_selectedFloor = nil;
	
	while (floor = [enumerator nextObject]) {		
		originY = position * 45;
		
		floorView = [[FloorPriceView alloc] initWithFrame:CGRectMake(0, originY, 300, 40)];
		[floorView setFloorNum:[[floor objectForKey:@"floor"] intValue]];
		[floorView setPrice:[[floor objectForKey:@"price"] intValue]];
		[_floorList addSubview:floorView];
		
		tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(floorSelected:)];
		[floorView addGestureRecognizer:tapGesture];
		
		[floorView release];
		[tapGesture release];
		position++;
	}
	
	[_floorList setContentSize:CGSizeMake(316, position * 45)];
	[_floorList setHidden:NO];
	[_floorListTitle setText:[typeId stringByAppendingString:@"可选楼层"]];
	[_floorListTitle setHidden:NO];
	[_floorTipLabel setHidden:YES];
	
	[floors release];
}

- (void)houseTypeSelected:(id)sender {
	HouseTypeView *newType = (HouseTypeView *)[sender view];
	if (_selectedType != newType) {
		_selectedType.selected = NO;
		newType.selected = YES;
		_selectedType = newType;
		[self loadFloors:newType.typeId];
	}
	
	NSNumber *payment = [[NSNumber alloc] initWithInteger:0];
	NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:payment, @"payment", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPaymentChanged" object:self userInfo:userInfo];
	[payment release];
	[userInfo release];
}

- (void)floorSelected:(id)sender {
	FloorPriceView *newFloor = (FloorPriceView *)[sender view];
	if (_selectedFloor != newFloor) {
		_selectedFloor.selected = NO;
		newFloor.selected = YES;
		_selectedFloor = newFloor;
	}
	
	NSNumber *payment = [[NSNumber alloc] initWithInteger:_selectedType.typeArea * newFloor.price];
	NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:payment, @"payment", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TotalPaymentChanged" object:self userInfo:userInfo];
	[payment release];
	[userInfo release];
}

- (void)dealloc {
    [super dealloc];
}


@end
