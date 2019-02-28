#import "PYButtonCell.h"
#import "UIColor+Hex.h"
@interface PYButtonCell()
@end
@implementation PYButtonCell
- (void)layoutSubviews {
	[super layoutSubviews];
	[self.textLabel setTextColor:[UIColor colorWithHexString:@"#2ed573"]];
	//[self.textLabel setTextColor:[UIColor redColor]];
}
@end
