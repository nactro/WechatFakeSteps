#import "PSButtonCell.h"
#import "UIColor+Hex.h"
#define TINT_COLOR		[UIColor colorWithRed:46/255.0 green:213/255.0 blue:115/255.0 alpha:1]
@interface PYButtonCell()
@end
@implementation PYButtonCell
- (void)layoutSubviews {
	[super layoutSubviews];

	[self.textLabel setTextColor:[UIColor greenColor]];
	//[self.textLabel setTextColor:[UIColor redColor]];
}
@end
